codeunit 55056 HRPortal
{
    Permissions = TableData "Approval Entry" = m;

    var
        HRPortalUsers: Record HRPortalUsers;
        Employee: Record Employee;
        Leave: Record "Leave Application";
        NoSeriesMgt: Codeunit "No. Series";
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
        TrainingRequest: Record "Training Needs Header";
        TrainingRequestLines: Record "Employee Training Needs";
        TrainingRequestLines1: Record "Employee Training Needs";
        LeaveApplication: Record "Leave Application";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        MaturityDate: Date;
        NonWorkingDay: Boolean;
        NoOfWorkingDays: Decimal;
        PayrollPeriod: Record "Payroll Period II";

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
        memo: Record "Imprest Memo Header";
        memo1: Record "Imprest Memo Header";
        memoLines: Record "Imprest Memo Lines";
        employeeAppraisal: Record "Employee Appraisal";
        employeeAppraisal1: Record "Employee Appraisal";
        employeeAppraisalLines: Record "Appraisal Lines";

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
            SendEmailNotification(employeeEmail, 'Password Reset', 'Your one time password is <strong>' + Format(password) + '</strong>');
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
        EnvInfo: Codeunit "Environment Information";
        PortalLink: Text;
    begin
        if EnvInfo.IsSandbox() then
            PortalLink := ''
        else
            PortalLink := 'https://selfservice.jsc.go.ke:8090/';

        HRPortalUsers.Reset;
        HRPortalUsers.SetRange("Authentication Email", emailaddress);
        if HRPortalUsers.FindFirst() then begin

            emailBody := 'Dear ' + HRPortalUsers.employeeName + ',<BR><BR>' +
               'Your Password for the account <b>' + ' ' + Format(HRPortalUsers."Authentication Email") + ' ' + '</b> has been Reset Successfully.Kindly Change your Password on Login<BR>' +
               'Use the following link to acess the employee self service Portal.' + ' ' + '<b><a href="' + PortalLink + '" target="_blank">Employee Portal</a></b><BR>Your New Credentials are:'
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
        HRmgt: Codeunit "HR Management";
    begin
        HrEmployees.Reset();
        HrEmployees.SetRange("No.", EmpNo);
        if HrEmployees.Find('-') then begin
            Leave.Reset();
            Leave.SetRange("Application No", ApplicationNo);
            if Leave.Find('-') then begin
                If (HrEmployees."Responsibility Center" = '') then
                    Error('Responsibility Center must be specified for this employee.Kindly Contact ICT');
                Leave."Apply on behalf" := onBehalf;
                Leave."Employee No" := HrEmployees."No.";
                Leave.Validate("Employee No");
                Leave."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                Leave."Mobile No" := HrEmployees."Mobile Phone No.";
                Leave."Email Adress" := HrEmployees."Company E-Mail";
                Leave."Leave Period" := HRmgt.GetCurrentLeavePeriodCode();
                Leave."Responsibility Center" := HrEmployees."Responsibility Center";
                Leave.Validate("Responsibility Center");
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
                Leave.Reset();
                Leave.SetRange("Employee No", EmpNo);
                Leave.SetRange(Status, Leave.Status::Open);
                If Leave.FindFirst() THEN begin
                    status := 'danger*You have an open leave application ' + Leave."Application No" + ' kindly proceed to utilize it before creating a new one.';
                end else begin
                    Leave.Init();
                    If (HrEmployees."Responsibility Center" = '') then
                        Error('Responsibility Center must be specified for this employee.Kindly Contact ICT');
                    HRSetup.Get();
                    Leave."Application No" := NoSeriesMgt.GetNextNo(HRSetup."Leave Application Nos.", Today, true);
                    Leave.Insert();
                    Leave."Apply on behalf" := onBehalf;
                    Leave."Employee No" := HrEmployees."No.";
                    Leave.Validate("Employee No");
                    Leave."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                    Leave."Mobile No" := HrEmployees."Mobile Phone No.";
                    Leave."Email Adress" := HrEmployees."Company E-Mail";
                    Leave."Leave Period" := HRmgt.GetCurrentLeavePeriodCode();
                    Leave."Responsibility Center" := HrEmployees."Responsibility Center";
                    Leave.Validate("Responsibility Center");
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

    procedure CreateEmployeeAppraisalApplication(EmpNo: Code[50]; AppraisorNo: Code[50]; appraisalPeriod: Code[30]; appraisalType: Code[30]; ApplicationNo: Code[50]) status: Text
    var
        HRSetup: Record "Human Resources Setup";
        LeaveReliever: Record "Leave Relievers";
    begin
        HrEmployees.Reset();
        HrEmployees.SetRange("No.", EmpNo);
        if HrEmployees.Find('-') then begin
            employeeAppraisal.Reset();
            employeeAppraisal.SetRange("Appraisal No", ApplicationNo);
            if employeeAppraisal.Find('-') then begin
                employeeAppraisal."Employee No" := HrEmployees."No.";
                employeeAppraisal.Validate("Employee No");
                employeeAppraisal."Appraisee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                employeeAppraisal."Appraiser No" := AppraisorNo;
                employeeAppraisal.Validate("Appraiser No");
                employeeAppraisal."Appraisal Period" := appraisalPeriod;
                employeeAppraisal.Validate("Appraisal Period");
                employeeAppraisal."Appraisal Type" := appraisalType;
                employeeAppraisal.Validate("Appraisal Type");
                employeeAppraisal.Date := today;
                //employeeAppraisal.ID:= 'ADMINCLOUD';
                employeeAppraisal.Modify(true);
                status := 'success*Appraisal Application has been modified succesfully*' + employeeAppraisal."Appraisal No";
            end else begin
                employeeAppraisal.Init();
                HRSetup.Get();
                employeeAppraisal."Appraisal No" := NoSeriesMgt.GetNextNo(HRSetup."Appraisal Nos", Today, true);
                employeeAppraisal."Employee No" := HrEmployees."No.";
                employeeAppraisal.Validate("Employee No");
                employeeAppraisal."Appraisee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                employeeAppraisal."Appraiser No" := AppraisorNo;
                employeeAppraisal.Validate("Appraiser No");
                employeeAppraisal."Appraisal Period" := appraisalPeriod;
                employeeAppraisal.Validate("Appraisal Period");
                employeeAppraisal.Date := today;
                //employeeAppraisal.ID:= 'ADMINCLOUD';
                employeeAppraisal.Status := employeeAppraisal.Status::Open;
                employeeAppraisal.Insert(true);
                employeeAppraisal."Employee No" := HrEmployees."No.";
                employeeAppraisal.Validate("Employee No");
                employeeAppraisal."Appraisee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Middle Name" + ' ' + HrEmployees."Last Name";
                employeeAppraisal."Appraisal Type" := appraisalType;
                employeeAppraisal.Validate("Appraisal Type");
                employeeAppraisal.Modify(true);
                status := 'success*Appraisal Application has been created succesfully*' + employeeAppraisal."Appraisal No";
            end;
        end;
    end;

    procedure AddAppraisalLines(ApplicationNo: Code[50]; workplanID: Code[30]; indicators: Code[30]; initiave: Code[30]; target: Decimal; actual: Decimal) status: Text
    var
        prevLineNo: Integer;

    begin

        employeeAppraisalLines.Init();
        employeeAppraisalLines."Appraisal No" := ApplicationNo;
        employeeAppraisalLines.Reset();
        employeeAppraisalLines.setrange("Appraisal No", ApplicationNo);
        If employeeAppraisalLines.FindLast() then
            prevLineNo := employeeAppraisalLines."Line No" + 1000
        else
            prevLineNo := 1000;
        employeeAppraisalLines."Line No" := prevLineNo;
        employeeAppraisalLines."Workplan Code" := workplanID;
        employeeAppraisalLines.Validate("Workplan Code");
        employeeAppraisalLines."Performance Measure" := indicators;
        employeeAppraisalLines.Validate("Performance Measure");
        employeeAppraisalLines."Initiative code" := initiave;
        employeeAppraisalLines.Validate("Initiative code");
        employeeAppraisalLines."FY Target" := target;
        employeeAppraisalLines.Actual := actual;
        if employeeAppraisalLines.Insert(true) then begin
            status := 'success*Appraisal Line has been created succesfully';
        end else begin
            status := 'danger*An error occured while submitting your Appraisal Line';
        end;


    end;

    procedure DeleteAppraisalLines(ApplicationNo: Code[50]; employeeNo: Code[50]; lineNo: Integer) status: Text
    var
        HRSetup: Record "Human Resources Setup";
        LeaveReliever: Record "Leave Relievers";
    begin
        employeeAppraisalLines.Reset();
        employeeAppraisalLines.SetRange("Appraisal No", ApplicationNo);
        employeeAppraisalLines.setrange("Line No", lineNo);
        //employeeAppraisalLines.setrange("Employee No", employeeNo);
        if employeeAppraisalLines.FindFirst() THEN begin
            if employeeAppraisalLines.Delete(true) then begin
                status := 'success*Appraisal Line has been deleted succesfully';
            end else begin
                status := 'danger*An error occured while deleted your Appraisal Line';
            end;
        end;
    end;

    procedure SendAppraisalApproval(DocNo: Code[50]) status: Text
    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
    begin
        employeeAppraisal.Reset();
        employeeAppraisal.SetRange("Appraisal No", DocNo);
        if employeeAppraisal.Find('-') then begin
            if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(employeeAppraisal) then
                ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(employeeAppraisal);
            status := 'success*Doccument has been successfully sent for approval';
        end else begin
            status := 'danger*Document not found';
        end;

    end;

    procedure SendAppraisalReview(DocNo: Code[50]) status: Text
    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
    begin
        employeeAppraisal.Reset();
        employeeAppraisal.SetRange("Appraisal No", DocNo);
        if employeeAppraisal.Find('-') then begin
            if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(employeeAppraisal) then
                ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(employeeAppraisal);
            // employeeAppraisal.TestField("Appraisal Period");
            // employeeAppraisal.TestField("Employee No");
            // employeeAppraisal.TestField("Appraiser No");
            // Commit();
            // if ApprovalsMgmt.CheckNewEmpAppraisalWorkflowEnabled(employeeAppraisal) then
            //     ApprovalsMgmt.OnSendNewEmpAppraisalRequestforApproval(employeeAppraisal);
            // employeeAppraisal1.Reset();
            // employeeAppraisal1.SetRange("Appraisal No", DocNo);
            // if employeeAppraisal1.Find('-') then begin
            //     employeeAppraisal1."Appraisal Status" := employeeAppraisal1."Appraisal Status"::Review;
            //     if employeeAppraisal1.Status = employeeAppraisal1.Status::Released then
            //         employeeAppraisal1."Appraisal Status" := employeeAppraisal1."Appraisal Status"::Completed;
            //     employeeAppraisal1.Modify();
            // end;

            // Commit();
            // CurrPage.Update();
            status := 'success*Doccument has been successfully sent for review';
        end else begin
            status := 'danger*Document not found';
        end;

    end;


    procedure CancelAppraisalApproval(DocNo: Code[50]) status: Text
    var
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
    begin
        employeeAppraisal.Get(DocNo);
        ApprovalsMgmt.OnCancelNewEmpAppraisalRequestApproval(employeeAppraisal);
        status := 'success*Doccument approval cancelled succesfully';
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
        PaySlipReport: Report "Client Payslip";
        Employee: Record "Client Employee Master";
        DateFilter: Date;
        DateFilterTxt: Text;
        VarPayPeriod: Record "Payroll Period II";
    begin

        //    VarPayPeriod.Reset();
        //     VarPayPeriod.SetRange(Closed, false);
        //     if VarPayPeriod.Find('-') then
        //       payPeriod := VarPayPeriod."Starting Date";

        DateFilterTxt := Format(payPeriod);
        TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        Employee.Reset;
        //Employee.SetRange(Employee."No.", employeeNumber);
        Employee.SetRange(Employee."No.", employeeNumber);
        Employee.SetRange("Pay Period Filter", Dt2Date(payPeriod));
        // Employee.SetRange("Pay Period Filter", payPeriod);
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindFirst() then begin
            //PaySlipReport.InitPayrollFilter(DateFilterTxt);
            PaySlipReport.SetTableView(Employee);
            TempBlob.CreateOutStream(StatementOutstream);
            if PaySlipReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                BaseImage := Base64Convert.ToBase64(StatementInstream);
                exit(BaseImage);
            end;
            // RecRef.GetTable(Employee);
            // Report.SaveAs(Report::"New Payslipx", '', ReportFormat::Pdf, OutStr, RecRef);
            // FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('payslip_%1.Pdf', Employee."No."), TRUE);
            // TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            // BaseImage := Base64Convert.ToBase64(InStr);
        end;
    end;

    procedure FAWEgenerateP9(employeeNumber: Code[20]; startDate: DateTime; endDate: DateTime) BaseImage: Text
    var
        RecRef: RecordRef;
        Employee: Record "Client Employee Master";

    begin
        TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        Employee.Reset;
        Employee.SetFilter("Company Code", 'Judicial Service Commission');
        if Employee.FindSet then begin
            RecRef.GetTable(Employee);
            Report.SaveAs(Report::"Client P9A", '', ReportFormat::Pdf, OutStr, RecRef);
            FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('P9_%1.Pdf', Employee."No."), TRUE);
            TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
            BaseImage := Base64Convert.ToBase64(InStr);
        end;
    end;

    procedure FAWEgenerateP92(employeeNumber: Code[20]; startDate: DateTime; endDate: DateTime) BaseImage: Text
    var
        RecRef: RecordRef;
        Employee: Record "Client Employee Master";
        ClientP9AReport: Report "Client P9A";
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
    begin
        Employee.Reset;
        Employee.SetRange("No.", employeeNumber);
        Employee.SetRange("Company Code", 'JSC');
        // Employee.SetRange("Starting Date", DT2DATE(startDate));
        // Employee.SetRange("Starting Date", DT2DATE(startDate));
        if Employee.FindSet then begin
            ClientP9AReport.SetPeriod(DT2DATE(startDate), DT2DATE(endDate));
            ClientP9AReport.SetTableView(Employee);
            TempBlob.CreateOutStream(StatementOutstream);
            if ClientP9AReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                BaseImage := Base64Convert.ToBase64(StatementInstream);
                exit(BaseImage);
            end;
        end else begin
            BaseImage := 'Report not found.';
        end;
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
    var
        HRMgt: Codeunit "HR Management";
    begin
        LeaveApplication.Get(DocNo);

        if ApprovalMgtHR.CheckLeaveRequestWorkflowEnabled(LeaveApplication) then
            ApprovalMgtHR.OnSendLeaveRequestApproval(LeaveApplication);
        UpdateApprovalEntries(DocNo, UserID);
        //HRMgt.NotifyLeaveReliever(LeaveApplication."Application No");
        status := 'success*Document has been successfully sent for approval';
    end;


    procedure CancelLeaveApproval(DocNo: Code[50]) status: Text
    begin
        LeaveApplication.Get(DocNo);
        ApprovalMgtHR.OnCancelLeaveRequestApproval(LeaveApplication);
        status := 'success*Document approval cancelled succesfully';
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

    procedure CreateImprestMemo(No: Code[30]; ToWho: Code[50]; employeeNumber: code[10]; subject: Text[2048]; memoBody1: Text[2048]; memoBody2: Text[2048]; Purpose: Text[2048]; location: Text[2048]; deaprturelocation: Text[2048]; departureDate: DateTime; returnlocation: Text[2048]; returnDate: DateTime; startDate: DateTime; totaldays: Integer; noOfDaysInField: Integer; international: Boolean; DSA: Boolean; CordinationAllowance: Boolean; FacilitatorAllowance: Boolean; SecritariateAllowance: Boolean; RapporteurAllowance: Boolean; DriverAllowance: Boolean; retreatAllowance: Boolean; expertAllowance: Boolean; AirTicket: Boolean; conference: Boolean; groundTransport: Boolean; accommodation: Boolean; outOfPocket: Boolean; tutorialFee: Boolean; mileageAllowance: Boolean; quarterPerDiem: Boolean; directorate: code[50]; department: code[50]) status: Text
    var
        glsetup: Record "General Ledger Setup";
        Staff: Record Employee;
        Staff2: Record Employee;
    begin
        CashMgt.Get();
        Staff.Get(employeeNumber);
        if No <> '' then begin
            memo.Get(No);
            memo.Date := Today;
            memo.From := Staff."Job Id";
            memo.Validate(From);
            memo."To" := ToWho;
            memo.Validate("To");
            memo.Subject := subject;
            memo."Message body" := memoBody1;
            memo."Message body 1" := memoBody2;
            // memo.Memo := memoBody1;
            memo."Employee No." := employeeNumber;
            memo.Purpose := Purpose;
            memo."Activity Location" := location;
            memo."Created By" := 'ADMINCLOUD';
            memo."Departure Location" := deaprturelocation;
            memo."Return Location" := returnlocation;
            memo."Departure Date" := DT2Date(departureDate);
            memo.Validate("Departure Date");
            memo."Start Date" := DT2Date(startDate);
            memo.Validate("Start Date");
            memo."Return Date" := DT2Date(returnDate);
            memo.Validate("Return Date");
            memo."Total Days in the Field" := totaldays;
            memo.Validate("Total Days in the Field");
            //memo."Total Days in the Field" := noOfDaysInField;
            memo.International := international;
            memo.DSA := DSA;
            memo."Cordination Allowance" := CordinationAllowance;
            memo."Facilitator Allowance" := FacilitatorAllowance;
            memo."Secretariat Allowance" := SecritariateAllowance;
            memo."Rapporteur Allowance" := RapporteurAllowance;
            memo."Driver Allowance" := DriverAllowance;
            memo."Retreat Allowance" := retreatAllowance;
            memo."Expert Allowance" := expertAllowance;
            memo."Air Ticket" := AirTicket;
            memo.Conference := conference;
            memo."Ground Transport" := groundTransport;
            memo.Accomodation := accommodation;
            memo."Out of Pocket Allowance" := outOfPocket;
            memo."Tuition Fee" := tutorialFee;
            memo."Mileage Allowance" := mileageAllowance;
            memo."Quarter Per Diem" := quarterPerDiem;
            Staff.Get(employeeNumber);
            memo.From := Staff."Job Id";
            memo."Sender Name" := Staff."Job Title";
            memo."Sender Email" := Staff."Company E-Mail";
            memo."Global Dimension 1 Code" := directorate;
            memo."Global Dimension 2 Code" := department;
            memo.Status := memo.Status::Open;
            if memo.modify(true) then begin
                Staff2.Get(ToWho);
                memo.From := Staff."Job Id";
                memo."To" := ToWho;
                memo.Validate("To");
                memo."Sender Name" := Staff."Job Title";
                memo."Sender Email" := Staff."Company E-Mail";
                memo."Recipient Name" := Staff2."Job Title";
                memo."Recipient Email" := Staff2."Company E-Mail";
                status := 'success*Memo has been modified succesfully*' + memo."No.";
            end else begin
                status := 'danger*An error occured while modifying your memo';
            end;
        end else begin
            memo.Init();
            //NoSeriesMgt.InitSeries(glsetup."ERC Memo Nos", memo."Memo No", 0D, memo."Memo No", memo."No. Series");
            //memo."Memo No" := NoSeriesMgt.DoGetNextNo(glsetup."ERC Memo Nos", Today, true, true);
            memo.Date := Today;
            memo.From := Staff."Job Id";
            memo.Validate(From);
            //memo.To := From;
            memo.Subject := subject;
            memo."Message body" := memoBody1;
            memo."Message body 1" := memoBody2;
            // memo.Memo := memoBody1;
            memo."Employee No." := employeeNumber;
            memo.Purpose := Purpose;
            memo."Activity Location" := location;
            memo."Created By" := 'ADMINCLOUD';
            memo."Departure Location" := deaprturelocation;
            memo."Return Location" := returnlocation;
            memo."Departure Date" := DT2Date(departureDate);
            memo.Validate("Departure Date");
            memo."Start Date" := DT2Date(startDate);
            memo.Validate("Start Date");
            memo."Return Date" := DT2Date(returnDate);
            memo.Validate("Return Date");
            memo."Total Days in the Field" := totaldays;
            memo.Validate("Total Days in the Field");
            //memo."Total Days in the Field" := noOfDaysInField;
            memo.International := international;
            memo.DSA := DSA;
            memo."Cordination Allowance" := CordinationAllowance;
            memo."Facilitator Allowance" := FacilitatorAllowance;
            memo."Secretariat Allowance" := SecritariateAllowance;
            memo."Rapporteur Allowance" := RapporteurAllowance;
            memo."Driver Allowance" := DriverAllowance;
            memo."Retreat Allowance" := retreatAllowance;
            memo."Expert Allowance" := expertAllowance;
            memo."Air Ticket" := AirTicket;
            memo.Conference := conference;
            memo."Ground Transport" := groundTransport;
            memo.Accomodation := accommodation;
            memo."Out of Pocket Allowance" := outOfPocket;
            memo."Tuition Fee" := tutorialFee;
            memo."Mileage Allowance" := mileageAllowance;
            memo."Quarter Per Diem" := quarterPerDiem;
            memo."Global Dimension 1 Code" := directorate;
            memo."Global Dimension 2 Code" := department;
            memo.Status := memo.Status::Open;
            If memo.Insert(true) then begin
                Staff2.Get(ToWho);
                memo.From := Staff."Job Id";
                memo."To" := ToWho;
                memo.Validate("To");
                memo."Sender Name" := Staff."Job Title";
                memo."Sender Email" := Staff."Company E-Mail";
                memo."Recipient Name" := Staff2."Job Title";
                memo."Recipient Email" := Staff2."Company E-Mail";
                memo.modify(true);
                status := 'success*Memo has been created succesfully*' + memo."No.";
            end else begin
                status := 'danger*An error occured while creating your  Memo';
            end;
        end;
    end;

    procedure CreateImprestMemoLines(imprestno: Code[30]; type: Integer; accountNo: code[50]; otherCosts: Decimal; expertName: Text;expertEmail: Text; DSA: Decimal; airTicket: Decimal; conference: Decimal; groundTransport: Decimal; accommodation: Decimal; coordinationAllowance: Decimal; facillitatorAllowance: Decimal; secretarioteAllowance: Decimal; outOfPocketAllowance: Decimal; rapparteurAllowance: Decimal; driverAllowance: Decimal; retreatAllowance: Decimal; expertAllowance: Decimal; tuitionFee: Decimal; millageAllowance: Decimal; quarterperDiem: Decimal) status: Text
    var
        memolines1: Record "Imprest Memo Lines";
        prevLineNo: Integer;
    begin
        if memo.Get(imprestno) then begin
            memoLines.Init();
            memolines1.Reset();
            memolines1.setrange("No.", imprestno);
            If memolines1.FindLast() then
                prevLineNo := memolines1."Line No." + 1000
            else
                prevLineNo := 1000;
            memolines."No." := imprestno;
            memoLines."Line No." := prevLineNo;
            memoLines.Type := type;
            if (type = 0) then begin
                memoLines."Account No." := accountNo;
                memoLines.Validate("Account No.");
            end else begin
                memoLines.Name := expertName;
                memoLines.Name := expertEmail;
            end;
            memoLines."Other Costs" := otherCosts;

            memoLines.DSA := DSA;

            memoLines."Air Ticket" := airTicket;

            memoLines.Conference := conference;

            memoLines."Ground Transport" := groundTransport;

            memoLines.Accomodation := accommodation;

            memoLines."Cordination Allowance" := coordinationAllowance;

            memoLines."Facilitator Allowance" := facillitatorAllowance;

            memoLines."Secretariat Allowance" := secretarioteAllowance;

            memoLines."Out of Pocket Allowance" := outOfPocketAllowance;

            memoLines."Rapporteur Allowance" := rapparteurAllowance;

            memoLines."Driver Allowance" := driverAllowance;

            memoLines."Retreat Allowance" := retreatAllowance;

            memoLines."Expert Allowance" := expertAllowance;

            memoLines."Tuition Fee" := tuitionFee;

            memoLines."Mileage Allowance" := millageAllowance;

            memoLines."Quarter Per Diem" := quarterperDiem;
            //compute totals
            memoLines.Amount := memoLines.DSA + memoLines."Air Ticket" + memoLines.Conference + memoLines."Ground Transport" + memoLines.Accomodation + memoLines."Cordination Allowance" + memoLines."Facilitator Allowance" + memoLines."Secretariat Allowance" + memoLines."Out of Pocket Allowance" + memoLines."Rapporteur Allowance" + memoLines."Driver Allowance" + memoLines."Retreat Allowance" + memoLines."Expert Allowance" + memoLines."Tuition Fee" + memoLines."Mileage Allowance" + memoLines."Quarter Per Diem";

            if memoLines.Insert(true) then begin
                status := 'success*Memo Line has been added succesfully' + Format(memolines."Line No.");
            end else begin
                status := 'danger*An error occured while submitting your Memo Line' + Format(memolines."Line No.");
            end;
        end;
    end;

    procedure DeleteImprestMemoLines(No: Code[30]; LineNo: Integer) status: Text
    var
    begin
        memoLines.Reset();
        memoLines.SetRange("No.", No);
        memoLines.SetRange("Line No.", LineNo);
        if memoLines.FindFirst then begin
            If memoLines.Delete() THEn begin
                status := 'success*Imprest memo Line has been deleted succesfully';
            end else begin
                status := 'danger*An error occured while deleting your Imprest memo Line';
            end;
        end;
    end;

    procedure SendImprestMemoApproval(DocNo: Code[50]) Status: Text
    var
        ApprovalsMngt: Codeunit "Approvals Mgmt. Ext";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        memo.Get(DocNo);

        ApprovalsMngt.OnSendImprestMemoForApproval(memo);
        UserSetup.SetRange("Employee No.", memo."Employee No.");
        if UserSetup.FindFirst() then begin
            UpdateApprovalEntries(DocNo, UserSetup."User ID");
        end;
        Commit();
        memo1.Get(DocNo);
        memo1.Status := memo1.Status::"Pending Approval";
        memo1.Modify(true);

        status := 'success*Imprest memo has been has been succesfully sent for approval.';
    end;

    procedure CancelImprestMemoApproval(DocNo: Code[50]) Status: Text
    var
        ApprovalsMngt: Codeunit "Approvals Mgmt. Ext";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        memo.Get(DocNo);

        ApprovalsMngt.OnCancelImprestMemoApprovalRequest(memo);
        Commit();
        memo1.Get(DocNo);
        memo1.Status := memo1.Status::Open;
        memo1.Modify(true);
        status := 'success*Imprest Memo Request approval request has been successfully cancelled.';
    end;

    procedure CreateImprestRequisition(No: Code[30]; AccountNo: Code[30]; activity: Code[100]; department: code[100]; TravelType: Integer; Purpose: Text[2048]; Destination: Text[250]; TravelDate: DateTime; ReturnDate: DateTime; Cashier: Code[30]) status: Text
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
            ImprestHeader."Shortcut Dimension 1 Code" := CopyStr(activity, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 1 Code"));
            ImprestHeader."Shortcut Dimension 2 Code" := CopyStr(department, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 2 Code"));
            ImprestHeader."Travel Type" := TravelType;
            // ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
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
            // ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Imprest Nos", Today, true, true);
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
            ImprestHeader."Shortcut Dimension 1 Code" := CopyStr(activity, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 1 Code"));
            ImprestHeader."Shortcut Dimension 2 Code" := CopyStr(department, 1, MaxStrLen(ImprestHeader."Shortcut Dimension 2 Code"));
            ImprestHeader."Travel Type" := TravelType;
            // ImprestHeader.Currency := CopyStr(Currency, 1, MaxStrLen(ImprestHeader.Currency));
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

    procedure CreateImprestRequisitionLines(imprestno: Code[30]; ImprestType: Code[50]) status: Text
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
            // ImprestLines."No of Days" := noOfDays;
            // ImprestLines.Validate("No of Days");
            // ImprestLines."Daily Rate" := DailyRate;
            // ImprestLines.Validate("Daily Rate");
            // ImprestLines."No of Days" := ImprestHeader."No of Days";
            // ImprestLines.Validate("No of Days");
            // ImprestLines.Destination := ImprestHeader.Destination;
            // ImprestLines."Shortcut Dimension 1 Code" := Dim1;
            // ImprestLines."Shortcut Dimension 2 Code" := Dim2;
            // ImprestLines.ValidateShortcutDimCode(3, Dim3);
            // ImprestLines.ValidateShortcutDimCode(4, Dim4);
            // ImprestLines.ValidateShortcutDimCode(5, Dim5);
            // ImprestLines.ValidateShortcutDimCode(6, Dim6);
            // ImprestLines.ValidateShortcutDimCode(7, Dim7);
            if ImprestLines.Insert(true) then begin
                ImprestLines."Expenditure Type" := ImprestType;
                ImprestLines.Validate("Expenditure Type");
                // ImprestLines."No of Days" := noOfDays;
                // ImprestLines.Validate("No of Days");
                // ImprestLines."Daily Rate" := DailyRate;
                // ImprestLines.Validate("Daily Rate");
                ImprestLines.Modify();
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
    var
        ApprovalsMgmt1: Codeunit "Approval Mgt Finance Ext";
        Committment1: Codeunit "Commitments Mgt Finance";
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
                            rtn := 'success*Document has been successfully sent for approval';
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
                            rtn := 'success*Document has been successfully sent for approval';
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
                            rtn := 'success*Document has been successfully sent for approval';
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
                            rtn := 'success*Document has been successfully sent for approval';
                        end;

                    "Payment Type"::"Staff Claim":
                        begin
                            GeneralLedgerSetup.Get();
                            CashManagementSetup.Get();
                            if PaymentsRec."Claim Type" = PaymentsRec."Claim Type"::" " then
                                Error('Please define a claim type');

                            if PaymentsRec."Payment Narration" = '' then
                                Error('Please define the Purpose for this claim');
                            ImprestLines.Reset();
                            ImprestLines.SetRange(ImprestLines.No, PaymentsRec."No.");
                            if ImprestLines.Find('-') then
                                repeat
                                    ImprestLines.TestField("Expenditure Date");
                                    //ClaimLines.TESTFIELD("Claim Receipt No.");
                                    ImprestLines.TestField("Expenditure Description");
                                    if ImprestLines.Amount <= 0 then
                                        Error('One of your lines has an amount less than or equal to 0');
                                until ImprestLines.Next() = 0;
                            Committment.CheckStaffClaimCommittment(PaymentsRec);
                            Committment.StaffClaimCommittment(PaymentsRec, ErrorMsg);
                            if ErrorMsg <> '' then
                                Error(ErrorMsg);
                            PaymentsRec.CalcFields("Petty Cash Amount");
                            if PaymentsRec."Petty Cash Amount" <= 0 then
                                Error('Petty Cash Amount can not be less than or equal to 0');
                            if ApprovalsMgmt1.CheckPaymentsApprovalsWorkflowEnabled(PaymentsRec) then
                                ApprovalsMgmt1.OnSendPaymentsForApproval(PaymentsRec);
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
                            rtn := 'success*Document approval has been cancelled successfully.';
                        end;

                    "Payment Type"::"Imprest Surrender":
                        begin
                            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                            rtn := 'success*Document approval has been cancelled successfully.';
                        end;
                    "Payment Type"::"Petty Cash":
                        begin
                            Committment.CancelPaymentsCommitments(PaymentsRec);
                            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                            rtn := 'success*Document approval has been cancelled successfully.';
                        end;

                    "Payment Type"::"Petty Cash Surrender":
                        begin
                            ApprovalMgt.OnCancelPaymentsApprovalRequest(PaymentsRec);
                            rtn := 'success*Document approval has been cancelled successfully.';
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
            // ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Imprest Surrender Nos", Today, true, true);
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

    procedure CreatePettyCash(No: Code[30]; AccountNo: Code[30]; Donor: Code[100]; Program: code[100]; PettyCashType: Integer; Purpose: Text; Cashier: Code[30]; Currency: Code[30]; EmpNo: Code[30]) status: Text
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
            // ImprestHeader."Pay Mode" := paymode;
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
            // ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Petty Cash Nos", Today, true, true);
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
            // ImprestHeader."Pay Mode" := paymode;
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
                status := 'success*Petty Cash Line has been created succesfully';
            end else begin
                status := 'danger*An error occured while created your Petty Cash';
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
            // ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Petty Cash Surrender Nos", Today, true, true);
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

    procedure CreateStaffClaim(No: Code[30]; AccountNo: Code[30]; Donor: Code[100]; Program: code[100]; claimType: Integer; Purpose: Text; Cashier: Code[30]; Currency: Code[30]; ImprestSurrenderDocNo: Code[30]; EmpNo: Code[30]) status: Text
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
            // ImprestHeader."Pay Mode" := paymode;
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
            // ImprestHeader."No." := NoSeriesMgt.DoGetNextNo(CashMgt."Staff Claim Nos", Today, true, true);
            ImprestHeader.Date := Today;
            ImprestHeader."Time Inserted" := Time;
            ImprestHeader.Cashier := Cashier;
            ImprestHeader."Created By" := Cashier;
            ImprestHeader."User Id" := 'ADMINCLOUD';
            // ImprestHeader."Pay Mode" := paymode;
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

    procedure CreateStaffClaimLines(No: Code[30]; claimType: Code[50]; DailyRate: Decimal; Narration: Text; expendituredate: DateTime; Dim1: Code[50];
    Dim2: Code[50]; Dim3: Code[50]; Dim4: Code[50]; Dim5: Code[50]; Dim6: Code[50]; Dim7: Code[50]) status: Text
    var
        ImprestLines1: Record "Payment Lines";
        prevLineNo: Integer;
    begin
        if ImprestHeader.Get(No) then begin
            ImprestLines.Init();
            ImprestLines."Payment Type" := ImprestLines."Payment Type"::"Staff Claim";
            // ImprestLines1.Reset();
            // ImprestLines1.setrange(No, No);
            // If ImprestLines1.FindLast() then
            //     prevLineNo := ImprestLines1."Line No" + 1000
            // else
            //     prevLineNo := 1000;
            // ImprestLines."Line No" := prevLineNo;
            ImprestLines.No := No;
            ImprestLines.Description := Narration;
            ImprestLines."Expenditure Type" := claimType;
            ImprestLines.Validate("Expenditure Type");
            ImprestLines."Expenditure Date" := DT2Date(expendituredate);
            ImprestLines."Expenditure Description" := Narration;
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

    procedure CreateTrainingRequest(No: Code[30]; EmpNo: Code[30]; sourceDocumentNo: Text; needSource: integer; jobFunction: Text[1000]; currentEmployeeSkills: Text[1000]; missingCompetencies: Text[1000]; requiredSkills: Text[1000]; commentsByDepartment: Text[1000]) status: Text
    var
        EmpRec: Record "Employee Master";
        TrainingSetup: Record "QuantumJumps HR Setup";
    begin
        CashMgt.Get();
        HrEmployees.Get(EmpNo);
        if No <> '' then begin
            TrainingRequest.Reset();
            TrainingRequest.SetRange("No.", No);
            if TrainingRequest.FindFirst() then begin
                TrainingRequest.Date := Today;
                TrainingRequest."Source Document No" := sourceDocumentNo;
                TrainingRequest."Need Source" := needSource;
                TrainingRequest."Employee No" := EmpNo;
                TrainingRequest.Validate("Employee No");
                TrainingRequest."Job Function" := jobFunction;
                TrainingRequest."Current Employee Skills" := currentEmployeeSkills;
                TrainingRequest."Missing Competencies" := missingCompetencies;
                TrainingRequest."Required Skills" := requiredSkills;
                TrainingRequest.Comments1 := commentsByDepartment;
                TrainingRequest.Status := TrainingRequest.Status::Open;
                if EmpRec.Get(EmpNo) then begin
                    TrainingRequest."Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                    TrainingRequest."Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                    TrainingRequest."Global Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
                end;
                TrainingRequest."Job Title" := HrEmployees."Job Title";
                TrainingRequest."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Last Name";
                if TrainingRequest.Modify(true) then begin
                    status := 'success*Training request has been modified succesfully*' + TrainingRequest."No.";
                end else begin
                    status := 'danger*An error occured while submitting your Training request';
                end;
            end else begin
                status := 'danger*Document could not be found';
            end;
        end else begin
            TrainingRequest.Init();
            TrainingSetup.Get;
            TrainingSetup.TestField("Training Nos.");
            // NoSeriesMgt.InitSeries(TrainingSetup."Training Nos.", TrainingRequest."No. Series", 0D, TrainingRequest."No.", TrainingRequest."No. Series");
            TrainingRequest."Required Hours" := TrainingSetup."Training Hours per Year";
            TrainingRequest.Date := Today;
            TrainingRequest."Employee No" := EmpNo;
            TrainingRequest."Source Document No" := sourceDocumentNo;
            TrainingRequest."Need Source" := needSource;
            TrainingRequest.Validate("Employee No");
            TrainingRequest."Job Function" := jobFunction;
            TrainingRequest."Current Employee Skills" := currentEmployeeSkills;
            TrainingRequest."Missing Competencies" := missingCompetencies;
            TrainingRequest."Required Skills" := requiredSkills;
            TrainingRequest.Comments1 := commentsByDepartment;
            if EmpRec.Get(EmpNo) then begin
                TrainingRequest."Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                TrainingRequest."Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                TrainingRequest."Global Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
            end;
            TrainingRequest."Job Title" := HrEmployees."Job Title";
            TrainingRequest."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Last Name";
            TrainingRequest.Status := TrainingRequest.Status::Open;
            if TrainingRequest.Insert() then begin
                TrainingRequest."Employee No" := EmpNo;
                TrainingRequest.Validate("Employee No");
                if EmpRec.Get(EmpNo) then begin
                    TrainingRequest."Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                    TrainingRequest."Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                    TrainingRequest."Global Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
                end;
                TrainingRequest."Job Title" := HrEmployees."Job Title";
                TrainingRequest."Employee Name" := HrEmployees."First Name" + ' ' + HrEmployees."Last Name";
                TrainingRequest.Modify(true);
                status := 'success*Training request has been modified succesfully*' + TrainingRequest."No.";
            end else begin
                status := 'danger*An error occured while submitting your Training request';
            end;
        end;
    end;

    procedure CreateTrainingRequestLines(No: Code[30]; EmpNo: Code[30]; needCode: Code[30]) status: Text
    var
        lineNo: Integer;
    begin
        TrainingRequestLines.Reset();
        TrainingRequestLines."Employee No." := EmpNo;
        TrainingRequestLines1.Reset();
        TrainingRequestLines1.SetRange("Employee No.", EmpNo);
        if TrainingRequestLines1.FindLast() then
            lineNo := TrainingRequestLines1."Line No." + 1
        else
            lineNo := 1;
        TrainingRequestLines."Line No." := lineNo;
        TrainingRequestLines."Document No." := No;
        TrainingRequestLines.Code := needCode;
        TrainingRequestLines.Validate(Code);
        if TrainingRequestLines.Insert(true) then begin
            status := 'success*Training request line added succesfully.';
        end else begin
            status := 'danger*An error occured while submitting your Training request line';
        end;
    end;

    procedure DeleteTrainingRequestLine(empNo: Code[30]; applicationNo: Code[50]; lineNo: Integer) status: Text
    var

    begin
        TrainingRequestLines.SetRange("Employee No.", EmpNo);
        TrainingRequestLines.SetRange("Line No.", lineNo);
        TrainingRequestLines.SetRange("Document No.", applicationNo);
        if TrainingRequestLines.FindFirst() then
            if TrainingRequestLines.Delete() then begin
                status := 'success*Training request line deleted succesfully.';
            end else begin
                status := 'danger*An error occured while submitting your Training request line';
            end;
    end;

    procedure SendTrainingRequestApproval(DocNo: Code[50]) Status: Text
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt. Ext";

    begin
        TrainingRequest.Reset();
        TrainingRequest.SetRange("No.", DocNo);
        if TrainingRequest.FindFirst() then begin
            ApprovalsMgmt.OnSendTrainingNeedsForApproval(TrainingRequest);
            status := 'success*Training Request has been succesfully sent for approval.';
        end;


    end;

    procedure CancelTrainingRequestApproval(DocNo: Code[50]) Status: Text
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt. Ext";
    begin
        TrainingRequest.Get(DocNo);
        TrainingRequest.Reset();
        TrainingRequest.SetRange("No.", DocNo);
        if TrainingRequest.FindFirst() then begin
            // ApprovalsMgmt.OnCancelTrainingRequestApproval(TrainingRequest);
            status := 'success*Training Request approval request has been successfully cancelled.';
        end;

    end;

    procedure fnInsertPortalAttachments(DocumentNo: Code[100]; Description: Text; Url: Text; Type: Text) status: Text
    var

    begin
        PortalUploads.INIT;
        PortalUploads."Application No" := DocumentNo;
        PortalUploads.Description := Description;
        PortalUploads.LocalUrl := Url;
        PortalUploads.Uploaded := TRUE;
        PortalUploads.Fetch_To_Sharepoint := TRUE;
        PortalUploads.Base_URL := 'https://jscgoke.sharepoint.com/sites/jscportals/ERP%20Documents/JSC' + '/' + Type + '/';
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

    procedure FAWEaddImprestMemoSharepointLinks(imprestno: Code[50]; filename: Text; sharepointlink: Text) status: Text
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
            memo.Reset;
            memo.setrange("No.", imprestno);
            if memo.Find('=') then
                RecordIDNumber := memo.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(imprestno, filename, sharepointlink, 'Memo');
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

    procedure FAWEgenerateMemoReport(employeeNumber: Code[20]; docNo: Text) BaseImage: Text
    var
        ImprestMemo: Record "Imprest Memo Header";
        ImprestMemoReport: Report "Memo Report";
        // ImprestMemoReport1: Report "Imprest Memo";
        RecRef: RecordRef;
        Filename: Text[100];
        TempBlob: Codeunit "Temp Blob";
        StatementOutstream: OutStream;
        StatementInstream: InStream;
        Base64Convert: Codeunit "Base64 Convert";
    begin

        // Employee.RESET;
        // Employee.SETRANGE(Employee."No.", employeeNumber);
        // IF Employee.FINDSET THEN BEGIN
        //     TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
        //     ImprestMemo.Reset;
        //     ImprestMemo.SetRange("No.", docNo);
        //     if ImprestMemo.FindFirst() then begin
        //         RecRef.GetTable(ImprestMemo);
        //         Report.SaveAs(Report::"Imprest Memo", '', ReportFormat::Pdf, OutStr, RecRef);
        //         FileManagement_lCdu.BLOBExport(TempBlob_lRec, STRSUBSTNO('ImprestMemo_%1.Pdf', ImprestMemo."No."), TRUE);
        //         TempBlob_lRec.CreateInstream(InStr, TEXTENCODING::UTF8);
        //         BaseImage := Base64Convert.ToBase64(InStr);
        //     end;
        // END;

        ImprestMemo.Reset();
        ImprestMemo.SetRange("No.", docNo);

        if ImprestMemo.FindFirst() then begin
            ImprestMemoReport.SetTableView(ImprestMemo);
            TempBlob.CreateOutStream(StatementOutstream);
            if ImprestMemoReport.SaveAs('', ReportFormat::Pdf, StatementOutstream) then begin
                TempBlob.CreateInStream(StatementInstream);
                BaseImage := Base64Convert.ToBase64(StatementInstream);
                exit(BaseImage);
            end;

        end;
    end;

    //     FileManagement_lCdu.BLOBExport(
    //         TempBlob_lRec,
    //         StrSubstNo('ImprestMemo_%1.pdf', ImprestMemo."No."),
    //         true
    //     );

    //     TempBlob_lRec.CreateInStream(InStr, TEXTENCODING::UTF8);
    //     BaseImage := Base64Convert.ToBase64(InStr);
    // end;

    // end;

    procedure FAWEgenerateImprestMemoExpenditure(employeeNumber: Code[20]; docNo: Text) BaseImage: Text
    var
        ImprestMemo: Record "Imprest Memo Header";
    begin

        Employee.RESET;
        Employee.SETRANGE(Employee."No.", employeeNumber);
        IF Employee.FINDSET THEN BEGIN
            TempBlob_lRec.CreateOutStream(OutStr, TEXTENCODING::UTF8);
            ImprestMemo.Reset;
            ImprestMemo.SetRange("No.", docNo);
            if ImprestMemo.FindSet then begin
                RecRef.GetTable(ImprestMemo);
                Report.SaveAs(Report::"Expenditure Requisition Form", '', ReportFormat::Pdf, OutStr, RecRef);
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
            // Report.SaveAs(Report::"Petty Cash Voucher", '', ReportFormat::Pdf, OutStr, RecRef);
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

    procedure FAWEaddAppraisalSharepointLinks(imprestno: Code[50]; filename: Text; sharepointlink: Text) status: Text
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
            employeeAppraisal.Reset;
            employeeAppraisal.setrange("Appraisal No", imprestno);
            if employeeAppraisal.Find('=') then
                RecordIDNumber := employeeAppraisal.RecordId;
            RecordLink."Record ID" := RecordIDNumber;
            if RecordLink.Insert(true) then begin
                fnInsertPortalAttachments(imprestno, filename, sharepointlink, 'Employee Appraisal');
                status := 'success*Link successfully created';
            end else begin
                status := 'error*An error occured during the process of creating link';
            end
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
