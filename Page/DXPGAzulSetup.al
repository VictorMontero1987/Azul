page 50200 "DX Azul Setup Page"
{
    ApplicationArea = All;
    Caption = 'DX Azul Setup';
    SourceTable = "DXTB Azul Setup";
    UsageCategory = Administration;
    PageType = Card;
    // Permissions = tabledata "TriningGym Setup" = IMR;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'Config Azure';
                field("IDReg"; Rec.IDReg)
                {
                    Caption = 'ID Registro';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("Channel"; Rec.Channel)
                {
                    Caption = 'Channel';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("SendAzure"; Rec.SendAzul)
                {
                    Caption = 'Send Azure';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field(Store; rec.Store)
                {
                    Caption = 'Store';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("URLPrimary"; rec.URLPrimary)
                {
                    Caption = 'URL Primary';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("URLSecondary"; Rec.URLSecondary)
                {
                    Caption = 'URL Secondary';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("PrimaryUrlHoldTrans"; Rec.PrimaryUrlHoldTrans)
                {
                    Caption = 'Primary Url Hold Trans';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("SencodaryUrlHoldTrans"; Rec.SencodaryUrlHoldTrans)
                {
                    Caption = 'Sencodary Url Hold Trans';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("ProcessVoid"; Rec.ProcessVoid)
                {
                    Caption = 'Process Void';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("CertThumbprint"; Rec.CertThumbprint)
                {
                    Caption = 'Cert. Thumbprint';
                    ApplicationArea = All;
                    ToolTip = '';
                }
                field("Attempts"; Rec.Attempts)
                {
                    Caption = 'Attempts';
                    ApplicationArea = All;
                    ToolTip = 'Attempts allowed before blocking the client';
                }


            }

        }

    }

    var
        SaleHeader: text[10];

}