codeunit 51825 "Release Repair Requisition"
{
    //Ibrahim Wasiu
    TableNo = "Repair Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //TestField(Posted, false);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseRepairRequest(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var RepairRequest: Record "Repair Header")
    begin
        if RepairRequest.Status = RepairRequest.Status::Open then exit;
        ClearReleaseFields(RepairRequest);
        RepairRequest.Status:=RepairRequest.Status::Open;
        RepairRequest.Modify(true);
    end;
    procedure Reject(var RepairRequest: Record "Repair Header")
    begin
        ClearReleaseFields(RepairRequest);
        RepairRequest.Status:=RepairRequest.Status::Open;
        RepairRequest.Modify(true);
    end;
    procedure PerformManualRelease(var RepairRequest: Record "Repair Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Repair Requisition", RepairRequest);
    end;
    procedure PerformManualReopen(var RepairRequest: Record "Repair Header")
    begin
        if RepairRequest.Status = RepairRequest.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(RepairRequest);
    end;
    procedure PerformManualReject(var RepairRequest: Record "Repair Header")
    begin
        if RepairRequest.Status = RepairRequest.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(RepairRequest);
    end;
    local procedure ClearReleaseFields(var RepairRequest: Record "Repair Header")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseRepairRequest(var RepairRequest: Record "Repair Header")
    begin
    end;
}
