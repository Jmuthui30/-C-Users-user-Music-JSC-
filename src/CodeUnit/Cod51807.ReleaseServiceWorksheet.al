codeunit 51807 "Release Service Worksheet"
{
    // version THL- PRM 1.0
    TableNo = "Service Line";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then EXIT;
        /*if Rec.Status in [Rec.Status::Open, Rec.Status::Rejected] then
            Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        */
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterServiceWorksheetTraining(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var ServiceLine: Record "Service Line")
    begin
        IF ServiceLine.Status = ServiceLine.Status::Open THEN EXIT;
        ClearReleaseFields(ServiceLine);
        ServiceLine.Status:=ServiceLine.Status::Open;
        ServiceLine.Modify(true);
    end;
    procedure Reject(var ServiceLine: Record "Service Line")
    begin
        ClearReleaseFields(ServiceLine);
        ServiceLine.Status:=ServiceLine.Status::Open;
        ServiceLine.Modify(true);
    end;
    procedure PerformManualRelease(var ServiceLine: Record "Service Line")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.RUN(CODEUNIT::"Release Service Worksheet", ServiceLine);
    end;
    procedure PerformManualReopen(var ServiceLine: Record "Service Line")
    begin
        IF ServiceLine.Status = ServiceLine.Status::"Pending Approval" THEN ERROR(CancelOrCompleteToReopenDocErr);
        Reopen(ServiceLine);
    end;
    procedure PerformManualReject(var ServiceLine: Record "Service Line")
    begin
        IF ServiceLine.Status = ServiceLine.Status::"Pending Approval" THEN ERROR(CancelOrCompleteToReopenDocErr);
        Reject(ServiceLine);
    end;
    local procedure ClearReleaseFields(var ServiceLine: Record "Service Line")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterServiceWorksheetTraining(var ServiceLine: Record "Service Line")
    begin
    end;
}
