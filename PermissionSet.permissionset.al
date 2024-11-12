permissionset 50200 PermissionSet
{
    Assignable = true;
    Permissions = tabledata "DXBank" = RIMD,
        tabledata "DXBanking Setup" = RIMD,
        tabledata "DX Azul Log Response" = RIMD,
        tabledata "DXTB Azul Setup" = RIMD,
        table "DXBank" = X,
        table "DXBanking Setup" = X,
        table "DX Azul Log Response" = X,
        table "DXTB Azul Setup" = X,
        report "DX ADD CARD" = X,
        report "DX Register Agreement" = X,
        codeunit "DX Send Azul" = X,
        codeunit "Http Request" = X,
        page "DX Azul Transactions" = X,
        page DXBank = X,
        page DXBankCard = X,
        page "DX Azul Setup Page" = X,
        page "DXBanking Setup" = X;
}