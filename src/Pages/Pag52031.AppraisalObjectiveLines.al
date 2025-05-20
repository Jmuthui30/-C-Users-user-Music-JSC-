page 52031 "Appraisal Objective Lines"
{
    PageType = ListPart;
    SourceTable = "Appraisal Objectives Lines";
    SourceTableView = SORTING("Employee No", "Appraisal Type", "Appraisal Period", "Line No");

    layout
    {
        area(content)
        {
            repeater(Control9)
            {
                ShowCaption = false;

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No"; Rec."Line No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    ApplicationArea = All;
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    ApplicationArea = All;
                }
                field("Agreed Target Date"; Rec."Agreed Target Date")
                {
                    ApplicationArea = All;
                }
                field(Weighting; Rec.Weighting)
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
