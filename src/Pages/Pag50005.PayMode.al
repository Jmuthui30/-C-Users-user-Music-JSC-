page 50005 "Pay Mode"
{
    // version THL-Basic Fin 1.0
    PageType = List;
    ApplicationArea = All;
    SourceTable = "Pay Mode";
    UsageCategory = Lists;

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
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
