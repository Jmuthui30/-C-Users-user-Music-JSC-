codeunit 50002 "Release Leave Adjustment"
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
    TableNo = "Leave Adjustment Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Approved then exit;
        if Rec.Status in[Rec.Status::New, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Approved;
        Rec.Modify(true);
        OnAfterReleaseLeaveAdjust(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure ReopenLeaveAdjustment(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        if LeaveAdjust.Status = LeaveAdjust.Status::New then exit;
        //ClearReleaseFields(LeaveAdjust);
        LeaveAdjust.Status:=LeaveAdjust.Status::New;
        LeaveAdjust.Modify(true);
    end;
    procedure RejectLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        //ClearReleaseFields(LeaveAdjust);
        LeaveAdjust.Status:=LeaveAdjust.Status::New;
        LeaveAdjust.Modify(true);
    end;
    procedure PerformManualReleaseLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Leave Adjustment", LeaveAdjust);
    end;
    procedure PerformManualReopenLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
        if LeaveAdjust.Status = LeaveAdjust.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        ReopenLeaveAdjustment(LeaveAdjust);
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
    procedure OnAfterReleaseLeaveAdjust(var LeaveAdjust: Record "Leave Adjustment Header")
    begin
    end;
}
