page 50204 "DXBanking Setup"
{
    PageType = Card;
    Caption = 'DXBanking Setup';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "DXBanking Setup";
    DeleteAllowed = true;
    InsertAllowed = true;
    PromotedActionCategories = 'New,Process,Task,Report,DXBank,DXBankingReference';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Key"; Rec."Key")
                {
                    ToolTip = 'Specifies the value of the Key field.', Comment = '%';
                    Visible = false;
                }
                field("Local Currency"; Rec."Local Currency")
                {
                    ToolTip = 'Specifies the value of the Local Currency field.', Comment = '%';
                }
                field("No. Series"; Rec."No. Series")
                {
                    ToolTip = 'Specifies the value of the No. Series field.', Comment = '%';
                }
                field("Posting No. Series"; Rec."Posting No. Series")
                {
                    ToolTip = 'Specifies the value of the Posting No. Series field.', Comment = '%';
                }
                field("Recibo de Ingreso"; Rec."Recibo de Ingreso")
                {
                    ToolTip = 'Specifies the value of the Recibo de Ingreso field.', Comment = '%';
                }
                field(AutoPosted; Rec.AutoPosted)
                {
                    ToolTip = 'Specifies the value of the AutoPosted field.', Comment = '%';

                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(DxBank)
            {
                Caption = 'DxBank';
                ApplicationArea = All;
                RunObject = page "DXBank";
                Promoted = true;
                Image = Bank;
                PromotedCategory = Category5;
            }
        }
    }
}
