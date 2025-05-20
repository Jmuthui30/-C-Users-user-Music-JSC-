codeunit 55055 "GeneralSettings"
{
    procedure weburl(): text;
    begin
        exit('http://localhost/TeknohubDynamicsSupport/');
    end;
    procedure IsSelfService(): Boolean var
        User: Record "User Settings";
    begin
        User.Reset();
        User.SetRange("User ID", UserId);
        if User.FindFirst()then begin
            if format(User."Profile ID").Contains('EMPLOYEE')then exit(true)
            else
                exit(false);
        end
        else
            exit(true);
    end;
}
