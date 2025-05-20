codeunit 51432 "Release Bal Score Card"
{
    // version THL- HRM 1.0
    // Author: Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
    // Advanced Finance: 51500 - 51599 = 99
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
    TableNo = "Bal Score Card Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseBalScoreCard(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    /// <summary>
    /// Reopen.
    /// </summary>
    /// <param name="BalScoreCard">VAR Record "Bal Score Card Header".</param>
    procedure Reopen(var BalScoreCard: Record "Bal Score Card Header")
    begin
        if BalScoreCard.Status = BalScoreCard.Status::Open then exit;
        ClearReleaseFields(BalScoreCard);
        BalScoreCard.Status:=BalScoreCard.Status::Open;
        BalScoreCard.Modify(true);
    end;
    /// <summary>
    /// Reject.
    /// </summary>
    /// <param name="BalScoreCard">VAR Record "Bal Score Card Header".</param>
    procedure Reject(var BalScoreCard: Record "Bal Score Card Header")
    begin
        ClearReleaseFields(BalScoreCard);
        BalScoreCard.Status:=BalScoreCard.Status::Open;
        BalScoreCard.Modify(true);
    end;
    /// <summary>
    /// PerformManualRelease.
    /// </summary>
    /// <param name="BalScoreCard">VAR Record "Bal Score Card Header".</param>
    procedure PerformManualRelease(var BalScoreCard: Record "Bal Score Card Header")
    var
        ApprovalsMgmt: Codeunit 1535;
    begin
        CODEUNIT.Run(CODEUNIT::"Release Bal Score Card", BalScoreCard);
    end;
    /// <summary>
    /// PerformManualReopen.
    /// </summary>
    /// <param name="BalScoreCard">VAR Record "Bal Score Card Header".</param>
    procedure PerformManualReopen(var BalScoreCard: Record "Bal Score Card Header")
    begin
        if BalScoreCard.Status = BalScoreCard.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(BalScoreCard);
    end;
    /// <summary>
    /// PerformManualReject.
    /// </summary>
    /// <param name="BalScoreCard">VAR Record "Bal Score Card Header".</param>
    procedure PerformManualReject(var BalScoreCard: Record "Bal Score Card Header")
    begin
        if BalScoreCard.Status = BalScoreCard.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(BalScoreCard);
    end;
    local procedure ClearReleaseFields(var BalScoreCard: Record "Bal Score Card Header")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    /// <summary>
    /// OnAfterReleaseBalScoreCard.
    /// </summary>
    /// <param name="BalScoreCard">VAR Record "Bal Score Card Header".</param>
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseBalScoreCard(var BalScoreCard: Record "Bal Score Card Header")
    begin
    end;
}
