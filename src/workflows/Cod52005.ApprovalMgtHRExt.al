codeunit 52005 "Approval Mgt HR Ext"

{
    Permissions = tabledata "Approval Entry" = rm;

    var
        WorkflowEventHandling: Codeunit "Wkfl Event Handle HR Ext";
        WorkFlowManagement: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No approval workflow for this record type is enabled.';

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnAfterCreateApprovalRequestForApproverChain', '', false, false)]
    // local procedure OnAfterCreateApprovalRequestForApproverChain(var ApprovalEntryArgument: Record "Approval Entry"; var ApproverId: Code[50]; var WorkflowStepArgument: Record "Workflow Step Argument"; var UserSetup: Record "User Setup"; var SufficientApproverOnly: Boolean)
    // var
    //     HRMgmt: Codeunit "HR Management";
    // begin
    //     if ApprovalEntryArgument.Status <> ApprovalEntryArgument.Status::Open then
    //         exit;

    //     if ApproverId = '' then
    //         exit;
    //     // Notify approver of approval request
    //     // if SufficientApproverOnly then
    //     //     exit;

    //     HRMgmt.NotifyApproverByEmail(ApprovalEntryArgument);

    // end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        LeaveRecall: Record "Employee Off/Holiday";

        LeaveRequest: Record "Leave Application";
        LeaveAdj: Record "Leave Bal Adjustment Header";

        RecruitmentRequest: Record "Recruitment Needs";

        Employee: Record Employee;
        NewEmployeeAppraisal: Record "Employee Appraisal";
        StaffAppraisalApprovalLbl: Label 'Staff Appraisal-%1 for the Period between %2 - %3', Comment = '%1 = Employee Name, %2 = Period Start, %3 = Period End';
    begin
        case RecRef.Number of
            //Travel Requests

            //Leave Application
            Database::"Leave Application":
                begin
                    RecRef.SetTable(LeaveRequest);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LeaveApplication;
                    ApprovalEntryArgument."Document No." := LeaveRequest."Application No";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;
            //Recruitment
            Database::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentRequest);
                    // ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::Recruitment;
                    ApprovalEntryArgument."Document No." := RecruitmentRequest."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;


            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    RecRef.SetTable(LeaveRecall);
                    // ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Leave Recall";
                    ApprovalEntryArgument."Document No." := LeaveRecall."No.";
                    ApprovalEntryArgument."Salespers./Purch. Code" := '';
                end;

            //Payroll Request

            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdj);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::LeaveAdjustment;
                    ApprovalEntryArgument."Document No." := LeaveAdj.Code;
                    //  ApprovalEntryArgument.Description := 'Leave Adjustment';
                end;

            //New Emp Appraisal
            Database::"Employee Appraisal":
                begin
                    RecRef.SetTable(NewEmployeeAppraisal);
                    ApprovalEntryArgument."Document Type" := ApprovalEntryArgument."Document Type"::"Employee Appraisal";
                    ApprovalEntryArgument."Document No." := NewEmployeeAppraisal."Appraisal No";
                    ApprovalEntryArgument.Description := StrSubstNo(StaffAppraisalApprovalLbl, NewEmployeeAppraisal."Appraisee Name", NewEmployeeAppraisal."Period Start", NewEmployeeAppraisal."Period End");
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    local procedure OnDelegateApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        ApprovalEntryToUpdate: Record "Approval Entry";
        WorkflowStepInstance: Record "Workflow Step Instance";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        NextSequenceNo: Integer;
    begin
        // Case 1 - Delegated to someone else notify them
        if ApprovalEntry."Approver ID" <> CopyStr(UserId(), 1, 50) then begin
            if WorkflowStepInstance.Get(ApprovalEntry."Workflow Step Instance ID") then
                ApprovalsMgmt.CreateApprovalEntryNotification(ApprovalEntry, WorkflowStepInstance);
            exit;
        end;

        // Case 2 - Delegated to yourself auto-approve and advance chain
        ApprovalEntryToUpdate.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
        ApprovalEntryToUpdate.SetRange("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
        ApprovalEntryToUpdate.SetRange("Approver ID", UserId());
        ApprovalEntryToUpdate.SetRange(Status, ApprovalEntryToUpdate.Status::Open);
        if ApprovalEntryToUpdate.FindFirst() then begin
            NextSequenceNo := ApprovalEntryToUpdate."Sequence No." + 1;
            ApprovalEntryToUpdate.Status := ApprovalEntryToUpdate.Status::Approved;
            ApprovalEntryToUpdate.Modify(true);
        end else
            exit;

        // Find next sequence and flip to Open
        ApprovalEntryToUpdate.Reset();
        ApprovalEntryToUpdate.SetRange("Record ID to Approve", ApprovalEntry."Record ID to Approve");
        ApprovalEntryToUpdate.SetRange("Workflow Step Instance ID", ApprovalEntry."Workflow Step Instance ID");
        ApprovalEntryToUpdate.SetRange("Sequence No.", NextSequenceNo);
        ApprovalEntryToUpdate.SetRange(Status, ApprovalEntryToUpdate.Status::Created);
        if ApprovalEntryToUpdate.FindFirst() then begin
            ApprovalEntryToUpdate.Status := ApprovalEntryToUpdate.Status::Open;
            ApprovalEntryToUpdate.Modify(true);

            // Notify next approver in chain
            if WorkflowStepInstance.Get(ApprovalEntryToUpdate."Workflow Step Instance ID") then
                ApprovalEntryToUpdate.SetRange(Status, ApprovalEntryToUpdate.Status::Open);
            if ApprovalEntryToUpdate.FindFirst() then
                ApprovalsMgmt.CreateApprovalEntryNotification(ApprovalEntryToUpdate, WorkflowStepInstance);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var

        LeaveRecall: Record "Employee Off/Holiday";
        LeaveRequest: Record "Leave Application";
        LeaveAdj: Record "Leave Bal Adjustment Header";
        NewEmployeeAppraisal: Record "Employee Appraisal";
        RecruitmentRequest: Record "Recruitment Needs";
        Employee: Record Employee;
    begin
        case RecRef.Number of


            //Leave Application
            Database::"Leave Application":
                begin
                    RecRef.SetTable(LeaveRequest);
                    LeaveRequest.Validate(Status, LeaveRequest.Status::"Pending Approval");
                    LeaveRequest.Modify(true);
                    Variant := LeaveRequest;
                    IsHandled := true;
                end;
            //Recruitment Needs
            Database::"Recruitment Needs":
                begin
                    RecRef.SetTable(RecruitmentRequest);
                    RecruitmentRequest.Validate(Status, RecruitmentRequest.Status::"Pending Approval");
                    RecruitmentRequest.Modify(true);
                    Variant := RecruitmentRequest;
                    IsHandled := true;
                end;

            //Leave Recall
            Database::"Employee Off/Holiday":
                begin
                    RecRef.SetTable(LeaveRecall);
                    LeaveRecall.Validate(Status, LeaveRecall.Status::"Pending Approval");
                    LeaveRecall.Modify(true);
                    Variant := LeaveRecall;
                    IsHandled := true;
                end;

            //Leave Adj
            Database::"Leave Bal Adjustment Header":
                begin
                    RecRef.SetTable(LeaveAdj);
                    LeaveAdj.Validate(Status, LeaveAdj.Status::"Pending Approval");
                    LeaveAdj.Modify(true);
                    Variant := LeaveAdj;
                    IsHandled := true;
                end;
            //New Employee Appraisal
            // Database::"Employee Appraisal":
            //     begin
            //         RecRef.SetTable(NewEmployeeAppraisal);
            //          if NewEmployeeAppraisal.Status = NewEmployeeAppraisal.Status::Open then
            //             NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Pending Approval");
            //         // if NewEmployeeAppraisal.Status = NewEmployeeAppraisal.Status::Open then
            //         //     NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Pending Approval")
            //         // else
            //         //     NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Mid-Year Approved");
            //         // NewEmployeeAppraisal.Validate("Appraisal Status", NewEmployeeAppraisal."Appraisal Status"::Set);
            //         // NewEmployeeAppraisal.Modify(true);
            //         Variant := NewEmployeeAppraisal;
            //         IsHandled := true;
            //     end;
            Database::"Employee Appraisal":
                begin
                    RecRef.SetTable(NewEmployeeAppraisal);
                    if NewEmployeeAppraisal.Get(NewEmployeeAppraisal."Appraisal No") then begin
                        NewEmployeeAppraisal.Validate(Status, NewEmployeeAppraisal.Status::"Pending Approval");
                        NewEmployeeAppraisal.Modify(true);
                    end;
                    IsHandled := true;
                end;

        end;
    end;
  

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure PerformActionsOnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var

        Leave: Record "Leave Application";
        HRMgt: Codeunit "HR Management";
    // Employee: Record Employee;
    begin

        //Leave
        if Leave.Get(ApprovalEntry."Document No.") then begin
            if Confirm('Do you want to notify Leave Applicant that you have rejected their leave?', false) then
                HRMgt.NotifyLeaveApplicantOnRejection(Leave);
        end;
        // New Employee Approval
        // if Employee.Get(Employee."No.") then begin
        //     Employee.Validate("Approval Status", Employee."Approval Status"::Rejected);
        //     Employee.Modify();
        // end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnBeforeApprovalEntryInsert', '', false, false)]
    local procedure InsertCustomApprovalEntryFields(var ApprovalEntry: Record "Approval Entry"; ApprovalEntryArgument: Record "Approval Entry")
    var
        LeaveApp: Record "Leave Application";
        RecRef: RecordRef;
        LeaveApprovalLbl: Label 'Leave Application %1 - %2 Day(s) applied', Comment = '%1 = Employee Name, %2 = Days Applied';
    begin
        //Insert Descriptions
        case ApprovalEntry."Table ID" of
            Database::"Leave Application":
                begin
                    RecRef.Get(ApprovalEntryArgument."Record ID to Approve");
                    RecRef.SetTable(LeaveApp);
                    ApprovalEntryArgument.Description := StrSubstNo(LeaveApprovalLbl, LeaveApp."Employee Name", LeaveApp."Days Applied");
                end;

        end;
    end;


//    [EventSubscriber(ObjectType::Table, Database::"Approval Entry", 'OnAfterModifyEvent', '', false, false)]
//     local procedure OnAfterModifyApprovalEntry(var Rec: Record "Approval Entry"; var xRec: Record "Approval Entry"; RunTrigger: Boolean)
//     var
//         LeaveApplication: Record "Leave Application";
//         OpenEntries: Record "Approval Entry";
//     begin
//         if Rec.IsTemporary then
//             exit;

//         // Only care about Leave Application entries
//         if Rec."Table ID" <> Database::"Leave Application" then
//             exit;

//         // Only fire when this entry just became Approved
//         if Rec.Status <> Rec.Status::Approved then
//             exit;

//         if xRec.Status = xRec.Status::Approved then
//             exit; // Already was approved, not a new transition

//         // Check no other open or created entries remain for this document
//         OpenEntries.SetRange("Table ID", Database::"Leave Application");
//         OpenEntries.SetRange("Document No.", Rec."Document No.");
//         OpenEntries.SetFilter(Status, '%1|%2', OpenEntries.Status::Open, OpenEntries.Status::Created);
//         if not OpenEntries.IsEmpty() then
//             exit;

//         // Fetch the Leave Application and confirm it is Released
//         if not LeaveApplication.Get(Rec."Document No.") then
//             exit;

//         if LeaveApplication.Status <> LeaveApplication.Status::Released then
//             exit;

//         SendLeaveNotification(LeaveApplication);
//     end;

//     local procedure SendLeaveNotification(LeaveApplication: Record "Leave Application")
//     var
//         Employee: Record Employee;
//         EmailMessage: Codeunit "Email Message";
//         Email: Codeunit Email;
//         Subject: Text;
//         Body: Text;
//     begin
//         Subject := StrSubstNo('Leave Approved: %1 - %2',
//             LeaveApplication."Application No",
//             LeaveApplication."Employee Name");

//         Body := StrSubstNo(
//             '<p>Dear Team,</p><p>Leave Application <b>%1</b> has been fully approved.</p>' +
//             '<p><b>Employee:</b> %2<br/>' +
//             '<b>Leave Type:</b> %3<br/>' +
//             '<b>From:</b> %4<br/>' +
//             '<b>To:</b> %5<br/>' +
//             '<b>Days Applied:</b> %6</p>' +
//             '<p>Regards,<br/>HR System</p>',
//             LeaveApplication."Application No",
//             LeaveApplication."Employee Name",
//             LeaveApplication."Leave Code",
//             LeaveApplication."Start Date",
//             LeaveApplication."End Date",
//             LeaveApplication."Days Applied");

//         Employee.Reset();
//         Employee.SetRange(Notify, true);
//         if Employee.FindSet() then
//             repeat
//                 if Employee."Company E-Mail" <> '' then begin
//                     Clear(EmailMessage);
//                     Clear(Email);
//                     EmailMessage.Create(Employee."Company E-Mail", Subject, Body, true);
//                     Email.Send(EmailMessage, Enum::"Email Scenario"::Default);
//                 end;
//             until Employee.Next() = 0;
//     end;


    procedure CheckLeaveRequestWorkflowEnabled(var LeaveRequest: Record "Leave Application"): Boolean
    begin
        if not IsLeaveRequestWorkflowEnabled(LeaveRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveRequestWorkflowEnabled(var LeaveRequest: Record "Leave Application"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveRequest, WorkflowEventHandling.RunworkflowOnSendLeaveApplicationforApprovalCode()));
    end;

    procedure CheckRecruitmentRequestWorkflowEnabled(var RecruitmentRequest: Record "Recruitment Needs"): Boolean
    begin
        if not IsRecruitmentRequestWorkflowEnabled(RecruitmentRequest) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsRecruitmentRequestWorkflowEnabled(var RecruitmentRequest: Record "Recruitment Needs"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(RecruitmentRequest, WorkflowEventHandling.RunworkflowOnSendRecruitmentRequestforApprovalCode()));
    end;



    procedure CheckLeaveRecallWorkflowEnabled(var LeaveRecall: Record "Employee Off/Holiday"): Boolean
    begin
        if not IsLeaveRecallWorkflowEnabled(LeaveRecall) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveRecallWorkflowEnabled(var LeaveRecall: Record "Employee Off/Holiday"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveRecall, WorkflowEventHandling.RunworkflowOnSendLeaveRecallRequestforApprovalCode()));
    end;



    procedure CheckLeaveAdjWorkflowEnabled(var LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean
    begin
        if not IsLeaveAdjWorkflowEnabled(LeaveAdj) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsLeaveAdjWorkflowEnabled(var LeaveAdj: Record "Leave Bal Adjustment Header"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(LeaveAdj, WorkflowEventHandling.RunWorkflowOnSendLeaveAdjForApprovalCode()));
    end;
    //NEW EMPLOYEE APPRAISAL WORKFLOW
    procedure CheckNewEmpAppraisalWorkflowEnabled(var NewEmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        if not IsNewEmpAppraisalWorkflowEnabled(NewEmployeeAppraisal) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsNewEmpAppraisalWorkflowEnabled(var NewEmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(NewEmployeeAppraisal, WorkflowEventHandling.RunworkflowOnSendNewEmpAppraisalforApprovalCode()));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendNewEmpAppraisalRequestforApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelNewEmpAppraisalRequestApproval(var NewEmployeeAppraisal: Record "Employee Appraisal")
    begin
    end;

    procedure CheckEmployeeAppraisalWorkflowEnabled(var EmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        if not IsEmployeeAppraisalWorkflowEnabled(EmployeeAppraisal) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsEmployeeAppraisalWorkflowEnabled(var EmployeeAppraisal: Record "Employee Appraisal"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(EmployeeAppraisal, WorkflowEventHandling.RunworkflowOnSendEmployeeAppraisalRequestforApprovalCode()));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendEmployeeAppraisalRequestforApproval(var EmployeeAppraisal: Record "Employee Appraisal")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelEmployeeAppraisalApprovalRequest(var EmployeeAppraisal: Record "Employee Appraisal")
    begin

    end;



    // New Employee Approval
    procedure CheckNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        if not IsNewEmployeeWorkflowEnabled(Emp) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsNewEmployeeWorkflowEnabled(var Emp: Record Employee): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(Emp, WorkflowEventHandling.RunworkflowOnSendNewEmployeeforApprovalCode()));
    end;




    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRequestApproval(var LeaveRequest: Record "Leave Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRequestApproval(var LeaveRequest: Record "Leave Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnSendRecruitmentApprovalRequest(var RecruitmentRequest: Record "Recruitment Needs")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRecruitmentApprovalRequest(var RecruitmentRequest: Record "Recruitment Needs")
    begin

    end;


    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRecallRequestforApproval(var LeaveRecall: Record "Employee Off/Holiday")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRecallApprovalRequest(var LeaveRecall: Record "Employee Off/Holiday")
    begin

    end;



    [IntegrationEvent(false, false)]
    procedure OnSendLeaveAdjApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveAdjApproval(var LeaveAdj: Record "Leave Bal Adjustment Header")
    begin

    end;


    // New Employee Approval
    [IntegrationEvent(false, false)]
    procedure OnSendNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelNewEmployeeApprovalRequest(var Emp: Record Employee)
    begin

    end;
}





