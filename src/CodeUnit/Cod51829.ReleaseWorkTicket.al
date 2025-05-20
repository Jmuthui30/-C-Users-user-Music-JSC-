codeunit 51829 "Release Work Ticket"
{
    TableNo = "Work Ticket Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseWorkT(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var WorkT: Record "Work Ticket Header")
    begin
        if WorkT.Status = WorkT.Status::Open then exit;
        ClearReleaseFields(WorkT);
        WorkT.Status:=WorkT.Status::Open;
        WorkT.Modify(true);
    end;
    procedure Reject(var WorkT: Record "Work Ticket Header")
    begin
        ClearReleaseFields(WorkT);
        WorkT.Status:=WorkT.Status::Open;
        WorkT.Modify(true);
    end;
    procedure PerformManualRelease(var WorkT: Record "Work Ticket Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Work Ticket", WorkT);
    end;
    procedure PerformManualReopen(var WorkT: Record "Work Ticket Header")
    begin
        if WorkT.Status = WorkT.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(WorkT);
    end;
    procedure PerformManualReject(var WorkT: Record "Work Ticket Header")
    begin
        if WorkT.Status = WorkT.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(WorkT);
    end;
    local procedure ClearReleaseFields(var workT: Record "Work Ticket Header")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseWorkT(var workT: Record "Work Ticket Header")
    begin
    end;
}
