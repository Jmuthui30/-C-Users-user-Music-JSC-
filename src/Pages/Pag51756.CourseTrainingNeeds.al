page 51756 "Course Training Needs"
{
    // version THL- HRM 1.0
    PageType = ListPart;
    SourceTable = "Course Training Needs";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Training Need Covered"; Rec."Training Need Covered")
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
