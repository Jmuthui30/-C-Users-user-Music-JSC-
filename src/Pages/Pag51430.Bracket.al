page 51430 "Bracket"
{
    // version THL- Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Bracket;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table Code"; Rec."Table Code")
                {
                    ApplicationArea = All;
                }
                field(Band; Rec.Band)
                {
                    ApplicationArea = All;
                }
                field("Base Amount"; Rec."Base Amount")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Lower Limit"; Rec."Lower Limit")
                {
                    ApplicationArea = All;
                }
                field("Upper Limit"; Rec."Upper Limit")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Institution; Rec.Institution)
                {
                    ApplicationArea = All;
                }
                field("Contribution Rates Inclusive"; Rec."Contribution Rates Inclusive")
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
