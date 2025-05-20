page 51532 "Employee Last Roles"
{
    AutoSplitKey = true;
    Caption = 'Last Roles';
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "HR_Employee Last Roles";

    layout
    {
        area(content)
        {
            repeater(Control15)
            {
                ShowCaption = false;

                field("Role ID"; Rec."Role ID")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
    end;
}
