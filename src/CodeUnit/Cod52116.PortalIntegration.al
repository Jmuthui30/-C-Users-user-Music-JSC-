codeunit 52116 "Portal Integration"
{
    Permissions = tabledata "Job Application" = RIMD;

    var
        HrEmployees: Record Employee;

        Leave: Record "Leave Application";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LeaveSetup: Record "Leave Type";
        EmployeeLeaves: Record "Employee Leaves";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        MaturityDate: Date;
        NonWorkingDay: Boolean;
        NoOfWorkingDays: Decimal;
        PayrollPeriod: Record "Payroll Period";

        RequestorID: Record "User Setup";

        UserSetup: Record "User Setup";

        ApprovalEntry: Record "Approval Entry";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        HrApprovalsMgmt: Codeunit "Approval Mgt HR Ext";

        EndpointData: Text;
        PostUrl: Text;
        JsonToken: JsonToken;
        EmployeeRec: Record Employee;
        JobApplication: Record "Job Application";
        Applicants: Record Applicant;
        CompanyInformation: Record "Company Information";
        PortalUploads: Record "SharePoint Intergration";


    procedure SubmitJobApplication(No: Code[30]; ApplicantNo: Code[30]): Boolean
    var
        RecruitmentNeeds: Record "Recruitment Needs";

    begin
        RecruitmentNeeds.Reset();
        RecruitmentNeeds.SetRange("Job ID", No);
        RecruitmentNeeds.SetRange(Status, RecruitmentNeeds.Status::Closed);
        RecruitmentNeeds.SetRange("Advertisement Status", RecruitmentNeeds."Advertisement Status"::Closed);
        RecruitmentNeeds.SetRange("Advertisment Status", RecruitmentNeeds."Advertisment Status"::Closed);
        if RecruitmentNeeds.Find('-') then Error('Your Cannot Submitted,Job Aready closed');
        JobApplication.Reset();
        JobApplication.SetRange(JobApplication."Applicant No.", ApplicantNo);
        JobApplication.SetRange(JobApplication."Job Applied Code", No);
        JobApplication.SetRange(Submitted, true);
        if JobApplication.Find('-') then begin

        end else begin
            Applicants.Reset();
            Applicants.SetRange("No.", ApplicantNo);
            if Applicants.Find('-') then begin
                Applicants."Job ID" := No;
                Applicants.Validate("Job ID");
                Applicants.Modify();
                Commit();
                JobApplication.Init();
                JobApplication."Applicant Type" := JobApplication."Applicant Type"::External;
                JobApplication."Job Applied Code" := No;
                JobApplication.Validate("Job Applied Code");
                JobApplication."Applicant No." := ApplicantNo;
                JobApplication."Applicant Name" := Applicants."First Name" + ' ' + Applicants."Middle Name" + ' ' + Applicants."Last Name";
                JobApplication.Gender := Applicants.Gender;
                JobApplication."Date-Time Created" := CurrentDateTime;
                JobApplication.Submitted := true;

                RecruitmentNeeds.Reset();
                RecruitmentNeeds.SetRange("Job ID", No);
                if RecruitmentNeeds.FindFirst() then
                    JobApplication."Recruitment Needs No." := RecruitmentNeeds."No.";

                JobApplication."Application Status" := JobApplication."Application Status"::Submited;
                if JobApplication.Insert(true) then
                    if Applicants.Get(ApplicantNo) then
                        //         //         Applicants."Submitted Date" := Today;
                        //         // Applicants."Submitted Time" := Time;
                        //         RecruitmentNeeds.Reset();
                        // RecruitmentNeeds.SetRange("Job ID", No);
                        // if RecruitmentNeeds.FindFirst() then begin
                        //     //     Applicants."Recruitment Needs NO" := RecruitmentNeeds."No.";
                Applicants.Submitted := true;
                Applicants."Submitted Date" := Today;
                Applicants."Submitted Time" := Time;
                //     JobApplication."Recruitment Needs No." := RecruitmentNeeds."No.";
                // end;
                Applicants.Modify();


                exit(true);
            end;
        end;
    end;

    procedure fnInsertPortalAttachments(DocumentNo: Code[100]; Description: Text; Url: Text; Type: Text) uploaded: Boolean
    var

    begin
        // IF CompanyInformation.GET THEN
        PortalUploads.Reset();
        PortalUploads.SetRange("Document No", DocumentNo);
        PortalUploads.SetRange(Description, Description);
        if PortalUploads.Find('-') then begin
        end else begin
            PortalUploads.INIT;
            PortalUploads."Document No" := DocumentNo;
            PortalUploads.Description := Description;
            PortalUploads.LocalUrl := Url;
            PortalUploads.Uploaded := TRUE;
            PortalUploads.Fetch_To_Sharepoint := TRUE;
            //PortalUploads.Base_URL := CompanyInformation."Sharepoint Path" + '/' + Type + '/';
            IF PortalUploads.INSERT(TRUE) THEN BEGIN
                uploaded := TRUE;
                EXIT(uploaded);
            END;
        end;
        EXIT(uploaded);
    end;

    procedure UpdateLinks(EntryNo: Integer; Link: Text; Reason: Text)
    begin
        IF PortalUploads.GET(EntryNo) THEN
            PortalUploads.SP_URL_Returned := Link;
        PortalUploads.Polled := TRUE;
        PortalUploads.Failure_reason := Reason;
        PortalUploads.MODIFY;
    end;

    procedure CheckLeaveDaysAvailable(EmpNo: Code[30]; LeaveCode: Code[30]) LeaveBalance: Decimal
    var
        EmployeeLeaves: Record "HR Leave Ledger Entries";
        TotalLeaveDays: Decimal;
    begin
        if HrEmployees.Get(EmpNo) then begin
            EmployeeLeaves.Reset;
            EmployeeLeaves.SetRange("Staff No.", EmpNo);
            EmployeeLeaves.SetRange("Leave Type", LeaveCode);
            EmployeeLeaves.SetRange(Closed, false);

            if EmployeeLeaves.FindSet() then begin
                repeat
                    TotalLeaveDays += EmployeeLeaves."No. of days";
                until EmployeeLeaves.Next() = 0;
            end;

            LeaveBalance := TotalLeaveDays;
            exit(LeaveBalance);
        end;
    end;


    local procedure FindMaturityDate() maturity: Date

    var
        AccPeriod: Record "Accounting Period";
    begin

        AccPeriod.Reset;
        AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
        AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            maturity := CalcDate('1Y', AccPeriod."Starting Date") - 1;
            exit(maturity);
        end else
            Error('Accounting Period has not been set');
    end;

    procedure ApproveDocument(DocumentNo: Code[50]; UserId: Code[50]; entryno: Integer) IsOkay: Boolean
    var
        VarVariant: Variant;
    begin
        IsOkay := FALSE;
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", UserId);
        ApprovalEntry.SETRANGE(ApprovalEntry."Entry No.", entryno);
        ApprovalEntry.SetRange(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        IF ApprovalEntry.FindFirst() THEN BEGIN
            VarVariant := ApprovalEntry;
            ApprovalsMgmt.ApproveApprovalRequests(VarVariant);
            IsOkay := TRUE;
        END;
    end;


    PROCEDURE RejectDocument(DocumentNo: Code[50]; ApproverID: Code[50]; RecIDText: Text; EntryNo: Integer) IsOkay: Boolean;
    VAR
        RecIDVal: RecordID;
        VarVariant: Variant;
    BEGIN
        IsOkay := FALSE;
        ApprovalEntry.Reset();
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", DocumentNo);
        ApprovalEntry.SETRANGE(ApprovalEntry."Approver ID", ApproverID);
        ApprovalEntry.SETRANGE(ApprovalEntry.Status, ApprovalEntry.Status::Open);
        IF (ApprovalEntry.FIND('-')) THEN BEGIN
            VarVariant := ApprovalEntry;
            ApprovalsMgmt.RejectApprovalRequests(VarVariant);
            MESSAGE(FORMAT(ApprovalEntry.Status));
            IsOkay := TRUE;
        END;
    end;

    procedure EmployeePhoto(StaffNo: Code[20]; VAR PictureText: text)
    var
        InStream: InStream;
        OutStream: OutStream;
        Media: Record "Tenant Media";
        FileSystem: File;
        FileName: Text[100];
        Base64: Codeunit "Base64 Convert";
    begin
        HrEmployees.Reset();
        HrEmployees.SetRange("No.", StaffNo);
        if HrEmployees.Find('-') then begin
            if HrEmployees.Image.HasValue then begin
                HrEmployees.Image.ExportStream(OutStream);
                PictureText := Base64.ToBase64(InStream);
            end;
        end;
    end;

    procedure DetermineLeaveReturnDate(startDate: Date; DaysApplied: Decimal; LeaveCode: Code[30]; EmpNo: Code[20]) ReturnDate: Date
    var
        HRSetup: Record "Human Resources Setup";
        LeaveTypes: Record "Leave Type";
        Description: Text[150];
        NextWorkingDate: Date;
        CalendarMgmt: Codeunit "Calendar Management";
        BaseCalendar: Record "Base Calendar Change";
        BaseCalender: Record Date;
        CustCalendarChange: record "Customized Calendar Change";
        EndDate: Date;
        BaseCalenderCode: Code[10];
    begin

        EmployeeRec.Get(EmpNo);
        if EmployeeRec."Base Calendar" <> '' then
            BaseCalenderCode := EmployeeRec."Base Calendar"
        else
            ReturnDate := startDate;
        LeaveSetup.Get;
        NoOfWorkingDays := 0;
        if DaysApplied <> 0 then
            if startDate <> 0D then begin
                NextWorkingDate := startDate;
                repeat
                    // if not HRmgt.CheckNonWorkingDay(BaseCalenderCode, NextWorkingDate, Description) then
                    NoOfWorkingDays := NoOfWorkingDays + 1;

                    if LeaveTypes.Get(LeaveCode) then begin
                        if LeaveTypes."Inclusive of Holidays" then begin
                            BaseCalendar.Reset();
                            BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", BaseCalenderCode);
                            BaseCalendar.SetRange(BaseCalendar.Date, NextWorkingDate);
                            BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                            BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                            if BaseCalendar.Find('-') then
                                NoOfWorkingDays := NoOfWorkingDays + 1;
                        end;

                        if LeaveTypes."Inclusive of Saturday" then begin
                            BaseCalender.Reset();
                            BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                            BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                            BaseCalender.SetRange(BaseCalender."Period No.", 6);

                            if BaseCalender.Find('-') then
                                NoOfWorkingDays := NoOfWorkingDays + 1;
                        end;


                        if LeaveTypes."Inclusive of Sunday" then begin
                            BaseCalender.Reset();
                            BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                            BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                            BaseCalender.SetRange(BaseCalender."Period No.", 7);
                            if BaseCalender.Find('-') then
                                NoOfWorkingDays := NoOfWorkingDays + 1;
                        end;


                        if LeaveTypes."Off/Holidays Days Leave" then;

                    end;

                    NextWorkingDate := CalcDate('1D', NextWorkingDate);
                until NoOfWorkingDays = DaysApplied;
                Message('enddate is %1', NextWorkingDate);
                //"End Date" := NextWorkingDate - 1;
                ReturnDate := NextWorkingDate;
            end;

        //check if the date that the person is supposed to report back is a working day or not
        //get base calendar to use
        NonWorkingDay := false;
        if startDate <> 0D then
            while NonWorkingDay = false
              do begin
                //NonWorkingDay := HRmgt.CheckNonWorkingDay(HumanResSetup."Default Base Calendar", "Resumption Date", Dsptn);
                if NonWorkingDay then begin
                    NonWorkingDay := false;
                    ReturnDate := CalcDate('1D', ReturnDate);
                end
                else
                    NonWorkingDay := true;
            end;

    end;


    procedure CheckDateStatusLeave(CalendarCode: Code[20]; TargetDate: Date; Var Description: Text[50]): Boolean
    var
        BaseCalChange: record "Base Calendar Change";
    begin

        BaseCalChange.Reset;
        BaseCalChange.SetRange("Base Calendar Code", CalendarCode);
        if BaseCalChange.FindSet then
            Repeat
                case BaseCalChange."Recurring System" of
                    BaseCalChange."Recurring System"::" ":
                        if TargetDate = BaseCalChange.Date then begin
                            Description := BaseCalChange.Description;
                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Weekly Recurring":
                        if DATE2DWY(TargetDate, 1) = BaseCalChange.Day then begin
                            Description := BaseCalChange.Description;
                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Annual Recurring":
                        if (DATE2DMY(TargetDate, 2) = DATE2DMY(BaseCalChange.Date, 2)) and
                           (DATE2DMY(TargetDate, 1) = DATE2DMY(BaseCalChange.Date, 1))
                        then begin
                            Description := BaseCalChange.Description;
                            exit(BaseCalChange.Nonworking);
                        end;
                end;
            Until BaseCalChange.Next = 0;
        Description := '';
    end;

    procedure CreateLeaveApplication(EmpNo: Code[50]; LeaveType: Code[30]; StartDate: Date; Days: Decimal; Reliever: Code[30]; Remarks: Text[2048]; ApplicationNo: Code[50]) No: Code[30]
    var
        HRSetup: Record "Human Resources Setup";
    begin

        HrEmployees.Reset();
        HrEmployees.SetRange("No.", EmpNo);
        if HrEmployees.Find('-') then begin
            Leave.Reset();
            Leave.SetRange("Application No", ApplicationNo);
            if Leave.Find('-') then begin
                Leave."Employee No" := HrEmployees."No.";
                Leave.Validate("Employee No");
                Leave."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                Leave."Mobile No" := HrEmployees."Mobile Phone No.";
                Leave."Application Date" := today;
                Leave."Leave Code" := LeaveType;
                Leave.Validate("Leave Code");
                Leave."Start Date" := StartDate;
                Leave."Days Applied" := Days;
                Leave.Validate("Start Date");
                Leave."Duties Taken Over By" := Reliever;
                Leave.Validate("Duties Taken Over By");
                Leave.Comments := Remarks;
                Leave.Status := Leave.Status::Open;
                if Leave.Modify(true) then
                    No := Leave."Application No";
                exit(No);
            end else begin
                Leave.Init();
                HRSetup.Get();
                Leave."Application No" := NoSeriesMgt.GetNextNo(HRSetup."Leave Application Nos.", Today, true);
                Leave.Insert();
                Leave."Employee No" := HrEmployees."No.";
                Leave.Validate("Employee No");
                Leave."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                Leave."Mobile No" := HrEmployees."Mobile Phone No.";
                Leave."Application Date" := today;
                Leave."Leave Code" := LeaveType;
                Leave.Validate("Leave Code");
                Leave."Start Date" := StartDate;
                Leave."Days Applied" := Days;
                Leave.Validate("Start Date");
                Leave."Duties Taken Over By" := Reliever;
                Leave.Validate("Duties Taken Over By");
                Leave.Comments := Remarks;
                Leave.Status := Leave.Status::Open;
                if Leave.Modify(true) then
                    No := Leave."Application No";
                exit(No);
            end;
        end;
    end;

    procedure SendLeaveForApproval(No: Code[50])
    var
        DocumentLink: Boolean;
    begin
        Leave.Reset();
        Leave.SetRange("Application No", No);
        if Leave.Find('-') then begin
            if HrApprovalsMgmt.CheckLeaveRequestWorkflowEnabled(Leave) then
                HrApprovalsMgmt.OnSendLeaveRequestApproval(Leave);
        end;
    end;

    procedure CancelLeaveApproval(No: Code[50])
    var
    begin
        Leave.Reset();
        Leave.SetRange("Application No", No);
        Leave.SetRange(Status, Leave.Status::"Pending Approval");
        if Leave.Find('-') then begin
            HrApprovalsMgmt.OnCancelLeaveRequestApproval(Leave);
            WorkflowWebhookMgt.FindAndCancel(Leave.RecordId);
        end;
    end;

    procedure ApplicantProfile(No: Code[40]; var Base64Txt: Text)
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        ApplicantReport: Report 53055;
        Base64Convert: Codeunit "Base64 Convert";
        Applicant: Record "Applicant";
    begin
        Applicant.Reset;
        Applicant.SetRange("No.", No);
        if Applicant.Find('-') then begin
            ApplicantReport.SetTableView(Applicant);
            TempBlob.CreateOutStream(StatementOutstream);
            if ApplicantReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                Base64Txt := Base64Convert.ToBase64(StatementInstream, true);
            end;
        end;
    end;

    procedure SENDEMAIL(Subject: Text; Receipient: Code[250]; FormattedBody: Text) sent: Boolean
    var
        EmailMessage: Codeunit "Email Message";
        smtp: Codeunit Email;

    begin
        sent := false;
        EmailMessage.Create(Receipient, Subject, FormattedBody, true);
        if smtp.Send(EmailMessage, Enum::"Email Scenario"::Default) then sent := true;
        exit(sent);
    end;





}
