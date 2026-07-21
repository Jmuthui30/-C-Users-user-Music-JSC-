page 52602 "Appraisal Planning Lines"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    Caption = 'Objective Planning Lines';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Appraisal Planning Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    Editable = LinesEditable;
                    ToolTip = 'Specifies the appraisal review period for this planned objective.';
                }
                field("Department Code"; "Department Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the department code.';
                    visible = false;
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                    ApplicationArea = All;
                    Editable = LinesEditable;
                    ToolTip = 'Specifies the objective selected from Appraisal Workplan Codes.';
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the objective description.';
                }
                field("Performance Measure"; Rec."Performance Measure")
                {
                    ApplicationArea = All;
                    Editable = LinesEditable;
                    ToolTip = 'Specifies the performance measure under the selected objective.';
                }
                field("Perf. Measure Description"; Rec."Perf. Measure Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the performance measure description.';
                }
                field("Initiative Code"; Rec."Initiative Code")
                {
                    ApplicationArea = All;
                    Editable = LinesEditable;
                    ToolTip = 'Specifies the initiative linked to the selected objective.';
                }
                field("Initiative Description"; Rec."Initiative Description")
                {
                    ApplicationArea = All;
                    Editable = LinesEditable;
                    ToolTip = 'Specifies the initiative description.';
                }
                field("Rating Allocation"; Rec."Rating Allocation")
                {
                    ApplicationArea = All;
                    Editable = LinesEditable;
                    ToolTip = 'Specifies the agreed maximum result score for this objective. Review period totals must equal 70.';
                }
                field(Target; Rec.Target)
                {
                    ApplicationArea = All;
                    Editable = LinesEditable;
                    ToolTip = 'Specifies the agreed target for the planned objective.';
                }
                field(Actual; Rec.Actual)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the actual value. Actual entry is done on the Employee Appraisal card, not during planning.';
                }
                field("Achieved (%)"; Rec."Achieved (%)")
                {
                    ApplicationArea = All;
                    visible = false;
                    ToolTip = 'Specifies the calculated achievement percentage. This remains blank during planning.';
                }
                field("Weighting (%)"; Rec."Weighting (%)")
                {
                    ApplicationArea = All;
                    visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the calculated weighting percentage derived from the 70-point rating allocation.';
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        SetControlAppearance();
        Rec.PopulateFromHeader();
    end;

    var
        LinesEditable: Boolean;

    local procedure SetControlAppearance()
    var
        PlanHeader: Record "Appraisal Planning Header";
    begin
        LinesEditable := false;
        if Rec."Plan No." = '' then
            exit;
        if PlanHeader.Get(Rec."Plan No.") then
            LinesEditable := PlanHeader."Planning Status" in [PlanHeader."Planning Status"::Draft, PlanHeader."Planning Status"::"Returned for Changes"];
    end;
}
