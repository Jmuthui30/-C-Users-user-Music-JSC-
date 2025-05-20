codeunit 52114 "Release Imprest Payroll Claim"
{
    TableNo = "Imprest Payroll Claims Header";

    // version THL- ADV.FIN 1.0
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
    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseImprestPayrollClaim(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
        if ImprestPayrollClaim.Status = ImprestPayrollClaim.Status::Open then exit;
        ClearReleaseFields(ImprestPayrollClaim);
        ImprestPayrollClaim.Status:=ImprestPayrollClaim.Status::Open;
        ImprestPayrollClaim.Modify(true);
    end;
    procedure Reject(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
        ClearReleaseFields(ImprestPayrollClaim);
        ImprestPayrollClaim.Status:=ImprestPayrollClaim.Status::Open;
        ImprestPayrollClaim.Modify(true);
    end;
    procedure PerformManualRelease(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Imprest Memo", ImprestPayrollClaim);
    end;
    procedure PerformManualReopen(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
        if ImprestPayrollClaim.Status = ImprestPayrollClaim.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(ImprestPayrollClaim);
    end;
    procedure PerformManualReject(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
        if ImprestPayrollClaim.Status = ImprestPayrollClaim.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(ImprestPayrollClaim);
    end;
    local procedure ClearReleaseFields(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseImprestPayrollClaim(var ImprestPayrollClaim: Record "Imprest Payroll Claims Header")
    begin
    end;
}
