namespace BodyShop.BodyShop;
using Microsoft.Sales.Customer;

report 50200 "DX ADD CARD"
{
    Caption = 'DX ADD CARD';
    UseRequestPage = true;
    ProcessingOnly = true;



    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Add Card")
                {
                    field(CardNO; CardNO)
                    {
                        ApplicationArea = all;
                        Caption = 'Credit card number';

                    }
                    field(MM; MM)
                    {
                        ApplicationArea = all;
                        Caption = 'Expiration month';
                    }
                    field(YYYY; YYYY)
                    {
                        ApplicationArea = all;
                        Caption = 'Expiration year';
                    }
                    /*field(Name; Name)
                    {
                        ApplicationArea = all;
                        Caption = 'Name';
                    }*/
                    field(CCV; CCV)
                    {
                        ApplicationArea = all;
                        Caption = 'CCV';
                    }

                }
            }
        }

    }
    trigger OnPreReport()
    var
        Customer: Record Customer;
        RegCard: Codeunit "DX Send azul";
    begin
        Customer := CustomerReg;
        if CardNO <> '' then begin
            if MM <> '' then begin
                if YYYY <> '' then begin
                    if CCV <> '' then begin
                        RegCard.UpRegHoldAzure(Customer, CardNO, MM, YYYY, CCV);
                    end
                    else begin
                        Message(MgsCCV)
                    end;
                end
                else begin
                    Message(MsgYYYY);
                end;
            end
            else begin
                Message(MsgMM);
            end;
        end
        else begin
            Message(MsgCardNO);
        end;
    end;

    procedure Register(Customer: Record "customer")
    var
    begin
        CustomerReg := Customer;
        Run();
    end;

    var
        CardNO: code[16];
        MM: Code[2];
        YYYY: Code[4];
        Name: code[20];
        CCV: Code[3];
        error: Label 'You can not print this report.';
        MsgCardNO: Label 'The card number cannot be empty.';
        MsgMM: Label 'The month of the card cannot be empty';
        MsgYYYY: Label 'The expiration year of the card cannot be empty';
        MgsCCV: Label 'The CVV of the card cannot be empty';

        AccountNo: Code[20];
        CustomerReg: Record "Customer";
}
