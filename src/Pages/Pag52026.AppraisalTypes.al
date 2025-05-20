page 52026 "Appraisal Types"
{
    SourceTable = "Appraisal Types";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Control10)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Max. Weighting"; Rec."Max. Weighting")
                {
                    ApplicationArea = All;
                }
                field("Minimum Job Group"; Rec."Minimum Job Group")
                {
                    ApplicationArea = All;
                }
                field("Maximum Job Group"; Rec."Maximum Job Group")
                {
                    ApplicationArea = All;
                }
                field("Max. Score"; Rec."Max. Score")
                {
                    ApplicationArea = All;
                }
                field("Use Template"; Rec."Use Template")
                {
                    ApplicationArea = All;
                }
                field("Template Link"; Rec."Template Link")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
