page 51645 "Internal Memo Setup"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Internal Memo Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Primary Key"; Rec."Primary Key")
                {
                    ApplicationArea = All;
                }
                field("Internal Memo Nos."; Rec."Internal Memo Nos.")
                {
                    ApplicationArea = All;
                }
                field("Activate Email Notification"; Rec."Activate Email Notification")
                {
                    ApplicationArea = All;
                }
                field("Staff Distribution List"; Rec."Staff Distribution List")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
