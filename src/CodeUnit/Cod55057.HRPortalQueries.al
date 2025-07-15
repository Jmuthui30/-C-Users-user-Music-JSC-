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
        // Filter to the same dimensions used in the FlowField.
        EmployeeLeaves.SetRange("Staff No.", EmpNo);
        EmployeeLeaves.SetRange("Leave Type", LeaveCode);
        EmployeeLeaves.SetRange(Closed, false);

        // Ask the DB‑server to sum the field, just like the FlowField does.
        EmployeeLeaves.CalcSums("No. of days");
        LeaveBalance := EmployeeLeaves."No. of days";
        // if HrEmployees.Get(EmpNo) then begin
        //     EmployeeLeaves.Reset;
        //     EmployeeLeaves.SetRange("Staff No.", EmpNo);
        //     EmployeeLeaves.SetRange("Leave Type", LeaveCode);
        //     EmployeeLeaves.SetRange(Closed, false);

        //     if EmployeeLeaves.FindSet() then begin
        //         repeat
        //             TotalLeaveDays += EmployeeLeaves."No. of days";
        //         until EmployeeLeaves.Next() = 0;
        //     end;

        //     LeaveBalance := TotalLeaveDays;
        //     exit(LeaveBalance);
        // end;
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

    procedure DetermineLeaveReturnDate(startDate: DateTime; DaysApplied: Decimal; LeaveCode: Code[30]; EmpNo: Code[20]) status: Text
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
        ReturnDate: Date;
        ResumptionDate: Date;
        LeaveLedger: Record "HR Leave Ledger Entries";
        HumanResSetup: Record "Human Resources Setup";
        HRMgt: Codeunit "HR Management";
        AccPeriod: Record "Payroll Period";
        FiscalStart: Date;
        LeaveEntitlement: Decimal;
        LeaveEntitlementRec: Record "Leave Entitlement Entry";
        LeaveTypeRec: Record "Leave Type";
        DaysEarnedPerMonth: Decimal;
        leaveBalave: Decimal;
    begin

        begin

            HumanResSetup.Get();
            // HumanResSetup.TestField(HumanResSetup."Default Base Calendar");

            //Get employee base calendar
            EmployeeRec.Get(EmpNo);
            if EmployeeRec."Base Calendar" <> '' then
                BaseCalenderCode := EmployeeRec."Base Calendar";
            // else
            //     BaseCalenderCode := HumanResSetup."Base Calender Code";

            NoOfWorkingDays := 0;
            if DaysApplied <> 0 then
                if DT2Date(startDate) <> 0D then begin
                    NextWorkingDate := DT2Date(startDate);
                    repeat
                        if not HRmgt.CheckNonWorkingDay(BaseCalenderCode, NextWorkingDate, Description) then
                            NoOfWorkingDays := NoOfWorkingDays + 1;

                        // Message(' NoOfWorkingDays is %1..NextWorkingDate%2', NoOfWorkingDays, NextWorkingDate);
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

                    EndDate := NextWorkingDate - 1;
                    ResumptionDate := NextWorkingDate;
                    Message('enddate is %1', ResumptionDate);
                end;

            //check if the date that the person is supposed to report back is a working day or not
            //get base calendar to use
            NonWorkingDay := false;
            if DT2Date(startDate) <> 0D then
                while NonWorkingDay = false
                  do begin
                    //NonWorkingDay := HRmgt.CheckNonWorkingDay(HumanResSetup."Default Base Calendar", "Resumption Date", Dsptn);
                    if NonWorkingDay then begin
                        NonWorkingDay := false;
                        ResumptionDate := CalcDate('1D', ResumptionDate);
                    end
                    else
                        NonWorkingDay := true;
                end;

            AccPeriod.Reset();
            AccPeriod.SetRange("Starting Date", 0D, Today);
            AccPeriod.SetRange("New Fiscal Year", true);
            if AccPeriod.Find('+') then begin
                FiscalStart := AccPeriod."Starting Date";
                MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;
            end;

            LeaveEntitlement := 0;
            DaysEarnedPerMonth := 0;

            EmployeeRec.TestField("Country/Region Code");
            LeaveTypes.Get(LeaveCode);

            LeaveEntitlementRec.Reset();
            LeaveEntitlementRec.SetRange("Leave Type Code", LeaveTypes.Code);
            LeaveEntitlementRec.SetRange("Employee Category", EmployeeRec."Employee Category");
            LeaveEntitlementRec.SetRange("Country/Region Code", EmployeeRec."Country/Region Code");
            if LeaveEntitlementRec.FindFirst() then begin
                LeaveEntitlement := LeaveEntitlementRec.Days;
                if LeaveTypeRec."Earn Days" then begin
                    LeaveEntitlementRec.TestField("Days Earned per Month");
                    DaysEarnedPerMonth := LeaveEntitlementRec."Days Earned per Month";
                end;
            end;
            leaveBalave := CheckLeaveDaysAvailable(EmployeeRec."No.", 'ANNUAL');

            status := Format(EndDate) + '*' + Format(ResumptionDate) + '*' + Format(LeaveEntitlement)
+ '*' + Format(leaveBalave)

        end;


    end;
}
