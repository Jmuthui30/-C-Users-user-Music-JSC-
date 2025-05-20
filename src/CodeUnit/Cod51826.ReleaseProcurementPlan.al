codeunit 51826 "Release Procurement Plan"
{
    //Ibrahim Wasiu
    TableNo = "Procurement Plan Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseProcurePlan(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var ProcurePlan: Record "Procurement Plan Header")
    begin
        if ProcurePlan.Status = ProcurePlan.Status::Open then exit;
        ClearReleaseFields(ProcurePlan);
        ProcurePlan.Status:=ProcurePlan.Status::Open;
        ProcurePlan.Modify(true);
    end;
    procedure Reject(var ProcurePlan: Record "Procurement Plan Header")
    begin
        ClearReleaseFields(ProcurePlan);
        ProcurePlan.Status:=ProcurePlan.Status::Open;
        ProcurePlan.Modify(true);
    end;
    procedure PerformManualRelease(var ProcurePlan: Record "Procurement Plan Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Procurement Plan", ProcurePlan);
    end;
    procedure PerformManualReopen(var ProcurePlan: Record "Procurement Plan Header")
    begin
        if ProcurePlan.Status = ProcurePlan.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(ProcurePlan);
    end;
    procedure PerformManualReject(var ProcurePlan: Record "Procurement Plan Header")
    begin
        if ProcurePlan.Status = ProcurePlan.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(ProcurePlan);
    end;
    local procedure ClearReleaseFields(var ProcurePlan: Record "Procurement Plan Header")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseProcurePlan(var ProcurePlan: Record "Procurement Plan Header")
    begin
    end;
}
