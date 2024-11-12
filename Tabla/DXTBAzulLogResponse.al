table 50201 "DX Azul Log Response"
{
    Caption = 'DX Azul Log Response';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Integer)
        {
            AutoIncrement = true;
            Caption = 'Id';
            DataClassification = ToBeClassified;
        }
        field(2; "Member Contact No."; Code[20])
        {
            Caption = 'Member Id';
            DataClassification = ToBeClassified;
        }
        field(3; AuthorizationCode; Text[15])
        {
            Caption = 'AuthorizationCode';
            DataClassification = ToBeClassified;
        }
        field(4; AzulOrderId; Text[15])
        {
            Caption = 'AzulOrderId';
            DataClassification = ToBeClassified;
        }
        field(5; CustomOrderId; Text[75])
        {
            Caption = 'CustomOrderId';
            DataClassification = ToBeClassified;
        }
        field(6; "DateTime"; Text[14])
        {
            Caption = 'DateTime';
            DataClassification = ToBeClassified;
        }
        field(7; ErrorDescription; Text[250])
        {
            Caption = 'ErrorDescription';
            DataClassification = ToBeClassified;
        }
        field(8; IsoCode; Text[2])
        {
            Caption = 'IsoCode';
            DataClassification = ToBeClassified;
        }
        field(9; ResponseCode; Text[7])
        {
            Caption = 'ResponseCode';
            DataClassification = ToBeClassified;
        }
        field(10; ResponseMessage; Text[250])
        {
            Caption = 'ResponseMessage';
            DataClassification = ToBeClassified;
        }
        field(11; Ticket; Text[4])
        {
            Caption = 'Ticket';
            DataClassification = ToBeClassified;
        }
        field(12; DataVaultBrand; Text[15])
        {
            Caption = 'DataVaultBrand';
            DataClassification = ToBeClassified;
        }
        field(13; DataVaultExpiration; Text[6])
        {
            Caption = 'DataVaultExpiration';
            DataClassification = ToBeClassified;
        }
        field(14; DataVaultToken; Text[150])
        {
            Caption = 'DataVaultToken';
            DataClassification = ToBeClassified;
        }
        field(15; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = ToBeClassified;
        }
        field(16; "Reference No."; Code[20])
        {
            Caption = 'Reference No.';
            DataClassification = ToBeClassified;
        }
        field(17; "Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(18; "LotNumber"; text[6])
        {
            Caption = 'LotNumber';
            DataClassification = ToBeClassified;
        }
        field(19; "RNN"; text[25])
        {
            Caption = 'RNN';
            DataClassification = ToBeClassified;
        }
        field(20; Transactiontype; Enum "DX Process Type")
        {
            Caption = 'Transaction Type';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(PK; Id, "Member Contact No.")
        {
            Clustered = true;
        }
    }
}
