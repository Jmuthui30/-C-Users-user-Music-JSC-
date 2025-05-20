page 51657 "Orientation Checklist Setup"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Orientation Checklist Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Item; Rec.Item)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Timeline; Rec.Timeline)
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
