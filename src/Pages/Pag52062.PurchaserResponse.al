page 52062 "Purchaser Response"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Purchaser Response";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Accept Note"; Rec."Accept Note")
                {
                    ApplicationArea = All;
                }
                field("Return Note"; Rec."Return Note")
                {
                    ApplicationArea = All;
                }
                field("Reject Note"; Rec."Reject Note")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                end;
            }
        }
    }
}
