table 50202 DXBank
{
    Caption = 'DXBank';
    DataClassification = ToBeClassified;

    fields
    {
        field(50116; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(50117; "Name"; Text[50])
        {
            Caption = 'Name';
        }
        field(50118; "Journal Template Name"; Text[80])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(50119; "Journal Batch Name"; Text[80])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name" = FIELD("Journal Template Name"));
        }
        field(50120; "CodeUnit ID"; Integer)
        {
            Caption = 'CodeUnit ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Codeunit));

        }
        field(50121; "No.Autorizacion"; Code[30])
        {
            Caption = 'No.Autorizacion';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        Validate("CodeUnit ID");
    end;
}
