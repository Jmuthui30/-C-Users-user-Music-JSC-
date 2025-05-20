codeunit 51602 "Release Leave Application"
{
    // version THL- HRM 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
    // Advanced Finance: 52100 - 52199 = 99
    // QuantumJumps HR: 51600 - 51799 = 199
    // QuantumJumps Procumement: 51800 - 51899 = 99
    // ***********************
    // EasyPFA: 51900 - 52099 = 199
    // Investment: 52100 - 52199 = 99
    // DynamicsHMIS: 52200 - 52299 = 99
    // EasyProperty: 52300 - 52399 = 99
    // Insurance: 61423 - 61622 = 199
    // Sacco:   61623 - 62422 = ***
    // ***********************
    TableNo = "Employee Leave Application";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseLeave(Rec);
        LeaveRelieverNotification(Rec);
        LeaveEmployeeNotification(Rec);
        HRLeaveNotification(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var Leave: Record "Employee Leave Application")
    begin
        if Leave.Status = Leave.Status::Open then exit;
        ClearReleaseFields(Leave);
        Leave.Status:=Leave.Status::Open;
        Leave.Modify(true);
    end;
    procedure ReopenLeaveAdjustment(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        if LeaveAdjust.Status = LeaveAdjust.Status::New then exit;
        //ClearReleaseFields(LeaveAdjust);
        LeaveAdjust.Status:=LeaveAdjust.Status::New;
        LeaveAdjust.Modify(true);
    end;
    procedure Reject(var Leave: Record "Employee Leave Application")
    begin
        ClearReleaseFields(Leave);
        Leave.Status:=Leave.Status::Open;
        Leave.Modify(true);
    end;
    procedure RejectLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        //ClearReleaseFields(LeaveAdjust);
        LeaveAdjust.Status:=LeaveAdjust.Status::New;
        LeaveAdjust.Modify(true);
    end;
    procedure PerformManualRelease(var Leave: Record "Employee Leave Application")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Leave Application", Leave);
    end;
    procedure PerformManualReleaseLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Leave Application", LeaveAdjust);
    end;
    procedure PerformManualReopen(var Leave: Record "Employee Leave Application")
    begin
        if Leave.Status = Leave.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(Leave);
    end;
    procedure PerformManualReopenLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        if LeaveAdjust.Status = LeaveAdjust.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        ReopenLeaveAdjustment(LeaveAdjust);
    end;
    procedure PerformManualReject(var Leave: Record "Employee Leave Application")
    begin
        if Leave.Status = Leave.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(Leave);
    end;
    procedure PerformManualRejectLeaveAdjsut(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        if LeaveAdjust.Status = LeaveAdjust.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        RejectLeaveAdjust(LeaveAdjust);
    end;
    local procedure ClearReleaseFields(var Leave: Record "Employee Leave Application")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseLeave(var Leave: Record "Employee Leave Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure LeaveRelieverNotification(var Leave: Record "Employee Leave Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure HRLeaveNotification(var Leave: Record "Employee Leave Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure LeaveEmployeeNotification(var Leave: Record "Employee Leave Application")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
    end;
}
