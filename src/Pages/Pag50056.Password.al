page 50056 Password
{
    ApplicationArea = All;
    Caption = 'Enter Password';
    PageType = StandardDialog;

    // Caption = 'Enter Password';
    layout
    {
        area(content)
        {
            field(EnterPassword; EnterPassword)
            {
                ToolTip = 'Enter Password';
                ApplicationArea = All;
                Caption = 'Enter Password';
                ExtendedDatatype = Masked;
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean var
        PasswordManagement: Codeunit "Password Management";
    begin
        if CloseAction in[Action::OK]then PasswordManagement.SetPassword(EnterPassword)
        else
            PasswordManagement.SetPassword('');
    end;
    var EnterPassword: text[30];
}
