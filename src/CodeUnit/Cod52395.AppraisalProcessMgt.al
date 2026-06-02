codeunit 52395 "Appraisal Process Mgt."
{
    procedure ValidateAppraiseeSubmission(EmployeeAppraisal: Record "Employee Appraisal")
    begin
        EmployeeAppraisal.TestField("Appraisal Period");
        EmployeeAppraisal.TestField("Employee No");
        EmployeeAppraisal.TestField("Appraiser No");
        EmployeeAppraisal.TestField("Current Review Period Code");

        ValidateObjectiveLines(EmployeeAppraisal, false);
    end;

    procedure ValidateAppraiserCompletion(EmployeeAppraisal: Record "Employee Appraisal")
    begin
        EmployeeAppraisal.TestField("Appraisal Period");
        EmployeeAppraisal.TestField("Employee No");
        EmployeeAppraisal.TestField("Appraiser No");
        EmployeeAppraisal.TestField("Current Review Period Code");

        ValidateObjectiveLines(EmployeeAppraisal, true);
    end;

    procedure MoveToNextReviewPeriod(var EmployeeAppraisal: Record "Employee Appraisal")
    var
        CurrentPeriod: Record "Bal Score Preview Periods";
        FinalPeriod: Record "Bal Score Preview Periods";
        NextPeriod: Record "Bal Score Preview Periods";
        NextPeriodLine: Record "Appraisal Lines";
        NextPeriodStartDate: Date;
    begin
        EmployeeAppraisal.TestField("Current Review Period Code");
        CurrentPeriod.Get(EmployeeAppraisal."Current Review Period Code");
        CurrentPeriod.TestField("Review Sequence");

        if not FindFinalReviewPeriod(FinalPeriod) then
            Error('Select one appraisal review period as the final review period before moving appraisals.');
        FinalPeriod.TestField("Review Sequence");

        // Legacy fixed final period retained for reference.
        // if CurrentPeriod."Review Sequence" >= 4 then
        //     Error('Review period %1 is the final review period. Complete the appraisal instead.', CurrentPeriod.Code);
        if CurrentPeriod."Review Sequence" >= FinalPeriod."Review Sequence" then
            Error('Review period %1 is the final review period. Complete the appraisal instead.', CurrentPeriod.Code);

        ValidateAppraiserCompletion(EmployeeAppraisal);

        NextPeriod.Reset();
        NextPeriod.SetRange("Review Sequence", CurrentPeriod."Review Sequence" + 1);
        if not NextPeriod.FindFirst() then
            Error('There is no next appraisal review period after %1.', CurrentPeriod.Code);

        if NextPeriod."Review Sequence" > FinalPeriod."Review Sequence" then
            Error('Review period %1 is after the selected final review period %2 and is ignored.', NextPeriod.Code, FinalPeriod.Code);

        if NextPeriod.Closed then
            Error('Review period %1 is already closed.', NextPeriod.Code);

        NextPeriodStartDate := GetReviewPeriodStartDate(EmployeeAppraisal, NextPeriod);
        if (NextPeriodStartDate <> 0D) and (WorkDate() < NextPeriodStartDate) then
            Error('Review period %1 starts on %2. You cannot move appraisal %3 before that date.', NextPeriod.Code, NextPeriodStartDate, EmployeeAppraisal."Appraisal No");

        NextPeriodLine.Reset();
        NextPeriodLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        NextPeriodLine.SetRange("Review Period Code", NextPeriod.Code);
        if not NextPeriodLine.FindFirst() then
            CopyCurrentReviewLinesToNext(EmployeeAppraisal, CurrentPeriod.Code, NextPeriod.Code);

        MarkCurrentReviewLinesReviewed(EmployeeAppraisal, CurrentPeriod.Code);

        EmployeeAppraisal."Current Review Period Code" := NextPeriod.Code;
        EmployeeAppraisal.Status := EmployeeAppraisal.Status::Open;
        EmployeeAppraisal."Appraisal Status" := EmployeeAppraisal."Appraisal Status"::Setting;
        EmployeeAppraisal.Modify(true);
    end;

    local procedure ValidateObjectiveLines(EmployeeAppraisal: Record "Employee Appraisal"; RequireAppraiserFields: Boolean)
    var
        AppraisalLine: Record "Appraisal Lines";
        HasObjectiveLine: Boolean;
        TotalWeighting: Decimal;
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        AppraisalLine.SetRange("Review Period Code", EmployeeAppraisal."Current Review Period Code");
        AppraisalLine.SetFilter("Workplan Code", '<>%1', '');
        if AppraisalLine.FindSet() then begin
            repeat
                HasObjectiveLine := true;
                AppraisalLine.TestField("Review Period Code");
                AppraisalLine.TestField("Workplan Code");
                AppraisalLine.TestField("Performance Measure");
                AppraisalLine.TestField("FY Target");
                AppraisalLine.TestField(Weighting);
                TotalWeighting += AppraisalLine.Weighting;
                AppraisalLine.TestField("Self Rating");
                AppraisalLine.TestField("Appraisee's comments");

                if RequireAppraiserFields then begin
                    AppraisalLine.TestField("Appraiser Rating");
                    AppraisalLine.TestField("Results Achieved Comments");
                    AppraisalLine.TestField("Quarter Score");
                end;
            until AppraisalLine.Next() = 0;
        end;

        if not HasObjectiveLine then
            Error('Enter at least one appraisal objective line before submitting appraisal %1.', EmployeeAppraisal."Appraisal No");

        if Round(TotalWeighting, 0.01) <> 100 then
            Error('Total weighting for appraisal %1 review period %2 must be 100. Current total is %3.',
                EmployeeAppraisal."Appraisal No",
                EmployeeAppraisal."Current Review Period Code",
                Round(TotalWeighting, 0.01));
    end;

    local procedure CopyCurrentReviewLinesToNext(EmployeeAppraisal: Record "Employee Appraisal"; CurrentReviewPeriod: Code[20]; NextReviewPeriod: Code[20])
    var
        CurrentLine: Record "Appraisal Lines";
        NewLine: Record "Appraisal Lines";
        LastLine: Record "Appraisal Lines";
        LineNo: Integer;
    begin
        LastLine.Reset();
        LastLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        if LastLine.FindLast() then
            LineNo := LastLine."Line No";

        CurrentLine.Reset();
        CurrentLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        CurrentLine.SetRange("Review Period Code", CurrentReviewPeriod);
        CurrentLine.SetFilter("Workplan Code", '<>%1', '');
        if CurrentLine.FindSet() then
            repeat
                LineNo += 10000;

                NewLine.Init();
                NewLine."Appraisal No" := EmployeeAppraisal."Appraisal No";
                NewLine."Line No" := LineNo;
                NewLine."Employee No" := EmployeeAppraisal."Employee No";
                NewLine."Appraisal Period" := EmployeeAppraisal."Appraisal Period";
                NewLine."Appraisal Type" := EmployeeAppraisal."Appraisal Type";
                NewLine."Review Period Code" := NextReviewPeriod;
                NewLine."Workplan Code" := CurrentLine."Workplan Code";
                NewLine."Workplan Description" := CurrentLine."Workplan Description";
                NewLine."Performance Measure" := CurrentLine."Performance Measure";
                NewLine."Actual targets" := CurrentLine."Actual targets";
                NewLine."FY Target" := CurrentLine."FY Target";
                NewLine.Weighting := CurrentLine.Weighting;
                NewLine."Initiative code" := CurrentLine."Initiative code";
                NewLine.Description := CurrentLine.Description;
                NewLine."Objective Code" := CurrentLine."Objective Code";
                NewLine."Key Responsibility" := CurrentLine."Key Responsibility";
                NewLine."Key Indicators" := CurrentLine."Key Indicators";
                NewLine.KPI := CurrentLine.KPI;
                NewLine."Agreed Target Date" := CurrentLine."Agreed Target Date";
                NewLine."Appraisal Line Type" := CurrentLine."Appraisal Line Type";
                NewLine.Insert(true);
            until CurrentLine.Next() = 0;
    end;

    local procedure MarkCurrentReviewLinesReviewed(EmployeeAppraisal: Record "Employee Appraisal"; CurrentReviewPeriod: Code[20])
    var
        AppraisalLine: Record "Appraisal Lines";
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        AppraisalLine.SetRange("Review Period Code", CurrentReviewPeriod);
        if AppraisalLine.FindSet() then
            repeat
                AppraisalLine.Reviewed := true;
                AppraisalLine.Modify(true);
            until AppraisalLine.Next() = 0;
    end;

    local procedure GetReviewPeriodStartDate(EmployeeAppraisal: Record "Employee Appraisal"; ReviewPeriod: Record "Bal Score Preview Periods"): Date
    var
        AppraisalPeriod: Record "Appraisal Periods";
        FinalPeriod: Record "Bal Score Preview Periods";
        PeriodEndDate: Date;
        PeriodStartDate: Date;
    begin
        if ReviewPeriod."Start Date" <> 0D then
            exit(ReviewPeriod."Start Date");

        PeriodStartDate := EmployeeAppraisal."Period Start";
        PeriodEndDate := EmployeeAppraisal."Period End";
        if PeriodStartDate = 0D then begin
            if not AppraisalPeriod.Get(EmployeeAppraisal."Appraisal Period") then
                exit(0D);
            PeriodStartDate := AppraisalPeriod."Start Date";
        end;
        if PeriodEndDate = 0D then begin
            if AppraisalPeriod.Period = '' then
                if not AppraisalPeriod.Get(EmployeeAppraisal."Appraisal Period") then
                    exit(0D);
            PeriodEndDate := AppraisalPeriod."End Date";
        end;

        if (PeriodStartDate = 0D) or (PeriodEndDate = 0D) then
            exit(0D);

        if PeriodEndDate < PeriodStartDate then
            exit(0D);

        if not FindFinalReviewPeriod(FinalPeriod) then
            exit(0D);
        FinalPeriod.TestField("Review Sequence");

        // Legacy fixed quarter offsets retained for reference.
        // case ReviewPeriod."Review Sequence" of
        //     1:
        //         exit(PeriodStartDate);
        //     2:
        //         exit(CalcDate('<3M>', PeriodStartDate));
        //     3:
        //         exit(CalcDate('<6M>', PeriodStartDate));
        //     4:
        //         exit(CalcDate('<9M>', PeriodStartDate));
        // end;
        exit(CalculateReviewPeriodStartDate(PeriodStartDate, PeriodEndDate, ReviewPeriod."Review Sequence", FinalPeriod."Review Sequence"));
    end;

    local procedure CalculateReviewPeriodStartDate(PeriodStartDate: Date; PeriodEndDate: Date; ReviewSequence: Integer; FinalReviewSequence: Integer): Date
    var
        MonthsPerReview: Integer;
        PeriodMonthCount: Integer;
        StartMonthOffset: Integer;
    begin
        if (ReviewSequence <= 0) or (FinalReviewSequence <= 0) then
            exit(0D);

        if ReviewSequence > FinalReviewSequence then
            exit(0D);

        if not TryGetFullCalendarMonthCount(PeriodStartDate, PeriodEndDate, PeriodMonthCount) then
            exit(0D);

        if PeriodMonthCount mod FinalReviewSequence <> 0 then
            exit(0D);

        MonthsPerReview := PeriodMonthCount DIV FinalReviewSequence;
        StartMonthOffset := (ReviewSequence - 1) * MonthsPerReview;
        exit(AddMonthsToDate(PeriodStartDate, StartMonthOffset));
    end;

    local procedure TryGetFullCalendarMonthCount(PeriodStartDate: Date; PeriodEndDate: Date; var PeriodMonthCount: Integer): Boolean
    begin
        if (PeriodStartDate = 0D) or (PeriodEndDate = 0D) then
            exit(false);

        if PeriodEndDate < PeriodStartDate then
            exit(false);

        if Date2DMY(PeriodStartDate, 1) <> 1 then
            exit(false);

        if PeriodEndDate <> CalcDate('<CM>', PeriodEndDate) then
            exit(false);

        PeriodMonthCount := ((Date2DMY(PeriodEndDate, 3) - Date2DMY(PeriodStartDate, 3)) * 12) + Date2DMY(PeriodEndDate, 2) - Date2DMY(PeriodStartDate, 2) + 1;
        exit(PeriodMonthCount > 0);
    end;

    local procedure AddMonthsToDate(ReferenceDate: Date; MonthOffset: Integer): Date
    var
        DateExpression: DateFormula;
    begin
        if MonthOffset = 0 then
            exit(ReferenceDate);

        Evaluate(DateExpression, '<' + Format(MonthOffset) + 'M>');
        exit(CalcDate(DateExpression, ReferenceDate));
    end;

    local procedure FindFinalReviewPeriod(var PreviewPeriod: Record "Bal Score Preview Periods"): Boolean
    begin
        PreviewPeriod.Reset();
        PreviewPeriod.SetRange("Final Review Period", true);
        if PreviewPeriod.FindFirst() then
            exit(true);

        PreviewPeriod.Reset();
        PreviewPeriod.SetRange("Preview Period Type", PreviewPeriod."Preview Period Type"::"Full Period Appraisal");
        exit(PreviewPeriod.FindFirst());
    end;
}
