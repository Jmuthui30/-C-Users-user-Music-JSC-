page 51519 "Bal Scoring Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bal Scoring Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Bal Score Percipectives"; Rec."Bal Score Percipectives")
                {
                    ApplicationArea = All;
                }
                field("Bal Score Emp Categories"; Rec."Bal Score Emp Categories")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Percentage Score"; Rec."Percentage Score")
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
