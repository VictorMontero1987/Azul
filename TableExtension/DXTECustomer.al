tableextension 50200 "DXCustomer " extends "Customer"
{
    fields
    {
        field(50200; IDAzul; text[10])
        {
            Caption = 'ID Azul';
            DataClassification = CustomerContent;
        }
        field(50201; "Send Azul"; Boolean)
        {
            Caption = 'Send Aul';
            DataClassification = CustomerContent;
        }
        field(50202; IDCardAzul; Text[50])
        {
            Caption = 'ID Card Azul';
            DataClassification = CustomerContent;
        }
        /* field(50203; Period; Text[1])
         {
             Caption = 'Period';
             DataClassification = CustomerContent;
         }

         field(50204; "Expiration Date"; Date)
         {
             Caption = 'Expiration Date';
             DataClassification = CustomerContent;
         }
         field(50205; Share; Decimal)
         {
             Caption = 'Share';
             DataClassification = CustomerContent;
         }
         field(50206; ExecutionDay; Integer)
         {
             Caption = 'Execution Day';
             DataClassification = CustomerContent;
         }*/

        field(50207; "IDtarjeraRegAzul"; Text[20])
        {
            Caption = 'ID tarjera Registrada';
            DataClassification = CustomerContent;
        }
        /* field(50208; "Nota"; Text[50])
         {
             Caption = 'Nota';
             DataClassification = CustomerContent;
         }
         field(50209; "Duedate"; Text[50])
         {
             Caption = 'Due date';
             DataClassification = CustomerContent;
         }*/


    }
}
