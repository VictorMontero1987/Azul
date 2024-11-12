page 50202 DXBank
{
    ApplicationArea = All;
    Caption = 'DXBank';
    PageType = List;
    CardPageID = "DXBankCard";
    SourceTable = DXBank;
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    ToolTip = 'Specifies the value of the Journal Template Name field.', Comment = '%';
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ToolTip = 'Specifies the value of the Journal Batch Name field.', Comment = '%';
                }
                field("CodeUnit ID"; Rec."CodeUnit ID")
                {
                    ToolTip = 'Specifies the value of the CodeUnit ID field.', Comment = '%';
                }
                field("No.Autorizacion"; Rec."No.Autorizacion")
                {
                    ToolTip = 'Specifies the value of the No.Autorizacion field.', Comment = '%';
                }
            }
        }
    }
}
