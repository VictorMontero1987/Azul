table 50200 "DXTB Azul Setup"
{
    Caption = 'DXTB Azure Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; URLPrimary; Text[150])
        {
            Caption = 'URL Primary';
            DataClassification = ToBeClassified;
        }
        field(2; URLSecondary; Text[150])
        {
            Caption = 'URL Secondary';
            DataClassification = ToBeClassified;
        }
        field(3; Store; Text[20])
        {
            Caption = 'Store';
            DataClassification = ToBeClassified;
        }
        field(4; Channel; Text[25])
        {
            Caption = 'Channel';
            DataClassification = ToBeClassified;
        }
        field(5; SendAzul; Boolean)
        {
            Caption = 'SendAzure';
            DataClassification = ToBeClassified;
        }

        field(6; IDReg; Integer)
        {
            AutoIncrement = true;
            Caption = 'IDReg';
            DataClassification = ToBeClassified;
        }
        field(7; Currency; Enum "DXEN Currency")
        {

            Caption = 'Currency';
            DataClassification = ToBeClassified;
        }
        field(8; Token; Text[250])
        {
            Caption = 'Token';
            DataClassification = ToBeClassified;
        }
        field(9; PrimaryUrlHoldTrans; Text[250])
        {
            Caption = 'Primary Url Hold Trans';
            DataClassification = ToBeClassified;
        }
        field(10; SencodaryUrlHoldTrans; Text[250])
        {
            Caption = 'Secondary Url Hold Trans';
            DataClassification = ToBeClassified;
        }
        field(11; ProcessVoid; Text[250])
        {
            Caption = 'Process Void';
            DataClassification = ToBeClassified;
        }
        field(12; CertThumbprint; Text[150])
        {
            Caption = 'Cert Thumbprint';
            DataClassification = ToBeClassified;
        }
        field(13; FormaPago; Code[10])
        {
            Caption = 'FormaPago';
            TableRelation = "Payment Method".Code;
            DataClassification = ToBeClassified;
        }
        field(14; "AutoPosted"; Boolean)
        {
            Caption = 'AutoPosted';
            DataClassification = ToBeClassified;
        }
        field(15; "Attempts"; Integer)
        {
            Caption = 'Attempts';
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(PK; IDReg)
        {
            Clustered = true;
        }
    }
}
