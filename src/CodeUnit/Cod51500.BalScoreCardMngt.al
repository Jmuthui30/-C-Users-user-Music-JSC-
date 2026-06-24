codeunit 51500 "Bal Score Card Mngt."
{
    procedure CreateEmployeeAppraisalPlanning()
    begin
        EnsureQuarterlyPreviewPeriods();
        FindMaturityDate;
        PlanReviewPeriod.Reset();
        PlanReviewPeriod.SetRange(Active, true);
        PlanReviewPeriod.SetRange(FiscalStart, FiscalStart);
        PlanReviewPeriod.SetRange(MaturityDate, MaturityDate);
        if PlanReviewPeriod.FindFirst() = false then
            Error(Text004);

        RunEmployeeAppraisalBatch(PlanReviewPeriod);
    end;

    procedure CreateEmployeeAppraisalsForAppraisalPeriod(AppraisalPeriodCode: Code[30])
    var
        AppraisalPeriod: Record "Appraisal Periods";
        ActiveEmployeeCount: Integer;
        ExistingAppraisalCount: Integer;
        LineCount: Integer;
        MissingEmployeeCount: Integer;
        MissingEmployeeNos: Text;
        MissingSupervisorCount: Integer;
        MissingSupervisorNos: Text;
        NewAppraisalCount: Integer;
        NoOfRecords: Integer;
        PeriodCode: Code[20];
        ProcessedCount: Integer;
    begin
        if AppraisalPeriodCode = '' then
            Error('Select an appraisal period before generating employee appraisals.');

        AppraisalPeriod.Get(AppraisalPeriodCode);
        AppraisalPeriod.TestField("Start Date");
        AppraisalPeriod.TestField("End Date");
        //jkm
        PeriodCode := GetEmployeeAppraisalPeriodCode(AppraisalPeriod.Period);

        EnsureQuarterlyPreviewPeriods();

        CollectEmployeeAppraisalBatchStatsForPeriod(PeriodCode, ActiveEmployeeCount, NewAppraisalCount, ExistingAppraisalCount, MissingEmployeeCount, MissingSupervisorCount, MissingEmployeeNos, MissingSupervisorNos);

        if ActiveEmployeeCount = 0 then
            Error(Text006);
        if MissingEmployeeCount = ActiveEmployeeCount then
            Error('No employee appraisals can be created because none of the active Employee Master records exist in the standard Employee table.');

        if NewAppraisalCount = 0 then begin
            Message('No new employee appraisals were created. %1 employee appraisal(s) already exist for %2. Skipped employee master record(s) not found in the standard Employee table: %3. Employees with missing appraiser records: %4.',
                ExistingAppraisalCount,
                GetAppraisalPeriodDisplayName(AppraisalPeriod),
                MissingEmployeeCount,
                MissingSupervisorCount);
            exit;
        end;

        if Confirm(
            StrSubstNo(
                'Generate employee appraisals for %1?\New appraisals to create: %2\Existing appraisals to skip: %3\Skipped employees not found in standard Employee: %4\Employees with missing appraiser records: %5\\Do you want to continue?',
                GetAppraisalPeriodDisplayName(AppraisalPeriod),
                NewAppraisalCount,
                ExistingAppraisalCount,
                MissingEmployeeCount,
                MissingSupervisorCount),
            false) = false
        then
            exit;

        Emp.Reset();
        Emp.SetRange(Status, Emp.Status::Active);
        if Emp.FindSet() then begin
            NoOfRecords := ActiveEmployeeCount;
            Window.Open('#1################### @2@@@@@@@@@@@@@\');
            repeat
                LineCount += 1;
                if CreateNewEmployeeAppraisalFromEmployee(Emp, PeriodCode) then
                    ProcessedCount += 1;
                if NavEmp.Get(Emp."No.") then
                    Window.Update(1, NavEmp.FullName)
                else
                    Window.Update(1, StrSubstNo('%1 - skipped', Emp."No."));
                Window.Update(2, Round(LineCount / NoOfRecords * 10000, 1));
            until Emp.Next() = 0;
            Window.Close();

            if MissingEmployeeCount > 0 then
                Message('Skipped %1 active Employee Master record(s) because they do not exist in the standard Employee table. Sample: %2', MissingEmployeeCount, MissingEmployeeNos);
            if MissingSupervisorCount > 0 then
                Message('Created appraisals, but %1 employee(s) have appraiser values that do not exist in the standard Employee table. Their appraiser was left blank. Sample: %2', MissingSupervisorCount, MissingSupervisorNos);

            if Confirm(StrSubstNo('%1 employee appraisals have been created. Do you want to open the list?', Format(ProcessedCount)), false) then
                Page.Run(Page::"Appraisal List");
        end else
            Error(Text006);

    end;

    local procedure RunEmployeeAppraisalBatch(var PlanReviewPeriodToRun: Record "Bal Score Plan Review Period")
    var
        ActiveEmployeeCount: Integer;
        ExistingAppraisalCount: Integer;
        LineCount: Integer;
        MissingEmployeeCount: Integer;
        MissingEmployeeNos: Text;
        MissingSupervisorCount: Integer;
        MissingSupervisorNos: Text;
        NewAppraisalCount: Integer;
        NoOfRecords: Integer;
        PeriodCode: Code[20];
        ProcessedCount: Integer;
    begin
        EnsureQuarterlyPreviewPeriods();
        SyncPlanReviewPeriodDates(PlanReviewPeriodToRun);
        PlanReviewPeriodToRun.TestField("Appraisal Period");
        PeriodCode := GetEmployeeAppraisalPeriodCode(PlanReviewPeriodToRun."Appraisal Period");
        CollectEmployeeAppraisalBatchStats(PlanReviewPeriodToRun, ActiveEmployeeCount, NewAppraisalCount, ExistingAppraisalCount, MissingEmployeeCount, MissingSupervisorCount, MissingEmployeeNos, MissingSupervisorNos);
        if ActiveEmployeeCount = 0 then
            Error(Text006);
        if MissingEmployeeCount = ActiveEmployeeCount then
            Error('No employee appraisals can be created because none of the active Employee Master records exist in the standard Employee table.');

        // Legacy confirmation retained for reference.
        // if Confirm(StrSubstNo(Text005, PlanReviewPeriod.Name), false) = true then begin
        if Confirm(
            StrSubstNo(
                'Create employee appraisals for %1?\New appraisals to create: %2\Existing appraisals to skip: %3\Skipped employees not found in standard Employee: %4\Employees with missing appraiser records: %5\\Do you want to continue?',
                GetPlanReviewPeriodDisplayName(PlanReviewPeriodToRun),
                NewAppraisalCount,
                ExistingAppraisalCount,
                MissingEmployeeCount,
                MissingSupervisorCount),
            false) = true
        then begin
            Emp.Reset();
            // Legacy BSC gates retained for reference. Unified appraisals are created for active employees.
            // Emp.SetRange(Appraisable, true);
            // Emp.SetFilter("Bal Score Emp Categories", '<>%1', '');
            // Emp.SetFilter("Appraisal Supervisor", '<>%1', '');
            Emp.SetRange(Status, Emp.Status::Active);
            if Emp.FindSet() then begin
                NoOfRecords := ActiveEmployeeCount;
                Window.OPEN('#1################### @2@@@@@@@@@@@@@\');
                repeat
                    LineCount := LineCount + 1;
                    // Legacy BSC planning creation retained for reference.
                    // UpdateBalScorePlanningHeader(Emp, PlanReviewPeriodToRun);
                    if CreateNewEmployeeAppraisalFromEmployee(Emp, PeriodCode) then
                        ProcessedCount += 1;
                    if NavEmp.Get(Emp."No.") then
                        Window.UPDATE(1, NavEmp.FullName)
                    else
                        Window.UPDATE(1, StrSubstNo('%1 - skipped', Emp."No."));
                    Window.UPDATE(2, ROUND(LineCount / NoOfRecords * 10000, 1));
                    Sleep(100);
                until Emp.Next() = 0;
                Window.Close();

                if MissingEmployeeCount > 0 then
                    Message('Skipped %1 active Employee Master record(s) because they do not exist in the standard Employee table. Sample: %2', MissingEmployeeCount, MissingEmployeeNos);
                if MissingSupervisorCount > 0 then
                    Message('Created/updated appraisals, but %1 employee(s) have appraiser values that do not exist in the standard Employee table. Their appraiser was left blank or unchanged. Sample: %2', MissingSupervisorCount, MissingSupervisorNos);

                // Legacy BSC appraisal creation retained for reference.
                // CreateBatchAppraisals;
                if Confirm(StrSubstNo(Text007, Format(ProcessedCount)), false) = true then begin
                    // Legacy BSC list retained for reference.
                    // Page.Run(Page::"Bal Admin App. Score Card List");
                    Page.Run(Page::"Appraisal List");
                end
                else begin
                    exit;
                end;
            end
            else
                Error(Text006);
        end
        else begin
            exit;
        end;
    end;

    local procedure GetEmployeeAppraisalPeriodCode(AppraisalPeriodCode: Code[30]): Code[20]
    var
        EmployeeAppraisal: Record "Employee Appraisal";
    begin
        if StrLen(AppraisalPeriodCode) > MaxStrLen(EmployeeAppraisal."Appraisal Period") then
            Error('Appraisal period %1 is too long for employee appraisal records.', AppraisalPeriodCode);

        exit(CopyStr(AppraisalPeriodCode, 1, MaxStrLen(EmployeeAppraisal."Appraisal Period")));
    end;

    local procedure GetAppraisalPeriodDisplayName(AppraisalPeriod: Record "Appraisal Periods"): Text
    begin
        if AppraisalPeriod.Description <> '' then
            exit(StrSubstNo('%1 - %2', AppraisalPeriod.Period, AppraisalPeriod.Description));

        exit(AppraisalPeriod.Period);
    end;

    local procedure GetPlanReviewPeriodDisplayName(PlanReviewPeriodRec: Record "Bal Score Plan Review Period"): Text
    var
        AppraisalPeriod: Record "Appraisal Periods";
    begin
        if PlanReviewPeriodRec."Appraisal Period" <> '' then
            if AppraisalPeriod.Get(PlanReviewPeriodRec."Appraisal Period") then begin
                if AppraisalPeriod.Description <> '' then
                    exit(StrSubstNo('%1 - %2', AppraisalPeriod.Period, AppraisalPeriod.Description));

                exit(AppraisalPeriod.Period);
            end;

        if PlanReviewPeriodRec.Name <> '' then
            exit(PlanReviewPeriodRec.Name);

        exit(PlanReviewPeriodRec.Code);
    end;

    local procedure EnsureEmployeeAppraisalFromEmployee(var Employee: Record "Employee Master"; ReviewPeriod: Record "Bal Score Plan Review Period"): Boolean
    var
        AppraiserEmployee: Record Employee;
        BCEmployee: Record Employee;
        EmployeeAppraisal: Record "Employee Appraisal";
        FirstReviewPeriod: Record "Bal Score Preview Periods";
    begin
        ReviewPeriod.TestField("Appraisal Period");

        if not BCEmployee.Get(Employee."No.") then
            exit(false);

        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Employee No", Employee."No.");
        EmployeeAppraisal.SetRange("Appraisal Period", ReviewPeriod."Appraisal Period");
        if EmployeeAppraisal.FindFirst() then begin
            if (EmployeeAppraisal."Appraiser No" = '') and (Employee."Appraisal Supervisor" <> '') then
                if AppraiserEmployee.Get(Employee."Appraisal Supervisor") then
                    EmployeeAppraisal.Validate("Appraiser No", Employee."Appraisal Supervisor");
            if EmployeeAppraisal."Current Review Period Code" = '' then
                if FindFirstProgressReviewPeriod(FirstReviewPeriod) then
                    EmployeeAppraisal."Current Review Period Code" := FirstReviewPeriod.Code;
            EmployeeAppraisal.Modify(true);
            exit(true);
        end;

        EmployeeAppraisal.Init();
        EmployeeAppraisal.Validate("Employee No", Employee."No.");
        EmployeeAppraisal.Validate("Appraisal Period", ReviewPeriod."Appraisal Period");
        if Employee."Appraisal Supervisor" <> '' then
            if AppraiserEmployee.Get(Employee."Appraisal Supervisor") then
                EmployeeAppraisal.Validate("Appraiser No", Employee."Appraisal Supervisor");
        if FindFirstProgressReviewPeriod(FirstReviewPeriod) then
            EmployeeAppraisal."Current Review Period Code" := FirstReviewPeriod.Code;
        EmployeeAppraisal.Status := EmployeeAppraisal.Status::Open;
        EmployeeAppraisal."Appraisal Status" := EmployeeAppraisal."Appraisal Status"::Setting;
        EmployeeAppraisal.Insert(true);
        exit(true);
    end;

    local procedure CreateNewEmployeeAppraisalFromEmployee(var Employee: Record "Employee Master"; AppraisalPeriodCode: Code[20]): Boolean
    var
        AppraiserEmployee: Record Employee;
        BCEmployee: Record Employee;
        EmployeeAppraisal: Record "Employee Appraisal";
        FirstReviewPeriod: Record "Bal Score Preview Periods";
    begin
        if not BCEmployee.Get(Employee."No.") then
            exit(false);

        EmployeeAppraisal.Reset();
        EmployeeAppraisal.SetRange("Employee No", Employee."No.");
        EmployeeAppraisal.SetRange("Appraisal Period", AppraisalPeriodCode);
        if EmployeeAppraisal.FindFirst() then
            exit(false);

        EmployeeAppraisal.Init();
        EmployeeAppraisal.Validate("Employee No", Employee."No.");
        EmployeeAppraisal.Validate("Appraisal Period", AppraisalPeriodCode);
        if Employee."Appraisal Supervisor" <> '' then
            if AppraiserEmployee.Get(Employee."Appraisal Supervisor") then
                EmployeeAppraisal.Validate("Appraiser No", Employee."Appraisal Supervisor");
        if FindFirstProgressReviewPeriod(FirstReviewPeriod) then
            EmployeeAppraisal."Current Review Period Code" := FirstReviewPeriod.Code;
        EmployeeAppraisal.Status := EmployeeAppraisal.Status::Open;
        EmployeeAppraisal."Appraisal Status" := EmployeeAppraisal."Appraisal Status"::Setting;
        EmployeeAppraisal.Insert(true);
        exit(true);
    end;

    local procedure CollectEmployeeAppraisalBatchStatsForPeriod(AppraisalPeriodCode: Code[20]; var ActiveEmployeeCount: Integer; var NewAppraisalCount: Integer; var ExistingAppraisalCount: Integer; var MissingEmployeeCount: Integer; var MissingSupervisorCount: Integer; var MissingEmployeeNos: Text; var MissingSupervisorNos: Text)
    var
        AppraisalEmployee: Record Employee;
        AppraiserEmployee: Record Employee;
        EmployeeAppraisal: Record "Employee Appraisal";
        EmployeeMaster: Record "Employee Master";
    begin
        EmployeeMaster.Reset();
        EmployeeMaster.SetRange(Status, EmployeeMaster.Status::Active);
        // EmployeeMaster.SetRange(EmployeeMaster.co);
        if EmployeeMaster.FindSet() then
            repeat
                ActiveEmployeeCount += 1;
                if not AppraisalEmployee.Get(EmployeeMaster."No.") then begin
                    MissingEmployeeCount += 1;
                    AddNoToSample(MissingEmployeeNos, EmployeeMaster."No.");
                end else begin
                    EmployeeAppraisal.Reset();
                    EmployeeAppraisal.SetRange("Employee No", EmployeeMaster."No.");
                    EmployeeAppraisal.SetRange("Appraisal Period", AppraisalPeriodCode);
                    if EmployeeAppraisal.FindFirst() then
                        ExistingAppraisalCount += 1
                    else
                        NewAppraisalCount += 1;

                    if (EmployeeMaster."Appraisal Supervisor" <> '') and not AppraiserEmployee.Get(EmployeeMaster."Appraisal Supervisor") then begin
                        MissingSupervisorCount += 1;
                        AddNoToSample(MissingSupervisorNos, EmployeeMaster."No.");
                    end;
                end;
            until EmployeeMaster.Next() = 0;
    end;

    local procedure CollectEmployeeAppraisalBatchStats(ReviewPeriod: Record "Bal Score Plan Review Period"; var ActiveEmployeeCount: Integer; var NewAppraisalCount: Integer; var ExistingAppraisalCount: Integer; var MissingEmployeeCount: Integer; var MissingSupervisorCount: Integer; var MissingEmployeeNos: Text; var MissingSupervisorNos: Text)
    var
        AppraisalEmployee: Record Employee;
        AppraiserEmployee: Record Employee;
        EmployeeAppraisal: Record "Employee Appraisal";
        EmployeeMaster: Record "Employee Master";
    begin
        ReviewPeriod.TestField("Appraisal Period");

        EmployeeMaster.Reset();
        EmployeeMaster.SetRange(Status, EmployeeMaster.Status::Active);
        if EmployeeMaster.FindSet() then
            repeat
                ActiveEmployeeCount += 1;
                if not AppraisalEmployee.Get(EmployeeMaster."No.") then begin
                    MissingEmployeeCount += 1;
                    AddNoToSample(MissingEmployeeNos, EmployeeMaster."No.");
                end else begin
                    EmployeeAppraisal.Reset();
                    EmployeeAppraisal.SetRange("Employee No", EmployeeMaster."No.");
                    EmployeeAppraisal.SetRange("Appraisal Period", ReviewPeriod."Appraisal Period");
                    if EmployeeAppraisal.FindFirst() then
                        ExistingAppraisalCount += 1
                    else
                        NewAppraisalCount += 1;

                    if (EmployeeMaster."Appraisal Supervisor" <> '') and not AppraiserEmployee.Get(EmployeeMaster."Appraisal Supervisor") then begin
                        MissingSupervisorCount += 1;
                        AddNoToSample(MissingSupervisorNos, EmployeeMaster."No.");
                    end;
                end;
            until EmployeeMaster.Next() = 0;
    end;

    local procedure AddNoToSample(var SampleText: Text; No: Code[20])
    begin
        if StrLen(SampleText) > 250 then
            exit;

        if SampleText <> '' then
            SampleText += ', ';
        SampleText += No;
    end;

    local procedure UpdateBalScorePlanningHeader(var Employee: Record "Employee Master"; ReviewPeriod: Record "Bal Score Plan Review Period")
    begin
        BalAppraisal_2.Reset();
        BalAppraisal_2.SetRange("Employee No.", Employee."No.");
        BalAppraisal_2.SetRange("Document Type", BalAppraisal_2."Document Type"::Planning);
        BalAppraisal_2.SetRange("Plan / Review Period Code", ReviewPeriod.Code);
        if BalAppraisal_2.FindFirst() then begin
            if BalAppraisal_2."Employee Appraisal Period" = '' then begin
                ReviewPeriod.TestField("Appraisal Period");
                BalAppraisal_2."Employee Appraisal Period" := ReviewPeriod."Appraisal Period";
                BalAppraisal_2.Modify(true);
            end;
            CreateBalScorePlanningLines(BalAppraisal_2);
        end
        else if BalAppraisal_2.FindFirst() = false then CreateBalScorePlanningLines(CreatePlanningHeader(Employee, ReviewPeriod));
    end;

    local procedure CreatePlanningHeader(var Employ: Record "Employee Master"; PlanReviewPeriod: Record "Bal Score Plan Review Period"): Record "Bal Score Card Header"
    var
        BalAppraisal_Int: Record "Bal Score Card Header";
    begin
        BalAppraisal_Int.Init();
        BalAppraisal_Int."Document Type" := BalAppraisal_Int."Document Type"::Planning;
        Employ.TestField("Appraisal Supervisor");
        PlanReviewPeriod.TestField("Appraisal Period");
        BalAppraisal_Int.Validate("Employee No.", Employ."No.");
        BalAppraisal_Int.Validate(Supervisor, Employ."Appraisal Supervisor");
        BalAppraisal_Int."Plan / Review Period Code" := PlanReviewPeriod.Code;
        BalAppraisal_Int."Employee Appraisal Period" := PlanReviewPeriod."Appraisal Period";
        BalAppraisal_Int.Status := BalAppraisal_Int.Status::Open;
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
        If BalAppraisalLines_2.FindSet() then
            LineNo := 10000 * BalAppraisalLines_2.Count
        else
            LineNo := 0;
        Employee.Get(BalScorePlanning."Employee No.");
        BalScoringSetup.Reset();
        BalScoringSetup.SetRange("Bal Score Emp Categories", Employee."Bal Score Emp Categories");
        if Employee.Sales = Employee.Sales::None_Sales then
            BalScoringSetup.SetFilter(Type, '%1|%2', BalScoringSetup.Type::Global, BalScoringSetup.Type::None_Sales)
        else if Employee.Sales = Employee.Sales::Sales then BalScoringSetup.SetFilter(Type, '%1|%2', BalScoringSetup.Type::Global, BalScoringSetup.Type::Sales);
        if BalScoringSetup.FindSet() then begin
            repeat
                BalAppraisalLines_2.Reset();
                BalAppraisalLines_2.SetRange(DocNo, BalScorePlanning."No.");
                BalAppraisalLines_2.SetRange(Percepective, BalScoringSetup."Bal Score Percipectives");
                if BalAppraisalLines_2.FindFirst() = false then begin
                    LineNo := LineNo + 1000;
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
        BalAppraisalLines.LineNo := LineNo;
        BalAppraisalLines.DocNo := BalScorePlanning_."No.";
        BalAppraisalLines."Document Type" := BalAppraisalLines."Document Type"::Planning;
        BalAppraisalLines.Percepective := ScoringSetup."Bal Score Percipectives";
        BalAppraisalLines."Expected Max Score" := ScoringSetup."Percentage Score";
        BalAppraisalLines.Type := ScoringSetup.Type;
        BalAppraisalLines.Insert(true);
    end;

    procedure CreateBatchAppraisals()
    begin
        BalPlanningHeader.Reset();
        BalPlanningHeader.SetFilter(Status, '<>%1', BalPlanningHeader.Status::Closed);
        BalPlanningHeader.SetFilter("Document Type", '=%1', BalPlanningHeader."Document Type"::Planning);
        BalPlanningHeader.SetFilter("Appraisal Doc No", '=%1', '');
        if BalPlanningHeader.FindSet() then begin
            repeat
                CreateAppraisalFromPlanning(BalPlanningHeader);
            until BalPlanningHeader.Next() = 0;
        end;
    end;

    procedure CreateAppraisalFromPlanning(Planning_: Record "Bal Score Card Header")
    begin
        EnsureQuarterlyPreviewPeriods();
        if FindFirstProgressReviewPeriod(BalScorePreviewPeriods) = false then
            Error('Set up a Q1 BSC preview period by running Initialize Quarterly Periods, or create a preview period with Review Sequence 1.')
        else begin
            if Planning_."No." <> '' then InsertAppraisalLines(CreateApraisalHeader(Planning_, BalScorePreviewPeriods), Planning_);
        end;
    end;

    local procedure CreateApraisalHeader(Planning: Record "Bal Score Card Header"; BalScorePreviewPeriods: Record "Bal Score Preview Periods"): Record "Bal Score Card Header"
    var
        BalAppraisal_FromP: Record "Bal Score Card Header";
    begin
        BalAppraisal_FromP.Init();
        BalAppraisal_FromP."Document Type" := BalAppraisal_FromP."Document Type"::Appraisal;
        Planning.TestField("Employee Appraisal Period");
        BalAppraisal_FromP.Validate("Employee No.", Planning."Employee No.");
        BalAppraisal_FromP.Validate(Supervisor, Planning.Supervisor);
        BalAppraisal_FromP.Status := BalAppraisal_FromP.Status::Open;
        BalAppraisal_FromP."Plan / Review Period Code" := Planning."Plan / Review Period Code";
        BalAppraisal_FromP."Employee Appraisal Period" := Planning."Employee Appraisal Period";
        BalAppraisal_FromP."Progress Review Period" := BalScorePreviewPeriods.Code;
        BalAppraisal_FromP."Planning Doc No" := Planning."No.";
        BalAppraisal_FromP.Insert(true);
        EnsureEmployeeAppraisalForBSC(BalAppraisal_FromP, Planning);
        Planning."Appraisal Doc No" := BalAppraisal_FromP."No.";
        Planning.Status := Planning.Status::Closed;
        Planning.Modify(true);
        exit(BalAppraisal_FromP);
    end;

    local procedure InsertAppraisalLines(AppraisalHeader: Record "Bal Score Card Header"; Planning: Record "Bal Score Card Header")
    begin
        PlanningLines.Reset();
        PlanningLines.SetRange(DocNo, Planning."No.");
        If PlanningLines.FindSet() then begin
            repeat
                NewAppLines.Init();
                NewAppLines.DocNo := AppraisalHeader."No.";
                NewAppLines.LineNo := PlanningLines.LineNo;
                NewAppLines.Type := PlanningLines.Type;
                NewAppLines.Percepective := PlanningLines.Percepective;
                NewAppLines."Expected Max Score" := PlanningLines."Expected Max Score";
                NewAppLines."Planning Assumption" := PlanningLines."Planning Assumption";
                NewAppLines.Validate("Progress Review Period", AppraisalHeader."Progress Review Period");
                NewAppLines."Document Type" := AppraisalHeader."Document Type";
                NewAppLines.Insert(true);
            until PlanningLines.Next() = 0;
        end;
    end;

    procedure ChangeProgressReviewPeriod(var AppraisalNo: Code[20]; var CurrentReviewPeriod: Code[20]; var NextReviewPeriod: Code[20])
    var
        LineNo: Integer;
    begin
        if Confirm(StrSubstNo(Text001, CurrentReviewPeriod, NextReviewPeriod), false) = true then begin
            ValidateNextReviewPeriod(CurrentReviewPeriod, NextReviewPeriod);
            BalAppraisalLines.Reset();
            BalAppraisalLines.SetRange(DocNo, AppraisalNo);
            BalAppraisalLines.SetRange("Progress Review Period", NextReviewPeriod);
            if BalAppraisalLines.Find then Error(StrSubstNo(Text003, NextReviewPeriod));
            if BalAppraisal.Get(AppraisalNo) then begin
                BalAppraisalLines.Reset();
                BalAppraisalLines.SetFilter(DocNo, AppraisalNo);
                if BalAppraisalLines.FindSet() then LineNo := ((BalAppraisalLines.Count() + 1) * 1000);
                BalAppraisalLines.Reset();
                BalAppraisalLines.SetRange(DocNo, AppraisalNo);
                BalAppraisalLines.SetRange("Progress Review Period", CurrentReviewPeriod);
                BalAppraisalLines.SetRange(Reviewed, false);
                if BalAppraisalLines.FindSet() then begin
                    repeat
                        LineNo := LineNo + 1000;
                        NewAppLines.Init();
                        NewAppLines.DocNo := BalAppraisalLines.DocNo;
                        NewAppLines.LineNo := LineNo;
                        NewAppLines.Percepective := BalAppraisalLines.Percepective;
                        NewAppLines."Expected Max Score" := BalAppraisalLines."Expected Max Score";
                        NewAppLines."Planning Assumption" := BalAppraisalLines."Planning Assumption";
                        NewAppLines."Achievements ToDate" := BalAppraisalLines."Achievements ToDate";
                        NewAppLines.Emphasis := BalAppraisalLines.Emphasis;
                        NewAppLines.Validate("Progress Review Period", NextReviewPeriod);
                        NewAppLines."Document Type" := BalAppraisalLines."Document Type";
                        NewAppLines.Insert(true);
                        BalAppraisalLines.Reviewed := true;
                        BalAppraisalLines.Modify(true);
                    until BalAppraisalLines.Next() = 0;
                end;
                BalAppraisal."Progress Review Period" := NextReviewPeriod;
                BalAppraisal.Status := BalAppraisal.Status::Open;
                BalAppraisal.Modify(true);
            end;
        end
        else begin
            exit;
        end;
    end;

    local procedure EnsureEmployeeAppraisalForBSC(var BSCAppraisal: Record "Bal Score Card Header"; Planning: Record "Bal Score Card Header"): Code[20]
    var
        ExistingEmployeeAppraisal: Record "Employee Appraisal";
    begin
        BSCAppraisal.TestField("Employee No.");
        BSCAppraisal.TestField(Supervisor);
        BSCAppraisal.TestField("Employee Appraisal Period");

        ExistingEmployeeAppraisal.Reset();
        ExistingEmployeeAppraisal.SetRange("Employee No", BSCAppraisal."Employee No.");
        ExistingEmployeeAppraisal.SetRange("Appraisal Period", BSCAppraisal."Employee Appraisal Period");
        if ExistingEmployeeAppraisal.FindFirst() then begin
            if ExistingEmployeeAppraisal."BSC Planning No." = '' then
                ExistingEmployeeAppraisal."BSC Planning No." := Planning."No.";
            if ExistingEmployeeAppraisal."BSC Appraisal No." = '' then
                ExistingEmployeeAppraisal."BSC Appraisal No." := BSCAppraisal."No.";
            if ExistingEmployeeAppraisal."Current Review Period Code" = '' then
                ExistingEmployeeAppraisal."Current Review Period Code" := BSCAppraisal."Progress Review Period";
            ExistingEmployeeAppraisal.Modify(true);
        end else begin
            HumanResourcesSetup.Get();
            HumanResourcesSetup.TestField("Appraisal Nos");

            ExistingEmployeeAppraisal.Init();
            ExistingEmployeeAppraisal."Appraisal No" := NoSeriesMgt.GetNextNo(HumanResourcesSetup."Appraisal Nos", WorkDate());
            ExistingEmployeeAppraisal."No. series" := HumanResourcesSetup."Appraisal Nos";
            ExistingEmployeeAppraisal.Validate("Employee No", BSCAppraisal."Employee No.");
            ExistingEmployeeAppraisal.Validate("Appraisal Period", BSCAppraisal."Employee Appraisal Period");
            ExistingEmployeeAppraisal.Validate("Appraiser No", BSCAppraisal.Supervisor);
            ExistingEmployeeAppraisal.Date := Today;
            ExistingEmployeeAppraisal.Status := ExistingEmployeeAppraisal.Status::Open;
            ExistingEmployeeAppraisal."Appraisal Status" := ExistingEmployeeAppraisal."Appraisal Status"::Setting;
            ExistingEmployeeAppraisal."BSC Planning No." := Planning."No.";
            ExistingEmployeeAppraisal."BSC Appraisal No." := BSCAppraisal."No.";
            ExistingEmployeeAppraisal."Current Review Period Code" := BSCAppraisal."Progress Review Period";
            ExistingEmployeeAppraisal.Insert(true);
        end;

        BSCAppraisal."Employee Appraisal No." := ExistingEmployeeAppraisal."Appraisal No";
        BSCAppraisal.Modify(true);
        exit(ExistingEmployeeAppraisal."Appraisal No");
    end;

    local procedure ValidateNextReviewPeriod(CurrentReviewPeriod: Code[20]; NextReviewPeriod: Code[20])
    var
        CurrentPeriod: Record "Bal Score Preview Periods";
        NextPeriod: Record "Bal Score Preview Periods";
    begin
        CurrentPeriod.Get(CurrentReviewPeriod);
        NextPeriod.Get(NextReviewPeriod);

        CurrentPeriod.TestField("Review Sequence");
        NextPeriod.TestField("Review Sequence");

        if NextPeriod."Review Sequence" <> CurrentPeriod."Review Sequence" + 1 then
            Error('Next progress review period must follow %1 in sequence.', CurrentReviewPeriod);

        if NextPeriod.Closed then
            Error('Progress review period %1 is already closed.', NextReviewPeriod);
    end;

    procedure EnsureQuarterlyPreviewPeriods()
    var
        FinalPreviewPeriod: Record "Bal Score Preview Periods";
        HasFinalPreviewPeriod: Boolean;
    begin
        HasFinalPreviewPeriod := FindFinalProgressReviewPeriod(FinalPreviewPeriod);

        // Legacy fixed-type creation retained for reference. The final period is now controlled by "Final Review Period".
        // EnsureQuarterlyPreviewPeriod('Q1', 'Quarter 1', 1, BalScorePreviewPeriods."Preview Period Type"::"First Period Appraisal");
        // EnsureQuarterlyPreviewPeriod('Q2', 'Quarter 2', 2, BalScorePreviewPeriods."Preview Period Type"::" ");
        // EnsureQuarterlyPreviewPeriod('Q3', 'Quarter 3', 3, BalScorePreviewPeriods."Preview Period Type"::" ");
        // EnsureQuarterlyPreviewPeriod('Q4', 'Quarter 4', 4, BalScorePreviewPeriods."Preview Period Type"::"Full Period Appraisal");
        EnsureQuarterlyPreviewPeriod('Q1', 'Quarter 1', 1, false);
        EnsureQuarterlyPreviewPeriod('Q2', 'Quarter 2', 2, false);
        EnsureQuarterlyPreviewPeriod('Q3', 'Quarter 3', 3, false);
        EnsureQuarterlyPreviewPeriod('Q4', 'Quarter 4', 4, not HasFinalPreviewPeriod);
    end;

    local procedure EnsureQuarterlyPreviewPeriod(PeriodCode: Code[20]; PeriodName: Text[50]; SequenceNo: Integer; IsFinalPeriod: Boolean)
    var
        PreviewPeriod: Record "Bal Score Preview Periods";
        ExistingSequencePeriod: Record "Bal Score Preview Periods";
        IsNew: Boolean;
        NeedsModify: Boolean;
    begin
        // Legacy signature retained for reference:
        // local procedure EnsureQuarterlyPreviewPeriod(PeriodCode: Code[20]; PeriodName: Text[50]; SequenceNo: Integer; PreviewPeriodType: Option " ","First Period Appraisal","Full Period Appraisal")
        if PreviewPeriod.Get(PeriodCode) = false then begin
            ExistingSequencePeriod.Reset();
            ExistingSequencePeriod.SetRange("Review Sequence", SequenceNo);
            if ExistingSequencePeriod.FindFirst() then begin
                if IsFinalPeriod and not ExistingSequencePeriod."Final Review Period" then begin
                    ExistingSequencePeriod.Validate("Final Review Period", true);
                    ExistingSequencePeriod.Modify(true);
                end;
                exit;
            end;

            PreviewPeriod.Init();
            PreviewPeriod.Code := PeriodCode;
            IsNew := true;
        end;

        if PreviewPeriod.Name = '' then begin
            PreviewPeriod.Name := PeriodName;
            NeedsModify := true;
        end;

        if PreviewPeriod."Review Sequence" = 0 then begin
            PreviewPeriod."Review Sequence" := SequenceNo;
            NeedsModify := true;
        end;

        if PreviewPeriod."Quarter No." = 0 then begin
            PreviewPeriod."Quarter No." := SequenceNo;
            NeedsModify := true;
        end;

        if IsFinalPeriod and not PreviewPeriod."Final Review Period" then begin
            PreviewPeriod.Validate("Final Review Period", true);
            NeedsModify := true;
        end;

        PreviewPeriod.SetPreviewPeriodTypeFromSequence();

        if IsNew then
            PreviewPeriod.Insert(true)
        else
            if NeedsModify then
                PreviewPeriod.Modify(true);
    end;

    local procedure FindFirstProgressReviewPeriod(var PreviewPeriod: Record "Bal Score Preview Periods"): Boolean
    begin
        PreviewPeriod.Reset();
        PreviewPeriod.SetRange("Review Sequence", 1);
        if PreviewPeriod.FindFirst() then
            exit(true);

        PreviewPeriod.Reset();
        PreviewPeriod.SetRange("Preview Period Type", PreviewPeriod."Preview Period Type"::"First Period Appraisal");
        exit(PreviewPeriod.FindFirst());
    end;

    procedure SuggestReviewPeriodDatesFromActivePlan()
    var
        ActiveAppraisalPeriod: Record "Appraisal Periods";
    begin
        ActiveAppraisalPeriod.Reset();
        ActiveAppraisalPeriod.SetRange(Active, true);
        if not ActiveAppraisalPeriod.FindFirst() then
            Error('Set one appraisal period as active before suggesting review dates.');
        if ActiveAppraisalPeriod.Count() > 1 then
            Error('Only one appraisal period can be active when suggesting review dates.');

        SuggestReviewPeriodDatesForAppraisalPeriod(ActiveAppraisalPeriod);
    end;

    procedure SuggestReviewPeriodDates(PlanReviewPeriodRec: Record "Bal Score Plan Review Period")
    var
        AppraisalPeriod: Record "Appraisal Periods";
    begin
        PlanReviewPeriodRec.TestField("Appraisal Period");
        AppraisalPeriod.Get(PlanReviewPeriodRec."Appraisal Period");
        SuggestReviewPeriodDatesForAppraisalPeriod(AppraisalPeriod);
    end;

    procedure SuggestReviewPeriodDatesForAppraisalPeriod(AppraisalPeriod: Record "Appraisal Periods")
    var
        FinalPreviewPeriod: Record "Bal Score Preview Periods";
        PreviewPeriod: Record "Bal Score Preview Periods";
        SuggestedStartDate: Date;
        SuggestedEndDate: Date;
        UpdatedCount: Integer;
        IgnoredCount: Integer;
    begin
        AppraisalPeriod.TestField("Start Date");
        AppraisalPeriod.TestField("End Date");

        if AppraisalPeriod."End Date" < AppraisalPeriod."Start Date" then
            Error('Appraisal period %1 has an end date before the start date.', AppraisalPeriod.Period);

        if not FindFinalProgressReviewPeriod(FinalPreviewPeriod) then
            Error('Select one appraisal review period as the final review period before suggesting dates.');

        FinalPreviewPeriod.TestField("Review Sequence");

        PreviewPeriod.Reset();
        PreviewPeriod.SetCurrentKey("Review Sequence");
        PreviewPeriod.SetFilter("Review Sequence", '<>%1', 0);
        if PreviewPeriod.FindSet() then
            repeat
                if PreviewPeriod."Review Sequence" <= FinalPreviewPeriod."Review Sequence" then begin
                    SuggestReviewPeriodDateRange(
                        AppraisalPeriod."Start Date",
                        AppraisalPeriod."End Date",
                        PreviewPeriod."Review Sequence",
                        FinalPreviewPeriod."Review Sequence",
                        SuggestedStartDate,
                        SuggestedEndDate);

                    PreviewPeriod."Start Date" := SuggestedStartDate;
                    PreviewPeriod."End Date" := SuggestedEndDate;
                    PreviewPeriod.SetPreviewPeriodTypeFromSequence();
                    PreviewPeriod.Modify(true);
                    UpdatedCount += 1;
                end else begin
                    if (PreviewPeriod."Start Date" <> 0D) or (PreviewPeriod."End Date" <> 0D) then begin
                        PreviewPeriod."Start Date" := 0D;
                        PreviewPeriod."End Date" := 0D;
                        PreviewPeriod.SetPreviewPeriodTypeFromSequence();
                        PreviewPeriod.Modify(true);
                    end;
                    IgnoredCount += 1;
                end;
            until PreviewPeriod.Next() = 0;

        Message('Suggested calendar-month start and end dates for %1 review period(s). %2 period(s) after the final review period were ignored. Due dates were not changed.', UpdatedCount, IgnoredCount);
    end;

    local procedure SuggestReviewPeriodDateRange(PeriodStartDate: Date; PeriodEndDate: Date; ReviewSequence: Integer; FinalReviewSequence: Integer; var SuggestedStartDate: Date; var SuggestedEndDate: Date)
    var
        MonthsPerReview: Integer;
        PeriodMonthCount: Integer;
        StartMonthOffset: Integer;
    begin
        if FinalReviewSequence <= 0 then
            Error('Final review sequence must be greater than zero.');

        if not TryGetFullCalendarMonthCount(PeriodStartDate, PeriodEndDate, PeriodMonthCount) then
            Error('Cannot suggest review dates because the appraisal period must start on the first day of a month and end on the last day of a month. Enter review dates manually, or adjust the appraisal period dates.');

        if PeriodMonthCount mod FinalReviewSequence <> 0 then
            Error('Cannot suggest clean calendar-month review dates. Appraisal period %1 to %2 has %3 month(s), but the selected final review sequence is %4. Use a final sequence that divides the appraisal period months, or enter review dates manually.', PeriodStartDate, PeriodEndDate, PeriodMonthCount, FinalReviewSequence);

        MonthsPerReview := PeriodMonthCount DIV FinalReviewSequence;
        StartMonthOffset := (ReviewSequence - 1) * MonthsPerReview;

        SuggestedStartDate := AddMonthsToDate(PeriodStartDate, StartMonthOffset);
        if ReviewSequence = FinalReviewSequence then
            SuggestedEndDate := PeriodEndDate
        else
            SuggestedEndDate := AddMonthsToDate(PeriodStartDate, (ReviewSequence * MonthsPerReview)) - 1;
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

    local procedure FindFinalProgressReviewPeriod(var PreviewPeriod: Record "Bal Score Preview Periods"): Boolean
    begin
        PreviewPeriod.Reset();
        PreviewPeriod.SetRange("Final Review Period", true);
        if PreviewPeriod.FindFirst() then
            exit(true);

        PreviewPeriod.Reset();
        PreviewPeriod.SetRange("Preview Period Type", PreviewPeriod."Preview Period Type"::"Full Period Appraisal");
        exit(PreviewPeriod.FindFirst());
    end;

    local procedure SyncPlanReviewPeriodDates(var ReviewPeriod: Record "Bal Score Plan Review Period")
    var
        AppraisalPeriod: Record "Appraisal Periods";
    begin
        ReviewPeriod.TestField("Appraisal Period");
        AppraisalPeriod.Get(ReviewPeriod."Appraisal Period");

        if (ReviewPeriod."Start Date" = AppraisalPeriod."Start Date") and (ReviewPeriod."End Date" = AppraisalPeriod."End Date") then
            exit;

        ReviewPeriod."Start Date" := AppraisalPeriod."Start Date";
        ReviewPeriod."End Date" := AppraisalPeriod."End Date";
        ReviewPeriod.Modify(true);
    end;

    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            FiscalStart := AccPeriod."Starting Date";
            MaturityDate := CalcDate('1Y', FiscalStart) - 1;
        end;
    end;

    var
        BalAppraisal: Record "Bal Score Card Header";
        BalPlanningHeader: Record "Bal Score Card Header";
        BalAppraisal_2: Record "Bal Score Card Header";
        BalScorePreviewPeriods: Record "Bal Score Preview Periods";
        PlanReviewPeriod: Record "Bal Score Plan Review Period";
        BalAppraisalLines: Record "Bal Score Card Lines";
        BalAppraisalLines_2: Record "Bal Score Card Lines";
        NewAppLines: Record "Bal Score Card Lines";
        PlanningLines: Record "Bal Score Card Lines";
        BalScoringSetup: Record "Bal Scoring Setup";
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit "No. Series";
        Window: Dialog;
        Emp: Record "Employee Master";
        NavEmp: Record Employee;
        MaturityDate: Date;
        FiscalStart: Date;
        Text001: Label 'Do you wish to close %1 Progress Review Period and intialize %2?';
        Text003: Label 'Progress Review Period %1 have been Reviewed Already';
        Text004: Label 'There is no active Balance Score Card Plan Review Period';
        Text005: Label 'You are about to create Employee Appraisals Planning for the Plan Review Period of %1, Do you wish to continue?';
        Text006: Label 'No active employees were found for appraisal creation.';
        Text007: Label '%1 employee appraisals have been created/updated. Do you want to open the list?';
        Text008: Label 'Balance Scoring Setup have not been Completely done, Do the setup first or contact HR Admin';
}
