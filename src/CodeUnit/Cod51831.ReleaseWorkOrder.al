codeunit 51831 "Release Work Order"
{
    //Ibrahim Wasiu
    TableNo = "Work Order Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseWorkOrder(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var WorkOrder: Record "Work Order Header")
    begin
        if WorkOrder.Status = WorkOrder.Status::Open then exit;
        ClearReleaseFields(WorkOrder);
        WorkOrder.Status:=WorkOrder.Status::Open;
        WorkOrder.Modify(true);
    end;
    procedure Reject(var WorkOrder: Record "Work Order Header")
    begin
        ClearReleaseFields(WorkOrder);
        WorkOrder.Status:=WorkOrder.Status::Open;
        WorkOrder.Modify(true);
    end;
    procedure PerformManualRelease(var WorkOrder: Record "Work Order Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Work Order", WorkOrder);
    end;
    procedure PerformManualReopen(var WorkOrder: Record "Work Order Header")
    begin
        if WorkOrder.Status = WorkOrder.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(WorkOrder);
    end;
    procedure PerformManualReject(var WorkOrder: Record "Work Order Header")
    begin
        if WorkOrder.Status = WorkOrder.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(WorkOrder);
    end;
    local procedure ClearReleaseFields(var WorkOrder: Record "Work Order Header")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseWorkOrder(var WorkOrder: Record "Work Order Header")
    begin
    end;
}
