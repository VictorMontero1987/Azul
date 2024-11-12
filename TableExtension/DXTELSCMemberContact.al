namespace BodyShop.BodyShop;

tableextension 50201 "DXLSC Member Contact " extends "LSC Member Contact"
{
    fields
    {

        field(50213; SendAzul; Boolean)
        {
            Caption = 'Send Azul';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50214; DataVaultToken; text[250])
        {
            Caption = 'Data Vault Token';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(50215; AzulOrderId; text[15])
        {
            Caption = 'Azul Order Id';
            DataClassification = EndUserIdentifiableInformation;
        }





    }
}
