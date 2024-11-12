namespace Azul.Azul;

using Microsoft.Sales.History;

pageextension 50202 "DXPE LSC Memb Batch Lines" extends "LSC Membership Batch Lines"
{
    actions
    {
        addafter("View Invoice")
        {
            action("make payments via azul")
            {
                ApplicationArea = All;
                Caption = 'Make payments via azul';
                Image = Payment;
                trigger OnAction()
                var
                    DxSendAzul: codeunit "DX Send azul";
                    Membership: Record "LSC Membsh. Subscription Batch";
                    count, i, suma : Integer;
                begin
                    //rec.SetFilter("Batch No.", FieldName("Batch No."));
                    //rec.SetFilter("Entry Status", 'Posted');
                    // rec.SetFilter(Closed, 'No');
                    count := rec.Count;
                    suma := 0;
                    Membership.SetFilter("Batch No.", rec."Batch No.");
                    if Membership.FindFirst() then begin
                        if Membership."Process Status" <> Membership."Process Status"::"Batch Posted" then begin
                            Message(posted);
                            exit;
                        end
                        else begin
                            if DXSetup.FindFirst() then begin
                                if DXSetup.SendAzul = true then begin
                                    if rec.FindSet() then begin
                                        for i := 1 to count do begin
                                            DxSendAzul.ProcessPayment(Rec);
                                            Rec.Next();
                                            suma += 1;
                                        end;
                                        Message('Facturas pagadas exitosamente:%1 to %2', suma, count);
                                    end else begin
                                        Message('No existen registros para enviar');
                                    end;

                                end
                                else begin
                                    Message(SendAzulpos);
                                end;
                            end
                            else begin
                                Message(Conf);
                            end;
                        end;
                    end;
                end;

            }
        }
    }
    var
        DxText001: Label 'Data sent successfully';
        Período: Option Daily,Weekly,Biweekly,Monthly;
        DXSetup: Record "DXTB Azul Setup";
        SendAzulpos: Label 'Sending payments via Azul is disabled, please check';
        Conf: Label 'Azul configuration not found';
        posted: Label 'The batch is not posted';

}
