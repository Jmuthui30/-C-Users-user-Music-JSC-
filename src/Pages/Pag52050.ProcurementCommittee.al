page 52050 "Procurement Committee"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Procurement Commitee";

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
                field("Minimum Members"; Rec."Minimum Members")
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
