page 51624 "Appraisal Rating"
{
    // version THL- HRM 1.0
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Appraisal Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field("Total Possible Score"; Rec."Total Possible Score")
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
