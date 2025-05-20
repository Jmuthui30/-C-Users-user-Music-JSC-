page 52025 "Score Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Score Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Score ID"; Rec."Score ID")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
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
