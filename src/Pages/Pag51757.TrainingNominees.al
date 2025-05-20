page 51757 "Training Nominees"
{
    // version THL- HRM 1.0
    PageType = ListPart;
    SourceTable = "Training Nominees";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
