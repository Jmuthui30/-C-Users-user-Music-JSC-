codeunit 52600 "Appraisal Planning Mgt."
{
    procedure SubmitPlan(PlanNo: Code[20]; ActorEmployeeNo: Code[20])
    var
        PlanHeader: Record "Appraisal Planning Header";
        StatusBefore: Text[50];
    begin
        PlanHeader.Get(PlanNo);
        PlanHeader.EnsureEditable();
        ValidatePlan(PlanHeader, false);
        PlanHeader.TestField("Employee Agreed", true);

        StatusBefore := CopyStr(Format(PlanHeader."Planning Status"), 1, 50);
        PlanHeader."Planning Status" := PlanHeader."Planning Status"::"Pending Appraiser Review";
        PlanHeader."Submitted At" := CurrentDateTime();
        PlanHeader."Submitted By" := CopyStr(UserId, 1, MaxStrLen(PlanHeader."Submitted By"));
        PlanHeader."Review Round" += 1;
        Clear(PlanHeader."Last Review Reason");
        PlanHeader.Modify(true);

        InsertHistory(PlanHeader."No.", 'Sent for appraiser review', StatusBefore, Format(PlanHeader."Planning Status"), '');
    end;

    procedure ReturnPlan(PlanNo: Code[20]; ActorEmployeeNo: Code[20]; Reason: Text[250])
    var
        PlanHeader: Record "Appraisal Planning Header";
        StatusBefore: Text[50];
    begin
        PlanHeader.Get(PlanNo);
        if not (PlanHeader."Planning Status" in [PlanHeader."Planning Status"::"Pending Appraiser Review", PlanHeader."Planning Status"::"Pending HR Approval"]) then
            Error('Only appraisal planning documents pending review can be returned.');
        if Reason = '' then
            Error('Enter a return reason before returning appraisal planning %1.', PlanHeader."No.");

        StatusBefore := CopyStr(Format(PlanHeader."Planning Status"), 1, 50);
        PlanHeader."Planning Status" := PlanHeader."Planning Status"::"Returned for Changes";
        PlanHeader."Returned At" := CurrentDateTime();
        PlanHeader."Returned By" := CopyStr(UserId, 1, MaxStrLen(PlanHeader."Returned By"));
        PlanHeader."Last Review Reason" := Reason;
        PlanHeader."Appraiser Agreed" := false;
        PlanHeader.Modify(true);

        InsertHistory(PlanHeader."No.", 'Returned for changes', StatusBefore, Format(PlanHeader."Planning Status"), Reason);
    end;

    procedure AcceptPlanForHrApproval(PlanNo: Code[20]; ActorEmployeeNo: Code[20])
    var
        PlanHeader: Record "Appraisal Planning Header";
        StatusBefore: Text[50];
    begin
        PlanHeader.Get(PlanNo);
        if PlanHeader."Planning Status" <> PlanHeader."Planning Status"::"Pending Appraiser Review" then
            Error('Appraisal planning %1 must be pending appraiser review before it can be accepted.', PlanHeader."No.");

        ValidatePlan(PlanHeader, true);
        PlanHeader.TestField("Appraiser Agreed", true);

        StatusBefore := CopyStr(Format(PlanHeader."Planning Status"), 1, 50);
        PlanHeader."Planning Status" := PlanHeader."Planning Status"::"Pending HR Approval";
        PlanHeader."Objectives Agreed At" := CurrentDateTime();
        PlanHeader.Modify(true);

        InsertHistory(PlanHeader."No.", 'Accepted for HR approval', StatusBefore, Format(PlanHeader."Planning Status"), '');
    end;

    procedure CreateAppraisalFromApprovedPlan(PlanNo: Code[20]; ActorEmployeeNo: Code[20]) AppraisalNo: Code[20]
    var
        EmployeeAppraisal: Record "Employee Appraisal";
        PlanHeader: Record "Appraisal Planning Header";
        StatusBefore: Text[50];
    begin//jmk
        PlanHeader.Get(PlanNo);
        if PlanHeader."Actual Appraisal No." <> '' then begin
            if EmployeeAppraisal.Get(PlanHeader."Actual Appraisal No.") then
                exit(EmployeeAppraisal."Appraisal No");
            Clear(PlanHeader."Actual Appraisal No.");
        end;

        if PlanHeader."Planning Status" <> PlanHeader."Planning Status"::"Pending HR Approval" then
            Error('Appraisal planning %1 must be pending HR approval before creating the actual appraisal.', PlanHeader."No.");

        ValidatePlan(PlanHeader, true);
        EnsureNoExistingActualAppraisal(PlanHeader);

        EmployeeAppraisal.Init();
        EmployeeAppraisal.Validate("Employee No", PlanHeader."Employee No.");
        EmployeeAppraisal.Validate("Appraisal Period", PlanHeader."Appraisal Period");
        EmployeeAppraisal.Validate("Appraiser No", PlanHeader."Appraiser No.");
        EmployeeAppraisal."Appraisal Planning No." := PlanHeader."No.";
        EmployeeAppraisal.Insert(true);

        ClearAutoInsertedObjectiveLines(EmployeeAppraisal."Appraisal No");
        CopyPlanningLinesToAppraisal(PlanHeader, EmployeeAppraisal);

        EmployeeAppraisal.Status := EmployeeAppraisal.Status::Open;

        EmployeeAppraisal."Appraisal Status" := EmployeeAppraisal."Appraisal Status"::Review;
        EmployeeAppraisal."Current Review Period Code" := FindFirstReviewPeriodCode();
        EmployeeAppraisal."Appraisal Planning No." := PlanHeader."No.";
        EmployeeAppraisal.UpdateDirectorateSnapshot();

        // Employee Appraisal (52015)
        EmployeeAppraisal.RecalculateFrameworkScores();
        EmployeeAppraisal.Modify(true);

        StatusBefore := CopyStr(Format(PlanHeader."Planning Status"), 1, 50);
        PlanHeader."Planning Status" := PlanHeader."Planning Status"::"Appraisal Created";
        PlanHeader."Actual Appraisal No." := EmployeeAppraisal."Appraisal No";
        PlanHeader."Appraisal Created At" := CurrentDateTime();
        PlanHeader."HR Approved By" := CopyStr(UserId, 1, MaxStrLen(PlanHeader."HR Approved By"));
        PlanHeader."HR Approved At" := CurrentDateTime();
        PlanHeader.Modify(true);

        InsertHistory(PlanHeader."No.", 'Actual appraisal created', StatusBefore, Format(PlanHeader."Planning Status"), EmployeeAppraisal."Appraisal No");
        exit(EmployeeAppraisal."Appraisal No");
    end;

    procedure GetCurrentEmployeeNo(): Code[20]
    var
        Employee: Record Employee;
    begin
        Employee.Reset();
        Employee.SetRange("User ID", UserId);
        if Employee.FindFirst() then
            exit(Employee."No.");
        exit('');
    end;

    procedure ValidatePlan(PlanHeader: Record "Appraisal Planning Header"; RequireAppraiserAgreement: Boolean)
    begin
        PlanHeader.TestField("Employee No.");
        PlanHeader.TestField("Employee Name");
        PlanHeader.TestField("Appraisal Period");
        PlanHeader.TestField("Appraiser No.");
        PlanHeader.TestField("Appraiser Name");
        PlanHeader.TestField("Period Start");
        PlanHeader.TestField("Period End");
        ValidatePlanningLines(PlanHeader);
        if RequireAppraiserAgreement then
            PlanHeader.TestField("Appraiser Agreed", true);
    end;

    local procedure ValidatePlanningLines(PlanHeader: Record "Appraisal Planning Header")
    var
        FinalReviewPeriod: Record "Bal Score Preview Periods";
        PlanLine: Record "Appraisal Planning Line";
        ReviewPeriod: Record "Bal Score Preview Periods";
        TotalAllocation: Decimal;
    begin
        if not FindFinalReviewPeriod(FinalReviewPeriod) then
            message('Select one appraisal review period as the final review period before submitting appraisal planning %1.', PlanHeader."No.");
        FinalReviewPeriod.TestField("Review Sequence");

        PlanLine.Reset();
        PlanLine.SetRange("Plan No.", PlanHeader."No.");
        if PlanLine.IsEmpty() then
            message('Enter at least one objective planning line for appraisal planning %1.', PlanHeader."No.");

        if PlanLine.FindSet() then
            repeat
                PlanLine.TestField("Review Period Code");
                PlanLine.TestField("Workplan Code");
                PlanLine.TestField("Performance Measure");
                PlanLine.TestField(Target);
                PlanLine.TestField("Rating Allocation");
                if PlanLine.Actual <> 0 then
                    message('Actual must remain blank during planning for plan %1 line %2.', PlanLine."Plan No.", PlanLine."Line No");
                if PlanLine."Achieved (%)" <> 0 then
                    message('Achieved percentage must remain blank during planning for plan %1 line %2.', PlanLine."Plan No.", PlanLine."Line No");
            until PlanLine.Next() = 0;

        ReviewPeriod.Reset();
        ReviewPeriod.SetCurrentKey("Review Sequence");
        ReviewPeriod.SetFilter("Review Sequence", '%1..%2', 1, FinalReviewPeriod."Review Sequence");
        if ReviewPeriod.FindSet() then
            repeat
                TotalAllocation := CalculateReviewAllocation(PlanHeader."No.", ReviewPeriod.Code);
                if Round(TotalAllocation, 0.01) <> 80 then
                    message('Total rating allocation for appraisal planning %1 review period %2 must be 80. Current total is %3.',
                        PlanHeader."No.", ReviewPeriod.Code, Round(TotalAllocation, 0.01));
            until ReviewPeriod.Next() = 0;
    end;

    local procedure CopyPlanningLinesToAppraisal(PlanHeader: Record "Appraisal Planning Header"; var EmployeeAppraisal: Record "Employee Appraisal")
    var
        AppraisalLine: Record "Appraisal Lines";
        PlanLine: Record "Appraisal Planning Line";
        LineNo: Integer;
    begin
        PlanLine.Reset();
        PlanLine.SetRange("Plan No.", PlanHeader."No.");
        if PlanLine.FindSet() then
            repeat
                LineNo += 10000;

                AppraisalLine.Init();
                AppraisalLine."Appraisal No" := EmployeeAppraisal."Appraisal No";
                AppraisalLine."Line No" := LineNo;
                AppraisalLine."Employee No" := PlanHeader."Employee No.";
                AppraisalLine."Appraisal Period" := PlanHeader."Appraisal Period";
                AppraisalLine."Review Period Code" := PlanLine."Review Period Code";
                AppraisalLine."Workplan Code" := PlanLine."Workplan Code";
                AppraisalLine."Workplan Description" := PlanLine."Workplan Description";
                AppraisalLine."Performance Measure" := PlanLine."Performance Measure";
                AppraisalLine."Actual targets" := PlanLine."Perf. Measure Description";
                AppraisalLine."Initiative code" := PlanLine."Initiative Code";
                AppraisalLine.Description := CopyStr(PlanLine."Initiative Description", 1, MaxStrLen(AppraisalLine.Description));
                AppraisalLine."FY Target" := PlanLine.Target;
                AppraisalLine."Planning No." := PlanLine."Plan No.";
                AppraisalLine."Planning Line No." := PlanLine."Line No";
                AppraisalLine."Appraisal Line Type" := AppraisalLine."Appraisal Line Type"::Objective;
                AppraisalLine.Validate("Rating Allocation", PlanLine."Rating Allocation");
                AppraisalLine.Insert(true);
            until PlanLine.Next() = 0;
    end;

    local procedure ClearAutoInsertedObjectiveLines(AppraisalNo: Code[20])
    var
        AppraisalLine: Record "Appraisal Lines";
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", AppraisalNo);
        if not AppraisalLine.IsEmpty() then
            AppraisalLine.DeleteAll(true);
    end;

    local procedure EnsureNoExistingActualAppraisal(PlanHeader: Record "Appraisal Planning Header")
    var
        EmployeeAppraisal: Record "Employee Appraisal";
    begin
        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Appraisal Planning No.", PlanHeader."No.");
        if EmployeeAppraisal.FindFirst() then
            Error('Actual appraisal %1 already exists for appraisal planning %2.', EmployeeAppraisal."Appraisal No", PlanHeader."No.");

        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Employee No", PlanHeader."Employee No.");
        EmployeeAppraisal.SetRange("Appraisal Period", PlanHeader."Appraisal Period");
        EmployeeAppraisal.SetFilter(Status, '<>%1', EmployeeAppraisal.Status::Completed);
        if EmployeeAppraisal.FindFirst() then
            Error('Employee %1 already has appraisal %2 for appraisal period %3. Use the existing appraisal or complete it before creating another.',
                PlanHeader."Employee No.", EmployeeAppraisal."Appraisal No", PlanHeader."Appraisal Period");
    end;

    local procedure CalculateReviewAllocation(PlanNo: Code[20]; ReviewPeriodCode: Code[20]): Decimal
    var
        PlanLine: Record "Appraisal Planning Line";
        TotalAllocation: Decimal;
    begin
        PlanLine.Reset();
        PlanLine.SetRange("Plan No.", PlanNo);
        PlanLine.SetRange("Review Period Code", ReviewPeriodCode);
        if PlanLine.FindSet() then
            repeat
                TotalAllocation += PlanLine."Rating Allocation";
            until PlanLine.Next() = 0;
        exit(TotalAllocation);
    end;

    local procedure InsertHistory(PlanNo: Code[20]; ActionText: Text[100]; StatusBefore: Text[50]; StatusAfter: Text[50]; Comment: Text[250])
    var
        LastReview: Record "Appraisal Planning Review";
        PlanningReview: Record "Appraisal Planning Review";
        EntryNo: Integer;
    begin
        LastReview.Reset();
        LastReview.SetRange("Plan No.", PlanNo);
        if LastReview.FindLast() then
            EntryNo := LastReview."Entry No.";
        EntryNo += 10000;

        PlanningReview.Init();
        PlanningReview."Plan No." := PlanNo;
        PlanningReview."Entry No." := EntryNo;
        PlanningReview.Action := ActionText;
        PlanningReview."Action By" := CopyStr(UserId, 1, MaxStrLen(PlanningReview."Action By"));
        PlanningReview."Action At" := CurrentDateTime();
        PlanningReview."Status Before" := StatusBefore;
        PlanningReview."Status After" := StatusAfter;
        PlanningReview.Comment := Comment;
        PlanningReview.Insert(true);
    end;

    local procedure FindFirstReviewPeriodCode(): Code[20]
    var
        ReviewPeriod: Record "Bal Score Preview Periods";
    begin
        ReviewPeriod.Reset();
        ReviewPeriod.SetCurrentKey("Review Sequence");
        ReviewPeriod.SetFilter("Review Sequence", '>%1', 0);
        if ReviewPeriod.FindFirst() then
            exit(ReviewPeriod.Code);
        exit('');
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
