namespace Azul.Azul;

enum 50202 "DX Process Type"
{
    Extensible = true;

    value(0; "Record")
    {
        Caption = 'Record';
    }
    value(1; "Payments")
    {
        Caption = 'Payments';
    }
    value(2; "Cancel Transaction")
    {
        Caption = 'Cancel Transaction';
    }
    value(3; "Refund")
    {
        Caption = 'Refund';
    }
}
