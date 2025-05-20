page 51666 "Medical Cover Limits"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Medical Cover Limits";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Cover; Rec.Cover)
                {
                    ApplicationArea = All;
                }
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
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
