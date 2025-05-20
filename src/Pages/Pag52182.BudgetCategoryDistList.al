page 52182 "Budget Category Dist. List"
{
    // version BUDGET
    Caption = 'Budget Category Distribution';
    CardPageID = "Budget Category Dist. Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Budget Category Dist. Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Business Unit"; Rec."Business Unit")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
