codeunit 51500 "Bal Score Card Mngt."
{
    procedure CreateEmployeeAppraisalPlanning()
    var
        LineCount: Integer;
        NoOfRecords: Integer;
    begin
        FindMaturityDate;
        PlanReviewPeriod.Reset();
        PlanReviewPeriod.SetRange(Active, true);
        PlanReviewPeriod.SetRange(FiscalStart, FiscalStart);
        PlanReviewPeriod.SetRange(MaturityDate, MaturityDate);
        if PlanReviewPeriod.FindFirst() = false then Error(Text004)
        else
        begin
            if Confirm(StrSubstNo(Text005, PlanReviewPeriod.Name), false) = true then begin
                Emp.Reset();
                Emp.SetRange(Appraisable, true);
                Emp.SetFilter("Bal Score Emp Categories", '<>%1', '');
                Emp.SetFilter("Appraisal Supervisor", '<>%1', '');
                if Emp.FindSet()then begin
                    NoOfRecords:=Emp.COUNT;
                    Window.OPEN('#1################### @2@@@@@@@@@@@@@\');
                    repeat LineCount:=LineCount + 1;
                        UpdateBalScorePlanningHeader(Emp, PlanReviewPeriod);
                        NavEmp.Get(Emp."No.");
                        Window.UPDATE(1, NavEmp.FullName);
                        Window.UPDATE(2, ROUND(LineCount / NoOfRecords * 10000, 1));
                        Sleep(100);
                    until Emp.Next() = 0;
                    Window.Close();
                    CreateBatchAppraisals;
                    if Confirm(StrSubstNo(Text007, Format(Emp.count)), false) = true then begin
                        Page.Run(Page::"Bal Admin App. Score Card List");
                    end
                    else
                    begin
                        exit;
                    end;
                end
                else
                    Error(Text006);
            end
            else
            begin
                exit;
            end;
        end;
    end;
    local procedure UpdateBalScorePlanningHeader(var Employee: Record "Employee Master"; ReviewPeriod: Record "Bal Score Plan Review Period")
    begin
        BalAppraisal_2.Reset();
        BalAppraisal_2.SetRange("Employee No.", Employee."No.");
        BalAppraisal_2.SetRange("Document Type", BalAppraisal_2."Document Type"::Planning);
        BalAppraisal_2.SetRange("Plan / Review Period Code", ReviewPeriod.Code);
        if BalAppraisal_2.FindFirst()then CreateBalScorePlanningLines(BalAppraisal_2)
        else if BalAppraisal_2.FindFirst() = false then CreateBalScorePlanningLines(CreatePlanningHeader(Employee, ReviewPeriod));
    end;
    local procedure CreatePlanningHeader(var Employ: Record "Employee Master"; PlanReviewPeriod: Record "Bal Score Plan Review Period"): Record "Bal Score Card Header" var
        BalAppraisal_Int: Record "Bal Score Card Header";
    begin
        BalAppraisal_Int.Init();
        BalAppraisal_Int."Document Type":=BalAppraisal_Int."Document Type"::Planning;
        BalAppraisal_Int.Validate("Employee No.", Employ."No.");
        BalAppraisal_Int.Validate(Supervisor, Employ."Appraisal Supervisor");
        BalAppraisal_Int."Plan / Review Period Code":=PlanReviewPeriod.Code;
        BalAppraisal_Int.Status:=BalAppraisal_Int.Status::Open;
        BalAppraisal_Int.Insert(true);
        exit(BalAppraisal_Int);
    end;
    local procedure CreateBalScorePlanningLines(BalScorePlanning: Record "Bal Score Card Header")
    var
        LineNo: Integer;
        Employee: Record "Employee Master";
    begin
        BalAppraisalLines_2.Reset();
        BalAppraisalLines_2.SetRange(DocNo, BalScorePlanning."No.");
        If BalAppraisalLines_2.FindSet()then LineNo:=10000 * BalAppraisalLines_2.Count
        else
            LineNo:=0;
        Employee.Get(BalScorePlanning."Employee No.");
        BalScoringSetup.Reset();
        BalScoringSetup.SetRange("Bal Score Emp Categories", Employee."Bal Score Emp Categories");
        if Employee.Sales = Employee.Sales::None_Sales then BalScoringSetup.SetFilter(Type, '%1|%2', BalScoringSetup.Type::Global, BalScoringSetup.Type::None_Sales)
        else if Employee.Sales = Employee.Sales::Sales then BalScoringSetup.SetFilter(Type, '%1|%2', BalScoringSetup.Type::Global, BalScoringSetup.Type::Sales);
        if BalScoringSetup.FindSet()then begin
            repeat BalAppraisalLines_2.Reset();
                BalAppraisalLines_2.SetRange(DocNo, BalScorePlanning."No.");
                BalAppraisalLines_2.SetRange(Percepective, BalScoringSetup."Bal Score Percipectives");
                if BalAppraisalLines_2.FindFirst() = false then begin
                    LineNo:=LineNo + 1000;
                    InsertBalPlaningLines(BalScorePlanning, BalScoringSetup, LineNo);
                end;
            until BalScoringSetup.Next() = 0;
        end
        else
            Error(Text008);
    end;
    local procedure InsertBalPlaningLines(BalScorePlanning_: Record "Bal Score Card Header"; ScoringSetup: Record "Bal Scoring Setup"; LineNo: Integer)
    begin
        BalAppraisalLines.Init();
        BalAppraisalLines.LineNo:=LineNo;
        BalAppraisalLines.DocNo:=BalScorePlanning_."No.";
        BalAppraisalLines."Document Type":=BalAppraisalLines."Document Type"::Planning;
        BalAppraisalLines.Percepective:=ScoringSetup."Bal Score Percipectives";
        BalAppraisalLines."Expected Max Score":=ScoringSetup."Percentage Score";
        BalAppraisalLines.Type:=ScoringSetup.Type;
        BalAppraisalLines.Insert(true);
    end;
    procedure CreateBatchAppraisals()
    begin
        BalPlanningHeader.Reset();
        BalPlanningHeader.SetFilter(Status, '<>%1', BalPlanningHeader.Status::Closed);
        BalPlanningHeader.SetFilter("Document Type", '=%1', BalPlanningHeader."Document Type"::Planning);
        BalPlanningHeader.SetFilter("Appraisal Doc No", '=%1', '');
        if BalPlanningHeader.FindSet()then begin
            repeat CreateAppraisalFromPlanning(BalPlanningHeader);
            until BalPlanningHeader.Next() = 0;
        end;
    end;
    procedure CreateAppraisalFromPlanning(Planning_: Record "Bal Score Card Header")
    begin
        BalScorePreviewPeriods.Reset();
        BalScorePreviewPeriods.SetRange("Preview Period Type", BalScorePreviewPeriods."Preview Period Type"::"First Period Appraisal");
        if BalScorePreviewPeriods.FindFirst() = false then Error('There Must be a First Period Appriasal Review Period. Contact Administrator')
        else
        begin
            if Planning_."No." <> '' then InsertAppraisalLines(CreateApraisalHeader(Planning_, BalScorePreviewPeriods), Planning_);
        end;
    end;
    local procedure CreateApraisalHeader(Planning: Record "Bal Score Card Header"; BalScorePreviewPeriods: Record "Bal Score Preview Periods"): Record "Bal Score Card Header" var
        BalAppraisal_FromP: Record "Bal Score Card Header";
    begin
        BalAppraisal_FromP.Init();
        BalAppraisal_FromP."Document Type":=BalAppraisal_FromP."Document Type"::Appraisal;
        BalAppraisal_FromP.Validate("Employee No.", Planning."Employee No.");
        BalAppraisal_FromP.Validate(Supervisor, Planning.Supervisor);
        BalAppraisal_FromP.Status:=BalAppraisal.Status::Open;
        BalAppraisal_FromP."Progress Review Period":=BalScorePreviewPeriods.Code;
        BalAppraisal_FromP."Planning Doc No":=Planning."No.";
        BalAppraisal_FromP.Insert(true);
        Planning."Appraisal Doc No":=BalAppraisal."No.";
        Planning.Status:=Planning.Status::Closed;
        Planning.Modify(true);
        exit(BalAppraisal_FromP);
    end;
    local procedure InsertAppraisalLines(AppraisalHeader: Record "Bal Score Card Header"; Planning: Record "Bal Score Card Header")
    begin
        PlanningLines.Reset();
        PlanningLines.SetRange(DocNo, Planning."No.");
        If PlanningLines.FindSet()then begin
            repeat NewAppLines.Init();
                NewAppLines.DocNo:=AppraisalHeader."No.";
                NewAppLines.LineNo:=PlanningLines.LineNo;
                NewAppLines.Type:=PlanningLines.Type;
                NewAppLines.Percepective:=PlanningLines.Percepective;
                NewAppLines."Expected Max Score":=PlanningLines."Expected Max Score";
                NewAppLines."Planning Assumption":=PlanningLines."Planning Assumption";
                NewAppLines.Validate("Progress Review Period", AppraisalHeader."Progress Review Period");
                NewAppLines."Document Type":=AppraisalHeader."Document Type";
                NewAppLines.Insert(true);
            until PlanningLines.Next() = 0;
        end;
    end;
    procedure ChangeProgressReviewPeriod(var AppraisalNo: Code[20]; var CurrentReviewPeriod: Code[20]; var NextReviewPeriod: Code[20])
    var
        LineNo: Integer;
    begin
        if Confirm(StrSubstNo(Text001, CurrentReviewPeriod, NextReviewPeriod), false) = true then begin
            BalAppraisalLines.Reset();
            BalAppraisalLines.SetRange(DocNo, AppraisalNo);
            BalAppraisalLines.SetRange("Progress Review Period", NextReviewPeriod);
            if BalAppraisalLines.Find then Error(StrSubstNo(Text003, NextReviewPeriod));
            if BalAppraisal.Get(AppraisalNo)then begin
                BalAppraisalLines.Reset();
                BalAppraisalLines.SetFilter(DocNo, AppraisalNo);
                if BalAppraisalLines.FindSet()then LineNo:=((BalAppraisalLines.Count() + 1) * 1000);
                BalAppraisalLines.Reset();
                BalAppraisalLines.SetRange(DocNo, AppraisalNo);
                BalAppraisalLines.SetRange("Progress Review Period", CurrentReviewPeriod);
                BalAppraisalLines.SetRange(Reviewed, false);
                if BalAppraisalLines.FindSet()then begin
                    repeat LineNo:=LineNo + 1000;
                        NewAppLines.Init();
                        NewAppLines.DocNo:=BalAppraisalLines.DocNo;
                        NewAppLines.LineNo:=LineNo;
                        NewAppLines.Percepective:=BalAppraisalLines.Percepective;
                        NewAppLines."Expected Max Score":=BalAppraisalLines."Expected Max Score";
                        NewAppLines."Planning Assumption":=BalAppraisalLines."Planning Assumption";
                        NewAppLines."Achievements ToDate":=BalAppraisalLines."Achievements ToDate";
                        NewAppLines.Emphasis:=BalAppraisalLines.Emphasis;
                        NewAppLines.Validate("Progress Review Period", NextReviewPeriod);
                        NewAppLines."Document Type":=BalAppraisalLines."Document Type";
                        NewAppLines.Insert(true);
                        BalAppraisalLines.Reviewed:=true;
                        BalAppraisalLines.Modify(true);
                    until BalAppraisalLines.Next() = 0;
                end;
                BalAppraisal."Progress Review Period":=NextReviewPeriod;
                BalAppraisal.Status:=BalAppraisal.Status::Open;
                BalAppraisal.Modify(true);
            end;
        end
        else
        begin
            exit;
        end;
    end;
    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+')then begin
            FiscalStart:=AccPeriod."Starting Date";
            MaturityDate:=CalcDate('1Y', FiscalStart) - 1;
        end;
    end;
    var BalAppraisal: Record "Bal Score Card Header";
    BalPlanningHeader: Record "Bal Score Card Header";
    BalAppraisal_2: Record "Bal Score Card Header";
    BalScorePreviewPeriods: Record "Bal Score Preview Periods";
    PlanReviewPeriod: Record "Bal Score Plan Review Period";
    BalAppraisalLines: Record "Bal Score Card Lines";
    BalAppraisalLines_2: Record "Bal Score Card Lines";
    NewAppLines: Record "Bal Score Card Lines";
    PlanningLines: Record "Bal Score Card Lines";
    BalScoringSetup: Record "Bal Scoring Setup";
    Window: Dialog;
    Emp: Record "Employee Master";
    NavEmp: Record Employee;
    MaturityDate: Date;
    FiscalStart: Date;
    Text001: Label 'Do you wish to close %1 Progress Review Period and intialize %2?';
    Text003: Label 'Progress Review Period %1 have been Reviewed Already';
    Text004: Label 'There is no active Balance Score Card Plan Review Period';
    Text005: Label 'You are about to create Employee Appraisals Planning for the Plan Review Period of %1, Do you wish to continue?';
    Text006: Label 'There is no new Employee set to be  Appraised';
    Text007: Label '%1 Employee Appraisal Plannings have been Created/Updated, Do you wish to Open the list?';
    Text008: Label 'Balance Scoring Setup have not been Completely done, Do the setup first or contact HR Admin';
}
