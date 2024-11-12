codeunit 50200 "DX Send Azul"
{
    Access = Public;


    /// TODO:Crea consulta al Endpoind via Post 
    procedure UpRegHoldAzure(var Customer: Record Customer; var CardNO: code[20]; MM: Code[2]; YYYY: Code[4]; CCV: Code[3]): Boolean
    var
        MemberContactLog: Record "DX Azul Log Response";
        Azul: Record "DXTB Azul Setup";
        Base64: Codeunit "Base64 Convert";
        Session: Record Session;
        Lkeys: List of [JsonToken];
        Jtoken: JsonToken;
        JArray, JArray2 : JsonArray;
        CustObject, JsonObject, SocioObject, IntegrationQuotaObject, j : JsonObject;
        JsonData, prueva, URL, ResponeTxt : Text;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        sendSucessfully: Boolean;
        count: Integer;

    begin
        Clear(JsonObject);
        Clear(CustObject);
        Clear(Request);
        Clear(Response);
        Clear(JArray);
        Clear(JArray2);
        Clear(SocioObject);
        Clear(IntegrationQuotaObject);
        Clear(Azul);
        count := 0;
        if not Azul.FindLast() then
            exit;

        Url := STRSUBSTNO(Azul.URLPrimary);
        CustObject.Add('Channel', Azul.Channel);
        CustObject.Add('Store', Azul.Store);
        CustObject.Add('CardNumber', CardNO);
        CustObject.Add('Expiration', YYYY + MM);
        CustObject.Add('CVC', CCV);
        CustObject.Add('PosInputMode', 'E-Commerce');
        CustObject.Add('TrxType', 'Hold');
        CustObject.Add('Amount', '100');
        CustObject.Add('Itbis', '000');
        CustObject.Add('CurrencyPosCode', '$');
        CustObject.Add('Payments', '1');
        CustObject.Add('Plan', '0');
        CustObject.Add('AcquirerRefData', '1');
        CustObject.Add('OrderNumber', '');
        CustObject.Add('ECommerceUrl', '');
        CustObject.Add('CustomOrderId', '');
        CustObject.Add('DataVaultToken', '');
        CustObject.Add('SaveToDataVault', '1');

        HttpMgnt.Initialize(HttpMethods::POST, URL);
        HttpMgnt.AddBody(Format(CustObject));
        HttpMgnt.SetContentType('application/json');
        if HttpMgnt.SendRequest() then begin
            //Message(HttpMgnt.GetResponseAsText());
            j := HttpMgnt.GetResponseAsJson();
            JArray.Add(j);
            Lkeys := j.Values;
            MemberContactLog.Init();
            foreach jtoken in Lkeys do begin
                count := count + 1;
                if Jtoken.IsValue then;
                case count of
                    1:
                        begin
                            MemberContactLog.AuthorizationCode := jtoken.AsValue().AsText();
                        end;
                    2:
                        begin
                            MemberContactLog.AzulOrderId := jtoken.AsValue().AsText();
                            Customer.IDAzul := jtoken.AsValue().AsText();
                        end;
                    3:
                        begin
                            MemberContactLog.CustomOrderId := jtoken.AsValue().AsText();
                        end;
                    4:
                        begin
                            MemberContactLog.DataVaultBrand := jtoken.AsValue().AsText();
                        end;
                    5:
                        begin
                            MemberContactLog.DataVaultExpiration := jtoken.AsValue().AsText();
                        end;
                    6:
                        begin
                            MemberContactLog.DataVaultToken := jtoken.AsValue().AsText();
                            Customer.IDCardAzul := jtoken.AsValue().AsText();
                        end;
                    7:
                        begin
                            MemberContactLog.DateTime := jtoken.AsValue().AsText();
                        end;
                    8:
                        begin
                            MemberContactLog.ErrorDescription := jtoken.AsValue().AsText();
                        end;
                    9:
                        begin
                            MemberContactLog.IsoCode := jtoken.AsValue().AsText();
                        end;
                    10:
                        begin
                            MemberContactLog.LotNumber := jtoken.AsValue().AsText();
                        end;
                    11:
                        begin
                            MemberContactLog.RNN := jtoken.AsValue().AsText();
                        end;
                    12:
                        begin
                            MemberContactLog.ResponseCode := jtoken.AsValue().AsText();
                        end;
                    13:
                        begin
                            MemberContactLog.ResponseMessage := jtoken.AsValue().AsText();
                        end;
                    14:
                        begin
                            MemberContactLog.Ticket := jtoken.AsValue().AsText();
                        end;
                end;
            end;
            MemberContactLog.Transactiontype := MemberContactLog.Transactiontype::Record;
            MemberContactLog."Customer No." := Customer."No.";
            MemberContactLog.Amount := 1;
            Customer."Send Azul" := true;
            Customer.IDCardAzul := MemberContactLog.DataVaultToken;
            if MemberContactLog.Insert() then;
            IF Customer.Modify() THEN;
            IF voidtransactions(Customer) THEN;
            Message('Tarjeta Registrada');
        end
        else begin
            Message(FailConextion + ' URL: Register Transaction');
        end;


    end;

    procedure voidtransactions(Rec: Record "customer"): Boolean
    var
        MemberContactLog: Record "DX Azul Log Response";
        Azul: Record "DXTB Azul Setup";
        Base64: Codeunit "Base64 Convert";
        Session: Record Session;
        Lkeys: List of [JsonToken];
        Jtoken: JsonToken;
        JArray, JArray2 : JsonArray;
        CustObject, JsonObject, SocioObject, IntegrationQuotaObject, j : JsonObject;
        JsonData, prueva, URL, ResponeTxt : Text;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        sendSucessfully: Boolean;
        count: Integer;
    begin
        Clear(JsonObject);
        Clear(CustObject);
        Clear(Request);
        Clear(Response);
        Clear(JArray);
        Clear(JArray2);
        Clear(SocioObject);
        Clear(IntegrationQuotaObject);
        Clear(Azul);
        if not Azul.FindLast() then
            exit;
        Url := STRSUBSTNO(Azul.ProcessVoid);
        CustObject.Add('Channel', Azul.Channel);
        CustObject.Add('Store', Azul.Store);
        CustObject.Add('AzulOrderId', rec.IDAzul);
        HttpMgnt.Initialize(HttpMethods::POST, URL);
        HttpMgnt.AddBody(Format(CustObject));
        HttpMgnt.SetContentType('application/json');
        if HttpMgnt.SendRequest() then begin
            // Message(HttpMgnt.GetResponseAsText());
            j := HttpMgnt.GetResponseAsJson();
            JArray.Add(j);
            Lkeys := j.Values;
            MemberContactLog.Init();
            foreach jtoken in Lkeys do begin
                count := count + 1;
                if Jtoken.IsValue then;
                case count of
                    1:
                        begin
                            MemberContactLog.AuthorizationCode := jtoken.AsValue().AsText();
                        end;
                    2:
                        begin
                            MemberContactLog.AzulOrderId := jtoken.AsValue().AsText();
                        end;
                    3:
                        begin
                            MemberContactLog.CustomOrderId := jtoken.AsValue().AsText();
                        end;
                    4:
                        begin
                            MemberContactLog.DataVaultBrand := jtoken.AsValue().AsText();
                        end;
                    5:
                        begin
                            MemberContactLog.DataVaultExpiration := jtoken.AsValue().AsText();
                        end;
                    6:
                        begin
                            MemberContactLog.DataVaultToken := jtoken.AsValue().AsText();
                        end;
                    7:
                        begin
                            MemberContactLog.DateTime := jtoken.AsValue().AsText();
                        end;
                    8:
                        begin
                            MemberContactLog.ErrorDescription := jtoken.AsValue().AsText();
                        end;
                    9:
                        begin
                            MemberContactLog.IsoCode := jtoken.AsValue().AsText();
                        end;
                    10:
                        begin
                            MemberContactLog.LotNumber := jtoken.AsValue().AsText();
                        end;
                    11:
                        begin
                            MemberContactLog.RNN := jtoken.AsValue().AsText();
                        end;
                    12:
                        begin
                            MemberContactLog.ResponseCode := jtoken.AsValue().AsText();
                        end;
                    13:
                        begin
                            MemberContactLog.ResponseMessage := jtoken.AsValue().AsText();
                        end;
                    14:
                        begin
                            MemberContactLog.Ticket := jtoken.AsValue().AsText();
                        end;
                end;
            end;
            MemberContactLog.Transactiontype := MemberContactLog.Transactiontype::Refund;
            MemberContactLog."Customer No." := rec."No.";
            MemberContactLog.Amount := 1;
            if MemberContactLog.Insert() then;
        end
        else begin
            Message(FailConextion + ' URL: Void Transaction');
        end;
    end;

    local procedure ProcessReg(JToken: JsonToken; Rec: Record "customer"; ID: Integer) processReg: Boolean
    var
        JSONOb2, JSONObj3 : JsonObject;
        JSONToken2, JSONToken3 : JsonToken;
        JSONkeys, JSONkeys1 : Text;
        ObjectKeys, ObjectKeys1 : List of [Text];
        PaymentsReceived: Record Customer;
        MemberContactLog: Record "DX Azul Log Response";
    begin
        JSONOb2 := JToken.AsObject();
        ObjectKeys := JSONOb2.Keys;
        foreach JSONKeys in ObjectKeys do begin
            JSONOb2.Get(JSONkeys, JSONToken2);
            MemberContactLog.Init();
            if JSONToken2.IsValue then
                case JSONkeys of
                    'AuthorizationCode':
                        begin
                            MemberContactLog.AuthorizationCode := JSONToken2.AsValue().AsText();
                        end;
                    'AzulOrderId':
                        begin
                            MemberContactLog.AzulOrderId := JSONToken2.AsValue().AsText();
                            rec.IDAzul := JSONToken2.AsValue().AsText();
                        end;
                    'CustomOrderId':
                        begin
                            MemberContactLog.CustomOrderId := JSONToken2.AsValue().AsText();
                        end;
                    'DataVaultBrand':
                        begin
                            MemberContactLog.DataVaultBrand := JSONToken2.AsValue().AsText();
                        end;
                    'DataVaultExpiration':
                        begin
                            MemberContactLog.DataVaultExpiration := JSONToken2.AsValue().AsText();
                        end;
                    'DataVaultToken':
                        begin
                            MemberContactLog.DataVaultToken := JSONToken2.AsValue().AsText();
                            if ID = 0 then
                                rec.IDCardAzul := JSONToken2.AsValue().AsText();
                        end;
                    'DateTime':
                        begin
                            MemberContactLog.DateTime := JSONToken2.AsValue().AsText();
                        end;
                    'ErrorDescription':
                        begin
                            MemberContactLog.ErrorDescription := JSONToken2.AsValue().AsText();
                        end;
                    'IsoCode':
                        begin
                            MemberContactLog.IsoCode := JSONToken2.AsValue().AsText();
                        end;
                    'ResponseCode':
                        begin
                            MemberContactLog.ResponseCode := JSONToken2.AsValue().AsText();
                        end;
                    'ResponseMessage':
                        begin
                            MemberContactLog.ResponseMessage := JSONToken2.AsValue().AsText();
                        end;
                    'Ticket':
                        begin
                            MemberContactLog.Ticket := JSONToken2.AsValue().AsText();
                        end;
                end;
        end;
        if ID = 0 then begin
            MemberContactLog."Customer No." := rec."No.";
        end;
        if MemberContactLog.Insert() then;
        rec.Modify();

        if MemberContactLog.ResponseMessage = 'APROBADA' then begin
            exit(true);
        end
        else begin
            exit(false);
        end;


    end;


    procedure ProcessPaymentAzul(var PostedSales: Record "LSC Membership Batch Line"): Boolean
    var
        Customer: Record Customer;
        MemberContactLog: Record "DX Azul Log Response";
        Azul: Record "DXTB Azul Setup";
        Base64: Codeunit "Base64 Convert";
        Session: Record Session;
        Lkeys: List of [JsonToken];
        Jtoken: JsonToken;
        JArray, JArray2 : JsonArray;
        CustObject, JsonObject, SocioObject, IntegrationQuotaObject, j : JsonObject;
        JsonData, prueva, URL, ResponeTxt : Text;
        Request: HttpRequestMessage;
        Response: HttpResponseMessage;
        sendSucessfully: Boolean;
        count: Integer;


    begin

        Clear(JsonObject);
        Clear(CustObject);
        Clear(Request);
        Clear(Response);
        Clear(JArray);
        Clear(JArray2);
        Clear(SocioObject);
        Clear(IntegrationQuotaObject);
        Clear(Azul);
        count := 0;
        if not Azul.FindLast() then
            exit;
        Customer.SetFilter(Customer."No.", PostedSales."Invoiced To");
        if not Customer.FindFirst() then
            exit;
        Url := STRSUBSTNO(Azul.URLPrimary);
        CustObject.Add('Channel', Azul.Channel);
        CustObject.Add('Store', Azul.Store);
        CustObject.Add('CardNumber', '');
        CustObject.Add('Expiration', '');
        CustObject.Add('CVC', '');
        CustObject.Add('PosInputMode', 'E-Commerce');
        CustObject.Add('TrxType', 'Sale');
        CustObject.Add('Amount', FORMAT(ROUND(PostedSales.Amount * 100, 1, '=')).Replace(',', ''));
        CustObject.Add('Itbis', '');
        CustObject.Add('CurrencyPosCode', '$');
        CustObject.Add('Payments', '1');
        CustObject.Add('Plan', '0');
        CustObject.Add('AcquirerRefData', '1');
        CustObject.Add('OrderNumber', '');
        CustObject.Add('ECommerceUrl', '');
        CustObject.Add('CustomOrderId', '');
        CustObject.Add('DataVaultToken', Customer.IDCardAzul);
        CustObject.Add('SaveToDataVault', '0');
        HttpMgnt.Initialize(HttpMethods::POST, URL);
        HttpMgnt.AddBody(Format(CustObject));
        HttpMgnt.SetContentType('application/json');
        if HttpMgnt.SendRequest() then begin
            //Message(HttpMgnt.GetResponseAsText());
            j := HttpMgnt.GetResponseAsJson();
            Lkeys := j.Values;
            MemberContactLog.Init();
            foreach jtoken in Lkeys do begin
                count := count + 1;
                if Jtoken.IsValue then;
                case count of
                    1:
                        begin
                            MemberContactLog.AuthorizationCode := jtoken.AsValue().AsText();
                        end;
                    2:
                        begin
                            MemberContactLog.AzulOrderId := jtoken.AsValue().AsText();
                        end;
                    3:
                        begin
                            MemberContactLog.CustomOrderId := jtoken.AsValue().AsText();
                        end;
                    4:
                        begin
                            MemberContactLog.DateTime := jtoken.AsValue().AsText();
                        end;
                    5:
                        begin
                            MemberContactLog.ErrorDescription := jtoken.AsValue().AsText();
                        end;
                    6:
                        begin
                            MemberContactLog.IsoCode := jtoken.AsValue().AsText();
                        end;
                    7:
                        begin
                            MemberContactLog.LotNumber := jtoken.AsValue().AsText();
                        end;
                    8:
                        begin
                            MemberContactLog.RNN := jtoken.AsValue().AsText();
                        end;
                    9:
                        begin
                            MemberContactLog.ResponseCode := jtoken.AsValue().AsText();
                        end;
                    10:
                        begin
                            MemberContactLog.ResponseMessage := jtoken.AsValue().AsText();
                        end;
                    11:
                        begin
                            MemberContactLog.Ticket := jtoken.AsValue().AsText();
                        end;

                end;
            end;
            MemberContactLog.Transactiontype := MemberContactLog.Transactiontype::Payments;
            MemberContactLog."Customer No." := Customer."No.";
            MemberContactLog."Reference No." := PostedSales."Invoice No.";
            MemberContactLog.Amount := PostedSales.Amount;

            if MemberContactLog.Insert() then begin
                if MemberContactLog.ResponseMessage = 'APROBADA' then begin
                    PostedSales."Invoice Comment" := 'Factura pagada via Azul con exito, el numero de autorizacion es: ' + MemberContactLog.AuthorizationCode;
                    PostedSales.Modify();
                end;
            end;
            exit(true);

        end;
    end;



    procedure ProcessPayment(var PostedSales: Record "LSC Membership Batch Line")
    var
        Customer: Record Customer;
        AzulLogResponse: Record "DX Azul Log Response";
        suma, count, i : Integer;

    begin
        suma := 0;
        count := PostedSales.Count;
        for i := 1 to count do begin
            Customer.SetFilter(Customer."No.", PostedSales."Invoiced To");
            if not Customer.FindFirst() then
                exit;
            if Customer.IDCardAzul <> '' then begin
                if PostedSales."Invoice Comment" = '' then begin
                    if ProcessPaymentAzul(PostedSales) then begin
                        AzulLogResponse.SetFilter(AzulLogResponse."Customer No.", PostedSales."Invoiced To");
                        AzulLogResponse.SetFilter(AzulLogResponse."Reference No.", PostedSales."Invoice No.");
                        AzulLogResponse.SetFilter(AzulLogResponse.ResponseMessage, 'APROBADA');
                        if AzulLogResponse.FindFirst() then begin
                            PaymentInvoice(PostedSales."Invoice No.");
                        end;
                    end else begin
                        PostedSales.attempts += 1;
                        PostedSales.Modify();
                    end;
                end;
            end;
            PostedSales.Next();
            suma += 1;
        end;
        Message(completado, suma, count);
    end;

    procedure InsertPaymentJournal(SalesInvoiceHeader: Record "LSC Membership Batch Line"; DxBankingReference: Record "DX Azul Log Response")
    var
        NoLine: Integer;
        azul: Record "DXTB Azul Setup";
        rGJournalLine: Record "Gen. Journal Line";
        rGJournalLine2: Record "Gen. Journal Line";
        gJournalBatch: Record "Gen. Journal Batch";
        Amount: Decimal;
        RemainingAmount: Decimal;
        rCustLedgerEntry: Record "Cust. Ledger Entry";
        rDetailedCustomerLE: Record "Detailed Cust. Ledg. Entry";
        CustLgEntry: Record "Cust. Ledger Entry";
        PfechapagoDate: Date;
        Pfechapago: Text;
        Year: Integer;
        Month: Integer;
        Day: Integer;
    begin
        Clear(rGJournalLine);
        Clear(rGJournalLine2);
        Clear(gJournalBatch);

        if DxBnk.FindFirst() then;
        if azul.FindLast() then;
        rGJournalLine2.SetCurrentKey("Journal Batch Name", "Journal Template Name", "Line No.");
        rGJournalLine2.SetRange("Journal Template Name", DxBnk."Journal Template Name");
        rGJournalLine2.SetRange("Journal Batch Name", DxBnk."Journal Batch Name");

        if rGJournalLine2.FindLast() then
            NoLine := 10000 + rGJournalLine2."Line No."
        else
            NoLine := 10000;

        // rGenJourTemp.SetRange("Name", DxBnk."Journal Template Name");
        // If rGenJourTemp.FindFirst() then;

        rGJournalLine.Init();
        rGJournalLine.Validate("Journal Template Name", DxBnk."Journal Template Name");
        rGJournalLine.Validate("Journal Batch Name", DxBnk."Journal Batch Name");
        // rGJournalLine.Validate("Posting Date", Today());
        // rGJournalLine.Validate("Posting Date", 20271010D);
        // rGJournalLine.Validate("Posting Date", CalcDate('<+1D>', Today()));

        rGJournalLine."Posting Date" := SalesInvoiceHeader."Posting Date";
        rGJournalLine.Validate("Line No.", NoLine);
        rGJournalLine.Validate("Document No.", DxBankingReference."Reference No.");

        rGJournalLine.Validate("Document Type", rGJournalLine."Document Type"::Payment);

        rGJournalLine."Applies-to Doc. Type" := rGJournalLine."Applies-to Doc. Type"::Invoice;
        // rGJournalLine."Applies-to ID" := DxBankingReference."No.Autorizacion.";
        rGJournalLine."Applies-to Doc. No." := DxBankingReference."Reference No.";

        rGJournalLine.Validate("Account Type", rGJournalLine."Account Type"::Customer);
        rGJournalLine.Validate("Account No.", DxBankingReference."Customer No.");

        rGJournalLine.Validate("Amount", DxBankingReference.Amount);
        rGJournalLine."Payment Method Code" := azul.FormaPago;
        // rGJournalLine."Amount" := DxBankingReference.ValorPagado * -1;
        // rGJournalLine.Validate("DXRecibo Ingreso", DxBnkSetup."Recibo de Ingreso");

        gJournalBatch.Get(rGJournalLine."Journal Template Name", rGJournalLine."Journal Batch Name");
        rGJournalLine."Bal. Account Type" := rGJournalLine."Bal. Account Type"::"Bank Account";
        rGJournalLine."Bal. Account No." := gJournalBatch."Bal. Account No.";

        //  rGJournalLine.Validate("Posting No. Series", DxBnkSetup."Posting No. Series");

        rGJournalLine."External Document No." := DxBankingReference.AuthorizationCode;

        // If DxBnkSetup."Local Currency" = 'DOP' then begin
        //     rGJournalLine."Currency Code" := '';
        // end else begin
        //     rGJournalLine.Validate("Currency Code", DxBankingReference.Currency);
        // end;

        //rGJournalLine.Validate("Currency Code", SalesInvoiceHeader."Currency Code");
        // rGJournalLine.Validate("No.Autorizacion", DxBankingReference."No.Autorizacion.");

        rGJournalLine.Insert(true);

        // If DxBnkSetup.AutoPosted = true then begin
        //     AutoPost(rGJournalLine);
        // end;

        Clear(Amount);
        Clear(RemainingAmount);

        //Agregar al customer
        Clear(rCustLedgerEntry);
        rCustLedgerEntry.SetRange("Document No.", DxBankingReference."Reference No.");
        // rCustLedgerEntry.SetRange("Document No.", DxBankingReference."No.Documento");
        if rCustLedgerEntry.Findfirst() then begin

            rCustLedgerEntry."Applies-to ID" := DxBankingReference."Reference No.";
            // rCustLedgerEntry."No.Autorizacion" := DxBankingReference."No.Autorizacion.";
            rCustLedgerEntry."Credit Amount" := DxBankingReference.Amount;
            rCustLedgerEntry."Amount to Apply" := DxBankingReference.Amount;
            rCustLedgerEntry."Accepted Payment Tolerance" := 0;
            rCustLedgerEntry."Accepted Pmt. Disc. Tolerance" := FALSE;

            // rCustLedgerEntry.Validate("Applies-to ID", DxBankingReference."No.Autorizacion.");
            // rCustLedgerEntry.Validate("No.Autorizacion", DxBankingReference."No.Autorizacion.");
            // rCustLedgerEntry.Validate("Amount to Apply", DxBankingReference.ValorPagado * -1);
            // rCustLedgerEntry.Validate("Accepted Payment Tolerance", 0);
            // rCustLedgerEntry.Validate("Accepted Pmt. Disc. Tolerance", FALSE);

            Clear(rDetailedCustomerLE);
            rDetailedCustomerLE.SetRange("Cust. Ledger Entry No.", rCustLedgerEntry."Entry No.");

            IF rDetailedCustomerLE.FindSet() then begin
                repeat
                    if rDetailedCustomerLE."Ledger Entry Amount" = TRUE then
                        Amount := Amount + rDetailedCustomerLE.Amount;

                    RemainingAmount := RemainingAmount + rDetailedCustomerLE.Amount;
                until rDetailedCustomerLE.Next = 0;
            end;


            if (DxBankingReference.Amount > RemainingAmount) then
                rCustLedgerEntry."Amount to Apply" := RemainingAmount
            else
                rCustLedgerEntry."Amount to Apply" := DxBankingReference.Amount;
            rCustLedgerEntry.Modify();
        end;

        If azul.AutoPosted = true then begin
            AutoPost(rGJournalLine);
        end;

    end;

    procedure AutoPost(rGJournalLine: Record "Gen. Journal Line")
    var
        ErrorMessage: Text;
    begin
        if DxBnkSetup.FindFirst() then begin
            rGJournalLine.SetCurrentKey("Journal Batch Name", "Journal Template Name", "Line No.");
            rGJournalLine.SetRange("Journal Template Name", DxBnk."Journal Template Name");
            rGJournalLine.SetRange("Journal Batch Name", DxBnk."Journal Batch Name");

            if rGJournalLine.FindSet() then begin
                TryPostJournalLine(rGJournalLine);
                // ErrorMessage := 'Ocurrió un error al publicar las líneas del diario.';
                // Message(ErrorMessage);
            end;
        end;
    end;

    procedure PaymentInvoice(invoice: Code[20])
    var
        SalesHeader: record "Sales Header";
    begin
        SalesHeader.SetFilter("No.", invoice);
        if SalesHeader.FindFirst() then begin
            PostDocument(CODEUNIT::"Sales-Post (Yes/No)", Enum::"Navigate After Posting"::"Posted Document", SalesHeader);
        end;
    end;

    local procedure PostDocument(PostingCodeunitID: Integer; Navigate: Enum "Navigate After Posting"; Rec: Record "Sales Header")
    var
        LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        SalesHeader: Record "Sales Header";
        SalesInvoiceHeader: Record "Sales Invoice Header";
        OfficeMgt: Codeunit "Office Management";
        InstructionMgt: Codeunit "Instruction Mgt.";
        PreAssignedNo: Code[20];
        xLastPostingNo: Code[20];
        IsScheduledPosting: Boolean;
        IsHandled: Boolean;
    begin
        LinesInstructionMgt.SalesCheckAllLinesHaveQuantityAssigned(Rec);
        PreAssignedNo := Rec."No.";
        xLastPostingNo := Rec."Last Posting No.";

        Rec.SendToPosting(PostingCodeunitID);

        IsScheduledPosting := Rec."Job Queue Status" = Rec."Job Queue Status"::"Scheduled for Posting";
        DocumentIsPosted := (not SalesHeader.Get(Rec."Document Type", Rec."No.")) or IsScheduledPosting;
        OnPostOnAfterSetDocumentIsPosted(SalesHeader, IsScheduledPosting, DocumentIsPosted);

        IsHandled := false;
        OnPostDocumentBeforeNavigateAfterPosting(Rec, PostingCodeunitID, Navigate, DocumentIsPosted, IsHandled);
        if IsHandled then
            exit;

        /* if PostingCodeunitID <> CODEUNIT::"Sales-Post (Yes/No)" then
             exit;*/

        if OfficeMgt.IsAvailable() then begin
            if (Rec."Last Posting No." <> '') and (Rec."Last Posting No." <> xLastPostingNo) then
                SalesInvoiceHeader.SetRange("No.", Rec."Last Posting No.")
            else begin
                SalesInvoiceHeader.SetCurrentKey("Pre-Assigned No.");
                SalesInvoiceHeader.SetRange("Pre-Assigned No.", PreAssignedNo);
            end;
            if SalesInvoiceHeader.FindFirst() then
                PAGE.Run(PAGE::"Posted Sales Invoice", SalesInvoiceHeader);
        end;
    end;

    procedure TryPostJournalLine(rGJournalLine: Record "Gen. Journal Line")
    begin
        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", rGJournalLine);
        PostSuccess := true;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPostOnAfterSetDocumentIsPosted(SalesHeader: Record "Sales Header"; var IsScheduledPosting: Boolean; var DocumentIsPosted: Boolean)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnPostDocumentBeforeNavigateAfterPosting(var SalesHeader: Record "Sales Header"; var PostingCodeunitID: Integer; var Navigate: Enum "Navigate After Posting"; DocumentIsPosted: Boolean; var IsHandled: Boolean)
    begin
    end;

    var
        DocumentIsPosted: Boolean;
        DxBnkSetup: Record "DXBanking Setup";
        HttpMgnt: Codeunit "Http Request";
        DxBnk: Record "DXBank";
        RestHeaders: TextBuilder;
        ContentTypeSet: Boolean;
        DocumentNoConsolidate: Code[20];
        PostSuccess: Boolean;
        LRegistration: label 'VAT Registration No cannot be empty';
        LName: Label 'you must enter the name';
        LClient: Label 'The client does not have a reference number';
        LEmail: label 'the email cannot be empty';
        CertThumbprint: Text;
        FailConextion: Label 'Failed to connect to the server';
        invoice: code[20];
        completado: Label 'Data sent successfully: %1 to %2';
}
