page 52192 "Budget Distribution"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    SourceTable = "Budget Distribution";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("GL Account"; Rec."GL Account")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        StaffBasedBudget.Reset();
                        StaffBasedBudget.SetRange(Budget, Rec.Budget);
                        StaffBasedBudget.SetRange("Budget Line Account", Rec."GL Account");
                        StaffBasedBudget.SetRange(Department, Rec.Department);
                        StaffBasedBudget.SetRange(Branch, Rec.Branch);
                        StaffBasedBudget.SetRange("SI Code", Rec."SI Code");
                        Page.Run(Page::"Staff Based Budget", StaffBasedBudget);
                    end;
                }
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Move Distribut to Draft Budget")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = MovementWorksheet;
                RunObject = report "Move Distribut to Draft Budget";
            }
        }
    }
    var StaffBasedBudget: Record "Staff Based Budget";
}
