page 51616 "Appraisal Setup"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Appraisal Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                }
                field("Due Date for Appraisees"; Rec."Due Date for Appraisees")
                {
                    ApplicationArea = All;
                }
                field("Due Date for Appraisers"; Rec."Due Date for Appraisers")
                {
                    ApplicationArea = All;
                }
                field(Activated; Rec.Activated)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
