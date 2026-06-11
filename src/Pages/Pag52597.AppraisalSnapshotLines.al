page 52597 "Appraisal Snapshot Lines"
{
    ApplicationArea = All;
    Caption = 'Appraisal Snapshot Lines';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Appraisal Snapshot Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Objective Code"; Rec."Objective Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the objective code.';
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the objective.';
                }
                field("Performance Measure"; Rec."Performance Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the performance measure.';
                }
                field("Perf. Measure Description"; Rec."Perf. Measure Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the performance measure description.';
                }
                field("Initiative Code"; Rec."Initiative Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the initiative code.';
                }
                field("Initiative Description"; Rec."Initiative Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the initiative description.';
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the target.';
                }
                field(Actual; Rec.Actual)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual value.';
                }
                field("Achieved (%)"; Rec."Achieved (%)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the achieved percentage.';
                }
                field(Weighting; Rec.Weighting)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the weighting.';
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the self rating.';
                }
                field("Appraisee Comments"; Rec."Appraisee Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee comments.';
                }
                field("Appraiser Rating"; Rec."Appraiser Rating")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser rating.';
                }
                field("Appraiser Comments"; Rec."Appraiser Comments")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser comments.';
                }
                field("Quarter Score"; Rec."Quarter Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quarter score.';
                }
                field("Achievement Notes"; Rec."Achievement Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the achievement notes.';
                }
                field("Corrective Action"; Rec."Corrective Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the corrective action.';
                }
            }
        }
    }
}
