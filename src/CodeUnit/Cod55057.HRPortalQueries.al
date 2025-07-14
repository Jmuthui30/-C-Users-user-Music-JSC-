codeunit 55057 HRPortalQueries
{
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

        FileManagement_lCdu: Codeunit "File Management";
        Base64Convert: Codeunit "Base64 Convert";
        tbl_leaveTypes: Record "Leave Type";
        tbl_approvalCommentLine: Record "Approval Comment Line";
        tbl_approvalEntry: Record "Approval Entry";
        destination: Record Destination;
        tbl_payments: Record payments;


    procedure FAWEloginUser(empNumber: Code[30]; password: Text) data: Text
    var
        sunsurrImprest: Decimal;
    begin
        HRPortalUsers.Reset();
        HRPortalUsers.SetRange(employeeNo, empNumber);
        HRPortalUsers.SetRange(password, password);
        HRPortalUsers.Reset();
        Employee.SetRange("No.", empNumber);
        if HRPortalUsers.FindSet() and Employee.FindSet() then begin

            data := 'success****' + Employee."Search Name" + '****' + Employee."Social Security No." + '****' + Format(Employee.Gender) + '****'
            + HRPortalUsers.employeeNo + '****' + HRPortalUsers.password + '****' + Format(HRPortalUsers.changedPassword) + '****'
            + Format(Employee."Company E-Mail") + '****' + Employee."Global Dimension 1 Code" + '****' + Employee."Global Dimension 2 Code" + '****' + Employee."Mobile Phone No." + '****' + Format(sunsurrImprest);
        end;
        exit(data);
    end;

    procedure FAWEfnGetEmployeeDetail(empNumber: Code[30]) data: Text
    var
        leaveBalave: Decimal;
    begin
        Employee.Reset();
        Employee.SetRange("No.", empNumber);
        if Employee.FindSet() then begin
            repeat
                leaveBalave := CheckLeaveDaysAvailable(empNumber, 'ANNUAL');
                data += Employee."Company E-Mail" + '*' + Employee."Phone No." + '*' + Employee."Social Security No." + '*' + Format(Employee.Gender) + '*' + Format(Employee."Imprest Account") + '*' + Format(leaveBalave) + '::::';
            until Employee.Next() = 0;
        end;
        Exit(data);
    end;

    procedure FAWEfnGetEmployees() data: Text
    begin
        Employee.Reset();
        repeat
            data += Employee."No." + '*' + Format(Employee."Employee Posting Group") + '*' + Format(Employee."First Name") + '*' + Format(Employee."Last Name") + '*' + Format(Employee."Job Title") + '::::';
        until Employee.Next = 0;
        exit(data);
    end;

    procedure FAWEfnGetLeaveTypes() data: Text
    begin
        tbl_leaveTypes.Reset();
        repeat
            data += Format(tbl_leaveTypes.Gender) + '*' + Format(tbl_leaveTypes.Code) + '*' + Format(tbl_leaveTypes.Description) + '*' + Format(tbl_leaveTypes.Days) + '::::';
        until tbl_leaveTypes.Next = 0;
        exit(data);

    end;



    procedure FAWEfnGetApprovalEntry(docNumber: Code[30]) data: Text
    begin
        tbl_approvalEntry.Reset();
        tbl_approvalEntry.SetRange("Document No.", docNumber);
        if tbl_approvalEntry.FindSet(true) then begin
            repeat
                tbl_approvalEntry.calcfields(Comment);
                data += Format(tbl_approvalEntry."Sequence No.") + '*' + Format(tbl_approvalEntry.Status) + '*' + Format(tbl_approvalEntry."Sender ID") + '*' + Format(tbl_approvalEntry."Approver ID") + '*' + Format(tbl_approvalEntry.Amount) + '*' + Format(tbl_approvalEntry."Due Date") + '*' + Format(tbl_approvalEntry."Date-Time Sent for Approval") + '*' + format(tbl_approvalEntry.Comment) + '*' + Format(tbl_approvalEntry."Table ID") + '*' + Format(tbl_approvalEntry."Record ID to Approve") + '*' + tbl_approvalEntry."Workflow Step Instance ID" + '::::';
            until tbl_approvalEntry.Next = 0;
        end;
        exit(data);
    end;

    procedure FAWEfnGetApprovalCommentLine(tableId: Integer; recordToApprove: RecordId) data: Text
    begin
        tbl_approvalCommentLine.Reset();
        tbl_approvalCommentLine.SetRange("Table ID", tableId);
        tbl_approvalCommentLine.SetRange("Record ID to Approve", recordToApprove);
        if tbl_approvalCommentLine.FindSet(true) then begin
            repeat
                data += tbl_approvalCommentLine.Comment + '*' + Format(tbl_approvalCommentLine."User ID") + '*' + Format(tbl_approvalCommentLine."Date and Time") + '::::';
            until tbl_approvalCommentLine.Next = 0;
        end;
        Exit(data);

    end;

    procedure FAWEfnGetDestinations() data: Text
    begin
        destination.Reset();
        if destination.FindSet() then begin
            repeat
                data += destination."Destination Code" + '*' + Format(destination."Destination Name") + '::::';
            until destination.Next = 0;
        end;
        Exit(data);

    end;

    procedure FAWEfnGetImprestLines(imprestNumber: Code[30]) data: Text
    var
        tbl_imprestLines: Record "Payment Lines";
    begin
        tbl_imprestLines.Reset();
        tbl_imprestLines.SetRange(No, imprestNumber);
        if tbl_imprestLines.FindSet(true) then begin
            repeat
                data := data + tbl_imprestLines.Purpose + '*' + Format(tbl_imprestLines."Daily Rate") + '*' + Format(tbl_imprestLines."Daily Rate") + '*' + Format(tbl_imprestLines.Amount) + '*' + Format(tbl_imprestLines."Line No") + '*' + Format(tbl_imprestLines."Actual Spent") + '::::';
            until tbl_imprestLines.Next = 0;
        end;
        exit(data);
    end;

    procedure FAWEfnGetPettyCashLines(lineNumber: Code[20]) data: Text
    var
        PettySurrender: Record "Payment Lines";
    begin
        PettySurrender.Reset();
        PettySurrender.SetRange(No, lineNumber);
        if PettySurrender.FindSet(true) then begin
            repeat
                data += Format(PettySurrender."Account Type") + '*' + Format(PettySurrender."Account No") + '*' + PettySurrender."Account Name" + '*' + Format(PettySurrender.Amount) + '*' + Format(PettySurrender."Line No") + '*' + Format(PettySurrender."Actual Spent") + '*' + Format(PettySurrender."Remaining Amount") + '*' + PettySurrender.Description + '*' + Format(PettySurrender."Line No") + '*' + Format(PettySurrender."Line No") + '*' + Format(PettySurrender.Amount) + '::::';
            until PettySurrender.Next = 0;
        end;
        Exit(data);
    end;

    // procedure FAWEfnGetReceipts(employeeNo: Code[20]) data: Text
    // begin
    //     tbl_receiptsHeader.Reset();
    //     tbl_receiptsHeader.SetRange("Employee No", employeeNo);
    //     if tbl_receiptsHeader.FindSet(true) then begin
    //         repeat
    //             data += Format(tbl_receiptsHeader.Posted) + '*' + Format(tbl_receiptsHeader."Fully Allocated") + '*' + Format(tbl_receiptsHeader."Fully Allocated Imprest") + '*' + Format(tbl_receiptsHeader."No.") + '*' + Format(tbl_receiptsHeader."Being Payment of") + '*' + Format(tbl_receiptsHeader."On Behalf Of") + '::::';
    //         until tbl_receiptsHeader.Next = 0;
    //     end;
    //     exit(data);

    // end;
    procedure FAWEfnGetImprestToSurrender(empNo: Code[20]) data: Text
    begin
        tbl_payments.Reset();
        tbl_payments.SetRange("Account No.", empNo);
        tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::Imprest);
        tbl_payments.SetRange(Posted, true);
        tbl_payments.SetRange(Surrendered, false);
        if tbl_payments.FindSet() then begin
            repeat
                data += tbl_payments."No." + '*' + tbl_payments."Payment Narration" + '::::';
            until tbl_payments.Next = 0;

        end;

    end;

    procedure FAWEfnGetPettyCashToSurrender(empNo: Code[20]) data: Text
    begin
        tbl_payments.Reset();
        tbl_payments.SetRange("Account No.", empNo);
        tbl_payments.SetRange("Payment Type", tbl_payments."Payment Type"::"Petty Cash");
        tbl_payments.SetRange(Status, tbl_payments.Status::Released);
        tbl_payments.SetRange(Posted, true);
        tbl_payments.SetRange(Surrendered, false);
        //tbl_payments.SetRange(Reversed, False);
        if tbl_payments.FindSet(true) then begin
            repeat
                data := data + tbl_payments."No." + '*' + Format(tbl_payments."Payment Narration") + '*' + Format(tbl_payments."Payment Narration") + '::::';
            until tbl_payments.Next = 0;
        end;
        exit(data)

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
}
