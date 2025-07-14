page 52435 "Portal Users"
{
    ApplicationArea = All;
    Caption = 'Portal Users';
    PageType = List;
    SourceTable = HRPortalUsers;
    UsageCategory = Lists;
    DeleteAllowed = true;
    Editable = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(employeeName; Rec.employeeName)
                {
                    ToolTip = 'Specifies the value of the employeeName field.', Comment = '%';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.', Comment = '%';
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.', Comment = '%';
                }
                field(changedPassword; Rec.changedPassword)
                {
                    ToolTip = 'Specifies the value of the changedPassword field.', Comment = '%';
                }
                field(employeeNo; Rec.employeeNo)
                {
                    ToolTip = 'Specifies the value of the employeeNo field.', Comment = '%';
                }
                field(password; Rec.password)
                {
                    ToolTip = 'Specifies the value of the password field.', Comment = '%';
                }
                field(IdNo; Rec.IdNo)
                {
                    ToolTip = 'Specifies the value of the IdNo field.', Comment = '%';
                }
                field("Authentication Email"; Rec."Authentication Email")
                {
                    ToolTip = 'Specifies the value of the Authentication Email field.', Comment = '%';
                }
            }
        }
    }
}
