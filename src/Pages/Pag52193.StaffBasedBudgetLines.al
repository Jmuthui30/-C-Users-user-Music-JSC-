page 52193 "Staff Based Budget Lines"
{
    // version BUDGET
    PageType = ListPart;
    SourceTable = "Staff Based Budget";
    MultipleNewLines = false;

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
    actions
    {
        area(Processing)
        {
            action("Staff Based Budget")
            {
                ApplicationArea = All;
                Caption = 'Import';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                RunObject = xmlport "Staff Based Budget";
            }
        }
    }
    var StaffBasedBudget: XmlPort "Staff Based Budget";
}
