page 52178 "Staff Based Budget"
{
    // version BUDGET
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = ListPart;
    SourceTable = "Staff Based Budget";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Dept Name"; Rec."Dept Name")
                {
                    ApplicationArea = All;
                }
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("SI Code"; Rec."SI Code")
                {
                    ApplicationArea = All;
                }
                field("Strategic Initiative"; Rec."Strategic Initiative")
                {
                    ApplicationArea = All;
                }
                field("Budget Line Account"; Rec."Budget Line Account")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
