codeunit 51431 "Login Management Ext"
{
    procedure IsWebServiceUser(UID: Code[70]): Boolean begin
        if CurrentClientType = CLIENTTYPE::Web then exit(false)
        else
            exit(true);
    end;
}
