page 51743 "Performance Issues"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Performance Issues";

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
}
