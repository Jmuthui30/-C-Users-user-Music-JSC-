codeunit 51820 "AL Logon Management"
{
    // version NAVW111.00
    SingleInstance = true;

    trigger OnRun()
    begin
    end;
    var LogonInProgress: Boolean;
    procedure IsLogonInProgress(): Boolean begin
        exit(LogonInProgress);
    end;
    procedure SetLogonInProgress(Value: Boolean)
    begin
        LogonInProgress:=Value;
    end;
}
