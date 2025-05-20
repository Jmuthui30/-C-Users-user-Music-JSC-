codeunit 52113 "Release Imprest Memo"
{
    TableNo = "Imprest Memo Header";

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
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //TESTFIELD("Request Posted",FALSE);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseImprestMemo(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var ImprestMemo: Record "Imprest Memo Header")
    begin
        if ImprestMemo.Status = ImprestMemo.Status::Open then exit;
        ClearReleaseFields(ImprestMemo);
        ImprestMemo.Status:=ImprestMemo.Status::Open;
        ImprestMemo.Modify(true);
    end;
    procedure Reject(var ImprestMemo: Record "Imprest Memo Header")
    begin
        ClearReleaseFields(ImprestMemo);
        ImprestMemo.Status:=ImprestMemo.Status::Open;
        ImprestMemo.Modify(true);
    end;
    procedure PerformManualRelease(var ImprestMemo: Record "Imprest Memo Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Imprest Memo", ImprestMemo);
    end;
    procedure PerformManualReopen(var ImprestMemo: Record "Imprest Memo Header")
    begin
        if ImprestMemo.Status = ImprestMemo.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(ImprestMemo);
    end;
    procedure PerformManualReject(var ImprestMemo: Record "Imprest Memo Header")
    begin
        if ImprestMemo.Status = ImprestMemo.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(ImprestMemo);
    end;
    local procedure ClearReleaseFields(var ImprestMemo: Record "Imprest Memo Header")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseImprestMemo(var ImprestMemo: Record "Imprest Memo Header")
    begin
    end;
}
