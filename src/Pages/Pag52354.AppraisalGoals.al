page 52354 "Appraisal Goals"
{
    ApplicationArea = All;
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    Caption = 'Appraisal Goals';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Workplan Code"; Rec."Workplan Code")
                {
                    ToolTip = 'Specifies the value of the Workplan Code field.';
                    Caption = 'Objectives Code';
                }
                field("Workplan Description"; Rec."Workplan Description")
                {
                    ToolTip = 'Specifies the value of the Workplan Description field.';
                    Caption = 'Objectives Name';
                }
                field("Performance Measure"; Rec."Performance Measure")
                {
                    ToolTip = 'Specifies the value of the Performance Measure field.';
                }
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    Caption = 'Review Period';
                    Editable = false;
                    ToolTip = 'Specifies the quarterly review period for this objective line.';
                }
                field("Actual targets"; Rec."Actual targets")
                {
                    ToolTip = 'Specifies the value of the Actual/achieved targets field';
                    Caption = 'Perfomance Measure Description';
                }
                field("Initiative code"; Rec."Initiative code")
                {
                    ToolTip = 'Specifies the value of the Initiative code field';
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Initiative Description';
                    ToolTip = 'Specifies the value of the Initiatives field';
                }
                field("FY Target"; Rec."FY Target")
                {
                    Caption = 'Target';
                }
                field(Actual; Rec.Actual)
                {
                    Caption = 'Actual';
                    ToolTip = 'Specifies the value of the Actual field';
                    trigger OnValidate()
                    begin
                        if (Rec.Actual <> 0) and (Rec."FY Target" <> 0) then begin
                            Rec."Achieved (%)" := Round((Rec.Actual / Rec."FY Target") * 100, 0.01);
                            // Rec."Weighted Rating" := Round((Rec."Achieved (%)" * Rec.Weighting) / 100, 0.01);
                        end else begin
                            Rec."Achieved (%)" := 0;
                            // Rec."Weighted Rating" := 0;
                        end;
                    end;
                }
                
                field("Achieved (%)"; Rec."Achieved (%)")
                {
                    ToolTip = 'Specifies the value of the Achieved (%) field.';
                    Editable = false;
                }
                field("Self Rating"; Rec."Self Rating")
                {
                    ApplicationArea = All;
                    Editable = AppraiseeEditable;
                    ToolTip = 'Specifies the appraisee self-rating for this review period.';
                }
                field("Appraisee's comments"; Rec."Appraisee's comments")
                {
                    ApplicationArea = All;
                    Editable = AppraiseeEditable;
                    Caption = 'Appraisee Comments';
                    ToolTip = 'Specifies the appraisee comments for this objective.';
                }

                field(Weighting; Rec.Weighting)
                {
                    ApplicationArea = All;
                    Caption = 'Weighting (%)';
                    Editable = AppraiseeEditable;
                    ToolTip = 'Specifies this objective''s percentage weighting within the current review period.';

                    trigger OnValidate()
                    begin
                        CurrPage.Update(false);
                    end;
                }
                field("Weighted Rating"; Rec."Weighted Rating")
                {
                    Visible = false;
                    ToolTip = 'Specifies the weighting copied into the legacy weighted rating field.';
                    Editable = false;
                    trigger OnValidate()
                    begin
                        if Rec."Weighted Rating" <> 0 then begin
                            Rec.Rating := Round(Rec."Weighted Rating" * Rec."Achieved (%)" / 100, 0.01);
                        end;
                    end;
                }
                field(Rating; Rec.Rating)
                {
                    Caption = 'Weighted Score';
                    Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies the legacy weighted score value.';
                    //Editable = UnderReview;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Mid-Year Appraisal"; Rec."Mid-Year Appraisal")
                {
                    Caption = 'Rating by appraiser';
                    //Editable = LineEditable AND UnderReview AND MidYearVisible;
                    Visible = MidYearVisible;
                    ToolTip = 'Specifies the value of the Rating by appraiser field';

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Variance; Rec.Variance)
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Variance field';
                }
                field("Results Achieved Comments"; Rec."Results Achieved Comments")
                {
                    Visible = FinalYearVisible;
                    Caption = 'Appraiser''s comments';
                    Editable = AppraiserEditable;
                    ToolTip = 'Specifies the value of the Appraiser''s comments field';
                }
                field("Appraiser Rating"; Rec."Appraiser Rating")
                {
                    ApplicationArea = All;
                    Editable = AppraiserEditable;
                    ToolTip = 'Specifies the appraiser rating for this objective.';
                }
                field("Quarter Score"; Rec."Quarter Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the calculated score for this review period.';
                }
                field("Achievement Notes"; Rec."Achievement Notes")
                {
                    ApplicationArea = All;
                    Editable = AppraiseeEditable;
                    ToolTip = 'Specifies additional achievement notes for this review period.';
                }
                field("Corrective Action"; Rec."Corrective Action")
                {
                    ApplicationArea = All;
                    Editable = AppraiserEditable;
                    ToolTip = 'Specifies corrective action or emphasis for this objective.';
                }
                field("Appraisal No"; Rec."Appraisal No")
                {
                    Visible = false;
                    Enabled = false;
                    ToolTip = 'Specifies the value of the Appraisal No field';
                }
                /* 
                field("Objective Code"; Rec."Objective Code")
                {
                    Caption = 'Strategic objecive code';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Strategic objecive code field';
                }
                field("Key Responsibility"; Rec."Key Responsibility")
                {
                    Caption = 'Strategic Objectives';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Strategic Objectives field';
                }
                field("Activity code"; Rec."Activity code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activity code field';
                }
                field("Key Indicators"; Rec."Key Indicators")
                {
                    Caption = 'Activities';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activities field';
                }
                field(Task; Rec.Task)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Task field';
                }
                field(KPI; Rec.KPI)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the KPI field';
                }
                field("Agreed perfomance targets"; Rec."Agreed perfomance targets")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Agreed perfomance targets field';
                } */
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Suggest Equal Weighting")
            {
                ApplicationArea = All;
                Caption = 'Suggest Equal Weighting';
                Image = Suggest;
                ToolTip = 'Distributes 100 percent weighting equally across the objective lines for the current review period.';

                trigger OnAction()
                begin
                    SuggestEqualWeighting();
                end;
            }
        }
    }

    // trigger OnAfterGetRecord()
    // begin
    //     SetControlAppearance;
    // NameIndent := Indentation;
    // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    // end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GetHeader();
        SetControlAppearance();
        // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        GetHeader();
        Rec."Employee No" := EmployeeAppraisal."Employee No";
        Rec."Appraisal Period" := EmployeeAppraisal."Appraisal Period";
        Rec."Appraisal Type" := EmployeeAppraisal."Appraisal Type";
        Rec."Review Period Code" := EmployeeAppraisal."Current Review Period Code";
        // NameEmphasize := "Appraisal Line Type" <> "Appraisal Line Type"::Objective;
    end;

    trigger OnOpenPage()
    begin
        GetHeader();
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    var
        EmployeeAppraisal: Record "Employee Appraisal";
        AppraiseeEditable: Boolean;
        AppraiserEditable: Boolean;
        Approved: Boolean;
        Completed: Boolean;
        FinalYearVisible: Boolean;
        MidYearVisible: Boolean;
        Setting: Boolean;
        UnderReview: Boolean;

    local procedure GetHeader()
    begin
        //EmployeeAppraisal.SetRange(EmployeeAppraisal."Appraisal No", "Appraisal No");
        if EmployeeAppraisal.Get(Rec."Appraisal No") then;
    end;

    local procedure SetControlAppearance()
    begin
        GetHeader();

        UnderReview :=
            (EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released) and
            ((EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) or
             (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::"Further review"));

        AppraiseeEditable :=
            (EmployeeAppraisal.Status = EmployeeAppraisal.Status::Open) and
            ((EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Setting) or
             (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Set));
        AppraiserEditable := UnderReview;

        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Setting then
            Setting := true
        else
            Setting := false;

        if EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Completed then
            Completed := true
        else
            Completed := false;

        // if (EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::"Mid-Year") and (EmployeeAppraisal."Appraisal Status" = EmployeeAppraisal."Appraisal Status"::Review) then
        //     MidYearVisible := true
        // else
        //     MidYearVisible := false;

        // Legacy Mid-Year/Final-Year visibility retained for reference. Quarterly review fields are always part of the unified appraisal.
        // if EmployeeAppraisal."AppraisalType" = EmployeeAppraisal."AppraisalType"::"Final Year" then
        //     FinalYearVisible := true
        // else
        //     FinalYearVisible := false;
        FinalYearVisible := true;


        if EmployeeAppraisal.Status = EmployeeAppraisal.Status::Released then
            Approved := true
        else
            Approved := false;
    end;

    local procedure SuggestEqualWeighting()
    var
        AppraisalLine: Record "Appraisal Lines";
        LineCount: Integer;
        LineIndex: Integer;
        RemainingWeight: Decimal;
        SuggestedWeight: Decimal;
    begin
        GetHeader();
        SetControlAppearance();
        EmployeeAppraisal.TestField("Appraisal No");
        EmployeeAppraisal.TestField("Current Review Period Code");

        if not AppraiseeEditable then
            Error('Weighting can only be suggested while appraisal %1 is open for objective setting.', EmployeeAppraisal."Appraisal No");

        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        AppraisalLine.SetRange("Review Period Code", EmployeeAppraisal."Current Review Period Code");
        AppraisalLine.SetFilter("Workplan Code", '<>%1', '');
        LineCount := AppraisalLine.Count();
        if LineCount = 0 then
            Error('Enter objective lines before suggesting weighting for appraisal %1.', EmployeeAppraisal."Appraisal No");

        RemainingWeight := 100;
        SuggestedWeight := Round(100 / LineCount, 0.01);

        if AppraisalLine.FindSet() then
            repeat
                LineIndex += 1;
                if LineIndex = LineCount then
                    AppraisalLine.Validate(Weighting, RemainingWeight)
                else begin
                    AppraisalLine.Validate(Weighting, SuggestedWeight);
                    RemainingWeight -= SuggestedWeight;
                end;
                AppraisalLine.Modify(true);
            until AppraisalLine.Next() = 0;

        CurrPage.Update(false);
        Message('Suggested equal weighting for %1 objective line(s). Review and adjust the weighting before submitting.', LineCount);
    end;
}





