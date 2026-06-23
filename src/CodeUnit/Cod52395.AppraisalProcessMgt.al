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

        EmployeeAppraisal.RecalculateFrameworkScores();
        EmployeeAppraisal.Modify(true);

        StampCurrentReviewComments(EmployeeAppraisal, CurrentPeriod.Code);
        StampCurrentReviewOutcomes(EmployeeAppraisal, CurrentPeriod.Code);
        CreateReviewSnapshot(EmployeeAppraisal, CurrentPeriod);
        MarkCurrentReviewLinesReviewed(EmployeeAppraisal, CurrentPeriod.Code);

        EmployeeAppraisal."Current Review Period Code" := NextPeriod.Code;
        EmployeeAppraisal.Status := EmployeeAppraisal.Status::Open;
        EmployeeAppraisal."Appraisal Status" := EmployeeAppraisal."Appraisal Status"::Setting;
        EmployeeAppraisal."Appraisee Agreed" := false;
        EmployeeAppraisal."Appraiser Agreed" := false;
        EmployeeAppraisal.Modify(true);

        Commit();
        if not TrySendNextReviewPeriodNotification(EmployeeAppraisal, CurrentPeriod, NextPeriod) then
            Message(
                'Appraisal %1 moved to review period %2, but the appraisee email notification could not be sent. Verify the employee email address and Business Central email account setup.',
                EmployeeAppraisal."Appraisal No",
                NextPeriod.Code);
    end;

    procedure StampCurrentReviewCommentsForCurrentPeriod(EmployeeAppraisal: Record "Employee Appraisal")
    begin
        StampCurrentReviewComments(EmployeeAppraisal, EmployeeAppraisal."Current Review Period Code");
    end;

    procedure CreateCurrentReviewSnapshot(EmployeeAppraisal: Record "Employee Appraisal")
    var
        CurrentPeriod: Record "Bal Score Preview Periods";
    begin
        EmployeeAppraisal.TestField("Current Review Period Code");
        CurrentPeriod.Get(EmployeeAppraisal."Current Review Period Code");
        EmployeeAppraisal.RecalculateFrameworkScores();
        EmployeeAppraisal.Modify(true);
        StampCurrentReviewComments(EmployeeAppraisal, CurrentPeriod.Code);
        StampCurrentReviewOutcomes(EmployeeAppraisal, CurrentPeriod.Code);
        CreateReviewSnapshot(EmployeeAppraisal, CurrentPeriod);
    end;

    procedure OpenReviewSnapshots(EmployeeAppraisal: Record "Employee Appraisal")
    var
        ReviewSnapshot: Record "Appraisal Review Snapshot";
    begin
        EmployeeAppraisal.TestField("Appraisal No");
        EnsureReviewSnapshotsFromHistory(EmployeeAppraisal);

        ReviewSnapshot.Reset();
        ReviewSnapshot.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        if ReviewSnapshot.IsEmpty() then
            Message('No closed review snapshots exist yet for appraisal %1. A snapshot is created when a review period is moved to the next period.', EmployeeAppraisal."Appraisal No");

        Commit();
        Page.RunModal(Page::"Appraisal Review Snapshots", ReviewSnapshot);
    end;

    local procedure CreateReviewSnapshot(EmployeeAppraisal: Record "Employee Appraisal"; ReviewPeriod: Record "Bal Score Preview Periods")
    var
        ReviewSnapshot: Record "Appraisal Review Snapshot";
        SnapshotComment: Record "Appraisal Snapshot Comment";
        SnapshotLine: Record "Appraisal Snapshot Line";
        SnapshotOutcome: Record "Appraisal Snapshot Outcome";
    begin
        EmployeeAppraisal.RecalculateFrameworkScores();

        SnapshotLine.Reset();
        SnapshotLine.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        SnapshotLine.SetRange("Review Period Code", ReviewPeriod.Code);
        SnapshotLine.DeleteAll(true);

        SnapshotComment.Reset();
        SnapshotComment.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        SnapshotComment.SetRange("Review Period Code", ReviewPeriod.Code);
        SnapshotComment.DeleteAll(true);

        SnapshotOutcome.Reset();
        SnapshotOutcome.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        SnapshotOutcome.SetRange("Review Period Code", ReviewPeriod.Code);
        SnapshotOutcome.DeleteAll(true);

        if not ReviewSnapshot.Get(EmployeeAppraisal."Appraisal No", ReviewPeriod.Code) then begin
            ReviewSnapshot.Init();
            ReviewSnapshot."Appraisal No." := EmployeeAppraisal."Appraisal No";
            ReviewSnapshot."Review Period Code" := ReviewPeriod.Code;
            ReviewSnapshot.Insert(true);
        end;

        ReviewSnapshot."Review Period Name" := ReviewPeriod.Name;
        ReviewSnapshot."Snapshot Date-Time" := CurrentDateTime();
        ReviewSnapshot."Snapshot By" := UserId;
        ReviewSnapshot."Appraisal Period" := EmployeeAppraisal."Appraisal Period";
        ReviewSnapshot."Period Start" := EmployeeAppraisal."Period Start";
        ReviewSnapshot."Period End" := EmployeeAppraisal."Period End";
        ReviewSnapshot."Review Start Date" := ReviewPeriod."Start Date";
        ReviewSnapshot."Review End Date" := ReviewPeriod."End Date";
        ReviewSnapshot."Final Review Period" := ReviewPeriod."Final Review Period";
        ReviewSnapshot."Employee No." := EmployeeAppraisal."Employee No";
        ReviewSnapshot."Appraisee Name" := EmployeeAppraisal."Appraisee Name";
        ReviewSnapshot."Appraisee Job Title" := EmployeeAppraisal."Appraisee's Job Title";
        ReviewSnapshot."Job Group" := EmployeeAppraisal."Job Group";
        ReviewSnapshot."Directorate Code" := EmployeeAppraisal."Directorate Code";
        ReviewSnapshot."Directorate Name" := EmployeeAppraisal."Directorate Name";
        ReviewSnapshot."Appraiser No." := EmployeeAppraisal."Appraiser No";
        ReviewSnapshot."Appraiser ID" := EmployeeAppraisal."Appraiser ID";
        ReviewSnapshot."Appraiser Name" := EmployeeAppraisal."Appraisers Name";
        ReviewSnapshot."Appraiser Job Title" := EmployeeAppraisal."Appraiser's Job Title";
        ReviewSnapshot."Source Status" := CopyStr(Format(EmployeeAppraisal.Status), 1, MaxStrLen(ReviewSnapshot."Source Status"));
        ReviewSnapshot."Source Appraisal Status" := CopyStr(Format(EmployeeAppraisal."Appraisal Status"), 1, MaxStrLen(ReviewSnapshot."Source Appraisal Status"));
        ReviewSnapshot."Total Weighting" := CalculateReviewWeighting(EmployeeAppraisal."Appraisal No", ReviewPeriod.Code);
        ReviewSnapshot."Current Review Score" := CalculateReviewScore(EmployeeAppraisal."Appraisal No", ReviewPeriod.Code);
        ReviewSnapshot."Total Review Score" := CalculateCumulativeReviewScore(EmployeeAppraisal."Appraisal No", ReviewPeriod);
        ReviewSnapshot."Total Rating" := ReviewSnapshot."Total Review Score";
        ReviewSnapshot."Total Percentage Score" := EmployeeAppraisal."Total Percentage FY Rating";
        ReviewSnapshot."Performance Grade" := EmployeeAppraisal."Grade final year rating";
        ReviewSnapshot."Attribute Total Rating" := EmployeeAppraisal."Total FY Attributes";
        ReviewSnapshot."Attribute Expected Rating" := EmployeeAppraisal."Expected TR -attributes";
        ReviewSnapshot."Attribute Percentage Score" := EmployeeAppraisal."Total Percentage-Attributes";
        ReviewSnapshot."Attribute Grade" := EmployeeAppraisal."Grade-Attributes";
        ReviewSnapshot."Appraisee Agreed" := EmployeeAppraisal."Appraisee Agreed";
        ReviewSnapshot."Appraiser Agreed" := EmployeeAppraisal."Appraiser Agreed";
        ReviewSnapshot.Modify(true);

        CopySnapshotLines(EmployeeAppraisal, ReviewPeriod);
        CopySnapshotComments(EmployeeAppraisal, ReviewPeriod);
        CopySnapshotOutcomes(EmployeeAppraisal, ReviewPeriod);
    end;

    local procedure EnsureReviewSnapshotsFromHistory(EmployeeAppraisal: Record "Employee Appraisal")
    var
        AppraisalLine: Record "Appraisal Lines";
        CurrentPeriod: Record "Bal Score Preview Periods";
        ReviewPeriod: Record "Bal Score Preview Periods";
        ReviewSnapshot: Record "Appraisal Review Snapshot";
    begin
        if EmployeeAppraisal."Current Review Period Code" = '' then
            exit;

        if not CurrentPeriod.Get(EmployeeAppraisal."Current Review Period Code") then
            exit;

        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        AppraisalLine.SetFilter("Review Period Code", '<>%1', '');
        AppraisalLine.SetRange(Reviewed, true);
        if AppraisalLine.FindSet() then
            repeat
                if (AppraisalLine."Review Period Code" <> EmployeeAppraisal."Current Review Period Code") and
                   ReviewPeriod.Get(AppraisalLine."Review Period Code") and
                   (ReviewPeriod."Review Sequence" < CurrentPeriod."Review Sequence") and
                   not ReviewSnapshot.Get(EmployeeAppraisal."Appraisal No", ReviewPeriod.Code)
                then
                    CreateReviewSnapshot(EmployeeAppraisal, ReviewPeriod);
            until AppraisalLine.Next() = 0;
    end;

    local procedure CalculateReviewWeighting(AppraisalNo: Code[20]; ReviewPeriodCode: Code[20]): Decimal
    var
        AppraisalLine: Record "Appraisal Lines";
        TotalWeighting: Decimal;
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", AppraisalNo);
        AppraisalLine.SetRange("Review Period Code", ReviewPeriodCode);
        if AppraisalLine.FindSet() then
            repeat
                TotalWeighting += AppraisalLine.Weighting;
            until AppraisalLine.Next() = 0;

        exit(Round(TotalWeighting, 0.01));
    end;

    local procedure CalculateReviewScore(AppraisalNo: Code[20]; ReviewPeriodCode: Code[20]): Decimal
    var
        AppraisalLine: Record "Appraisal Lines";
        TotalScore: Decimal;
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", AppraisalNo);
        AppraisalLine.SetRange("Review Period Code", ReviewPeriodCode);
        if AppraisalLine.FindSet() then
            repeat
                TotalScore += AppraisalLine."Quarter Score";
            until AppraisalLine.Next() = 0;

        exit(Round(TotalScore, 0.01));
    end;

    local procedure CalculateCumulativeReviewScore(AppraisalNo: Code[20]; ReviewPeriod: Record "Bal Score Preview Periods"): Decimal
    var
        AppraisalLine: Record "Appraisal Lines";
        LineReviewPeriod: Record "Bal Score Preview Periods";
        TotalScore: Decimal;
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", AppraisalNo);
        AppraisalLine.SetFilter("Review Period Code", '<>%1', '');
        if AppraisalLine.FindSet() then
            repeat
                if LineReviewPeriod.Get(AppraisalLine."Review Period Code") then
                    if LineReviewPeriod."Review Sequence" <= ReviewPeriod."Review Sequence" then
                        TotalScore += AppraisalLine."Quarter Score";
            until AppraisalLine.Next() = 0;

        exit(Round(TotalScore, 0.01));
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

    local procedure CopySnapshotLines(EmployeeAppraisal: Record "Employee Appraisal"; ReviewPeriod: Record "Bal Score Preview Periods")
    var
        AppraisalLine: Record "Appraisal Lines";
        SnapshotLine: Record "Appraisal Snapshot Line";
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", EmployeeAppraisal."Appraisal No");
        AppraisalLine.SetRange("Review Period Code", ReviewPeriod.Code);
        if AppraisalLine.FindSet() then
            repeat
                SnapshotLine.Init();
                SnapshotLine."Appraisal No." := EmployeeAppraisal."Appraisal No";
                SnapshotLine."Review Period Code" := ReviewPeriod.Code;
                SnapshotLine."Line No." := AppraisalLine."Line No";
                SnapshotLine."Objective Code" := AppraisalLine."Workplan Code";
                SnapshotLine.Objective := AppraisalLine."Workplan Description";
                SnapshotLine."Performance Measure" := AppraisalLine."Performance Measure";
                SnapshotLine."Perf. Measure Description" := AppraisalLine."Actual targets";
                SnapshotLine."Initiative Code" := AppraisalLine."Initiative code";
                SnapshotLine."Initiative Description" := AppraisalLine.Description;
                SnapshotLine.Target := AppraisalLine."FY Target";
                SnapshotLine.Actual := AppraisalLine.Actual;
                SnapshotLine."Achieved (%)" := AppraisalLine."Achieved (%)";
                SnapshotLine.Weighting := AppraisalLine.Weighting;
                SnapshotLine."Self Rating" := AppraisalLine."Self Rating";
                SnapshotLine."Appraisee Comments" := AppraisalLine."Appraisee's comments";
                SnapshotLine."Appraiser Rating" := AppraisalLine."Appraiser Rating";
                SnapshotLine."Appraiser Comments" := AppraisalLine."Results Achieved Comments";
                SnapshotLine."Quarter Score" := AppraisalLine."Quarter Score";
                SnapshotLine."Achievement Notes" := AppraisalLine."Achievement Notes";
                SnapshotLine."Corrective Action" := AppraisalLine."Corrective Action";
                SnapshotLine.Reviewed := true;
                SnapshotLine.Insert(true);
            until AppraisalLine.Next() = 0;
    end;

    local procedure CopySnapshotComments(EmployeeAppraisal: Record "Employee Appraisal"; ReviewPeriod: Record "Bal Score Preview Periods")
    var
        AppraisalComment: Record "Appraisal Comments";
        EntryNo: Integer;
    begin
        AppraisalComment.Reset();
        AppraisalComment.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        AppraisalComment.SetRange("Review Period Code", ReviewPeriod.Code);
        if AppraisalComment.FindSet() then
            repeat
                CopySnapshotComment(EmployeeAppraisal, ReviewPeriod.Code, AppraisalComment, EntryNo);
            until AppraisalComment.Next() = 0;

        if ReviewPeriod."Final Review Period" then begin
            AppraisalComment.Reset();
            AppraisalComment.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
            AppraisalComment.SetRange("Review Period Code", '');
            if AppraisalComment.FindSet() then
                repeat
                    CopySnapshotComment(EmployeeAppraisal, ReviewPeriod.Code, AppraisalComment, EntryNo);
                until AppraisalComment.Next() = 0;
        end;
    end;

    local procedure CopySnapshotComment(EmployeeAppraisal: Record "Employee Appraisal"; ReviewPeriodCode: Code[20]; AppraisalComment: Record "Appraisal Comments"; var EntryNo: Integer)
    var
        SnapshotComment: Record "Appraisal Snapshot Comment";
    begin
        EntryNo += 10000;

        SnapshotComment.Init();
        SnapshotComment."Appraisal No." := EmployeeAppraisal."Appraisal No";
        SnapshotComment."Review Period Code" := ReviewPeriodCode;
        SnapshotComment."Entry No." := EntryNo;
        SnapshotComment.Section := CopyStr(Format(AppraisalComment.Person), 1, MaxStrLen(SnapshotComment.Section));
        SnapshotComment."Appraisee / Section Comment" := AppraisalComment."Comments on Performance";
        SnapshotComment."Appraiser Comment" := AppraisalComment."Comments On Supervisor";
        SnapshotComment."Developmental Action" := AppraisalComment."Developmental Action";
        SnapshotComment.Date := AppraisalComment.Date;
        SnapshotComment.Insert(true);
    end;

    local procedure CopySnapshotOutcomes(EmployeeAppraisal: Record "Employee Appraisal"; ReviewPeriod: Record "Bal Score Preview Periods")
    var
        AppraisalOutcome: Record "Appraisal Outcome";
        SnapshotOutcome: Record "Appraisal Snapshot Outcome";
    begin
        AppraisalOutcome.Reset();
        AppraisalOutcome.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        AppraisalOutcome.SetRange("Review Period Code", ReviewPeriod.Code);
        if AppraisalOutcome.FindSet() then
            repeat
                SnapshotOutcome.Init();
                SnapshotOutcome."Appraisal No." := EmployeeAppraisal."Appraisal No";
                SnapshotOutcome."Review Period Code" := ReviewPeriod.Code;
                SnapshotOutcome."Line No." := AppraisalOutcome."Line No.";
                SnapshotOutcome."Outcome No." := AppraisalOutcome."Outcome No.";
                SnapshotOutcome."Outcome Type" := AppraisalOutcome."Outcome Type";
                SnapshotOutcome.Subject := AppraisalOutcome.Subject;
                SnapshotOutcome."Letter Body" := AppraisalOutcome."Letter Body";
                SnapshotOutcome."Issue Date" := AppraisalOutcome."Issue Date";
                SnapshotOutcome."Issued By" := AppraisalOutcome."Issued By";
                SnapshotOutcome.Status := CopyStr(Format(AppraisalOutcome.Status), 1, MaxStrLen(SnapshotOutcome.Status));
                SnapshotOutcome.Rating := AppraisalOutcome.Rating;
                SnapshotOutcome.Grade := AppraisalOutcome.Grade;
                SnapshotOutcome.Insert(true);
            until AppraisalOutcome.Next() = 0;
    end;

    local procedure StampCurrentReviewComments(EmployeeAppraisal: Record "Employee Appraisal"; CurrentReviewPeriod: Code[20])
    var
        AppraisalComment: Record "Appraisal Comments";
    begin
        if CurrentReviewPeriod = '' then
            exit;

        AppraisalComment.Reset();
        AppraisalComment.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        AppraisalComment.SetRange("Review Period Code", '');
        AppraisalComment.SetFilter(Person, '%1|%2|%3',
            AppraisalComment.Person::"Substantial Achievements",
            AppraisalComment.Person::"Significant Positive Issues",
            AppraisalComment.Person::"Significant Negative Issues");
        if AppraisalComment.FindSet() then
            repeat
                AppraisalComment."Review Period Code" := CurrentReviewPeriod;
                AppraisalComment.Modify(true);
            until AppraisalComment.Next() = 0;
    end;

    local procedure StampCurrentReviewOutcomes(EmployeeAppraisal: Record "Employee Appraisal"; CurrentReviewPeriod: Code[20])
    var
        AppraisalOutcome: Record "Appraisal Outcome";
    begin
        if CurrentReviewPeriod = '' then
            exit;

        AppraisalOutcome.Reset();
        AppraisalOutcome.SetRange("Appraisal No.", EmployeeAppraisal."Appraisal No");
        AppraisalOutcome.SetRange("Review Period Code", '');
        if AppraisalOutcome.FindSet() then
            repeat
                AppraisalOutcome."Review Period Code" := CurrentReviewPeriod;
                AppraisalOutcome.Modify(true);
            until AppraisalOutcome.Next() = 0;
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

    [TryFunction]
    local procedure TrySendNextReviewPeriodNotification(EmployeeAppraisal: Record "Employee Appraisal"; PreviousPeriod: Record "Bal Score Preview Periods"; NextPeriod: Record "Bal Score Preview Periods")
    var
        CompanyInfo: Record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Employee: Record Employee;
        Body: Text;
        RecipientEmail: Text;
        Subject: Text[250];
    begin
        Employee.Get(EmployeeAppraisal."Employee No");
        RecipientEmail := Employee."Company E-Mail";
        if RecipientEmail = '' then
            RecipientEmail := Employee."E-Mail";
        if RecipientEmail = '' then
            Error('Employee %1 does not have a company or personal email address.', Employee."No.");

        CompanyInfo.Get();
        Subject := StrSubstNo('Performance appraisal moved to %1', NextPeriod.Code);
        Body :=
            StrSubstNo(
                '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p>' +
                '<p style="font-family:Verdana,Arial;font-size:10pt">Your performance appraisal <b>%2</b> for appraisal period <b>%3</b> has moved from review period <b>%4</b> to <b>%5</b>.</p>' +
                '<p style="font-family:Verdana,Arial;font-size:10pt">The appraisal is now open for the new review period. Please review the carried-forward objectives and complete the required entries for this period.</p>' +
                '<p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,<br>Human Resource Management<br>%6</p>',
                EmployeeAppraisal."Appraisee Name",
                EmployeeAppraisal."Appraisal No",
                EmployeeAppraisal."Appraisal Period",
                PreviousPeriod.Code,
                NextPeriod.Code,
                CompanyInfo.Name);

        EmailMessage.Create(RecipientEmail, Subject, Body, true);
        if not Email.Send(EmailMessage, Enum::"Email Scenario"::Default) then
            Error('The appraisal review-period notification could not be sent.');
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
