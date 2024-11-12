page 50201 DXBankCard
{
    ApplicationArea = All;
    Caption = 'DXBank Card';
    PageType = Card;
    SourceTable = DXBank;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
    actions
    {
        area(Reporting)
        {
            action("DXReport Journal")
            {
                ApplicationArea = All;
                Image = PaymentJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Proceso Recoleccion en Informacion';

                trigger OnAction()
                begin
                    //Genera Reporte Proceso de Recolección en Información                    
                    Report.Run(50116, true, true);
                    //Genera Reporte Proceso de Recolección en Información
                end;
            }
        }
    }
}
