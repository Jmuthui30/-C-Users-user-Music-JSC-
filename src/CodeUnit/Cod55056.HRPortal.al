codeunit 55056 HRPortal
{
    Permissions = TableData "Approval Entry" = m;

    var
        HRPortalUsers: Record HRPortalUsers;
        Employee: Record Employee;
        Leave: Record "Leave Application";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LeaveSetup: Record "Leave Type";
        EmployeeLeaves: Record "Leave Application";
        HrEmployees: Record Employee;
        ApprovalEntry: Record "Approval Entry";
        CashManagementSetup: Record "Cash Management Setups";
        GeneralLedgerSetup: Record "General Ledger Setup";
        PaymentsRec: Record "Payments";
        PLines: Record "Payment Lines";
        // IRHeader: Record REQUI;
        Committment: Codeunit "Commitments Mgt Finance";
        ErrorMsg: Text[250];
        ApprovalMgt: Codeunit "Approval Mgt Finance Ext";
        ApprovalMgtHR: Codeunit "Approval Mgt HR Ext";
        // TrainingRequest: Record "Training Request";
        // TrainingRequestLines: Record "Training Request Lines";
        LeaveApplication: Record "Leave Application";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        MaturityDate: Date;
        NonWorkingDay: Boolean;
        NoOfWorkingDays: Decimal;
        PayrollPeriod: Record "Payroll Period";

        RequestorID: Record "User Setup";


        UserSetup: Record "User Setup";
        PortalUploads: Record "SharePoint Intergrations";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtFin: Codeunit "Approval Mgt Finance Ext";
        HrApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        CashMgt: Record "Cash Management Setups";

        EndpointData: Text;
        PostUrl: Text;
        JsonToken: JsonToken;
        EmployeeRec: Record Employee;
        CompanyInformation: Record "Company Information";
        ImprestHeader: Record Payments;
        ImprestLines: Record "Payment Lines";
        TempBlob_lRec: Codeunit "Temp Blob";
        OutStr: OutStream;
        InStr: InStream;

        // purchaseHeader: Record "Internal Request Header";

        FileManagement_lCdu: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        tbl_leaveTypes: Record "Leave Type";
        tbl_approvalCommentLine: Record "Approval Comment Line";
        tbl_approvalEntry: Record "Approval Entry";
        RecRef: RecordRef;


    procedure SendEmailNotification(recepient: Text; emailSubject: Text; emailBody: Text)
    var
        Customer: Record Customer;
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        Body: Text;
    begin
        EmailMessage.Create(recepient, emailSubject, emailBody, true);
        Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
    end;

    procedure FAWEresetPasswordEmail("employeeNumber-idNumber": Text) status: Text
    begin
        status := 'danger*Account not found';
        Employee.Reset;
        Employee.SetRange(Employee."No.", "employeeNumber-idNumber");
        if Employee.FindFirst() then begin
            status := myResetPass(Employee);
        end else begin
            Employee.Reset;
            Employee.SetRange(Employee."Company E-Mail", "employeeNumber-idNumber");
            if Employee.Findfirst() then begin
                status := myResetPass(Employee);
            end
            else begin
                status := 'danger*Account with the given credentials does not exist';

            end;
        end;

    end;

    local procedure myResetPass(Employee: Record Employee) status: Text
    var
        employeeEmail: Text;
        password: Integer;
        passwordOk: Boolean;
        SMTPMailSetup: Record "Email Account";
    begin
        employeeEmail := Employee."Company E-Mail";
        if employeeEmail = '' then begin
            status := 'danger*You have not added company email to the selected employee. Kindly update and try again';
        end else begin
            passwordOk := false;
            repeat
                password := Random(9999);
                if password > 1000 then
                    passwordOk := true;
            until passwordOk = true;
            HRPortalUsers.Reset;
            HRPortalUsers.SetRange(HRPortalUsers.employeeNo, Employee."No.");
            if HRPortalUsers.FindSet then begin
                HRPortalUsers.password := Format(password);
                HRPortalUsers.changedPassword := false;
                HRPortalUsers."Last Modified Date" := Today;
                HRPortalUsers.Modify(true);
            end else begin
                HRPortalUsers.Init;
                HRPortalUsers.employeeNo := Employee."No.";
                //  HRPortalUsers.IdNo := Employee."National ID No.";
                HRPortalUsers."Authentication Email" := Employee."Company E-Mail";
                HRPortalUsers.password := Format(password);
                HRPortalUsers.State := HRPortalUsers.State::Enabled;
                HRPortalUsers.changedPassword := false;
                HRPortalUsers.employeeName := Employee."First Name" + ' ' + Employee."Last Name";
                HRPortalUsers."Last Modified Date" := Today;
                HRPortalUsers.Insert(true);
            end;
            SendEmailNotification(HRPortalUsers."Authentication Email", 'Password Reset', 'Your one time password is <strong>' + Format(password) + '</strong>');
            status := 'success*We have sent a one time password to your email (' + employeeEmail + '). Use it to log in to your account';
        end;
    end;

    procedure FAWEchangePassword(employeeNo: Code[50]; currentPassword: Text; newPassword: Text; confirmPassword: Text) status: Text
    var
        HRPortalUsers: Record HRPortalUsers;
        employeeEmail: Text;
    begin
        status := 'danger*Your password could not be changed. Please try again';
        if newPassword = confirmPassword then begin
            HRPortalUsers.Reset;
            HRPortalUsers.SetRange(employeeNo, employeeNo);
            HRPortalUsers.SetRange(password, currentPassword);
            if HRPortalUsers.FindSet then begin
                if StrLen(newPassword) > 3 then begin
                    if newPassword = confirmPassword then begin
                        HRPortalUsers.password := newPassword;
                        HRPortalUsers.changedPassword := true;
                        HRPortalUsers."Last Modified Date" := Today;
                        if HRPortalUsers.Modify(true) then begin
                            status := 'success*Your password was successfully updated';
                        end else begin
                            status := 'danger*Your password could not be changed. Please try again';
                        end;
                    end else begin
                        status := 'danger*New Password and confirm new password do not match!!!';
                    end;
                end else begin
                    status := 'danger*The password you entered as your new password is too short. It should be atleast 4 characters';
                end;
            end else begin
                Employee.Reset;
                Employee.SetRange("No.", employeeNo);
                if Employee.FindSet then begin
                    employeeEmail := Employee."Company E-Mail";
                    if employeeEmail = '' then begin
                        status := 'danger*You have not been assisned a company email company email. Kindly contact ICT.';
                    end else begin
                        // passwordOk := false;
                        // repeat
                        //     password := Random(9999);
                        //     if password > 1000 then
                        //         passwordOk := true;
                        // until passwordOk = true;
                        HRPortalUsers.Reset;
                        HRPortalUsers.SetRange(employeeNo, employeeNo);
                        if HRPortalUsers.FindSet then begin
                            HRPortalUsers.password := Format(newPassword);
                            HRPortalUsers.changedPassword := false;
                            HRPortalUsers."Last Modified Date" := Today;
                            HRPortalUsers.Modify(true);
                        end else begin
                            HRPortalUsers.Init;
                            HRPortalUsers.employeeNo := Employee."No.";
                            //HRPortalUsers.IdNo := Employee."National ID No.";
                            HRPortalUsers."Authentication Email" := Employee."Company E-Mail";
                            HRPortalUsers.password := Format(newPassword);
                            HRPortalUsers.State := HRPortalUsers.State::Enabled;
                            HRPortalUsers.employeeName := Employee."First Name" + ' ' + Employee."Last Name";
                            HRPortalUsers.changedPassword := true;
                            HRPortalUsers."Last Modified Date" := Today;
                            HRPortalUsers.Insert(true);
                        end;

                        status := 'success*Your portal credentials have been created succesfully. Please proceed to login';

                        SendEmailNotification(HRPortalUsers."Authentication Email", 'Employee Password Reset', 'Your one time password is <strong>' + Format(newPassword) + '</strong>');

                    end;
                end else begin
                    status := 'danger*You are not configured as an employee. Kindly contact ICT.';
                end;
            end;

        end else begin
            status := 'danger*New Password and confirm new password do not match!!!';
        end;

        exit(status);
    end;



    procedure FAWEFnResetPassword(emailaddress: Text) passChangestatus: Text
    var
        RandomDigit: Text;
        Body: Text;
    begin
        HRPortalUsers.Reset;
        HRPortalUsers.SetRange("Authentication Email", emailaddress);
        HRPortalUsers.SetRange(HRPortalUsers.State, HRPortalUsers.State::Enabled);
        if HRPortalUsers.FindSet then begin
            RandomDigit := CreateGuid;
            RandomDigit := DelChr(RandomDigit, '=', '{}-01');
            RandomDigit := CopyStr(RandomDigit, 1, 8);
            HRPortalUsers.password := RandomDigit;
            HRPortalUsers."Last Modified Date" := Today;
            HRPortalUsers.changedPassword := false;
            // DynasoftPortalUser.changedPassword := DynasoftPortalUser."record type"::Customer;
            if HRPortalUsers.Modify(true) then begin
                passChangestatus := 'success*Password Reset Successfully';
                ResetSendEmail(emailaddress);
            end else begin
                passChangestatus := 'danger*The Password was Not Modified';
            end;
        end else begin
            passChangestatus := 'emailnotfound*Email Address is Missing';
        end;
    end;

    procedure ResetSendEmail(emailaddress: Text)
    var
        SMTPMailSetup: Record "Email Account";
        Email2: Text;
        Body: Text;
        SMTP: Codeunit "Email Message";
        emailhdr: Text;
        emailBody: Text;
    begin
        HRPortalUsers.Reset;
        HRPortalUsers.SetRange("Authentication Email", emailaddress);
        if HRPortalUsers.FindSet then begin

            emailBody := 'Dear ' + HRPortalUsers.employeeName + ',<BR><BR>' +
               'Your Password for the account <b>' + ' ' + Format(HRPortalUsers."Authentication Email") + ' ' + '</b> has been Reset Successfully.Kindly Change your Password on Login<BR>' +
               'Use the following link to acess the employee self service Portal.' + ' ' + '<b><a href="#">Employee Portal</a></b><BR>Your New Credentials are:'
               + '<BR>'
               + 'Username:' + ' <b>' + HRPortalUsers."Authentication Email" + '</b><BR>Password:' + ' <b>' + HRPortalUsers.password + '</b>';

            emailhdr := 'Employee Password Reset';

            SendEmailNotification(emailaddress, emailhdr, emailBody);

        end;
    end;



    procedure CreateLeaveApplication(EmpNo: Code[50]; LeaveType: Code[30]; StartDate: DateTime; Days: Decimal; Remarks: Text[2048]; ApplicationNo: Code[50]; onBehalf: Boolean) status: Text
    var
        HRSetup: Record "Human Resources Setup";
        LeaveReliever: Record "Leave Relievers";
    begin
        HrEmployees.Reset();
        HrEmployees.SetRange("No.", EmpNo);
        if HrEmployees.Find('-') then begin
            Leave.Reset();
            Leave.SetRange("Application No", ApplicationNo);
            if Leave.Find('-') then begin
                Leave."Apply on behalf" := onBehalf;
                Leave."Employee No" := HrEmployees."No.";
                Leave.Validate("Employee No");
                Leave."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                Leave."Mobile No" := HrEmployees."Mobile Phone No.";
                Leave."Email Adress" := HrEmployees."Company E-Mail";
                Leave."Leave Period" := HrEmployees."Base Calendar";
                //Leave."Responsibility Center" := HrEmployees."Responsibility Center";
                Leave."Application Date" := today;
                Leave."Leave Code" := CopyStr(LeaveType, 1, MaxStrLen(Leave."Leave Code"));
                Leave.Validate("Leave Code");
                Leave."User ID" := 'ADMINCLOUD';
                Leave."Start Date" := DT2Date(StartDate);
                Leave."Days Applied" := Days;
                Leave.Validate("Start Date");
                //Leave."Duties Taken Over By" := CopyStr(Reliever, 1, MaxStrLen(Leave."Duties Taken Over By"));
                Leave.Validate("Duties Taken Over By");
                Leave.Comments := CopyStr(Remarks, 1, MaxStrLen(Leave.Comments));
                Leave.Status := Leave.Status::Open;
                Leave.Modify(true);
                status := 'success*Leave Application has been modified succesfully*' + Leave."Application No" + '*' + FORMAT(Leave."End Date");
            end else begin
                Leave.Init();
                HRSetup.Get();
                Leave."Application No" := NoSeriesMgt.GetNextNo(HRSetup."Leave Application Nos.", Today, true);
                Leave.Insert();
                Leave."Apply on behalf" := onBehalf;
                Leave."Employee No" := HrEmployees."No.";
                Leave.Validate("Employee No");
                Leave."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                Leave."Mobile No" := HrEmployees."Mobile Phone No.";
                Leave."Email Adress" := HrEmployees."Company E-Mail";
                Leave."Leave Period" := HrEmployees."Base Calendar";
                //Leave."Responsibility Center" := HrEmployees."Responsibility Center";
                Leave."Application Date" := today;
                Leave."Leave Code" := CopyStr(LeaveType, 1, MaxStrLen(Leave."Leave Code"));
                Leave.Validate("Leave Code");
                Leave."User ID" := 'ADMINCLOUD';
                Leave."Start Date" := DT2Date(StartDate);
                Leave."Days Applied" := Days;
                Leave.Validate("Start Date");
                //Leave."Duties Taken Over By" := CopyStr(Reliever, 1, MaxStrLen(Leave."Duties Taken Over By"));
                Leave.Validate("Duties Taken Over By");
                Leave.Comments := CopyStr(Remarks, 1, MaxStrLen(Leave.Comments));
                Leave.Status := Leave.Status::Open;
                Leave.Modify(true);

                status := 'success*Leave Application has been created succesfully*' + Leave."Application No" + '*' + FORMAT(Leave."End Date");
            end;
        end;
    end;

    procedure AddLeaveReleiver(ApplicationNo: Code[50]; Reliever: Code[30]) status: Text
    var
        HRSetup: Record "Human Resources Setup";
        LeaveReliever: Record "Leave Relievers";
    begin

        LeaveReliever.Init();
        LeaveReliever."Staff No" := Reliever;
        LeaveReliever."Leave Code" := ApplicationNo;
        LeaveReliever.Validate("Staff No");
        if LeaveReliever.Insert(true) then begin
            status := 'success*Leave Reliever has been created succesfully';
        end else begin
            status := 'danger*An error occured while submitting your Reliever Line';
        end;


    end;

    procedure DeleteLeaveReleiver(ApplicationNo: Code[50]; Reliever: Code[30]) status: Text
    var
        HRSetup: Record "Human Resources Setup";
        LeaveReliever: Record "Leave Relievers";
    begin

        LeaveReliever.Reset();
        LeaveReliever.SetRange("Leave Code", ApplicationNo);
        LeaveReliever.setrange("Staff No", Reliever);
        if LeaveReliever.FindFirst() THEN begin
            if LeaveReliever.Delete(true) then begin
                status := 'success*Leave Reliever has been deleted succesfully';
            end else begin
                status := 'danger*An error occured while deleted your Reliever Line';
            end;
        end;

    end;

    procedure fnGetPayslip(No: Code[20]; PayPeriod: Date) BigText: Text;
    var
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        //PaySlipReport: Report "New Payslipx";
        Employees: Record Employee;
        DateFilter: Date;
        DateFilterTxt: Text;
    begin
        // DateFilter := DMY2Date(1, 1, 2025);
        // if PayPeriod <> CalcDate('<-CM', PayPeriod) then
        //     PayPeriod := CalcDate('<-CM', PayPeriod);
        // DateFilterTxt := Format(PayPeriod);
        // //DateFilterTxt := Format(PayPeriod, 0, '<Day,2>/<Month,2>/<Year4>');       
        // Employees.Reset;
        // Employees.SetRange("No.", No);
        // Employees.SetRange("Pay Period Filter", PayPeriod);
        // if Employees.FindFirst() then begin
        //     PaySlipReport.InitPayrollFilter(DateFilterTxt);
        //     PaySlipReport.SetTableView(Employees);
        //     TempBlob.CreateOutStream(StatementOutstream);
        //     if PaySlipReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
        //         TempBlob.CreateInStream(StatementInstream);
        //         BigText := Base64Convert.ToBase64(StatementInstream);
        //         exit(BigText);
        //     end;
        // end
    end;

    procedure FAWEgeneratePayslip(employeeNumber: Code[20]; payPeriod: DateTime) BaseImage: Text
    var
        RecRef: RecordRef;
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
        //PaySlipReport: Report "New Payslipx";
        Employees: Record Employee;
        DateFilter: Date;
        DateFilterTxt: Text;
    begin
        // DateFilterTxt := Format(payPeriod);
        // TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        // Employee.Reset;
        // //Employee.SetRange(Employee."No.", employeeNumber);
        // Employee.SetRange(Employee."Employee No. Filter", employeeNumber);
        // Employee.SetRange("Pay Period Filter", Dt2Date(payPeriod));
        // if Employee.FindFirst() then begin
        //     PaySlipReport.InitPayrollFilter(DateFilterTxt);
        //     PaySlipReport.SetTableView(Employee);
        //     TempBlob.CreateOutStream(StatementOutstream);
        //     if PaySlipReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
        //         TempBlob.CreateInStream(StatementInstream);
        //         BaseImage := Base64Convert.ToBase64(StatementInstream);
        //         exit(BaseImage);
        //     end;
        //     // RecRef.GetTable(Employee);
        //     // Report.SaveAs(Report::"New Payslipx", '', ReportFormat::Pdf, OutStr, RecRef);
        //     // FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('payslip_%1.Pdf', Employee."No."), TRUE);
        //     // TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
        //     // BaseImage := Base64Convert.ToBase64(InStr);
        // end;
    end;

    procedure FAWEgenerateP9(employeeNumber: Code[20]; startDate: DateTime; endDate: DateTime) BaseImage: Text
    var
        RecRef: RecordRef;
    begin
        // TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        // Employee.Reset;
        // Employee.SetRange(Employee."No.", employeeNumber);
        // Employee.SetFilter(Employee."Date Filter", Format(Format(DT2DATE(startDate)) + '..' + Format(DT2DATE(endDate))));
        // Employee.SetFilter("Pay Period Filter", Format(Format(DT2DATE(startDate)) + '..' + Format(DT2DATE(endDate))));
        // if Employee.FindSet then begin
        //     RecRef.GetTable(Employee);
        //     Report.SaveAs(Report::"P9A Report", '', ReportFormat::Pdf, OutStr, RecRef);
        //     FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('P9_%1.Pdf', Employee."No."), TRUE);
        //     TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
        //     BaseImage := Base64Convert.ToBase64(InStr);
        // end;
    end;

    procedure PrintP9(EmployeeNo: Code[50]; Year: Integer) P9Base64Txt: Text
    var
        Payee: Record "Employee";
        // P9: Report "P9A Report";
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        EndDate, StartDate : Date;
        P9Instream: InStream;
        P9Outstream: OutStream;
        DateFilterTxt: Text;
        filename: Text;
    begin
        // filename := 'P9_' + EmployeeNo + '_' + Format(Year) + '.pdf';

        // StartDate := DMY2Date(31, 1, Year);
        // EndDate := DMY2Date(31, 12, Year);
        // DateFilterTxt := Format(StartDate) + '..' + Format(EndDate);

        // Payee.Reset();
        // Payee.SetRange("No.", EmployeeNo);
        // if Payee.FindFirst() then begin
        //     P9.SetTableView(Payee);
        //     P9.GetDefaults(StartDate, EndDate);
        //     TempBlob.CreateOutStream(P9Outstream);
        //     if P9.SaveAs('', ReportFormat::Pdf, P9Outstream) then begin
        //         TempBlob.CreateInStream(P9Instream);
        //         P9Base64Txt := Base64Convert.ToBase64(P9Instream);
        //         exit(P9Base64Txt);
        //     end;
        // end;
    end;

    procedure SendLeaveApproval(DocNo: Code[50]; UserID: Code[50]) status: Text
    begin
        LeaveApplication.Get(DocNo);

        if ApprovalMgtHR.CheckLeaveRequestWorkflowEnabled(LeaveApplication) then
            ApprovalMgtHR.OnSendLeaveRequestApproval(LeaveApplication);
        UpdateApprovalEntries(DocNo, UserID);
        status := 'success*Doccument has been successfully sent for approval';
    end;


    procedure CancelLeaveApproval(DocNo: Code[50]) status: Text
    begin
        LeaveApplication.Get(DocNo);
        ApprovalMgtHR.OnCancelLeaveRequestApproval(LeaveApplication);
        status := 'success*Doccument approval cancelled succesfully';
    end;

    procedure UpdateApprovalEntries(DocNo: Code[100]; SenderID: Code[100])
    var
        ApprovalEntryRec: Record "Approval Entry";
    begin
        //Update USERID on Approval Entries
        ApprovalEntryRec.Reset();
        ApprovalEntryRec.SetRange("Document No.", DocNo);
        ApprovalEntryRec.SetFilter(Status, '%1|%2', ApprovalEntryRec.Status::Created, ApprovalEntryRec.Status::Open);
        if ApprovalEntryRec.Find('-') then
            repeat
                ApprovalEntryRec."Sender ID" := SenderID;
                ApprovalEntryRec.Modify();
            until ApprovalEntryRec.Next() = 0;
    end;

    procedure GetStaffNoFromCustNo(AccNo: Code[30]): Code[20]
    var
    begin
        HrEmployees.Reset();
        HrEmployees.SetRange("Imprest Account", AccNo);
        if HrEmployees.FindFirst() then
            exit(HrEmployees."No.");
    end;

    procedure CreateImprestRequisition(No: Code[30]; AccountNo: Code[30]; Donor: Code[100]; Program: code[100]; TravelType: Integer;
   Currency: Code[30]; Purpose: Text[2048]; Destination: Code[250]; TravelDate: DateTime; ReturnDate: DateTime; Cashier: Code[30]) status: Text
    var
    begin
        CashMgt.Get();
        if ImprestHeader.Get(No) then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
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
            ImprestHeader."Date of Project" := DT2Date(TravelDate);
            ImprestHeader."Date of Completion" := DT2Date(ReturnDate);
            ImprestHeader.Validate("Date of Completion");
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := GetStaffNoFromCustNo(AccountNo);
            if imprestHeader.modify(true) then begin
                status := 'success*Imprest has been modified succesfully*' + imprestHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your Imprest';
            end;
        end else begin
            ImprestHeader.Init();
            ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Imprest Nos", Today, true, true);
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
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
            ImprestHeader."Date of Project" := DT2Date(TravelDate);
            ImprestHeader."Date of Completion" := DT2Date(ReturnDate);
            ImprestHeader.Validate("Date of Completion");
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := GetStaffNoFromCustNo(AccountNo);
            If ImprestHeader.Insert(true) then begin
                status := 'success*Imprest has been created succesfully*' + imprestHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your Imprest';
            end;
        end;
    end;

    procedure CreateImprestRequisitionLines(imprestno: Code[30]; ImprestType: Code[50]; DailyRate: Decimal; Dim1: Code[50];
    Dim2: Code[50]; Dim3: Code[50]; Dim4: Code[50]; Dim5: Code[50]; Dim6: Code[50]; Dim7: Code[50]) status: Text
    var
        ImprestLines1: Record "Payment Lines";
        prevLineNo: Integer;
    begin
        if ImprestHeader.Get(imprestno) then begin
            ImprestLines.Init();
            ImprestLines."Payment Type" := ImprestLines."Payment Type"::Imprest;
            ImprestLines1.Reset();
            ImprestLines1.setrange(No, imprestno);
            If ImprestLines1.FindLast() then
                prevLineNo := ImprestLines1."Line No" + 1000
            else
                prevLineNo := 1000;
            ImprestLines.No := imprestno;
            ImprestLines."Line No" := prevLineNo;
            ImprestLines."Expenditure Type" := ImprestType;
            ImprestLines.Validate("Expenditure Type");
            ImprestLines."Daily Rate" := DailyRate;
            ImprestLines.Validate("Daily Rate");
            ImprestLines."No of Days" := ImprestHeader."No of Days";
            ImprestLines.Validate("No of Days");
            ImprestLines.Destination := ImprestHeader.Destination;
            ImprestLines."Shortcut Dimension 1 Code" := Dim1;
            ImprestLines."Shortcut Dimension 2 Code" := Dim2;
            ImprestLines.ValidateShortcutDimCode(3, Dim3);
            ImprestLines.ValidateShortcutDimCode(4, Dim4);
            ImprestLines.ValidateShortcutDimCode(5, Dim5);
            ImprestLines.ValidateShortcutDimCode(6, Dim6);
            ImprestLines.ValidateShortcutDimCode(7, Dim7);
            if ImprestLines.Insert(true) then begin
                status := 'success*Imprest Line has been added succesfully';
            end else begin
                status := 'danger*An error occured while submitting your Imprest Line';
            end;
        end;
    end;

    procedure DeleteImprestRequisitionLines(No: Code[30]; LineNo: Integer) status: Text
    var
    begin
        ImprestLines.Reset();
        ImprestLines.SetRange("Imprest No.", No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::Imprest);
        if ImprestLines.FindFirst then begin
            If ImprestLines.Delete() THEn begin
                status := 'success*Imprest Line has been deleted succesfully';
            end else begin
                status := 'danger*An error occured while deleting your Imprest Line';
            end;
        end;
    end;

    procedure SendPaymentsApproval(DocNo: Code[50]) rtn: Text
    begin
        CashManagementSetup.Get;
        GeneralLedgerSetup.Get;

        with PaymentsRec do begin
            Reset;
            SetRange("No.", DocNo);
            if FindFirst then begin
                //TestFields
                case "Payment Type" of


                    "Payment Type"::Imprest:
                        begin
                            CalcFields("Imprest Amount");
                            if "Imprest Amount" <= 0 then
                                Error('Imprest Amount can not be less than or equal to 0');

                            TestField("Payment Narration");

                            Committment.CheckImprestCommittment(PaymentsRec);
                            Committment.ImprestCommittment(PaymentsRec, ErrorMsg);
                            if ErrorMsg <> '' then
                                Error(ErrorMsg);
                            Commit;
                            if ApprovalsMgmtFin.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec) then
                                ApprovalsMgmtFin.OnSendPaymentsForApproval(PaymentsRec);
                            UpdateApprovalEntries(DocNo, PaymentsRec."User Id");
                            rtn := 'success*Doccument has been successfully sent for approval';
                        end;

                    "Payment Type"::"Imprest Surrender":
                        begin
                            TestField("Surrender Date");
                            TestField("Imprest Issue Doc. No");
                            CalcFields("Remaining Amount");
                            if "Remaining Amount" <> 0 then
                                Error('Please account for all imprest amount');
                            if ApprovalsMgmtFin.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec) then
                                ApprovalsMgmtFin.OnSendPaymentsForApproval(PaymentsRec);
                            UpdateApprovalEntries(DocNo, PaymentsRec."User Id");
                            rtn := 'success*Doccument has been successfully sent for approval';
                        end;

                    "Payment Type"::"Petty Cash":
                        begin
                            CalcFields("Petty Cash Amount");
                            if "Petty Cash Amount" <= 0 then
                                Error('Petty Cash Amount can not be less than or equal to 0');

                            TestField("Payment Narration");

                            Committment.CheckPettyCashCommittment(PaymentsRec);
                            Committment.PettyCashCommittment(PaymentsRec, ErrorMsg);
                            if ErrorMsg <> '' then
                                Error(ErrorMsg);
                            Commit;
                            if ApprovalsMgmtFin.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec) then
                                ApprovalsMgmtFin.OnSendPaymentsForApproval(PaymentsRec);
                            UpdateApprovalEntries(DocNo, PaymentsRec."User Id");
                            rtn := 'success*Doccument has been successfully sent for approval';
                        end;
                    "Payment Type"::"Petty Cash Surrender":
                        begin
                            TestField("Surrender Date");
                            TestField("Petty Cash Issue Doc.No");
                            CalcFields("Remaining Amount");
                            if "Remaining Amount" <> 0 then
                                Error('Please account for all Petty Cash amount');
                            if ApprovalsMgmtFin.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec) then
                                ApprovalsMgmtFin.OnSendPaymentsForApproval(PaymentsRec);
                            UpdateApprovalEntries(DocNo, PaymentsRec."User Id");
                            rtn := 'success*Doccument has been successfully sent for approval';
                        end;


                end;


            end;
        end;
    end;

    procedure CancelPaymentsApproval(DocNo: Code[50]) rtn: Text
    begin
        with PaymentsRec do begin
            Reset;
            SetRange("No.", DocNo);
            if FindFirst then begin
                case "Payment Type" of
                    "Payment Type"::Imprest:
                        begin
                            Committment.CancelPaymentsCommitments(PaymentsRec);
                            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                            rtn := 'success*Doccument approval has been cancelled successfully.';
                        end;

                    "Payment Type"::"Imprest Surrender":
                        begin
                            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                            rtn := 'success*Doccument approval has been cancelled successfully.';
                        end;
                    "Payment Type"::"Petty Cash":
                        begin
                            Committment.CancelPaymentsCommitments(PaymentsRec);
                            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                            rtn := 'success*Doccument approval has been cancelled successfully.';
                        end;

                    "Payment Type"::"Petty Cash Surrender":
                        begin
                            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                            rtn := 'success*Doccument approval has been cancelled successfully.';
                        end;

                end;

            end;
        end;
    end;

    procedure CreateImprestSurRequisition(No: Code[30]; ImprestNo: Code[30]) status: Text
    var
        PaymentRec: Record Payments;
        PaymentLine: Record "Payment Lines";
        ImpSurrLines: Record "Payment Lines";
        ImprestFullySurrenderedLbl: Label 'The imprest %1 has been fully surrendered', Comment = '%1 = Imprest Issue Doc. No';
    begin
        CashMgt.Get();
        ImprestHeader.Reset();
        ImprestHeader.SetRange("No.", No);
        if ImprestHeader.Find('-') then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Imprest Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := ImprestNo;
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
                    if ImprestHeader.Insert(true) then begin
                        status := 'success*Imprest Surrender has been modified succesfully*' + ImprestHeader."No.";
                    end else begin
                        status := 'danger*An error occured while submitting your imprest surrender';
                    end;
                end;
        end else begin
            ImprestHeader.Init();
            ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Imprest Surrender Nos", Today, true, true);
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Imprest Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := ImprestNo;
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
                    if ImprestHeader.Insert(true) then
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

            status := 'success*Requisition has been created succesfully*' + ImprestHeader."No.";

        end;
    end;

    procedure FAWEupdateSurrenderLine(employeeNo: Code[50]; imprestSurrenderNo: Code[50]; lineNo: Integer; amountSpent: Decimal; receipt: Text) status: Text
    var
        ImprestLines: Record "Payment Lines";
        Payments: Record Payments;
    begin
        status := 'danger*The imprest line could not be updated';
        Payments.Reset;
        Payments.SetRange("Account No.", employeeNo);
        Payments.SetRange("No.", imprestSurrenderNo);
        Payments.SetRange(Status, Payments.Status::Open);
        Payments.SetRange("Payment Type", Payments."payment type"::"Imprest Surrender");
        if Payments.FindSet then begin
            ImprestLines.Reset;
            ImprestLines.SetRange(No, imprestSurrenderNo);
            ImprestLines.SetRange("Line No", lineNo);
            if ImprestLines.FindSet then begin
                ImprestLines.Validate("Actual Spent", amountSpent);
                // ImprestLines.Validate("Receipt No.", receipt);
                if ImprestLines.Modify(true) then begin
                    status := 'success*The imprest line was successfully updated';//+FORMAT(lineNo);
                end else begin
                    status := 'danger*The imprest line could not be updated';
                end;
            end else begin
                status := 'danger*The imprest line does not exist' + Format(lineNo);
            end;
        end else begin
            status := 'danger*An imprest surrender with the given number does not exist, you are not the requestor or is no longer open';
        end;
        exit(status);
    end;

    procedure CreatePettyCash(No: Code[30]; AccountNo: Code[30]; Donor: Code[100]; Program: code[100]; PettyCashType: Integer; paymode: code[50]; Purpose: Text; Cashier: Code[30]; Currency: Code[30]; EmpNo: Code[30]) status: Text
    var
    begin
        CashMgt.Get();
        HrEmployees.Get(EmpNo);
        if ImprestHeader.Get(No) then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
            ImprestHeader."Pay Mode" := paymode;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := Donor;
            ImprestHeader."Shortcut Dimension 2 Code" := Program;
            ImprestHeader."Petty Cash Type" := PettyCashType;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            if ImprestHeader.Modify(true) then begin
                status := 'success*Petty Cash has been modified succesfully*' + ImprestHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your imprest surrender';
            end;
        end else begin
            ImprestHeader.Init();
            ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Petty Cash Nos", Today, true, true);
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
            ImprestHeader."Pay Mode" := paymode;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := Donor;
            ImprestHeader."Shortcut Dimension 2 Code" := Program;
            ImprestHeader."Petty Cash Type" := PettyCashType;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            if ImprestHeader.Insert(true) then begin
                status := 'success*Petty Cash has been modified succesfully*' + ImprestHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your imprest surrender';
            end;
        end;
    end;

    procedure CreatePettyCashLines(No: Code[30]; ImprestType: Code[50]; DailyRate: Decimal; Narration: Text; Dim1: Code[50];
    Dim2: Code[50]; Dim3: Code[50]; Dim4: Code[50]; Dim5: Code[50]; Dim6: Code[50]; Dim7: Code[50]) status: Text
    var
        ImprestLines1: Record "Payment Lines";
        prevLineNo: Integer;
    begin
        if ImprestHeader.Get(No) then begin
            ImprestLines.Init();
            ImprestLines."Payment Type" := ImprestLines."Payment Type"::"Petty Cash";
            ImprestLines1.Reset();
            ImprestLines1.setrange(No, No);
            If ImprestLines1.FindLast() then
                prevLineNo := ImprestLines1."Line No" + 1000
            else
                prevLineNo := 1000;
            ImprestLines."Line No" := prevLineNo;
            ImprestLines.No := No;
            ImprestLines.Description := Narration;
            ImprestLines."Expenditure Type" := ImprestType;
            ImprestLines.Validate("Expenditure Type");
            ImprestLines.Amount := DailyRate;
            ImprestLines.Validate(Amount);
            ImprestLines."Shortcut Dimension 1 Code" := Dim1;
            ImprestLines."Shortcut Dimension 2 Code" := Dim2;
            ImprestLines.ValidateShortcutDimCode(3, Dim3);
            ImprestLines.ValidateShortcutDimCode(4, Dim4);
            ImprestLines.ValidateShortcutDimCode(5, Dim5);
            ImprestLines.ValidateShortcutDimCode(6, Dim6);
            ImprestLines.ValidateShortcutDimCode(7, Dim7);
            if ImprestLines.Insert(true) then begin
                status := 'success*Imprest Line has been created succesfully';
            end else begin
                status := 'danger*An error occured while created your Imprest Line';
            end;

        end;
    end;

    procedure DeletePettyCashLine(No: Code[30]; LineNo: Integer) status: Text
    begin
        ImprestLines.Reset();
        ImprestLines.SetRange(No, No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::"Petty Cash");
        if ImprestLines.Find('-') then begin
            if ImprestLines.Delete(true) then begin
                status := 'success*Imprest Line has been deleted succesfully';
            end else begin
                status := 'danger*An error occured while deleting your Imprest Line';
            end;
        end;
    end;

    procedure CreatePettySurRequisition(No: Code[30]; ImprestNo: Code[30]) status: Text
    var
        PaymentRec: Record Payments;
        PaymentLine: Record "Payment Lines";
        ImpSurrLines: Record "Payment Lines";
        ImprestFullySurrenderedLbl: Label 'The Petty Cash %1 has been fully surrendered', Comment = '%1 = Imprest Issue Doc. No';
    begin
        ImprestHeader.Reset();
        ImprestHeader.SetRange("No.", No);
        if ImprestHeader.Find('-') then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := ImprestNo;
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
                    if ImprestHeader.Modify(true) then begin
                        status := 'success*Petty Cash has been modified succesfully*' + ImprestHeader."No.";
                    end else begin
                        status := 'danger*An error occured while submitting your imprest surrender';
                    end;
                end;
        end else begin
            CashMgt.Get();
            ImprestHeader.Init();
            ImprestHeader.Date := Today;
            ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Petty Cash Surrender Nos", Today, true, true);
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Petty Cash Surrender";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Imprest Issue Doc. No" := ImprestNo;
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
                    if ImprestHeader.Insert(true) then
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
            status := 'success*Petty Cash has been modified succesfully*' + ImprestHeader."No.";
        end;
    end;



    procedure UpdatePettyCashSurrenderLine(No: Code[30]; LineNo: Integer; Amount: Decimal; ReceiptNo: Code[30]; ReceiptAmount: Decimal) status: Text
    begin

        ImprestLines.Reset();
        ImprestLines.SetRange(No, No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::"Petty Cash Surrender");
        if ImprestLines.Find('-') then
            ImprestLines."Actual Spent" := Amount;
        ImprestLines."Imprest Receipt No." := ReceiptNo;
        ImprestLines."Cash Receipt Amount" := ReceiptAmount;
        if ImprestLines.Modify(true) then begin
            status := 'success*Petty Cash has been modified succesfully*' + Format(ImprestLines."Line No");
        end else begin
            status := 'danger*An error occured while submitting your petty cash';
        end;

    end;

    procedure CreateStaffClaim(No: Code[30]; AccountNo: Code[30]; Donor: Code[100]; Program: code[100]; claimType: Integer; paymode: code[50]; Purpose: Text; Cashier: Code[30]; Currency: Code[30]; ImprestSurrenderDocNo: Code[30]; EmpNo: Code[30]) status: Text
    var
    begin
        CashMgt.Get();
        HrEmployees.Get(EmpNo);
        if ImprestHeader.Get(No) then begin
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
            ImprestHeader."Pay Mode" := paymode;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Staff Claim";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := Donor;
            ImprestHeader."Shortcut Dimension 2 Code" := Program;
            ImprestHeader."Claim Type" := claimType;
            ImprestHeader."Imprest Surrender Doc. No" := ImprestSurrenderDocNo;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            if ImprestHeader.Modify(true) then begin
                status := 'success*Petty Cash has been modified succesfully*' + ImprestHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your imprest surrender';
            end;
        end else begin
            ImprestHeader.Init();
            ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Petty Cash Nos", Today, true, true);
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
            ImprestHeader."Pay Mode" := paymode;
            ImprestHeader."Payment Type" := ImprestHeader."Payment Type"::"Staff Claim";
            ImprestHeader."Account Type" := ImprestHeader."Account Type"::Customer;
            ImprestHeader."Account No." := CopyStr(AccountNo, 1, MaxStrLen(ImprestHeader."Account No."));
            ImprestHeader.Validate("Account No.");
            ImprestHeader.Payee := ImprestHeader."Account Name";
            ImprestHeader."Shortcut Dimension 1 Code" := Donor;
            ImprestHeader."Shortcut Dimension 2 Code" := Program;
            ImprestHeader."Claim Type" := claimType;
            ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
            ImprestHeader."Payment Narration" := CopyStr(Purpose, 1, MaxStrLen(ImprestHeader."Payment Narration"));
            ImprestHeader.Status := ImprestHeader.Status::Open;
            ImprestHeader."Staff No." := EmpNo;
            ImprestHeader."Imprest Surrender Doc. No" := ImprestSurrenderDocNo;
            if ImprestHeader.Insert(true) then begin
                status := 'success*Staff Claim has been modified succesfully*' + ImprestHeader."No.";
            end else begin
                status := 'danger*An error occured while submitting your Staff Claim';
            end;
        end;
    end;

    procedure CreateStaffClaimLines(No: Code[30]; claimType: Integer; DailyRate: Decimal; Narration: Text; Dim1: Code[50];
    Dim2: Code[50]; Dim3: Code[50]; Dim4: Code[50]; Dim5: Code[50]; Dim6: Code[50]; Dim7: Code[50]) status: Text
    var
        ImprestLines1: Record "Payment Lines";
        prevLineNo: Integer;
    begin
        if ImprestHeader.Get(No) then begin
            ImprestLines.Init();
            ImprestLines."Payment Type" := ImprestLines."Payment Type"::"Staff Claim";
            ImprestLines1.Reset();
            ImprestLines1.setrange(No, No);
            If ImprestLines1.FindLast() then
                prevLineNo := ImprestLines1."Line No" + 1000
            else
                prevLineNo := 1000;
            ImprestLines."Line No" := prevLineNo;
            ImprestLines.No := No;
            ImprestLines.Description := Narration;
            ImprestLines."Claim Type" := claimType;
            ImprestLines.Validate("Expenditure Type");
            ImprestLines.Amount := DailyRate;
            ImprestLines.Validate(Amount);
            ImprestLines."Shortcut Dimension 1 Code" := Dim1;
            ImprestLines."Shortcut Dimension 2 Code" := Dim2;
            ImprestLines.ValidateShortcutDimCode(3, Dim3);
            ImprestLines.ValidateShortcutDimCode(4, Dim4);
            ImprestLines.ValidateShortcutDimCode(5, Dim5);
            ImprestLines.ValidateShortcutDimCode(6, Dim6);
            ImprestLines.ValidateShortcutDimCode(7, Dim7);
            if ImprestLines.Insert(true) then begin
                status := 'success*Staff Claim has been created succesfully';
            end else begin
                status := 'danger*An error occured while created your Staff Claim';
            end;
        end;
    end;

    procedure DeleteStaffClaimLine(No: Code[30]; LineNo: Integer) status: Text
    begin
        ImprestLines.Reset();
        ImprestLines.SetRange(No, No);
        ImprestLines.SetRange("Line No", LineNo);
        ImprestLines.SetRange("Payment Type", ImprestLines."Payment Type"::"Staff Claim");
        if ImprestLines.Find('-') then begin
            if ImprestLines.Delete(true) then begin
                status := 'success*Staff Claim Line has been deleted succesfully';
            end else begin
                status := 'danger*An error occured while deleting your Staff Claim';
            end;
        end;
    end;

    procedure CreateTrainingRequest(No: Code[30]; EmpNo: Code[30]; trainingNeed: Code[100]; trainingDescription: Text; fromDt: DateTime; toDt: DateTime; destination: Text; Currency: Code[30]; costOfTraining: decimal) status: Text
    var
    begin
        // CashMgt.Get();
        // HrEmployees.Get(EmpNo);
        // if TrainingRequest.Get(No) then begin
        //     TrainingRequest."Request Date" := Today;
        //     TrainingRequest."Employee No" := EmpNo;
        //     TrainingRequest.Validate("Employee No");
        //     TrainingRequest."Planned Start Date" := DT2Date(fromDt);
        //     TrainingRequest.Validate("Planned Start Date");
        //     TrainingRequest."Planned End Date" := DT2Date(toDt);
        //     TrainingRequest.Validate("Planned End Date");
        //     // TrainingRequest.Currency := CopyStr(Currency, 1, MaxStrLen(TrainingRequest.Currency));
        //     TrainingRequest.Description := trainingDescription;
        //     TrainingRequest."Cost of Training" := costOfTraining;
        //     TrainingRequest.Destination := destination;
        //     TrainingRequest."Training Need" := trainingNeed;
        //     if TrainingRequest.Modify(true) then begin
        //         status := 'success*Training request has been modified succesfully*' + TrainingRequest."Request No.";
        //     end else begin
        //         status := 'danger*An error occured while submitting your Training request';
        //     end;
        // end else begin
        //     TrainingRequest.Init();
        //     TrainingRequest."Request Date" := Today;
        //     TrainingRequest."Employee No" := EmpNo;
        //     TrainingRequest.Validate("Employee No");
        //     TrainingRequest."Planned Start Date" := DT2Date(fromDt);
        //     TrainingRequest.Validate("Planned Start Date");
        //     TrainingRequest."Planned End Date" := DT2Date(toDt);
        //     TrainingRequest.Validate("Planned End Date");
        //     // TrainingRequest.Currency := CopyStr(Currency, 1, MaxStrLen(TrainingRequest.Currency));
        //     TrainingRequest.Description := trainingDescription;
        //     TrainingRequest."Cost of Training" := costOfTraining;
        //     TrainingRequest.Destination := destination;
        //     TrainingRequest."Training Need" := trainingNeed;
        //     if TrainingRequest.Insert(true) then begin
        //         status := 'success*Training request has been modified succesfully*' + TrainingRequest."Request No.";
        //     end else begin
        //         status := 'danger*An error occured while submitting your Training request';
        //     end;
        // end;
    end;

    procedure SendTrainingRequestApproval(DocNo: Code[50]) Status: Text
    begin
        // TrainingRequest.Get(DocNo);

        // if ApprovalMgtHR.CheckTrainingRequestWorkflowEnabled(TrainingRequest) then
        //     ApprovalMgtHR.OnSendTrainingRequestforApproval(TrainingRequest);
        // UpdateApprovalEntries(DocNo, TrainingRequest."User ID");
        status := 'success*Training Request has been has been succesfully sent for approval.';
    end;

    procedure CancelTrainingRequestApproval(DocNo: Code[50]) Status: Text
    begin
        // TrainingRequest.Get(DocNo);
        // ApprovalMgtHR.OnCancelTrainingRequestApproval(TrainingRequest);
        status := 'success*Training Request approval request has been successfully cancelled.';
    end;

    procedure fnInsertPortalAttachments(DocumentNo: Code[100]; Description: Text; Url: Text; Type: Text) status: Text
    var

    begin
        PortalUploads.INIT;
        PortalUploads."Document No" := DocumentNo;
        PortalUploads.Description := Description;
        PortalUploads.LocalUrl := Url;
        PortalUploads.Uploaded := TRUE;
        PortalUploads.Fetch_To_Sharepoint := TRUE;
        PortalUploads.Base_URL := 'https://fawers.sharepoint.com/sites/ERP/ERP%20Documents/FAWE' + '/' + Type + '/';
        if PortalUploads.Insert(true) then begin
            status := 'success*Portal document has been created succesfully*' + Format(PortalUploads."Entry No");
        end else begin
            status := 'danger*An error occured while created your portal document';
        end;
    end;

    procedure UpdateLinks(EntryNo: Integer; Link: Text; Reason: Text) status: Text
    begin
        IF PortalUploads.GET(EntryNo) THEN
            PortalUploads.SP_URL_Returned := Link;
        PortalUploads.Polled := TRUE;
        PortalUploads.Failure_reason := Reason;
        if PortalUploads.Modify(true) then begin
            status := 'success*Portal document has been modified succesfully*' + Format(PortalUploads."Entry No");
        end else begin
            status := 'danger*An error occured while submitting your portal document';
        end;
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


    procedure FAWEaddImprestSharepointLinks(imprestno: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        ImprestMemo: Record Payments;
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        RecordLink.Reset;
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := sharepointlink;
            RecordLink.Description := filename;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            // RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            ImprestMemo.Reset;
            ImprestMemo.setrange("No.", imprestno);
            if ImprestMemo.Find('=') then
                RecordIDNumber := ImprestMemo.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(imprestno, filename, sharepointlink, 'Imprest Memo');
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end
        end;
    end;

    procedure FAWEaddPettyCashSharepointLinks(staffclaimnumber: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        staffclaim: Record payments;
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
        Payments: Record Payments;
    begin
        // Create Document Link to Sharepoint **********Obadiah Korir****************
        RecordLink.Reset;
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := sharepointlink;
            RecordLink.Description := filename;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            // RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            Payments.Reset;
            Payments.SetRange("No.", staffclaimnumber);
            if Payments.Find('=') then
                RecordIDNumber := Payments.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(staffclaimnumber, filename, sharepointlink, 'Petty Cash Voucher');
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end;
        end;
    end;

    procedure FAWEaddLeaveSharepointLinks(leaveno: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        leaveapplication: Record "Leave Application";
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        RecordLink.Reset;
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := sharepointlink;
            RecordLink.Description := filename;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            // RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            leaveapplication.Reset;
            leaveapplication.SetRange("Application No", leaveno);
            if leaveapplication.Find('=') then
                RecordIDNumber := leaveapplication.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(leaveno, filename, sharepointlink, 'Leave Application card');
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end
        end;
    end;

    procedure FAWEaddImprestSurrenderSharepointLinks(staffclaimnumber: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        Payments: Record payments;
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
    begin
        RecordLink.Reset;
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := sharepointlink;
            RecordLink.Description := filename;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            // RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            Payments.Reset;
            Payments.SetRange("No.", staffclaimnumber);
            if Payments.Find('=') then
                RecordIDNumber := Payments.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(staffclaimnumber, filename, sharepointlink, 'Imprest Surrender');
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end;
        end;
    end;

    procedure FAWEaddPettyCashSurrenderSharepointLinks(staffclaimnumber: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        staffclaim: Record payments;
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
        Payments: Record payments;
    begin
        // Create Document Link to Sharepoint **********Obadiah Korir****************
        RecordLink.Reset;
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := sharepointlink;
            RecordLink.Description := filename;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            // RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            Payments.Reset;
            Payments.SetRange("No.", staffclaimnumber);
            if Payments.Find('=') then
                RecordIDNumber := Payments.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(staffclaimnumber, filename, sharepointlink, 'Petty Cash Surrender');
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end;
        end;
    end;

    procedure FAWEaddStaffClaimSharepointLinks(staffclaimnumber: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        staffclaim: Record payments;
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
        Payments: Record payments;
    begin
        // Create Document Link to Sharepoint **********Obadiah Korir****************
        RecordLink.Reset;
        if RecordLink."Link ID" = 0 then begin
            RecordLink.URL1 := sharepointlink;
            RecordLink.Description := filename;
            RecordLink.Type := RecordLink.Type::Link;
            RecordLink.Company := COMPANYNAME;
            // RecordLink."User ID" := UserId;
            RecordLink.Created := CreateDatetime(Today, Time);
            Payments.Reset;
            Payments.SetRange("No.", staffclaimnumber);
            if Payments.Find('=') then
                RecordIDNumber := Payments.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(staffclaimnumber, filename, sharepointlink, 'Staff Claim');
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end;
        end;
    end;

    procedure FAWEaddTrainingSharepointLinks(staffclaimnumber: Code[50]; filename: Text; sharepointlink: Text) status: Text
    var
        staffclaim: Record payments;
        RecordLink: Record "Record Link";
        RecordIDNumber: RecordID;
        Payments: Record payments;
    begin
        // Create Document Link to Sharepoint **********Obadiah Korir****************
        // RecordLink.Reset;
        // if RecordLink."Link ID" = 0 then begin
        //     RecordLink.URL1 := sharepointlink;
        //     RecordLink.Description := filename;
        //     RecordLink.Type := RecordLink.Type::Link;
        //     RecordLink.Company := COMPANYNAME;
        //     // RecordLink."User ID" := UserId;
        //     RecordLink.Created := CreateDatetime(Today, Time);
        //     TrainingRequest.Reset;
        //     TrainingRequest.SetRange("Request No.", staffclaimnumber);
        //     if TrainingRequest.Find('=') then
        //         RecordIDNumber := TrainingRequest.RecordId;
        //     RecordLink."Record ID" := RecordIDNumber;
        //     if RecordLink.Insert(true) then begin
        //         fnInsertPortalAttachments(staffclaimnumber, filename, sharepointlink, 'Training Request');
        //         status := 'success*Link successfully created';
        //     end else begin
        //         status := 'error*An error occured during the process of creating link';
        //     end;
        // end;
    end;

    procedure FAWEgenerateImprestMemo(employeeNumber: Code[20]; docNo: Text) BaseImage: Text
    var
        ImprestMemo: Record Payments;
    begin

        Employee.RESET;
        Employee.SETRANGE(Employee."No.", employeeNumber);
        IF Employee.FINDSET THEN BEGIN
            TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
            ImprestMemo.Reset;
            ImprestMemo.SetRange("No.", docNo);
            if ImprestMemo.FindSet then begin
                RecRef.GetTable(ImprestMemo);
                Report.SaveAs(Report::Imprest, '', ReportFormat::Pdf, OutStr, RecRef);
                FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('ImprestMemo_%1.Pdf', ImprestMemo."No."), TRUE);
                TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
                BaseImage := Base64Convert.ToBase64(InStr);
            end;
        END;

    end;

    procedure FAWEenerateImprestSurrenders(docNo: Text) BaseImage: Text
    var
        Payments: Record Payments;
    begin

        Payments.Reset;
        Payments.SetRange("No.", docNo);
        if Payments.FindSet then begin
            TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
            RecRef.GetTable(Payments);
            Report.SaveAs(Report::"Imprest Surrender", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('ImprestSurrenders_%1.Pdf', Payments."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
        end;

    end;

    procedure FAWEgeneratepettyCashVoucher(docNo: Text) BaseImage: Text
    var
        Payments: Record Payments;
    begin

        Payments.Reset;
        Payments.SetRange("No.", docNo);
        if Payments.FindSet then begin
            TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
            RecRef.GetTable(Payments);
            Report.SaveAs(Report::"Petty Cash Voucher", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('PettyCashVoucher_%1.Pdf', Payments."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
        end;

    end;

    procedure FAWEgeneratepettyCashSurrender(docNo: Text) BaseImage: Text
    var
        Payments: Record Payments;
    begin

        Payments.Reset;
        Payments.SetRange("No.", docNo);
        if Payments.FindSet then begin
            TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
            RecRef.GetTable(Payments);
            Report.SaveAs(Report::"Petty Cash Surrender", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('PettyCashSurrender_%1.Pdf', Payments."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
        end;

    end;

    procedure FAWEgenerateStaffClaim(docNo: Text) BaseImage: Text
    var
        Payments: Record Payments;
    begin

        Payments.Reset;
        Payments.SetRange("No.", docNo);
        if Payments.FindSet then begin
            TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
            RecRef.GetTable(Payments);
            Report.SaveAs(Report::"Staff Claim Voucher", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('StaffClaim_%1.Pdf', Payments."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
        end;

    end;
}
