codeunit 51611 "Release Training"
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
    // *************************
    TableNo = "Staff Training Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseTraining(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var Training: Record "Staff Training Header")
    begin
        if Training.Status = Training.Status::Open then exit;
        ClearReleaseFields(Training);
        Training.Status:=Training.Status::Open;
        Training.Modify(true);
    end;
    procedure Reject(var Training: Record "Staff Training Header")
    begin
        ClearReleaseFields(Training);
        Training.Status:=Training.Status::Open;
        Training.Modify(true);
    end;
    procedure PerformManualRelease(var Training: Record "Staff Training Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Training", Training);
    end;
    procedure PerformManualReopen(var Training: Record "Staff Training Header")
    begin
        if Training.Status = Training.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(Training);
    end;
    procedure PerformManualReject(var Training: Record "Staff Training Header")
    begin
        if Training.Status = Training.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(Training);
    end;
    local procedure ClearReleaseFields(var Training: Record "Staff Training Header")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseTraining(var Training: Record "Staff Training Header")
    begin
    end;
}
