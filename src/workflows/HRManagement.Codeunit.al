codeunit 52001 "HR Management"
{
    procedure CheckNonWorkingDay(CalendarCode: Code[10]; TargetDate: Date; var Description: Text[50]): Boolean
    var
        BaseCalChange: Record "Base Calendar Change";
    begin
        BaseCalChange.Reset();
        BaseCalChange.SetRange("Base Calendar Code", CalendarCode);
        if BaseCalChange.FindSet() then
            repeat


                case BaseCalChange."Recurring System" of
                    BaseCalChange."Recurring System"::" ":
                        if TargetDate = BaseCalChange.Date then begin
                            Description := BaseCalChange.Description;

                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Weekly Recurring":
                        if Date2DWY(TargetDate, 1) = BaseCalChange.Day then begin
                            Description := BaseCalChange.Description;

                            exit(BaseCalChange.Nonworking);
                        end;
                    BaseCalChange."Recurring System"::"Annual Recurring":
                        if (Date2DMY(TargetDate, 2) = Date2DMY(BaseCalChange.Date, 2)) and
                           (Date2DMY(TargetDate, 1) = Date2DMY(BaseCalChange.Date, 1))
                        then begin
                            Description := BaseCalChange.Description;

                            exit(BaseCalChange.Nonworking);
                        end;
                end;
            until BaseCalChange.Next() = 0;
        Description := '';
    end;

    procedure CheckNonWorkingDayLoans(CalendarCode: Code[10]; TargetDate: Date; Description: Text[50]) NonWorkDay: Boolean
    var
        BaseCalChange: Record "Base Calendar Change";
        DayText: Text[150];
    begin

        BaseCalChange.Reset();
        BaseCalChange.SetRange(Date, TargetDate);
        BaseCalChange.SetRange("Base Calendar Code", CalendarCode);
        BaseCalChange.SetRange("Recurring System", BaseCalChange."Recurring System"::"Annual Recurring");
        if BaseCalChange.FindFirst() then
            NonWorkDay := BaseCalChange.Nonworking
        else begin
            DayText := '';
            DayText := Format(TargetDate, 0, '<Weekday Text>');
            case DayText of
                'Saturday',
                'Sunday':

                    NonWorkDay := true;
            end;
        end;
    end;

    procedure CheckIfLeaveAllowanceExists(LeaveAppRec: Record "Leave Application")
    var
        LeaveAppRec2: Record "Leave Application";
        AllExistsErrorErr: Label 'You have already applied for leave allowance for the period %1', Comment = '%1 = Leave Period';
    begin
        LeaveAppRec2.Reset();
        LeaveAppRec2.SetRange("Employee No", LeaveAppRec."Employee No");
        //LeaveAppRec2.SetRange(Status, LeaveAppRec2.Status::Released);
        LeaveAppRec2.SetRange("Leave Period", LeaveAppRec."Leave Period");
        LeaveAppRec2.SetRange("Leave Allowance Payable", true);
        if not LeaveAppRec2.IsEmpty() then
            Error(AllExistsErrorErr, LeaveAppRec."Leave Period");
    end;







    procedure DeleteEmployee(No: Code[20])
    var
        Employee: Record Employee;
    begin
        if Employee.Get(No) then
            Employee.Delete();
    end;

    //[TryFunction]

    /* procedure CallRESTWebService(BaseUrl: Text; Method: Text; RestMethod: Text; var HttpContent: DotNet BCHttpContent; var HttpResponseMessage: DotNet BCHttpResponseMessage)
     var
         HttpClient: DotNet BCHttpClient;
         Uri: DotNet BCUri;
     begin
         HttpClient := HttpClient.HttpClient();
         HttpClient.BaseAddress := Uri.Uri(BaseUrl);

         case RestMethod of
             'GET':
                 HttpResponseMessage := HttpClient.GetAsync(Method).Result;
             'POST':
                 HttpResponseMessage := HttpClient.PostAsync(Method, HttpContent).Result;
             'PUT':
                 HttpResponseMessage := HttpClient.PutAsync(Method, HttpContent).Result;
             'DELETE':
                 HttpResponseMessage := HttpClient.DeleteAsync(Method).Result;
         end;

         HttpResponseMessage.EnsureSuccessStatusCode(); // Throws an error when no success
     end;
 */









    procedure GetCurrentLeavePeriodCode(): Code[20]
    var
        LeavePeriods: Record "Leave Period";
    begin
        LeavePeriods.Reset();
        LeavePeriods.SetRange(closed, false);
        if LeavePeriods.FindFirst() then
            exit(LeavePeriods."Leave Period Code")
        else
            Error('Please define a new leave period');
    end;

    procedure GetCurrentPeriodStart(InitialDate: Date): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.Reset();
        AccountingPeriod.SetFilter("Starting Date", '<=%1', InitialDate);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.FindLast() then
            exit(AccountingPeriod."Starting Date");
    end;


    procedure GetEmail(EmployeeNo: Code[20]): Text
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmployeeNo) then begin
            Employee.TestField("E-Mail");
            exit(Employee."E-Mail");
        end;
    end;

    procedure GetEmpJobTitle(EmpNo: Code[50]): Text
    var
        Employee: Record Employee;
    begin
        if Employee.Get(EmpNo) then
            exit(Employee."Job Position Title");
    end;

    procedure GetLeaveName(LeaveCode: Code[30]): Text[250]
    var
        LeaveType: Record "Leave Type";
    begin
        if LeaveType.Get(LeaveCode) then
            exit(LeaveType.Description);
        //MESSAGE(LeaveType.Description);
    end;


    procedure GetLeavePeriod(ApplicationDate: Date): Date
    var
        AccPeriod: Record "Accounting Period";
        PeriodStart: Date;
    begin
        AccPeriod.Reset();
        AccPeriod.SetFilter("Starting Date", '>=%1', CalcDate('<-CM>', ApplicationDate));
        if AccPeriod.FindFirst() then
            PeriodStart := AccPeriod."Starting Date";
        exit(PeriodStart);
    end;



    procedure GetPreviousLeavePeriodFromAccountingPeriod(): Code[50]
    var
        LeavePeriods: Record "Leave Period";
    begin
        LeavePeriods.Reset();
        LeavePeriods.SetFilter("Start Date", '>=%1', GetPreviousPeriodStart());
        LeavePeriods.SetFilter("End Date", '<=%1', GetPreviousPeriodEnd());
        if LeavePeriods.FindFirst() then
            exit(LeavePeriods."Leave Period Code");
    end;

    procedure GetPreviousPeriodEnd(): Date
    var
        AccountingPeriod: Record "Accounting Period";
    begin
        AccountingPeriod.Reset();
        AccountingPeriod.SetFilter("Starting Date", '>%1', GetPreviousPeriodStart());
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.FindFirst() then
            exit(AccountingPeriod."Starting Date");
    end;

    procedure GetPreviousPeriodStart(): Date
    var
        AccountingPeriod: Record "Accounting Period";
        CurrentPeriodStart: Date;
    begin
        CurrentPeriodStart := GetCurrentPeriodStart(Today);

        AccountingPeriod.Reset();
        AccountingPeriod.SetFilter("Starting Date", '<%1', CurrentPeriodStart);
        AccountingPeriod.SetRange("New Fiscal Year", true);
        if AccountingPeriod.FindLast() then
            exit(AccountingPeriod."Starting Date");
    end;



    procedure GetVacantPositions(Vacant: Record "Company Job")
    begin
        Vacant.CalcFields("Occupied Position");
        Vacant.Vacancy := Vacant."No of Posts" - Vacant."Occupied Position";
        if Vacant.Vacancy < 0 then
            Vacant.Vacancy := 0;
        Vacant.Modify();
    end;

    procedure SubmitJobApplication(JobApplication: Record "Job Application")
    var
        JobsApplied: Record "Applicant job applied";
        Applicants: Record Applicant;
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailSignBigText: BigText;
        Instr: InStream;
        NewBodyLbl: Label 'Dear %1, <br><br> This is to Confirm receipt of your Job application for the Position of <Strong>%2 </Strong>.<br> <br> <br>Kind Regards <br><br>%3.', Comment = '%1 = Full Name, %2 = Job Title, %3 = Company Name';
        SubjectLbl: Label 'Job Application Received - %1', Comment = '%1 = Job Title';
        SubmitSuccessMsg: Label 'Job Application Submitted Successfully';
        Recipient: List of [Text];
        EmailSignText: Text;
        FormattedBody: Text;
        RecipientAddress: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
    begin
        JobApplication.TestField("Applicant No.");
        JobApplication.TestField("Job Applied Code");

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture, "E-Mail Signature");
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        CompanyInfo."E-Mail Signature".CreateInStream(Instr);
        EmailSignBigText.Read(Instr);
        EmailSignText := Format(EmailSignBigText);

        RecipientAddress := '';

        case JobApplication."Applicant Type" of
            JobApplication."Applicant Type"::External:
                begin
                    Applicants.Get(JobApplication."Applicant No.");
                    Applicants.TestField("First Name");
                    Applicants.TestField("E-Mail");
                    RecipientAddress := Applicants."E-Mail";
                end;
            JobApplication."Applicant Type"::Internal:
                begin
                    Employee.Get(JobApplication."Applicant No.");
                    Employee.TestField("E-Mail");
                    RecipientAddress := Employee."E-Mail";
                end;
        end;

        //Insert into jobs applied
        JobsApplied.Init();
        JobsApplied.Validate("Applicant No.", JobApplication."Applicant No.");
        JobsApplied.Validate("Need Code", JobApplication."Job Applied Code");
        JobsApplied.Validate("Job Application No.", JobApplication."No.");
        JobsApplied.Validate("Applicant Type", JobApplication."Applicant Type");
        if not JobsApplied.Get(Applicants."No.", JobApplication."Job Applied Code") then
            JobsApplied.Insert();

        SenderName := CompanyInfo.Name;
        SenderAddress := CompanyInfo."E-Mail";

        Clear(Recipient);
        Recipient.Add(RecipientAddress);
        Subject := StrSubstNo(SubjectLbl, JobApplication."Job Title");
        FormattedBody := StrSubstNo(NewBodyLbl, (JobApplication."Applicant Name"), JobApplication."Job Title", CompanyInfo.Name);
        EmailMessage.Create(Recipient, Subject, FormattedBody, true);
        Email.Send(EmailMessage);

        JobApplication.Validate(Submitted, true);
        JobApplication.Validate("Application Status", JobApplication."Application Status"::Submited);
        JobApplication.Modify();

        if GuiAllowed then
            Message(SubmitSuccessMsg);
    end;







    procedure LeaveAbsentism(EmployeeAbsence: Record "Employee Absence")
    var
        Employee: Record Employee;
        LeaveLedg: Record "HR Leave Ledger Entries";
        LeaveType: Record "Leave Type";
    begin
        Employee.Get(EmployeeAbsence."Employee No.");
        LeaveLedg.Init();
        LeaveLedg."Document No." := CopyStr((Employee."No." + '-' + Format(EmployeeAbsence."Entry No.")), 1, MaxStrLen(LeaveLedg."Document No."));
        LeaveLedg."Leave Period" := EmployeeAbsence."From Date";
        LeaveLedg."Leave Start Date" := EmployeeAbsence."From Date";
        LeaveLedg."Leave End Date" := EmployeeAbsence."To Date";
        LeaveLedg."Leave Approval Date" := Today;
        LeaveType.Reset();
        LeaveType.SetRange("Annual Leave", true);
        if LeaveType.FindFirst() then
            LeaveLedg."Leave Type" := LeaveType.Code;
        LeaveLedg."Leave Period Code" := Employee."Current Leave Period";
        LeaveLedg."Staff No." := Employee."No.";
        LeaveLedg."Staff Name" := CopyStr(Employee.FullName(), 1, MaxStrLen(LeaveLedg."Staff Name"));
        //LeaveLedg."Job ID" := Employee."Job Position";
        LeaveLedg."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedg."Job Group"));
        LeaveLedg."Contract Type" := CopyStr(Employee."Nature of Employment", 1, MaxStrLen(LeaveLedg."Contract Type"));
        LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
        LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
        LeaveLedg."User ID" := CopyStr(UserId(), 1, MaxStrLen(LeaveLedg."User ID"));
        LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Negative;
        LeaveLedg."No. of days" := -((EmployeeAbsence."To Date" - EmployeeAbsence."From Date") + 1);
        LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Adjustment";
        LeaveLedg.Insert();
    end;


    procedure LeaveAdjustment("Code": Code[20])
    var
        Employee: Record Employee;
        LeaveLedg: Record "HR Leave Ledger Entries";
        LeaveAdjustHead: Record "Leave Bal Adjustment Header";
        LeaveAdjustLines: Record "Leave Bal Adjustment Lines";
    begin
        LeaveAdjustHead.Get(Code);
        LeaveAdjustLines.SetRange("Header No.", Code);
        if LeaveAdjustLines.FindSet() then begin
            repeat
                LeaveAdjustLines.TestField("Leave Period");
                LeaveAdjustLines.TestField("Leave Code");

                LeaveLedg.Init();
                LeaveLedg."Entry No." := LeaveLedg.GetNextEntryNo();
                LeaveLedg."Document No." := LeaveAdjustLines."Header No.";
                LeaveLedg."Staff No." := CopyStr(LeaveAdjustLines."Staff No.", 1, MaxStrLen(LeaveLedg."Staff No."));
                LeaveLedg."Leave Entry Type" := LeaveAdjustLines."Leave Adj Entry Type";
                LeaveLedg."Leave Period Code" := LeaveAdjustLines."Leave Period";
                if Employee.Get(LeaveLedg."Staff No.") then begin
                    //LeaveLedg."Job ID" := Employee."Job Position";
                    LeaveLedg."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedg."Job Group"));
                    LeaveLedg."Contract Type" := CopyStr(Employee."Nature of Employment", 1, MaxStrLen(LeaveLedg."Contract Type"));
                    LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                end;
                LeaveLedg."Staff Name" := CopyStr(LeaveAdjustLines."Employee Name", 1, MaxStrLen(LeaveLedg."Staff Name"));
                LeaveLedg."Leave Type" := CopyStr(LeaveAdjustLines."Leave Code", 1, MaxStrLen(LeaveLedg."Leave Type"));
                LeaveLedg."Leave Period" := GetLeavePeriod(Today());
                LeaveLedg."Leave Date" := Today();
                LeaveLedg."Leave Approval Date" := Today();
                LeaveLedg."No. of days" := LeaveAdjustLines."New Entitlement";
                LeaveLedg."Leave Posting Description" := 'Leave Adjustment';
                LeaveLedg."Transaction Type" := LeaveAdjustLines."Transaction Type";
                LeaveLedg."User ID" := CopyStr(UserId(), 1, MaxStrLen(LeaveLedg."User ID"));
                LeaveLedg.Insert();
            until LeaveAdjustLines.Next() = 0;

            LeaveAdjustHead.Posted := true;
            LeaveAdjustHead."Posted By" := CopyStr(UserId(), 1, MaxStrLen(LeaveAdjustHead."Posted By"));
            LeaveAdjustHead."Posted Date" := Today();
            LeaveAdjustHead.Modify();
            Message('Leave adjustment posted successfully');
        end;

    end;


    procedure LeaveApplication(LeaveAppNo: Code[20])
    var
        Employee: Record Employee;
        LeaveLedg: Record "HR Leave Ledger Entries";
        LeaveApp: Record "Leave Application";
    begin
        LeaveApp.Get(LeaveAppNo);

        Employee.Get(LeaveApp."Employee No");
        Employee.SetRange("Leave Type Filter", LeaveApp."Leave Code");
        Employee.SetRange("Leave Period Filter", LeaveApp."Leave Period");
        Employee.CalcFields("Leave Balance Brought Forward");

        LeaveLedg.Init();
        LeaveLedg."Entry No." := LeaveLedg.GetNextEntryNo();
        LeaveLedg."Document No." := LeaveAppNo;
        LeaveLedg."Leave Type" := LeaveApp."Leave Code";
        LeaveLedg."Leave Start Date" := LeaveApp."Start Date";
        LeaveLedg."Leave End Date" := LeaveApp."End Date";
        LeaveLedg."Leave Return Date" := LeaveApp."Resumption Date";
        LeaveLedg."Leave Approval Date" := Today;
        LeaveLedg."Leave Date" := Today;
        LeaveLedg."Leave Period" := GetLeavePeriod(LeaveApp."Start Date");
        LeaveLedg."Leave Application No." := LeaveApp."Application No";
        LeaveLedg."Leave Posting Description" := 'Leave Application';
        LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Application";
        LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Negative;
        LeaveLedg."User ID" := LeaveApp."User ID";
        if LeaveLedg."Leave Entry Type" = LeaveLedg."Leave Entry Type"::Negative then
            LeaveLedg."No. of days" := -LeaveApp."Days Applied"
        else
            LeaveLedg."No. of days" := LeaveApp."Days Applied";
        LeaveLedg."Staff No." := LeaveApp."Employee No";
        LeaveLedg."Staff Name" := CopyStr(LeaveApp."Employee Name", 1, MaxStrLen(LeaveLedg."Staff Name"));
        // LeaveLedg."Job ID" := Employee."Job Position";
        LeaveLedg."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedg."Job Group"));
        LeaveLedg."Contract Type" := CopyStr(Employee."Nature of Employment", 1, MaxStrLen(LeaveLedg."Contract Type"));
        LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
        LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
        LeaveLedg."Leave Period Code" := LeaveApp."Leave Period";
        if LeaveLedg."No. of days" <> 0 then
            LeaveLedg.Insert();
    end;

    procedure LeaveRecall(LeaveRecNo: Code[20])
    var
        Employee: Record Employee;
        EmpOff_Holiday: Record "Employee Off/Holiday";
        LeaveLedg: Record "HR Leave Ledger Entries";
        LeaveApp: Record "Leave Application";
    begin
        LeaveLedg.Init();
        LeaveLedg."Document No." := LeaveRecNo;
        if EmpOff_Holiday.Get(LeaveRecNo) then begin
            LeaveLedg."Leave End Date" := EmpOff_Holiday."Recalled To";
            LeaveLedg."Leave Application No." := EmpOff_Holiday."Leave Application";
            LeaveLedg."Leave Start Date" := EmpOff_Holiday."Recalled From";
            LeaveLedg."Leave Return Date" := EmpOff_Holiday."Recalled From";
            LeaveLedg."Leave Approval Date" := Today;
            LeaveLedg."Leave Period" := EmpOff_Holiday."Recalled From";
            LeaveApp.Reset();
            LeaveApp.SetRange("Application No", EmpOff_Holiday."Leave Application");
            if LeaveApp.FindFirst() then begin
                LeaveLedg."Leave Type" := LeaveApp."Leave Code";
                LeaveLedg."Leave Period Code" := LeaveApp."Leave Period";
            end;
            LeaveLedg."Staff No." := EmpOff_Holiday."Employee No";
            if Employee.Get(LeaveLedg."Staff No.") then begin
                //  LeaveLedg."Job ID" := Employee."Job Position";
                LeaveLedg."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedg."Job Group"));
                LeaveLedg."Contract Type" := CopyStr(Employee."Nature of Employment", 1, MaxStrLen(LeaveLedg."Contract Type"));
                LeaveLedg."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
                LeaveLedg."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
            end;
            LeaveLedg."Staff Name" := CopyStr(EmpOff_Holiday."Employee Name", 1, MaxStrLen(LeaveLedg."Staff Name"));
            LeaveLedg."User ID" := CopyStr(UserId, 1, MaxStrLen(LeaveLedg."User ID"));
            LeaveLedg."Leave Entry Type" := LeaveLedg."Leave Entry Type"::Positive;
            LeaveLedg."No. of days" := EmpOff_Holiday."No. of Off Days";
            LeaveLedg."Transaction Type" := LeaveLedg."Transaction Type"::"Leave Recall";
            LeaveLedg.Insert();

            if Confirm('Do you want to notify the Employee via mail?') then
                NotifyLeaveRecallee(EmpOff_Holiday);
        end;
    end;

    procedure NotifyLeaveRecallee(LeaveRecallRec: Record "Employee Off/Holiday")
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        RecallMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that we have decided to recall you from your leave that was to run from <Strong>%2</Strong> to <Strong>%3</Strong>. </br><br>The reason for recall is: <b>%4</b><br> You are therefore advised to report back to work from <Strong>%5</Strong> to <Strong>%6</Strong>. <br><br> Thank you for your cooperation.<br><br>Kind regards,<br><br><Strong>%7<Strong></p>', Comment = '%1 = Employee Name, %2 = Leave Start Date, %3 = Leave End Date, %4 = Reason for Recall, %5 = Recalled From, %6 = Recalled To, %7 = Company Name';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        HRSetup.Get();
        //  HRSetup.TestField("Human Resource Emails");

        Employee.Reset();
        if Employee.Get(LeaveRecallRec."Employee No") then begin
            CompanyInfo.Get();
            CompanyInfo.TestField(Name);
            Receipient.Add(Employee."E-Mail");
            Subject := 'Leave Recall';
            TimeNow := Format(Time);
            FormattedBody := StrSubstNo(RecallMsg, Employee."First Name",
                                        Format(LeaveRecallRec."Leave Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                          Format(LeaveRecallRec."Leave Ending Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                            LeaveRecallRec."Reason for Recall",
                                              Format(LeaveRecallRec."Recalled From", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                                Format(LeaveRecallRec."Recalled To", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), CompanyInfo.Name);
            EmailMessage.Create(Receipient, Subject, FormattedBody, true);
            Email.Send(EmailMessage);
        end;
    end;


    procedure NotifyLeaveReliever(ApplicationNo: Code[20])
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        HRSetup: Record "Human Resources Setup";
        LeaveApp: Record "Leave Application";
        LeaveRelievers: Record "Leave Relievers";
        UserSetup: Record "User Setup";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        i: Integer;
        ApplicantMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> Your leave application <Strong>%2</Strong> for <Strong>%3</Strong> has been Approved. You can proceed from <Strong>%4</Strong> to <Strong>%5</Strong> and you are to resume work on <Strong>%6</Strong>. Your duties will be taken over by <Strong>%7 - %8</Strong>.<br><br>Thank you.<br><br>Kind regards,<br><br><Strong>%9<Strong></p>', Comment = '%1 = Employee Name, %2 = Application No, %3 = Leave Type, %4 = Start Date, %5 = End Date, %6 = Resumption Date, %7 = Reliever Name, %8 = Reliever Position, %9 = Company Name';
        HODMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to notify you that Employee <Strong>%2 - %3</Strong> will be going on leave from <Strong>%4</Strong> to <Strong>%5</Strong> and will be resuming work on <Strong>%6</Strong>. Their duties will be taken over by <Strong>%7</Strong>.<br><br>Thank you.<br><br>Kind regards,<br><br><Strong>%8</Strong></p>', Comment = '%1 = Employee Name, %2 = Employee No, %3 = Employee Name, %4 = Start Date, %5 = End Date, %6 = Resumption Date, %7 = Reliever Name, %8 = Reliever Position, %9 = Company Name';
        RelievingEmpMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt">This is to Notify you that <Strong>%2 - %3</Strong> is going on Leave from <Strong>%4</Strong>.  to <Strong>%5</Strong>. You will be taking over their duties from <Strong>%4</Strong>  to <Strong>%5</Strong>. <br><br>Thank you.<br><br>Kind Regards,<br><br><Strong>%6. </Strong></p>', Comment = '%1 = Employee Name, %2 = Employee No, %3 = Employee Name, %4 = Start Date, %5 = End Date, %6 = Company Name';
        SpaceLbl: Label '  ';
        Receipient: List of [Text];
        RecipientCC: List of [Text];
        FormattedApplicantBody: Text;
        FormattedHODBody: Text;
        FormattedRelieverBody: Text;
        Relievers: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        HRSetup.Get();

        //Notify Relieving Employee
        if LeaveApp.Get(ApplicationNo) then begin
            LeaveRelievers.Reset();
            LeaveRelievers.SetRange("Leave Code", ApplicationNo);
            if LeaveRelievers.FindSet() then
                repeat
                    Employee.Reset();
                    if Employee.Get(LeaveRelievers."Staff No") then
                        if Employee."E-Mail" <> '' then begin
                            CompanyInfo.Get();
                            CompanyInfo.TestField(Name);
                            SenderAddress := CompanyInfo."E-Mail";
                            SenderName := CompanyInfo.Name;
                            Clear(Receipient);
                            Receipient.Add(Employee."E-Mail");
                            Subject := ('Relieving - ' + SpaceLbl + LeaveApp."Employee No" + SpaceLbl + LeaveApp."Employee Name");
                            TimeNow := Format(Time);
                            FormattedRelieverBody := StrSubstNo(RelievingEmpMsg, Employee."First Name", LeaveApp."Employee No", LeaveApp."Employee Name", LeaveApp."Start Date", LeaveApp."End Date", CompanyInfo.Name);
                            EmailMessage.Create(Receipient, Subject, FormattedRelieverBody, true, RecipientCC, RecipientCC);
                            Email.Send(EmailMessage);
                        end;
                until LeaveRelievers.Next() = 0;

        end;
        //Get Relievers
        if LeaveApp.Get(ApplicationNo) then begin
            LeaveRelievers.Reset();
            LeaveRelievers.SetRange("Leave Code", ApplicationNo);
            if LeaveRelievers.FindSet() then begin
                i := 1;
                repeat
                    if i = 1 then
                        Relievers := LeaveRelievers."Staff Name"
                    else
                        Relievers := Relievers + ', ' + LeaveRelievers."Staff Name";

                    i := i + 1;

                until LeaveRelievers.Next() = 0;
            end;
        end;

        //Notify Employee
        if LeaveApp.Get(ApplicationNo) then begin
            Employee.Reset();
            if Employee.Get(LeaveApp."Employee No") then
                if Employee."E-Mail" <> '' then begin
                    CompanyInfo.Get();
                    CompanyInfo.TestField(Name);
                    SenderAddress := CompanyInfo."E-Mail";
                    SenderName := CompanyInfo.Name;
                    Clear(Receipient);
                    Receipient.Add(Employee."E-Mail");
                    Subject := ('Leave Application - ' + SpaceLbl + LeaveApp."Application No");
                    TimeNow := Format(Time);
                    FormattedApplicantBody := StrSubstNo(ApplicantMsg, Employee."First Name", LeaveApp."Application No", GetLeaveName(LeaveApp."Leave Code"), LeaveApp."Start Date", LeaveApp."End Date", LeaveApp."Resumption Date", LeaveApp."Duties Taken Over By",
                                                Relievers, CompanyInfo.Name);
                    EmailMessage.Create(Receipient, Subject, FormattedApplicantBody, true, RecipientCC, RecipientCC);
                    Email.Send(EmailMessage);
                end;
        end;


        //Notify HOD
        if LeaveApp.Get(ApplicationNo) then begin
            UserSetup.Reset();
            UserSetup.SetRange("Global Dimension 1 Code", LeaveApp."Shortcut Dimension 1 Code");
            UserSetup.SetRange("Global Dimension 2 Code", LeaveApp."Shortcut Dimension 2 Code");
            // UserSetup.SetRange("HOD User", true);
            if UserSetup.FindFirst() then
                if Employee.Get(UserSetup."Employee No.") then
                    if Employee."E-Mail" <> '' then begin
                        CompanyInfo.Get();
                        CompanyInfo.TestField(Name);
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyInfo.Name;
                        Clear(Receipient);
                        Receipient.Add(Employee."E-Mail");
                        Subject := ('Employee - ' + SpaceLbl + LeaveApp."Employee No" + SpaceLbl + '-' + SpaceLbl + LeaveApp."Employee Name" + SpaceLbl + 'Leave');
                        TimeNow := Format(Time);
                        FormattedHODBody := StrSubstNo(HODMsg, Employee."First Name", LeaveApp."Employee No", LeaveApp."Employee Name", LeaveApp."Start Date", LeaveApp."End Date",
                                        LeaveApp."Resumption Date", Relievers, CompanyInfo.Name);
                        EmailMessage.Create(Receipient, Subject, FormattedHODBody, true);
                        Email.Send(EmailMessage);
                    end;
        end;
    end;





    procedure UpdateContract(ContractNo: Code[20]; EmployeeNo: Code[20])
    var
        Employee: Record Employee;
        Contract: Record "Employee Contracts";
    begin
        if Contract.Get(ContractNo) then begin
            Employee.Reset();
            Employee.SetRange("No.", EmployeeNo);
            if Employee.Find('-') then begin
                Employee."Contract Type" := Contract."Contract Type";
                Employee."Contract Number" := Contract."No.";
                Employee."Contract Length" := Contract.Tenure;
                Employee."Contract Start Date" := Contract."Start Date";
                Employee."Contract End Date" := Contract."End Date";
                Employee.Modify();
            end;
        end;
    end;

    procedure UpdateUserExpiry(EmployeeRec: Record "Employee Contracts")
    var
        user: Record User;
        UserSetup: Record "User Setup";
    begin
        UserSetup.Reset();
        UserSetup.SetRange("Employee No.", EmployeeRec."Employee No");
        if UserSetup.FindFirst() then begin
            user.Reset();
            user.SetRange("User Name", UserSetup."User ID");
            if user.FindFirst() then begin
                user."Expiry Date" := CreateDateTime(EmployeeRec."End Date", 235959T);
                user.Modify();
            end;

        end;
    end;


    local procedure InitNextEntryNo() NextEntryNo: Integer
    var
        LeaveEntry: Record "HR Leave Ledger Entries";
    begin
        LeaveEntry.LockTable();
        if LeaveEntry.FindLast() then
            NextEntryNo := LeaveEntry."Entry No." + 1
        else
            NextEntryNo := 1;
    end;

    procedure AssignLeaveDays(var LeavePeriod: Record "Leave Period")
    var
        Employees: Record Employee;
        LeaveLedger: Record "HR Leave Ledger Entries";
        LeavePeriods: Record "Leave Period";
        LeaveTypes: Record "Leave Type";
        CurrentLeavePeriod, PrevLeavePeriod : Code[20];
        DaysEarnedPerMonth, LeaveEntitlement : Decimal;
        EntryNo: Integer;
        NoLeavePeriodErr: Label 'Please define a current leave period';
    begin
        LeavePeriod.SetRange(Closed, false);
        if LeavePeriods.IsEmpty() then
            Error(NoLeavePeriodErr)
        else begin
            LeavePeriod.TestField("Start Date");
            LeavePeriod.TestField("End Date");
            CurrentLeavePeriod := LeavePeriod."Leave Period Code";
        end;

        if LeaveLedger.FindLast() then
            EntryNo := LeaveLedger."Entry No.";

        Employees.Reset();
        Employees.SetRange(Status, Employees.Status::Active);
        Employees.SetFilter("Employee Type", '<>%1', Employees."Employee Type"::"Board Member");
        if Employees.FindSet() then
            repeat
                LeaveTypes.Reset();
                LeaveTypes.SetRange(Status, LeaveTypes.Status::Active);
                LeaveTypes.SetFilter(Gender, '%1|%2', LeaveTypes.Gender::" ", Employees.Gender);
                if LeaveTypes.FindSet() then
                    repeat
                        if not IsLeaveAssigned(LeaveTypes.Code, Employees."No.", CurrentLeavePeriod) then begin
                            if GetPreviousLeavePeriod(CurrentLeavePeriod, PrevLeavePeriod) then begin
                                ClosePreviousLeaveEntries(Employees."No.", PrevLeavePeriod);
                                ProcessLeaveBalanceBroughtForward(PrevLeavePeriod, Employees, LeavePeriod);
                            end;

                            GetLeaveEntitlement(Employees, LeaveTypes, LeaveEntitlement, DaysEarnedPerMonth);
                            InitLeaveLedgerEntry(Employees, LeavePeriod, LeaveTypes, Enum::"Leave Transaction Type"::"Leave Allocation", LeaveEntitlement);
                        end;
                    until LeaveTypes.Next() = 0;
            until Employees.Next() = 0;
    end;

    local procedure IsLeaveAssigned(LeaveType: Code[20]; EmpNo: Code[20]; LeavePeriod: Code[20]) Assigned: Boolean
    var
        LeaveLedger: Record "HR Leave Ledger Entries";
    begin
        LeaveLedger.Reset();
        LeaveLedger.SetRange("Staff No.", EmpNo);
        LeaveLedger.SetRange("Leave Period Code", LeavePeriod);
        LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Positive);
        LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave Allocation");
        LeaveLedger.SetRange("Leave Type", LeaveType);
        if not LeaveLedger.IsEmpty() then
            Assigned := true
        else
            Assigned := false;
    end;

    local procedure IsLeaveBFAssigned(LeaveType: Code[20]; EmpNo: Code[20]; LeavePeriod: Code[20]) Assigned: Boolean
    var
        LeaveLedger: Record "HR Leave Ledger Entries";
    begin
        LeaveLedger.Reset();
        LeaveLedger.SetRange("Staff No.", EmpNo);
        LeaveLedger.SetRange("Leave Period Code", LeavePeriod);
        LeaveLedger.SetRange("Leave Entry Type", LeaveLedger."Leave Entry Type"::Positive);
        LeaveLedger.SetRange("Transaction Type", LeaveLedger."Transaction Type"::"Leave B/F");
        LeaveLedger.SetRange("Leave Type", LeaveType);
        if not LeaveLedger.IsEmpty() then
            Assigned := true
        else
            Assigned := false;
    end;

    local procedure ClosePreviousLeaveEntries(EmpNo: Code[20]; PrevLeavePeriod: Code[20])
    var
        Employee: Record Employee;
        LeaveLedger: Record "HR Leave Ledger Entries";
        LeavePeriodRec: Record "Leave Period";
    begin
        Employee.Get(EmpNo);

        LeavePeriodRec.Get(PrevLeavePeriod);

        LeaveLedger.Reset();
        LeaveLedger.SetRange("Staff No.", EmpNo);
        LeaveLedger.SetRange("Leave Period Code", PrevLeavePeriod);
        LeaveLedger.SetRange(Closed, false);
        if LeaveLedger.FindSet() then
            repeat
                LeaveLedger.Validate(Closed, true);
                LeaveLedger.Modify();
            until LeaveLedger.Next() = 0;
    end;

    local procedure InitLeaveLedgerEntry(var Employee: Record Employee; var LeavePeriodRec: Record "Leave Period"; var LeaveType: Record "Leave Type"; LeaveTransactionType: Enum "Leave Transaction Type"; NoOfDays: Decimal)
    var
        LeaveLedger: Record "HR Leave Ledger Entries";
    begin
        LeaveLedger.Init();
        LeaveLedger."Entry No." := InitNextEntryNo();
        LeaveLedger."Leave Period" := LeavePeriodRec."Start Date";
        LeaveLedger."Staff No." := Employee."No.";
        LeaveLedger."Staff Name" := CopyStr(Employee.FullName(), 1, MaxStrLen(LeaveLedger."Staff Name"));
        LeaveLedger."Leave Entry Type" := LeaveLedger."Leave Entry Type"::Positive;
        LeaveLedger."Document No." := StrSubstNo(LeavePeriodRec."Leave Period Code");
        // LeaveLedger."Job ID" := Employee."Job Position";
        LeaveLedger."Job Group" := CopyStr(Employee."Salary Scale", 1, MaxStrLen(LeaveLedger."Job Group"));
        LeaveLedger."Leave Approval Date" := Today;
        LeaveLedger."Contract Type" := Format(Employee."Contract Type");
        LeaveLedger."No. of days" := NoOfDays;
        LeaveLedger."Leave Posting Description" := 'Assignment for Leave Period ' + LeavePeriodRec."Leave Period Code";
        LeaveLedger."Transaction Type" := LeaveTransactionType;
        LeaveLedger."User ID" := CopyStr(UserId(), 1, MaxStrLen(LeaveLedger."User ID"));
        LeaveLedger."Leave Type" := LeaveType.Code;
        LeaveLedger."Leave Period Code" := LeavePeriodRec."Leave Period Code";
        LeaveLedger."Leave Start Date" := LeavePeriodRec."Start Date";
        LeaveLedger."Leave End Date" := LeavePeriodRec."End Date";
        LeaveLedger."Global Dimension 1 Code" := Employee."Global Dimension 1 Code";
        LeaveLedger."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
        LeaveLedger.Entitlement := NoOfDays;
        LeaveLedger."Leave Date" := Today();
        LeaveLedger."Country/Region Code" := Employee."Country/Region Code";
        LeaveLedger.Insert();
    end;

    local procedure ProcessLeaveBalanceBroughtForward(PrevLeavePeriod: Code[20]; var Employee: Record Employee; var LeavePeriodRec: Record "Leave Period")
    var
        EmployeeCopy: Record Employee;
        LeaveTypes: Record "Leave Type";
        BalBroughtForward: Decimal;
    begin
        //Leave Bal/F
        LeaveTypes.Reset();
        LeaveTypes.SetRange(Status, LeaveTypes.Status::Active);
        LeaveTypes.SetRange(Balance, LeaveTypes.Balance::"Carry Forward");
        if LeaveTypes.FindSet() then
            repeat
                LeaveTypes.Testfield("Max Carry Forward Days");

                EmployeeCopy.Copy(Employee);
                EmployeeCopy.SetRange("Leave Type Filter", LeaveTypes.Code);
                EmployeeCopy.SetRange("Leave Period Filter", PrevLeavePeriod);
                EmployeeCopy.CalcFields("Leave Balance");

                if EmployeeCopy."Leave Balance" > 0 then
                    if EmployeeCopy."Leave Balance" >= LeaveTypes."Max Carry Forward Days" then
                        BalBroughtForward := LeaveTypes."Max Carry Forward Days"
                    else
                        BalBroughtForward := EmployeeCopy."Leave Balance";

                if (BalBroughtForward > 0) and (not IsLeaveBFAssigned(LeaveTypes.Code, Employee."No.", LeavePeriodRec."Leave Period Code")) then
                    InitLeaveLedgerEntry(EmployeeCopy, LeavePeriodRec, LeaveTypes, Enum::"Leave Transaction Type"::"Leave B/F", BalBroughtForward);

            until LeaveTypes.Next() = 0;
    end;

    procedure CloseLeavePeriod(var LeavePeriodRec: Record "Leave Period")
    var
        Employee: Record Employee;
        PeriodClosedSuccessMsg: Label 'Leave period %1 has been closed successfully', Comment = '%1 = Leave Period Code';
    begin
        LeavePeriodRec.TestField(Closed, false);

        //Close Entries
        Employee.Reset();
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet() then
            repeat
                ClosePreviousLeaveEntries(Employee."No.", LeavePeriodRec."Leave Period Code");
            until Employee.Next() = 0;

        //Close Period
        LeavePeriodRec.Validate(Closed, true);
        LeavePeriodRec.Modify();

        if GuiAllowed() then
            Message(PeriodClosedSuccessMsg, LeavePeriodRec."Leave Period Code");

        /*         Commit();

                //Create Period
                if Confirm(CreateNewLeavePeriodMsg, false) then
                    Report.RunModal(Report::"Create Leave Period", true, false); */
    end;

    procedure StartShortlist(RecNeeds: Record "Recruitment Needs")
    var
        ShortlistBeforePeriodEndErr: Label 'You can not shortlist before application window ends';
    begin
        RecNeeds.TestField("Start Date");
        RecNeeds.TestField("End Date");
        RecNeeds.TestField("Shortlisting Started", false);

        if RecNeeds."End Date" > Today() then
            Error(ShortlistBeforePeriodEndErr);

        //Suggest Applicants for Shortlist
        SuggestShortlistApplicants(RecNeeds);

        RecNeeds.Validate("Shortlisting Started", true);
        RecNeeds.Modify();
    end;





    procedure GetCurrentLeavePeriodRecord(var LeavePeriod: Record "Leave Period")
    begin
        LeavePeriod.SetRange(Closed, false);
        LeavePeriod.FindFirst();
    end;

    procedure GetLeaveLiability(Employee: Record Employee; var LeaveEarnedToDate: Decimal): Decimal
    var
        BaseCalendar: Record "Base Calendar";
        CompanyInfo: Record "Company Information";
        EmpRec: Record Employee;
        HRSetup: Record "Human Resources Setup";
        LeavePeriod: Record "Leave Period";
        LeaveTypes: Record "Leave Type";

        CurrLeavePeriod: Code[20];
        PayrollPeriod: Date;
        EmpBasic: Decimal;
        LeaveLiability: Decimal;
        WorkingDays: Integer;
    begin
        HRSetup.Get();
        //    if HRSetup."Compute Leave Liability" then begin
        LeaveEarnedToDate := 0;
        LeaveLiability := 0;
        EmpBasic := 0;
        WorkingDays := 0;

        CompanyInfo.Get();
        CompanyInfo.TestField("Base Calendar Code");

        //  PayrollPeriod := PayrollMgt.GetCurrentPayPeriodDate();

        LeavePeriod.SetRange(Closed, false);
        if not LeavePeriod.IsEmpty() then;

        BaseCalendar.Get(CompanyInfo."Base Calendar Code");

        /*BaseCalendarLines.Reset();
        BaseCalendarLines.SetRange("Base Calendar Code", BaseCalendar.Code);
        BaseCalendarLines.SetRange(Date, LeavePeriod."Start Date", LeavePeriod."End Date");
        BaseCalendarLines.SetRange(Nonworking, false);
        WorkingDays := BaseCalendarLines.Count;*/

        /* DateRec.Reset();
         DateRec.SetRange("Period Type", DateRec."Period Type"::Date);
         DateRec.SetRange("Period Start", LeavePeriod."Start Date");
         DateRec.SetRange("Period End", LeavePeriod."End Date");
         DateRec.SetFilter("Period No.", '%1..%2', 1, 5);
         WorkingDays := DateRec.Count();*/

        WorkingDays := 22;
        //  EmpBasic := PayrollMgt.GetCurrentBasicPay(Employee."No.", PayrollPeriod);

        LeaveTypes.SetRange("Annual Leave", true);
        if LeaveTypes.FindFirst() then;

        // LeaveEarnedToDate := GetLeaveDaysEarnedToDate(Employee, LeaveTypes.Code);

        CurrLeavePeriod := GetCurrentLeavePeriodCode();

        EmpRec.SetRange("No.", Employee."No.");
        EmpRec.SetRange("Leave Period Filter", CurrLeavePeriod);
        EmpRec.SetRange("Leave Type Filter", LeaveTypes.Code);
        EmpRec.CalcFields("Leave Days Taken");

        LeaveEarnedToDate := LeaveEarnedToDate - Abs(EmpRec."Leave Days Taken");

        if EmpBasic > 0 then
            LeaveLiability := (EmpBasic / WorkingDays) * LeaveEarnedToDate
        else
            LeaveLiability := 0;

        LeaveLiability := Round(LeaveLiability, 0.01, '=');
        exit(LeaveLiability);
        //  end else
        exit(0);
    end;



    procedure NotifyLeaveApplicantOnRejection(Leave: Record "Leave Application")
    var
        CompanyInfo: Record "Company Information";
        Employee: Record Employee;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        RecallMsg: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear %1,<br><br></p><p style="font-family:Verdana,Arial;font-size:10pt"> This is to inform you that your leave that was to run from <Strong>%2</Strong> to <Strong>%3</Strong> has been rejected. <br>Please refer to the rejection comments posted by your approver. <br>  <br><br> Thank you for your cooperation.<br><br>Kind regards,<br>Human Resource Department<br><Strong>%4<Strong></p>', Comment = '%1 = Employee Name, %2 = Start Date, %3 = End Date, %4 = Company Name';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        Employee.Reset();
        if Employee.Get(Leave."Employee No") then begin
            Employee.TestField("E-Mail");
            Clear(Receipient);
            CompanyInfo.Get();
            CompanyInfo.TestField(Name);
            Receipient.Add(Employee."E-Mail");
            Subject := 'Leave Recall';
            TimeNow := Format(Time);
            FormattedBody := StrSubstNo(RecallMsg, (Employee."First Name" + ' ' + Employee."Last Name"),
                                        Format(Leave."Start Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                          Format(Leave."End Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'),
                                           CompanyInfo.Name);
            EmailMessage.Create(Receipient, Subject, FormattedBody, true);
            Email.Send(EmailMessage);
        end;
    end;

    procedure CheckIfLeaveRelieversExist(Leave: Record "Leave Application")
    var
        LeaveRelievers: Record "Leave Relievers";
        LeaveReliverErr: Label 'Please define at least one leave reliever';
    begin
        LeaveRelievers.Reset();
        LeaveRelievers.SetRange("Leave Code", Leave."Application No");
        if LeaveRelievers.IsEmpty() then
            Error(LeaveReliverErr);
    end;


    [EventSubscriber(ObjectType::Table, Database::Employee, 'OnBeforeGetFullName', '', false, false)]
    local procedure AddOtherNameToFullName(Employee: Record Employee; var Handled: Boolean; var NewFullName: Text[100])
    begin
        if (Employee."Middle Name" = '') and (Employee."Other Name" = '') then
            NewFullName := (Employee."First Name" + ' ' + Employee."Last Name");

        if Employee."Other Name" = '' then
            NewFullName := (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
        else
            NewFullName := (Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name" + ' ' + Employee."Other Name");

        Handled := true;
    end;


    procedure GetLeaveDaysEarnedToDate(Employee: Record Employee; LeaveTypeCode: Code[20]) LeaveEarnedToDate: Decimal
    var
        LeavePeriods: Record "Leave Period";
        LeaveTypes: Record "Leave Type";
        NextMonth: Date;
        DaysEarnedOnLeaving: Decimal;
        DaysEarnedPerMonth: Decimal;
        LeaveEntitlement: Decimal;
        NoofMonthsWorked: Decimal;
    begin
        /* if GuiAllowed then
            Employee.TestField("Date Of Join"); */
        //Employee TestField commented for error

        LeaveEarnedToDate := 0;

        GetCurrentLeavePeriodRecord(LeavePeriods);

        Employee.SetRange("Leave Type Filter", LeaveTypeCode);
        Employee.SetRange("Leave Period Filter", LeavePeriods."Leave Period Code");
        Employee.CalcFields("Leave Balance Brought Forward", "Leave Entitlement");

        LeaveTypes.Get(LeaveTypeCode);

        if LeaveTypes."Earn Days" then begin
            GetLeaveEntitlement(Employee, LeaveTypes, LeaveEntitlement, DaysEarnedPerMonth);

            //Cater for employees joining in the middle of the year
            if Employee."Date Of Join" > LeavePeriods."Start Date" then begin
                NoofMonthsWorked := 0;
                Nextmonth := Employee."Date Of Join";
                repeat
                    Nextmonth := CalcDate('<1M>', Nextmonth);
                    NoofMonthsWorked := NoofMonthsWorked + 1;
                until Nextmonth >= Today();
                NoofMonthsWorked := NoofMonthsWorked - 1;

                LeaveEarnedToDate := DaysEarnedPerMonth * NoofMonthsWorked;
            end else begin
                //Normal employees
                NoofMonthsWorked := Date2DMY(Today(), 2);
                LeaveEarnedToDate := DaysEarnedPerMonth * NoofMonthsWorked;

                //Employees leaving in the middle of the month
                if Employee."Date Of Leaving" <> 0D then
                    if ((Date2DMY(Employee."Date Of Leaving", 2)) = (Date2DMY(Today(), 2))) and
                       ((Date2DMY(Employee."Date Of Leaving", 3)) = (Date2DMY(Today(), 3))) then begin
                        DaysEarnedOnLeaving := Round(((Date2DMY(Employee."Date Of Leaving", 1) - 1) * DaysEarnedPerMonth) / 22, 0.1, '=');
                        LeaveEarnedToDate := LeaveEarnedToDate - DaysEarnedPerMonth + DaysEarnedOnLeaving;
                    end;
            end;
        end else
            LeaveEarnedToDate := Employee."Leave Entitlement";

        LeaveEarnedToDate := LeaveEarnedToDate + Employee."Leave Balance Brought Forward";

        exit(LeaveEarnedToDate);
    end;

    procedure GetEmployeeJobGroup(EmpNo: Code[50]): Code[30]
    var
        Employee: Record Employee;
    begin
        Employee.Get(EmpNo);
        Employee.TestField("Salary Scale");
        exit(Employee."Salary Scale");
    end;

    local procedure GetPreviousLeavePeriod(CurrentLeavePeriod: Code[20]; var PrevLeavePeriod: Code[20]): Boolean
    var
        LeavePeriodRec, PrevLeavePeriodRec : Record "Leave Period";
    begin
        if LeavePeriodRec.Get(CurrentLeavePeriod) then begin
            PrevLeavePeriodRec.SetCurrentKey("End Date");
            PrevLeavePeriodRec.SetFilter("Leave Period Code", '<>%1', CurrentLeavePeriod);
            if PrevLeavePeriodRec.FindLast() then begin
                PrevLeavePeriod := PrevLeavePeriodRec."Leave Period Code";
                if PrevLeavePeriod <> '' then
                    exit(true)
                else
                    exit(false);
            end;
        end else
            exit(false);
    end;

    procedure GetLeaveEntitlement(Employee: Record Employee; LeaveTypeRec: Record "Leave Type"; var LeaveEntitlement: Decimal; var DaysEarnedPerMonth: Decimal)
    var
        LeaveEntitlementRec: Record "Leave Entitlement Entry";
        NoLeaveEntitlementDefinedErr: Label 'No Leave Entitlement defined for Leave Type: %1, Employee Category: %2, Country: %3', Comment = '%1 = Leave Type, %2 = Employee Category, %3 = Country';
    begin
        LeaveEntitlement := 0;
        DaysEarnedPerMonth := 0;

        Employee.TestField("Country/Region Code");

        LeaveEntitlementRec.Reset();
        LeaveEntitlementRec.SetRange("Leave Type Code", LeaveTypeRec.Code);
        LeaveEntitlementRec.SetRange("Employee Category", Employee."Employee Category");
        LeaveEntitlementRec.SetRange("Country/Region Code", Employee."Country/Region Code");
        if LeaveEntitlementRec.FindFirst() then begin
            LeaveEntitlement := LeaveEntitlementRec.Days;
            if LeaveTypeRec."Earn Days" then begin
                LeaveEntitlementRec.TestField("Days Earned per Month");
                DaysEarnedPerMonth := LeaveEntitlementRec."Days Earned per Month";
            end;
        end else
            Error(NoLeaveEntitlementDefinedErr, LeaveTypeRec.Code, Employee."Employee Category", Employee."Country/Region Code");
    end;

    procedure SubmitApplication(ApplicationNo: Code[10])
    var
        //ApplicantEducation: Record "Applicant Job Education";
        //  Applicants: Record Applicants;
        ApplicantEducation: Record "Applicants Qualification";
        Applicants: Record Applicant;

        CompanyInfo: Record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailSignBigText: BigText;
        Instr: InStream;
        NewBodyLbl: Label 'Dear %1, <br><br> Your account has been registered with us successfully.<br> <br> <br>Kind Regards <br><br>%2.', Comment = '%1 = Full Name, %2 = Company Name';
        SubmitSuccessMsg: Label 'Job Application Submitted Successfully';
        Receipient: List of [Text];
        EmailSignText: Text;
        FormattedBody: Text;
        SenderAddress: Text;
        SenderName: Text;
        Subject: Text;
        TimeNow: Text;
        RecruimentNeed: Record "Recruitment Needs";
        JobApplication: Record "Job Application";
    begin
        Applicants.Get(ApplicationNo);
        Applicants.TestField("E-Mail");

        // ApplicantEducation.Reset();
        // ApplicantEducation.SetRange(ApplicantEducation."Qualification Code", ApplicationNo);
        // ApplicantEducation.SetRange(ApplicantEducation."Qualification Type", ApplicantEducation."Qualification Type"::Academic);
        // if ApplicantEducation.IsEmpty() then
        //     Error('Please add at least one academic qualification');

        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        //CompanyInfo."E-Mail Signature".CreateInStream(Instr);
        //CompanyInfo."E-Mail".IndexOf(Instr);
        // EmailSignBigText.Read(Instr);
        // EmailSignText := Format(EmailSignBigText);

        SenderName := CompanyInfo.Name;
        SenderAddress := CompanyInfo."E-Mail";
        Receipient.Add(Applicants."E-Mail");
        Subject := 'Applicant Account Created';
        TimeNow := (Format(Time));
        // FormattedBody := StrSubstNo(NewBodyLbl, Applicants."First Name", CompanyInfo.Name);
        // EmailMessage.Create(Receipient, Subject, FormattedBody, true);
        // Email.Send(EmailMessage);


        //********************************************
        RecruimentNeed.Reset();
        RecruimentNeed.SetRange(RecruimentNeed."Job ID", Applicants."Job ID");
        if RecruimentNeed.Find('-') then //begin
            RecruimentNeed.Approved := true;
        RecruimentNeed."Interview Conducted" := false;
        RecruimentNeed.Modify(true);
        //end;

        Applicants.Submitted := true;
        Applicants."Offer Status" := Applicants."Offer Status"::"Offer Made";
        Applicants."Recruitment Needs NO" := RecruimentNeed."No.";
        Applicants."Submitted Date" := WorkDate();
        Applicants."Submitted Time" := Time;
        Applicants.Modify();
        // if GuiAllowed then
        Message(SubmitSuccessMsg);
    end;

    procedure SendOfferLetterViaMail(JobApplication: Record "Job Application")
    var
        Applicants: Record Applicant;
        CompanyInfo: Record "Company Information";
        Job: Record "Job Application";
        Base64Conv: Codeunit "Base64 Convert";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        TempBlob: Codeunit "Temp Blob";
        RecRef: RecordRef;
        InStr: InStream;
        NewBodyLbl: Label '<p style="font-family:Verdana,Arial;font-size:10pt">Dear<b> %1,</b></p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you for applying for <b> %3. We were impressed by your qualifications and would like to invite you to interview for the position..</p><p style="font-family:Verdana,Arial;font-size:9pt">Thank you</p><p style="font-family:Verdana,Arial;font-size:9pt"><br><br>Kind regards<br><br><Strong>%2</Strong>', Comment = '%1 = Full Name, %2 = Company Name,%3 = job title';
        // NewBodyLbl2: Label
        Recipient: List of [Text];
        OutStr: OutStream;
        ReportFormat: ReportFormat;
        Base64Text: Text;
        FileName: Text;
        FormattedBody: Text;
        Subject: Text;
    begin
        CompanyInfo.get();
        Applicants.Get(JobApplication."Applicant No.");
        // Applicants.TestField("E-Mail");
        Message('email is %1', Applicants."E-Mail");
        Clear(Recipient);

        Recipient.Add(Applicants."E-Mail");

        Subject := 'Letter of Invite - ' + Applicants."First Name";
        FileName := 'Letter of Invite_' + Applicants."No." + '.pdf';
        FormattedBody := StrSubstNo(NewBodyLbl, JobApplication."Applicant Name", CompanyInfo.Name, JobApplication."Job Title");
        EmailMessage.Create(Recipient, Subject, FormattedBody, true);

        // Job.Reset();
        // Job.SetRange("No.", JobApplication."No.");
        // RecRef.GetTable(Job);
        // TempBlob.CreateOutStream(OutStr);
        // TempBlob.CreateInStream(InStr);
        // Base64Text := Base64Conv.ToBase64(InStr, true);
        // EmailMessage.AddAttachment(CopyStr(FileName, 1, 250), 'application/pdf', Base64Text);
        Email.Send(EmailMessage);
    end;

    procedure EmployJobApplicant(RecNeed: Record "Job Application")
    var
        ApplicantQualifications: Record "Applicant Job Education";
        ApplicantJobHistory: Record "Applicant Job Experience";
        Applicants: Record Applicant;
        Jobs: Record "Company Job";
        Employee: Record Employee;
        EmployeeQualifications: Record "Employee Qualification";
        EmployementHistory: Record "Employment History";
        JobApplication: Record "Job Application";
        ApplicantHiredSuccessMsg: Label 'Job Applicant %1 has been successfully hired', Comment = '%1 = Applicant Name';
        CannotSelectMoreCandidatesErr: Label 'You cannot hire %1 candidates since %2 position only requires %3 candidate(s)', Comment = '%1 = Number of Candidates, %2 = Job Title, %3 = Number of Positions';
    begin
        // Jobs.Get(RecNeed."Applicant No.");
        //Jobs.TestField(Grade);

        JobApplication.Reset();
        JobApplication.SetRange(JobApplication."No.", RecNeed."No.");
        // JobApplication.SetRange("Select To Hire", true);
        Message('hre');
        if JobApplication.Find('-') then begin
            Message('hre12');
            Message('Here is 1%', JobApplication."Applicant Name");

            //if JobApplication.Count > RecNeed.po then
            //Error(CannotSelectMoreCandidatesErr, JobApplication.Count, RecNeed.Description, RecNeed.Positions);
            repeat
                case JobApplication."Applicant Type" of
                    JobApplication."Applicant Type"::External:
                        begin
                            JobApplication.TestField("Employment Date");
                            JobApplication.TestField("Expected Reporting Date");

                            Applicants.Get(JobApplication."Applicant No.");

                            //Insert Employee Record
                            Employee.Init();
                            Employee."No." := '';
                            Employee.Insert(true);
                            Employee.Validate("First Name", Applicants."First Name");
                            Employee.Validate("Middle Name", Applicants."Middle Name");
                            Employee.Validate("Last Name", Applicants."Last Name");
                            Employee.Validate("Search Name", Employee.FullName());
                            //Employee.Validate("ID No.", Applicants."Identification Document");
                            Employee.Validate(Gender, Applicants.Gender);
                            //  Employee.Validate("Country/Region Code", Applicants."Country/Region Code");
                            Employee.Validate(Status, Employee.Status::Active);
                            Employee.Validate("Birth Date", Applicants."Birth Date");
                            Employee.Validate("Date Of Join", JobApplication."Employment Date");
                            Employee.Validate("Employment Date", JobApplication."Employment Date");
                            Employee.Validate("Employment Date - Age", Applicants.Age);
                            Employee.Validate("Marital Status", Applicants."Marital Status");
                            // Employee.Validate("Ethnic Origin", Applicants."Ethnic Origin");
                            //  Employee.Validate(Disabled, Applican);
                            //   Employee.Validate("Mobile Phone No.", Applicants."Mobile Phone No.");
                            Employee.Validate("E-Mail", Applicants."E-Mail");
                            //  Employee.Validate(Address, Applicants."Postal Address");
                            // Employee.Validate("Post Code", Applicants."Post Code");
                            Employee.Validate("Salary Scale", Jobs.Grade);
                            if Applicants.Picture.HasValue() then
                                Employee.Validate(Image, Applicants.Image);
                            Employee.Modify();

                            //Insert Qualifications
                            // ApplicantQualifications.Reset();
                            // ApplicantQualifications.SetRange("Applicant No.", Applicants."No.");
                            // if ApplicantQualifications.FindSet() then
                            //     repeat
                            //         EmployeeQualifications."Employee No." := Employee."No.";
                            //         EmployeeQualifications."Line No." := ApplicantQualifications."Line No.";
                            //         EmployeeQualifications.Validate("Institution Type", ApplicantQualifications."Institution Type");
                            //         EmployeeQualifications.Validate("Institution Code", ApplicantQualifications.Institution);
                            //         EmployeeQualifications.Validate("From Date", ApplicantQualifications."Start Date");
                            //         EmployeeQualifications.Validate("To Date", ApplicantQualifications."End Date");
                            //         EmployeeQualifications.Validate(Country, ApplicantQualifications.Country);
                            //         EmployeeQualifications.Validate("Qualification Type", EmployeeQualifications."Qualification Type"::Academic);
                            //         EmployeeQualifications.Validate("Field of Study", EmployeeQualifications."Field of Study");
                            //         EmployeeQualifications.Validate("Education Level", EmployeeQualifications."Education Level");
                            //         if ApplicantQualifications."Qualification Code" <> '' then
                            //             EmployeeQualifications.Validate("Qualification Code", ApplicantQualifications."Qualification Code");
                            //         EmployeeQualifications.Validate(Score, ApplicantQualifications.Score);
                            //         EmployeeQualifications.Validate(Grade, ApplicantQualifications.Grade);
                            //         EmployeeQualifications.Validate("Proficiency Level", ApplicantQualifications."Proficiency Level");
                            //         EmployeeQualifications.Insert();
                            //     until ApplicantQualifications.Next() = 0;

                            //Insert Employment history
                            ApplicantJobHistory.Reset();
                            ApplicantJobHistory.SetRange("Applicant No.", Applicants."No.");
                            if ApplicantJobHistory.FindSet() then
                                repeat
                                    EmployementHistory."Employee No." := Employee."No.";
                                    EmployementHistory.From := ApplicantJobHistory."Start Date";
                                    EmployementHistory."To" := ApplicantJobHistory."End Date";
                                    EmployementHistory.Validate("Company Name", ApplicantJobHistory.Employer);
                                    EmployementHistory.Insert();
                                until ApplicantJobHistory.Next() = 0;
                        end;
                    JobApplication."Applicant Type"::"Internal":
                        begin
                            Employee.Get(JobApplication."Applicant No.");
                            Employee.Modify();
                        end;
                end;

                JobApplication.Validate("Application Status", JobApplication."Application Status"::Employed);
                JobApplication.Validate("Employee No.", Employee."No.");
                JobApplication.Modify();

            until JobApplication.Next() = 0;
            Message('empl is %1', Employee."No.");
            // RecNeed.Validate(, RecNeed.Status::Archived);
            //     RecNeed.Modify();
            Message(ApplicantHiredSuccessMsg, JobApplication."Applicant Name");
        end;
    end;

    procedure SuggestShortlistApplicants(RecNeeds: Record "Recruitment Needs")
    var
        JobsApplied: Record "Applicant job applied";
        Applicants: Record Applicant;
        ApplicantShortlist: Record "Applicant Shortlist";
        JobApplications: Record "Job Application";
    begin
        ApplicantShortlist.SetRange("Need Code", RecNeeds."No.");
        ApplicantShortlist.DeleteAll();

        JobsApplied.Reset();
        JobsApplied.SetRange("Need Code", RecNeeds."No.");
        JobsApplied.SetRange("Applicant Type", JobsApplied."Applicant Type"::External);
        if JobsApplied.FindSet() then
            repeat
                Applicants.Get(JobsApplied."Applicant No.");

                ApplicantShortlist.Init();
                ApplicantShortlist."Need Code" := RecNeeds."No.";
                ApplicantShortlist."Applicant No." := Applicants."No.";
                ApplicantShortlist.TransferFields(Applicants);
                ApplicantShortlist.Qualified := false;
                ApplicantShortlist."Job Application No." := JobsApplied."Job Application No.";
                if not ApplicantShortlist.Get(RecNeeds."No.", Applicants."No.") then
                    ApplicantShortlist.Insert();

                if JobApplications.Get(JobsApplied."Job Application No.") then begin
                    JobApplications.Validate("Application Status", JobApplications."Application Status"::Shortlisted);
                    JobApplications.Modify();
                end;

            until JobsApplied.Next() = 0;
    end;

    procedure ShortlistApplicants(RecruitmentNeeds: Record "Recruitment Needs")
    var
        Academics: Record "Applicant Job Education";
        Experience: Record "Applicant Job Experience";
        Prof: Record "Applicant Prof Membership";
        ApplicantsShortlist: Record "Applicant Shortlist";
        JobApplications: Record "Job Application";
        Qualified: Boolean;
        ApplicantEdLevelIndex, ShortlistEdLevelIndex : Integer;
        ApplicantEdTypeIndex, ShortlistEdTypeIndex : Integer;
        ApplicantProfLevelIndex, ShortlistProfLevelIndex : Integer;
        NoYears: Integer;
    begin
        //come back here to fix shortlisting
        //Suggest Applicants First
        SuggestShortlistApplicants(RecruitmentNeeds);

        ApplicantsShortlist.Reset();
        ApplicantsShortlist.SetRange("Need Code", RecruitmentNeeds."No.");
        if ApplicantsShortlist.FindSet() then
            repeat
                Qualified := false;

                ApplicantEdLevelIndex := 0;
                ShortlistEdLevelIndex := 0;
                ApplicantEdTypeIndex := 0;
                ShortlistEdTypeIndex := 0;
                ApplicantProfLevelIndex := 0;
                ShortlistProfLevelIndex := 0;

                //Shortlist By Field of Study
                if RecruitmentNeeds."Field of Study" <> '' then begin
                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    Academics.SetFilter("Field of Study", '=%1', RecruitmentNeeds."Field of Study");
                    if Academics.FindFirst() then
                        Qualified := true
                    else
                        Qualified := false;
                end;

                //Shortlist By Education Level
                //if Qualified then begin
                if RecruitmentNeeds."Education Level" <> RecruitmentNeeds."Education Level"::" " then begin
                    //Get Shortlist Index
                    ShortlistEdLevelIndex := RecruitmentNeeds."Education Level".Ordinals.IndexOf(RecruitmentNeeds."Education Level".AsInteger());

                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    if RecruitmentNeeds."Field of Study" <> '' then
                        Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                    //Academics.SetRange("Education Level", RecruitmentNeeds."Education Level");
                    if Academics.FindFirst() then begin
                        //Get Applicant Index
                        ApplicantEdLevelIndex := Academics."Education Level".Ordinals.IndexOf(Academics."Education Level".AsInteger());

                        if ApplicantEdLevelIndex >= ShortlistEdLevelIndex then
                            Qualified := true
                        else
                            Qualified := false;
                    end else
                        Qualified := false;
                end;
                //end;

                //Shortlist By Education Type
                //if Qualified then begin
                if RecruitmentNeeds."Education Type" <> RecruitmentNeeds."Education Type"::" " then begin
                    //Get Shortlist Index
                    ShortlistEdTypeIndex := RecruitmentNeeds."Education Type".Ordinals.IndexOf(RecruitmentNeeds."Education Type".AsInteger());

                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    if RecruitmentNeeds."Field of Study" <> '' then
                        Academics.SetRange("Field of Study", RecruitmentNeeds."Field of Study");
                    if Academics.FindFirst() then begin
                        //Get Applicant Index
                        ApplicantEdTypeIndex := Academics."Education Type".Ordinals.IndexOf(Academics."Education Type".AsInteger());

                        if ApplicantEdTypeIndex >= ShortlistEdTypeIndex then
                            Qualified := true
                        else
                            Qualified := false;
                    end else
                        Qualified := false;
                end;
                //end;

                //Shortlist By Proficiency Level
                //if Qualified then begin
                if RecruitmentNeeds."Proficiency Level" <> RecruitmentNeeds."Proficiency Level"::" " then begin
                    //Get Shortlist Index
                    ShortlistProfLevelIndex := RecruitmentNeeds."Education Type".Ordinals.IndexOf(RecruitmentNeeds."Proficiency Level".AsInteger());

                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    if Academics.FindFirst() then begin
                        ApplicantProfLevelIndex := Academics."Proficiency Level".Ordinals.IndexOf(Academics."Proficiency Level".AsInteger());
                        if ApplicantProfLevelIndex >= ShortlistProfLevelIndex then
                            Qualified := true
                        else
                            Qualified := false;
                    end else
                        Qualified := false;
                end;
                //end;

                //Shortlist by Professional Course
                //if Qualified then begin
                if RecruitmentNeeds."Professional Course" <> '' then begin
                    Academics.Reset();
                    Academics.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    Academics.SetRange("Qualification Code", RecruitmentNeeds."Professional Course");
                    if not Academics.IsEmpty() then
                        Qualified := true
                    else
                        Qualified := false;
                end;
                //end;

                //Shortlist by Professional Membership
                //if Qualified then begin
                if RecruitmentNeeds."Professional Membership" <> '' then begin
                    Prof.Reset();
                    Prof.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    Prof.SetRange("Professional Body", RecruitmentNeeds."Professional Membership");
                    if not Prof.IsEmpty() then
                        Qualified := true
                    else
                        Qualified := false;
                end;
                //end;

                //Shortlist by Experience Industry
                //if Qualified then begin
                if RecruitmentNeeds."Experience industry" <> '' then begin
                    Experience.Reset();
                    Experience.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");
                    if Experience.FindFirst() then
                        Qualified := true
                    else
                        Qualified := false;
                end;
                //end;

                //Shortlist by years of experience
                //if Qualified then begin
                if (RecruitmentNeeds."Minimum years of experience" <> 0) and (RecruitmentNeeds."Maximum years of experience" <> 0) then begin
                    Experience.Reset();
                    Experience.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                    if RecruitmentNeeds."Experience industry" <> '' then
                        Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");
                    if Experience.Find('-') then begin
                        Experience.CalcSums("No. of Years");
                        NoYears := Round(Experience."No. of Years", 1, '=');

                        if (NoYears >= RecruitmentNeeds."Minimum years of experience") and (NoYears <= RecruitmentNeeds."Maximum years of experience") then
                            Qualified := true
                        else
                            Qualified := false;

                    end else
                        Qualified := false;
                end else
                    if (RecruitmentNeeds."Minimum years of experience" <> 0) and (RecruitmentNeeds."Maximum years of experience" = 0) then begin
                        Experience.Reset();
                        Experience.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                        if RecruitmentNeeds."Experience industry" <> '' then
                            Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");

                        if Experience.Find('-') then begin
                            Experience.CalcSums("No. of Years");
                            NoYears := Round(Experience."No. of Years", 1, '=');
                            if NoYears >= RecruitmentNeeds."Minimum years of experience" then
                                Qualified := true
                            else
                                Qualified := false;
                        end else
                            Qualified := false;
                    end else
                        if (RecruitmentNeeds."Maximum years of experience" <> 0) and (RecruitmentNeeds."Minimum years of experience" = 0) then begin
                            Experience.Reset();
                            Experience.SetRange("Applicant No.", ApplicantsShortlist."Applicant No.");
                            if RecruitmentNeeds."Experience industry" <> '' then
                                Experience.SetRange(Industry, RecruitmentNeeds."Experience industry");

                            if Experience.Find('-') then begin
                                Experience.CalcSums("No. of Years");
                                NoYears := Round(Experience."No. of Years", 1, '=');
                                if NoYears <= RecruitmentNeeds."Maximum years of experience" then
                                    Qualified := true
                                else
                                    Qualified := false;
                            end else
                                Qualified := false;
                        end;
                //end;

                JobApplications.Get(ApplicantsShortlist."Job Application No.");

                if Qualified then
                    ApplicantsShortlist.Validate(Qualified, true)
                else
                    ApplicantsShortlist.Validate(Qualified, false);

                ApplicantsShortlist.Modify();

            until ApplicantsShortlist.Next() = 0;
    end;

    procedure MailQualifiedShortlistApplicants(RecNeeds: Record "Recruitment Needs")
    var
        ShortlistApplicantsRec: Record "Applicant Shortlist";
        CompanyInfo: Record "Company Information";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        NewBodyLbl: Label '<p>Dear %1,</p> <br><p>This is to invite you for an Interview for the job Position of <Strong>%2</Strong>.</p><p>The Interview will be conducted at <Strong>%3</Strong> on <Strong>%5</Strong> at <Strong>%6</Strong> .<br></p><br>Kind Regards, <br><br><Strong>%4 </Strong>.', Comment = '%1 = First Name, %2 = Job Title, %3 = Company Name, %4 = HR Manager, %5 = Interview Date, %6 = Interview Time';
        Receipient: List of [Text];
        FormattedBody: Text;
        Subject: Text;
        TimeNow: Text;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        ShortlistApplicantsRec.Reset();
        ShortlistApplicantsRec.SetRange("Need Code", RecNeeds."No.");
        ShortlistApplicantsRec.SetFilter("E-Mail", '<>%1', '');
        ShortlistApplicantsRec.SetRange(Qualified, true);
        ShortlistApplicantsRec.SetRange(Notified, false);
        if ShortlistApplicantsRec.FindSet() then
            repeat
                ShortlistApplicantsRec.TestField("Interview Date");
                ShortlistApplicantsRec.TestField("Interview Time");
                Clear(Receipient);
                Receipient.Add(ShortlistApplicantsRec."E-Mail");
                Subject := 'Interview Invitation';
                TimeNow := (Format(Time));
                FormattedBody := StrSubstNo(NewBodyLbl, ShortlistApplicantsRec."First Name", RecNeeds.Description, CompanyInfo.Name, 'Human Resource Manager', Format(ShortlistApplicantsRec."Interview Date", 0, '<Weekday Text> <Day> <Month Text> <Year4>'), ShortlistApplicantsRec."Interview Time");
                EmailMessage.Create(Receipient, Subject, FormattedBody, true);
                Email.Send(EmailMessage);

                ShortlistApplicantsRec.Notified := true;
                ShortlistApplicantsRec.Modify();
                Commit();

            until ShortlistApplicantsRec.Next() = 0;
    end;

    procedure MailUnQualifiedShortlistApplicants(RecNeeds: Record "Recruitment Needs")
    var
        ShortlistApplicantsRec: Record "Applicant Shortlist";
        CompanyInfo: Record "Company Information";
        JobApplication: Record "Job Application";
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        DearCandidateLbl: Label 'Dear %1,', Comment = '%1 = First Name';
        KindRegardsLbl: Label '<p>Kind Regards</p><br> %3 <br> Human Resources Recruitment', Comment = '%3 = Company Name';
        ThankYouLbl: Label '<p>Thank you for taking the time to submit your resume for consideration for the <Strong>%2</Strong> position with %3</p>', Comment = '%2 = Job Title, %3 = Company Name';
        WeRegretLbl: Label '<p>We regret to inform you that we will not be pursuing your candidacy for this position. Though your qualifications are impressive, the selection process was highly competitive, and we have decided to move forward with other candidates whose qualifications better meet our needs at this time.</p>', Comment = '%2 = Job Title, %3 = Company Name';
        WeThankYouLbl: Label '<p>We thank you for your interest and wish you all the best in your future endeavors.</p>';
        Receipient: List of [Text];
        FormattedBody: Text;
        NewBody: Text;
        Subject: Text;
        TimeNow: Text;
        EmailTextBuilder: TextBuilder;
    begin
        CompanyInfo.Get();
        CompanyInfo.TestField(Name);
        CompanyInfo.TestField("E-Mail");

        ShortlistApplicantsRec.Reset();
        ShortlistApplicantsRec.SetRange("Need Code", RecNeeds."No.");
        ShortlistApplicantsRec.SetRange(Qualified, false);
        ShortlistApplicantsRec.SetRange(Notified, false);
        if ShortlistApplicantsRec.FindSet() then
            repeat
                JobApplication.Get(ShortlistApplicantsRec."Job Application No.");

                Clear(Receipient);
                Receipient.Add(ShortlistApplicantsRec."E-Mail");
                Subject := 'Job Application - Regret';
                TimeNow := (Format(Time));

                EmailTextBuilder.Clear();
                EmailTextBuilder.Append(DearCandidateLbl);
                EmailTextBuilder.Append(ThankYouLbl);
                EmailTextBuilder.Append(WeRegretLbl);
                EmailTextBuilder.Append(WeThankYouLbl);
                EmailTextBuilder.Append(KindRegardsLbl);

                NewBody := EmailTextBuilder.ToText();

                FormattedBody := StrSubstNo(NewBody, JobApplication."Applicant Name", JobApplication."Job Title", CompanyInfo.Name);
                EmailMessage.Create(Receipient, Subject, FormattedBody, true);
                Email.Send(EmailMessage);

                ShortlistApplicantsRec.Notified := true;
                ShortlistApplicantsRec.Modify();
                Commit();
            until ShortlistApplicantsRec.Next() = 0;
    end;

    procedure CloseShortlisting(RecNeeds: Record "Recruitment Needs")
    var
        ShortListApplicantsRec: Record "Applicant Shortlist";
        JobApplications: Record "Job Application";
    begin
        RecNeeds.TestField("Shortlisting Closed", false);

        ShortListApplicantsRec.Reset();
        ShortListApplicantsRec.SetRange("Need Code", RecNeeds."No.");
        if ShortListApplicantsRec.FindSet() then
            repeat
                JobApplications.Get(ShortListApplicantsRec."Job Application No.");
                if ShortListApplicantsRec.Qualified then
                    JobApplications.Validate("Application Status", JobApplications."Application Status"::"Qualified for Interview")
                else
                    JobApplications.Validate("Application Status", JobApplications."Application Status"::"Non-Qualified for Interview");

                JobApplications.Modify();
            until ShortListApplicantsRec.Next() = 0;

        RecNeeds.Validate("Shortlisting Closed", true);
        RecNeeds.Modify();

    end;

}


