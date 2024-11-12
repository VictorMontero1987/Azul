namespace Azul.Azul;

page 50203 "DX Azul Transactions"
{
    ApplicationArea = All;
    Caption = 'DX Azul Transactions';
    PageType = List;
    SourceTable = "DX Azul Log Response";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                /* field(Id; Rec.Id)
                 {
                     Caption = 'Id';
                     ApplicationArea = All;
                     ToolTip = 'Specifies the value of the Id field.', Comment = '%';
                 }*/
                field(AuthorizationCode; Rec.AuthorizationCode)
                {
                    Caption = 'Authorization Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AuthorizationCode field.', Comment = '%';
                }
                field(AzulOrderId; Rec.AzulOrderId)
                {
                    Caption = 'Azul Order Id';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AzulOrderId field.', Comment = '%';
                }
                field(CustomOrderId; Rec.CustomOrderId)
                {
                    Caption = 'Custom Order Id';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the CustomOrderId field.', Comment = '%';
                }
                field(DataVaultBrand; Rec.DataVaultBrand)
                {
                    Caption = 'DataVault Brand';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DataVaultBrand field.', Comment = '%';
                }
                field(DataVaultExpiration; Rec.DataVaultExpiration)
                {
                    Caption = 'DataVault Expiration';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DataVaultExpiration field.', Comment = '%';
                }
                field(DataVaultToken; Rec.DataVaultToken)
                {
                    Caption = 'DataVault Token';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DataVaultToken field.', Comment = '%';
                }
                field("DateTime"; Rec."DateTime")
                {
                    Caption = 'DateTime';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the DateTime field.', Comment = '%';
                }
                field(ErrorDescription; Rec.ErrorDescription)
                {
                    Caption = 'Error Description';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ErrorDescription field.', Comment = '%';
                }
                field(IsoCode; Rec.IsoCode)
                {
                    Caption = 'Iso Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the IsoCode field.', Comment = '%';
                }
                field(LotNumber; Rec.LotNumber)
                {
                    Caption = 'Lot Number';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the LotNumber field.', Comment = '%';
                }
                field(RNN; Rec.RNN)
                {
                    Caption = 'RNN';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the RNN field.', Comment = '%';
                }
                field(ResponseCode; Rec.ResponseCode)
                {
                    Caption = 'Response Code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ResponseCode field.', Comment = '%';
                }
                field(ResponseMessage; Rec.ResponseMessage)
                {
                    Caption = 'Response Message';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ResponseMessage field.', Comment = '%';
                }
                field(Ticket; Rec.Ticket)
                {
                    Caption = 'Ticket';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ticket field.', Comment = '%';
                }
                field("Member Contact No."; Rec."Member Contact No.")
                {
                    Caption = 'Member Contact No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Member Id field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Caption = 'Customer No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    Caption = 'Amount';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Amount field.', Comment = '%';
                }
                field("Transactiontype"; Rec."Transactiontype")
                {
                    Caption = 'Transaction type';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Transaction Type field.', Comment = '%';
                }
                field("Reference No."; Rec."Reference No.")
                {
                    Caption = 'Reference No.';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reference No. field.', Comment = '%';
                }

            }
        }
    }
}
