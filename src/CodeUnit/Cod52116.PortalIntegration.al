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
        ImprestLines: Record "Payment Lines";
        PLines: Record "Payment Lines";
        ImprestHeader: Record Payments;
        PaymentsRec: Record Payments;


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

 procedure CreateImprestRequisition(No: Code[30]; AccountNo: Code[30]; Donor: Code[100]; Program: code[100]; TravelType: Integer;
    Currency: Code[30]; Purpose: Text[2048]; Destination: Code[250]; TravelDate: Date; NoOfDays: Integer; ReturnDate: Date; Cashier: Code[30];EmpNo:Code[30]): Code[30]
    var
    begin
        if ImprestHeader.Get(No) then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := Cashier;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::Imprest;
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := CopyStr(Donor, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 1 Code"));
            ImprestHeader."Shortcut Dimension 2 Code" := CopyStr(Program, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 2 Code"));
            ImprestHeader."Travel Type" := TravelType;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Destination := CopyStr(Destination, 1, MaxStrLen(ImprestHeader.Destination));
            ImprestHeader."Date of Project" := TravelDate;
            ImprestHeader."Date of Completion" := ReturnDate;
            ImprestHeader.Validate("Date of Completion");
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            ImprestHeader.Modify(true);
            exit(ImprestHeader."No.");
        end else begin
            ImprestHeader.Init();
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := Cashier;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::Imprest;
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := CopyStr(Donor, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 1 Code"));
            ImprestHeader."Shortcut Dimension 2 Code" := CopyStr(Program, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 2 Code"));
            ImprestHeader."Travel Type" := TravelType;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Destination := CopyStr(Destination, 1, MaxStrLen(ImprestHeader.Destination));
            ImprestHeader."Date of Project" := TravelDate;
            ImprestHeader."Date of Completion" := ReturnDate;
            ImprestHeader.Validate("Date of Completion");
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            ImprestHeader.Insert(true);
            exit(ImprestHeader."No.");
        end;
    end;

    procedure CreateImprestRequisitionLines(No: Code[30]; ImprestType: Code[50]; DailyRate: Decimal; LineNo: Integer)
    var
    begin
        if ImprestHeader.Get(No) then begin
            ImprestLines.Reset();
            ImprestLines.SetRange("Imprest No.", No);
            ImprestLines.SetRange("Line No", LineNo);
            ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::Imprest);
            if ImprestLines.Find('-') then begin
                ImprestLines."Payment Type" := ImprestLines."Payment Type"::Imprest;
                ImprestLines.No := CopyStr(No, 1, MaxStrLen(ImprestLines.No));
                ImprestLines."No of Days" := ImprestHeader."No of Days";
                ImprestLines."Expenditure Type" := CopyStr(ImprestType, 1, MaxStrLen(ImprestLines."Expenditure Type"));
                ImprestLines.Validate("Expenditure Type");
                ImprestLines."Daily Rate" := DailyRate;
                ImprestLines.Validate("Daily Rate");
                ImprestLines.Destination := ImprestHeader.Destination;
                ImprestLines."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                ImprestLines."Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                ImprestLines.Modify();
            end else begin
                ImprestLines.Init();
                ImprestLines."Payment Type" := ImprestLines."Payment Type"::Imprest;
                ImprestLines.No := CopyStr(No, 1, MaxStrLen(ImprestLines.No));
                ImprestLines."Expenditure Type" := CopyStr(ImprestType, 1, MaxStrLen(ImprestLines."Expenditure Type"));
                ImprestLines.Validate("Expenditure Type");
                ImprestLines."No of Days" := ImprestHeader."No of Days";
                ImprestLines."Daily Rate" := DailyRate;
                ImprestLines.Validate("Daily Rate");
                ImprestLines.Destination := ImprestHeader.Destination;
                ImprestLines."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                ImprestLines."Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                ImprestLines.Insert();
            end;
        end;

    end;

    procedure DeleteImprestLine(No: Code[30]; LineNo: Integer): Boolean
    begin
        ImprestLines.Reset();
        ImprestLines.SetRange(No, No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::Imprest);
        if ImprestLines.Find('-') then
            if ImprestLines.Delete(true) then
                exit(true);
    end;

    procedure CreateImprestSurRequisition(No: Code[30]; ImprestNo: Code[30]): Code[30]
    var
        ImpSurrLines: Record "Payment Lines";
        PaymentLine: Record "Payment Lines";
        PaymentRec: Record Payments;
        ImprestFullySurrenderedLbl: Label 'The imprest %1 has been fully surrendered', Comment = '%1 = Imprest Issue Doc. No';
    begin
        if ImprestHeader.Get(No) then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Imprest Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := CopyStr(ImprestNo, 1, MaxStrLen(ImprestHeader."Imprest Issue Doc. No"));
            if PaymentRec.Get(ImprestNo) then
                if ImprestHeader."Payment Type" = ImprestHeader."Payment Type"::"Imprest Surrender" then begin
                    if PaymentRec.Surrendered then
                        Error(ImprestFullySurrenderedLbl, ImprestHeader."Imprest Issue Doc. No");

                    ImprestHeader."Account Type" := PaymentRec."Account Type";
                    ImprestHeader."Account No." := PaymentRec."Account No.";
                    ImprestHeader.Validate("Account No.");
                    ImprestHeader."Pay Mode" := PaymentRec."Pay Mode";
                    ImprestHeader."Cheque No" := PaymentRec."Cheque No";
                    ImprestHeader."Cheque Date" := PaymentRec."Cheque Date";
                    ImprestHeader.Payee := PaymentRec.Payee;
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."Paying Bank Account" := PaymentRec."Paying Bank Account";
                    ImprestHeader.Currency := PaymentRec.Currency;
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader."Multi-Donor" := PaymentRec."Multi-Donor";
                    ImprestHeader."Staff No." := PaymentRec."Staff No.";
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."No of Days" := PaymentRec."No of Days";
                    ImprestHeader."Date of Project" := PaymentRec."Date of Project";
                    ImprestHeader."Date of Completion" := PaymentRec."Date of Completion";
                    ImprestHeader."Due Date" := PaymentRec."Due Date";
                    ImprestHeader."Posted Date" := PaymentRec."Posted Date";

                    ImprestHeader."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    ImprestHeader.Validate("Shortcut Dimension 1 Code");
                    ImprestHeader."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    ImprestHeader.Validate("Shortcut Dimension 2 Code");
                    ImprestHeader."Dimension Set ID" := PaymentRec."Dimension Set ID";
                    ImprestHeader."Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 3 Code");
                    //ImprestHeader.Validate("Dimension Set ID");
                    ImprestHeader.Status := ImprestHeader.Status::Open;
                    ImprestHeader.Modify(true);
                    exit(ImprestHeader."No.");
                end;
        end else begin
            ImprestHeader.Init();
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Imprest Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := CopyStr(ImprestNo, 1, MaxStrLen(ImprestHeader."Imprest Issue Doc. No"));
            if PaymentRec.Get(ImprestNo) then
                if ImprestHeader."Payment Type" = ImprestHeader."Payment Type"::"Imprest Surrender" then begin
                    if PaymentRec.Surrendered then
                        Error(ImprestFullySurrenderedLbl, ImprestHeader."Imprest Issue Doc. No");

                    ImprestHeader."Account Type" := PaymentRec."Account Type";
                    ImprestHeader."Account No." := PaymentRec."Account No.";
                    ImprestHeader.Validate("Account No.");
                    ImprestHeader."Pay Mode" := PaymentRec."Pay Mode";
                    ImprestHeader."Cheque No" := PaymentRec."Cheque No";
                    ImprestHeader."Cheque Date" := PaymentRec."Cheque Date";
                    ImprestHeader.Payee := PaymentRec.Payee;
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."Paying Bank Account" := PaymentRec."Paying Bank Account";
                    ImprestHeader.Currency := PaymentRec.Currency;
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader."Multi-Donor" := PaymentRec."Multi-Donor";
                    ImprestHeader."Staff No." := PaymentRec."Staff No.";
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."No of Days" := PaymentRec."No of Days";
                    ImprestHeader."Date of Project" := PaymentRec."Date of Project";
                    ImprestHeader."Date of Completion" := PaymentRec."Date of Completion";
                    ImprestHeader."Due Date" := PaymentRec."Due Date";
                    ImprestHeader."Posted Date" := PaymentRec."Posted Date";

                    ImprestHeader."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 1 Code");
                    ImprestHeader."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 2 Code");
                    ImprestHeader."Dimension Set ID" := PaymentRec."Dimension Set ID";
                    ImprestHeader."Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 3 Code");
                    // ImprestHeader.Validate("Dimension Set ID");
                    ImprestHeader.Status := ImprestHeader.Status::Open;
                    ImprestHeader.Insert(true);

                    PaymentLine.Reset();
                    PaymentLine.SetRange(No, PaymentRec."No.");
                    if PaymentLine.Find('-') then
                        repeat
                            ImpSurrLines.Init();
                            ImpSurrLines.TransferFields(PaymentLine);
                            ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Imprest Surrender";
                            ImpSurrLines.No := ImprestHeader."No.";
                            ImpSurrLines."Line No" := GetNextLineNo(ImprestHeader."No.");
                            ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                            ImpSurrLines.Insert();
                        until PaymentLine.Next() = 0;
                end;
            exit(ImprestHeader."No.");
        end;
    end;

    procedure UpdateImprestSurrenderLine(No: Code[30]; LineNo: Integer; Amount: Decimal; ReceiptNo: Code[30]; ReceiptAmount: Decimal)
    begin
        ImprestLines.Reset();
        ImprestLines.SetRange(No, No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::"Imprest Surrender");
        if ImprestLines.Find('-') then
            ImprestLines."Actual Spent" := Amount;
        ImprestLines."Imprest Receipt No." := CopyStr(ReceiptNo, 1, MaxStrLen(ImprestLines."Imprest Receipt No."));
        ImprestLines."Cash Receipt Amount" := ReceiptAmount;
        ImprestLines.Modify();

    end;

    local procedure GetNextLineNo(No: Code[30]): Integer
    var
        paymentlines: Record "Payment Lines";
    begin
        paymentlines.Reset();
        paymentlines.SetRange(paymentlines.No, No);
        if paymentlines.FindLast() then
            exit(paymentlines."Line No" + 10000)
        else
            exit(10000);
    end;

    procedure CreatePettyCash(No: Code[30]; AccountNo: Code[30]; PettyCashType: Integer; Purpose: Text; Cashier: Code[30]; Currency: Code[30]; EmpNo: Code[30]): Code[30]
    var
    begin
        HrEmployees.Get(EmpNo);
        if ImprestHeader.Get(No) then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := Cashier;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := HrEmployees."Global Dimension 1 Code";
            ImprestHeader."Shortcut Dimension 2 Code" := HrEmployees."Global Dimension 2 Code";
            ImprestHeader."Petty Cash Type" := PettyCashType;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            ImprestHeader.Modify(true);
            exit(ImprestHeader."No.");
        end else begin
            ImprestHeader.Init();
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := Cashier;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := HrEmployees."Global Dimension 1 Code";
            ImprestHeader."Shortcut Dimension 2 Code" := HrEmployees."Global Dimension 2 Code";
            ImprestHeader."Petty Cash Type" := PettyCashType;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            ImprestHeader.Insert(true);
            exit(ImprestHeader."No.");
        end;
    end;

    procedure CreatePettyCashLines(No: Code[30]; ImprestType: Code[50]; DailyRate: Decimal; LineNo: Integer; Narration: Text)
    var
    begin
        if ImprestHeader.Get(No) then begin
            ImprestLines.Reset();
            ImprestLines.SetRange("Imprest No.", No);
            ImprestLines.SetRange("Line No", LineNo);
            ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::"Petty Cash");
            if ImprestLines.Find('-') then begin
                ImprestLines."Payment Type" := ImprestLines."Payment Type"::"Petty Cash";
                ImprestLines.No := CopyStr(No, 1, MaxStrLen(ImprestLines.No));
                ImprestLines.Description := CopyStr(Narration, 1, MaxStrLen(ImprestLines.Description));
                ImprestLines."Expenditure Type" := CopyStr(ImprestType, 1, MaxStrLen(ImprestLines."Expenditure Type"));
                ImprestLines.Validate("Expenditure Type");
                ImprestLines.Amount := DailyRate;
                ImprestLines.Validate(Amount);
                ImprestLines."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                ImprestLines."Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                ImprestLines.Modify();
            end else begin
                ImprestLines.Init();
                ImprestLines."Payment Type" := ImprestLines."Payment Type"::"Petty Cash";
                ImprestLines.No := CopyStr(No, 1, MaxStrLen(ImprestLines.No));
                ImprestLines.Description := CopyStr(Narration, 1, MaxStrLen(ImprestLines.Description));
                ImprestLines."Expenditure Type" := CopyStr(ImprestType, 1, MaxStrLen(ImprestLines."Expenditure Type"));
                ImprestLines.Validate("Expenditure Type");
                ImprestLines.Amount := DailyRate;
                ImprestLines.Validate(Amount);
                ImprestLines."Shortcut Dimension 1 Code" := ImprestLines."Shortcut Dimension 1 Code";
                ImprestLines."Shortcut Dimension 2 Code" := ImprestHeader."Shortcut Dimension 2 Code";
                ImprestLines.Insert();
            end;
        end;

    end;

    procedure DeletePettyCashLine(No: Code[30]; LineNo: Integer): Boolean
    begin
        ImprestLines.Reset();
        ImprestLines.SetRange(No, No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::"Petty Cash");
        if ImprestLines.Find('-') then
            if ImprestLines.Delete(true) then
                exit(true);
    end;

    procedure CreatePettySurRequisition(No: Code[30]; ImprestNo: Code[30]): Code[30]
    var
        ImpSurrLines: Record "Payment Lines";
        PaymentLine: Record "Payment Lines";
        PaymentRec: Record Payments;
        ImprestFullySurrenderedLbl: Label 'The Petty Cash %1 has been fully surrendered', Comment = '%1 = Imprest Issue Doc. No';
    begin
        if ImprestHeader.Get(No) then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := CopyStr(ImprestNo, 1, MaxStrLen(ImprestHeader."Imprest Issue Doc. No"));
            if PaymentRec.Get(ImprestNo) then
                if ImprestHeader."Payment Type" = ImprestHeader."Payment Type"::"Petty Cash Surrender" then begin
                    if PaymentRec.Surrendered then
                        Error(ImprestFullySurrenderedLbl, ImprestHeader."Imprest Issue Doc. No");

                    ImprestHeader."Account Type" := PaymentRec."Account Type";
                    ImprestHeader."Account No." := PaymentRec."Account No.";
                    ImprestHeader.Validate("Account No.");
                    ImprestHeader."Pay Mode" := PaymentRec."Pay Mode";
                    ImprestHeader."Cheque No" := PaymentRec."Cheque No";
                    ImprestHeader."Cheque Date" := PaymentRec."Cheque Date";
                    ImprestHeader.Payee := PaymentRec.Payee;
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."Paying Bank Account" := PaymentRec."Paying Bank Account";
                    ImprestHeader.Currency := PaymentRec.Currency;
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader."Multi-Donor" := PaymentRec."Multi-Donor";
                    ImprestHeader."Staff No." := PaymentRec."Staff No.";
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."No of Days" := PaymentRec."No of Days";
                    ImprestHeader."Date of Project" := PaymentRec."Date of Project";
                    ImprestHeader."Date of Completion" := PaymentRec."Date of Completion";
                    ImprestHeader."Due Date" := PaymentRec."Due Date";
                    ImprestHeader."Posted Date" := PaymentRec."Posted Date";

                    ImprestHeader."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    ImprestHeader.Validate("Shortcut Dimension 1 Code");
                    ImprestHeader."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    ImprestHeader.Validate("Shortcut Dimension 2 Code");
                    ImprestHeader."Dimension Set ID" := PaymentRec."Dimension Set ID";
                    ImprestHeader."Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 3 Code");
                    //ImprestHeader.Validate("Dimension Set ID");
                    ImprestHeader.Status := ImprestHeader.Status::Open;
                    ImprestHeader.Modify(true);
                    exit(ImprestHeader."No.");
                end;
        end else begin
            ImprestHeader.Init();
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := CopyStr(ImprestNo, 1, MaxStrLen(ImprestHeader."Imprest Issue Doc. No"));
            if PaymentRec.Get(ImprestNo) then
                if ImprestHeader."Payment Type" = ImprestHeader."Payment Type"::"Petty Cash Surrender" then begin
                    if PaymentRec.Surrendered then
                        Error(ImprestFullySurrenderedLbl, ImprestHeader."Imprest Issue Doc. No");

                    ImprestHeader."Account Type" := PaymentRec."Account Type";
                    ImprestHeader."Account No." := PaymentRec."Account No.";
                    ImprestHeader.Validate("Account No.");
                    ImprestHeader."Pay Mode" := PaymentRec."Pay Mode";
                    ImprestHeader."Cheque No" := PaymentRec."Cheque No";
                    ImprestHeader."Cheque Date" := PaymentRec."Cheque Date";
                    ImprestHeader.Payee := PaymentRec.Payee;
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."Paying Bank Account" := PaymentRec."Paying Bank Account";
                    ImprestHeader.Currency := PaymentRec.Currency;
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader."Multi-Donor" := PaymentRec."Multi-Donor";
                    ImprestHeader."Staff No." := PaymentRec."Staff No.";
                    ImprestHeader."Payment Narration" := PaymentRec."Payment Narration";
                    ImprestHeader.Destination := PaymentRec.Destination;
                    ImprestHeader."No of Days" := PaymentRec."No of Days";
                    ImprestHeader."Date of Project" := PaymentRec."Date of Project";
                    ImprestHeader."Date of Completion" := PaymentRec."Date of Completion";
                    ImprestHeader."Due Date" := PaymentRec."Due Date";
                    ImprestHeader."Posted Date" := PaymentRec."Posted Date";

                    ImprestHeader."Shortcut Dimension 1 Code" := PaymentRec."Shortcut Dimension 1 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 1 Code");
                    ImprestHeader."Shortcut Dimension 2 Code" := PaymentRec."Shortcut Dimension 2 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 2 Code");
                    ImprestHeader."Dimension Set ID" := PaymentRec."Dimension Set ID";
                    ImprestHeader."Shortcut Dimension 3 Code" := PaymentRec."Shortcut Dimension 3 Code";
                    //ImprestHeader.Validate("Shortcut Dimension 3 Code");
                    // ImprestHeader.Validate("Dimension Set ID");
                    ImprestHeader.Status := ImprestHeader.Status::Open;
                    ImprestHeader.Insert(true);

                    PaymentLine.Reset();
                    PaymentLine.SetRange(No, PaymentRec."No.");
                    if PaymentLine.Find('-') then
                        repeat
                            ImpSurrLines.Init();
                            ImpSurrLines.TransferFields(PaymentLine);
                            ImpSurrLines."Payment Type" := ImpSurrLines."Payment Type"::"Petty Cash Surrender";
                            ImpSurrLines.No := ImprestHeader."No.";
                            ImpSurrLines."Line No" := GetNextLineNo(ImprestHeader."No.");
                            ImpSurrLines.Purpose := PaymentRec."Payment Narration";
                            ImpSurrLines.Insert();
                        until PaymentLine.Next() = 0;
                end;
            exit(ImprestHeader."No.");
        end;
    end;

    procedure UpdatePettyCashSurrenderLine(No: Code[30]; LineNo: Integer; Amount: Decimal; ReceiptNo: Code[30]; ReceiptAmount: Decimal)
    begin
        ImprestLines.Reset();
        ImprestLines.SetRange(No, No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::"Petty Cash Surrender");
        if ImprestLines.Find('-') then begin
            ImprestLines."Actual Spent" := Amount;
            ImprestLines."Imprest Receipt No." := CopyStr(ReceiptNo, 1, MaxStrLen(ImprestLines."Imprest Receipt No."));
            ImprestLines."Cash Receipt Amount" := ReceiptAmount;
            ImprestLines.Modify();
        end;

    end;

// procedure GetImprestBalance(No: Code[30]): Decimal
//     var
//         Customer: Record Customer;
//         Payee: Record Payee;
//     begin
//         Payee.Reset();
//         Payee.SetRange("Employee No.", No);
//         if Payee.FindFirst() then
//             if Customer.Get(Payee."Receivable Account No") then begin
//                 Customer.CalcFields(Balance);
//                 exit(Customer.Balance);
//             end;
//     end;

//     procedure GetStaffNoFromCustNo(AccNo: Code[30]): Code[20]
//     var
//         PayeeRec: Record Payee;
//     begin
//         PayeeRec.Reset();
//         PayeeRec.SetRange("Receivable Account No", AccNo);
//         if PayeeRec.FindFirst() then
//             exit(PayeeRec."Employee No.");
//     end;


}
