table 50203 "DXBanking Setup"
{
    Caption = 'DXBanking Setup';

    fields
    {
        field(50116; "Key"; Code[1])
        {
            Caption = 'Key';
        }
        field(50117; "Local Currency"; Code[10])
        {
            Caption = 'Local Currency';
            TableRelation = "Currency";
        }
        field(50118; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(50119; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series';
            TableRelation = "No. Series";
        }
        field(50120; "Recibo de Ingreso"; Boolean)
        {
            Caption = 'Recibo de Ingreso';
            DataClassification = ToBeClassified;
        }
        field(50121; "AutoPosted"; Boolean)
        {
            Caption = 'AutoPosted';
        }
    }
    keys
    {
        key(PK; "Key")
        {
            Clustered = true;
        }
    }
}
