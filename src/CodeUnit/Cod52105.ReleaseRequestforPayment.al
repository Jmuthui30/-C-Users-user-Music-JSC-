codeunit 52105 "Release Request for Payment"
{
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
    TableNo = "Request for Payment";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //TESTFIELD(,FALSE);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseRequestForPayment(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var RequestForPayment: Record "Request for Payment")
    begin
        if RequestForPayment.Status = RequestForPayment.Status::Open then exit;
        ClearReleaseFields(RequestForPayment);
        RequestForPayment.Status:=RequestForPayment.Status::Open;
        RequestForPayment.Modify(true);
    end;
    procedure Reject(var RequestForPayment: Record "Request for Payment")
    begin
        ClearReleaseFields(RequestForPayment);
        RequestForPayment.Status:=RequestForPayment.Status::Open;
        RequestForPayment.Modify(true);
    end;
    procedure PerformManualRelease(var RequestForPayment: Record "Request for Payment")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Request for Payment", RequestForPayment);
    end;
    procedure PerformManualReopen(var RequestForPayment: Record "Request for Payment")
    begin
        if RequestForPayment.Status = RequestForPayment.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(RequestForPayment);
    end;
    procedure PerformManualReject(var RequestForPayment: Record "Request for Payment")
    begin
        if RequestForPayment.Status = RequestForPayment.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(RequestForPayment);
    end;
    local procedure ClearReleaseFields(var RequestForPayment: Record "Request for Payment")
    begin
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseRequestForPayment(var RequestForPayment: Record "Request for Payment")
    begin
    end;
}
