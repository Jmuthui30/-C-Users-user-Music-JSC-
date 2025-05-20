page 52179 "Budget Categories"
{
    // version BUDGET
    DeleteAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Budget Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field("Business Unit"; Rec."Business Unit")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    ApplicationArea = All;
                }
                field("Budget Line Description"; Rec."Budget Line Description")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Inactive; Rec.Inactive)
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
