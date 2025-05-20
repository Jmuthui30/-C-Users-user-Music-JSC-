page 52035 "Objective Lines-Appraisal"
{
    PageType = ListPart;
    SourceTable = "Appraisal Objectives Lines";

    layout
    {
        area(content)
        {
            repeater(Control8)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    ApplicationArea = All;
                    Caption = 'Objectives';
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    ApplicationArea = All;
                    Caption = 'Action Plan(list specific activities)';
                }
                field("Agreed Target Date"; Rec."Agreed Target Date")
                {
                    ApplicationArea = All;
                    Caption = 'Time Frame';
                }
                field(Weighting; Rec.Weighting)
                {
                    ApplicationArea = All;
                    Caption = 'Performance Rating(weight)';
                }
                field("Score/Points"; Rec."Score/Points")
                {
                    ApplicationArea = All;
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
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
