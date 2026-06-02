page 52593 "Appraisal Review History"
{
    ApplicationArea = All;
    Caption = 'Appraisal Review History';
    Editable = false;
    PageType = List;
    SourceTable = "Appraisal Lines";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quarterly review period for this objective line.';
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                    ApplicationArea = All;
                    Caption = 'Objective Code';
                    ToolTip = 'Specifies the objective code.';
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                    ApplicationArea = All;
                    Caption = 'Objective';
                    ToolTip = 'Specifies the objective description.';
                }
                field("Performance Measure"; Rec."Performance Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the performance measure.';
                }
                field("FY Target"; Rec."FY Target")
                {
                    ApplicationArea = All;
                    Caption = 'Target';
                    ToolTip = 'Specifies the approved performance target.';
                }
                field(Actual; Rec.Actual)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual achieved target.';
                }
                field("Achieved (%)"; Rec."Achieved (%)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the achieved percentage.';
                }
                field(Weighting; Rec.Weighting)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the objective weighting.';
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee self-rating.';
                }
                field("Appraisee's comments"; Rec."Appraisee's comments")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee Comments';
                    ToolTip = 'Specifies the appraisee comments.';
                }
                field("Appraiser Rating"; Rec."Appraiser Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser rating.';
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Appraiser Comments';
                    ToolTip = 'Specifies the appraiser comments.';
                }
                field("Quarter Score"; Rec."Quarter Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated score for the review period.';
                }
                field(Reviewed; Rec.Reviewed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this review line has been carried forward to the next review period.';
                }
            }
        }
    }
}
