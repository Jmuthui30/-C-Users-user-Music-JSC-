codeunit 51813 "Release Govt. Emp Appraisal"
{
    // version THL- PRM 1.0
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
    TableNo = "Employee Appraisals";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //TESTFIELD(Posted,FALSE);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseEmpAppraisal(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var EmpAppraisal: Record "Employee Appraisals")
    begin
        if EmpAppraisal.Status = EmpAppraisal.Status::Open then exit;
        ClearReleaseFields(EmpAppraisal);
        EmpAppraisal.Status:=EmpAppraisal.Status::Open;
        EmpAppraisal.Modify(true);
    end;
    procedure Reject(var EmpAppraisal: Record "Employee Appraisals")
    begin
        ClearReleaseFields(EmpAppraisal);
        EmpAppraisal.Status:=EmpAppraisal.Status::Open;
        EmpAppraisal.Modify(true);
    end;
    procedure PerformManualRelease(var EmpAppraisal: Record "Employee Appraisals")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Govt. Emp Appraisal", EmpAppraisal);
    end;
    procedure PerformManualReopen(var EmpAppraisal: Record "Employee Appraisals")
    begin
        if EmpAppraisal.Status = EmpAppraisal.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(EmpAppraisal);
    end;
    procedure PerformManualReject(var EmpAppraisal: Record "Employee Appraisals")
    begin
        if EmpAppraisal.Status = EmpAppraisal.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(EmpAppraisal);
    end;
    local procedure ClearReleaseFields(var EmpAppraisal: Record "Employee Appraisals")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseEmpAppraisal(var EmpAppraisal: Record "Employee Appraisals")
    begin
    end;
}
