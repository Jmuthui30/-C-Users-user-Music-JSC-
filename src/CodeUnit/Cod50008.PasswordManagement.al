codeunit 50008 "Password Management"
{
    SingleInstance = true;

    procedure SetPassword(MyPassword: Text[30])
    begin
        GlobalPassword:=MyPassword;
    end;
    procedure GetPassword()CurrentPassword: Text[30]begin
        CurrentPassword:=GlobalPassword;
    end;
    var GlobalPassword: text[30];
}
