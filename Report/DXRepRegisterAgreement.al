namespace BodyShop.BodyShop;
using Microsoft.Sales.Customer;

report 50201 "DX Register Agreement"
{
    Caption = 'Register Agreement';
    UseRequestPage = true;
    ProcessingOnly = false;
    dataset
    {
        dataitem(Customer; Customer)
        {

        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group("Register Agreement")
                {
                    field(fechaVencimiento; fechaVencimiento)
                    {
                        ApplicationArea = all;
                        Caption = 'Expiration date';
                    }
                    field(diaEjecucion; diaEjecucion)
                    {
                        ApplicationArea = all;
                        Caption = 'Execution day';
                    }
                    field(Período; Período)
                    {
                        ApplicationArea = all;
                        Caption = 'Periodo';
                        OptionCaption = 'Diario,Semana,Quincenal,Mensual';
                        //OptionMembers = D,S,Q,M;
                    }
                    field(monto; monto)
                    {
                        ApplicationArea = all;
                        Caption = 'Amount';
                    }

                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        Customer: Record Customer;
        RegCard: Codeunit "DX Send Azul";
    begin
       // RegCard.UpRegAcuerdoCardNet(Customer, fechaVencimiento, diaEjecucion, periodo, monto)
    end;

    var
        Período: Option Diario,Semana,Quincenal,Mensual;

        "fechaVencimiento": Date;
        "diaEjecucion": Text;
        "periodo": text;
        "monto": Decimal;

}
