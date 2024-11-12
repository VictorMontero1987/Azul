pageextension 50200 "DX Customer" extends "Customer Card"
{
    layout
    {
        addafter(Payments)
        {
            group(Azul)
            {

                field(IDCardNet; rec.IDAzul)
                {
                    Enabled = false;
                    ApplicationArea = All;
                    Caption = 'ID Azul';
                    ToolTip = '';
                }
                field(EnviarCardnet; rec."Send Azul")
                {
                    Enabled = false;
                    ApplicationArea = All;
                    Caption = 'Send Azul';
                    ToolTip = '';
                }
                field(IDTarjetaCardNet; rec.IDCardAzul)
                {
                    Enabled = false;
                    ApplicationArea = All;
                    Caption = 'ID Card Azul.';
                    ToolTip = '';
                }

            }

        }
    }
    actions
    {
        addafter("WordTemplate")
        {
            action("Register credit card in Azul")
            {
                ApplicationArea = All;
                Caption = 'Register credit card in Azul';
                Image = SendTo;
                trigger OnAction()
                var
                    DxSendAzul: codeunit "DX Send azul";
                    "DX ADD CARD": Report "DX ADD CARD";
                begin
                    if DXSetup.FindFirst() then begin
                        if DXSetup.SendAzul = true then begin
                            // if rec.IDCardAzul = '' then begin
                            "DX ADD CARD".Register(Rec);
                            //   end
                            // else begin
                            //      Message(message);
                            //  end;

                        end
                        else begin
                            Message(message);
                        end;
                    end
                    else begin
                        Message(message1);
                    end;
                end;

            }
        }
    }
    var
        Período: Option Daily,Weekly,Biweekly,Monthly;
        DxText001: Text;
        DXSetup: Record "DXTB Azul Setup";
        message: Label 'This user is already registered on Azul ';
        message1: Label 'You need to configure the connection parameters for the API Azul';

}
