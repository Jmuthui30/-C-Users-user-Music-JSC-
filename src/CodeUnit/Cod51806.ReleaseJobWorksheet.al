codeunit 51806 "Release Job Worksheet"
{
    // version THL- PRM 1.0
    TableNo = "Worksheet Requisitions Lines";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseJobWorksheet(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
        if WorksheetRequisitionsLines.Status = WorksheetRequisitionsLines.Status::Open then exit;
        ClearReleaseFields(WorksheetRequisitionsLines);
        WorksheetRequisitionsLines.Status:=WorksheetRequisitionsLines.Status::Open;
        WorksheetRequisitionsLines.Modify(true);
    end;
    procedure Reject(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
        ClearReleaseFields(WorksheetRequisitionsLines);
        WorksheetRequisitionsLines.Status:=WorksheetRequisitionsLines.Status::Open;
        WorksheetRequisitionsLines.Modify(true);
    end;
    procedure PerformManualRelease(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Job Worksheet", WorksheetRequisitionsLines);
    end;
    procedure PerformManualReopen(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
        if WorksheetRequisitionsLines.Status = WorksheetRequisitionsLines.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(WorksheetRequisitionsLines);
    end;
    procedure PerformManualReject(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
        if WorksheetRequisitionsLines.Status = WorksheetRequisitionsLines.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(WorksheetRequisitionsLines);
    end;
    local procedure ClearReleaseFields(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseJobWorksheet(var WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    begin
    end;
}
