codeunit 51870 "Release Employee Change Req"
{
    // version THL- PRM 1.0
    TableNo = "Employee Change Request";

    trigger OnRun()
    begin
        if Rec."Approval Status" = Rec."Approval Status"::Approved then EXIT;
        /*if Rec.Status in [Rec.Status::Open, Rec.Status::Rejected] then
            Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        */
        Rec."Approval Status" := Rec."Approval Status"::Approved;
        Rec.Modify(true);
        OnAfterEmployeeChangeRequestRelease(Rec);
    end;

    var
        NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
        DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
        CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
        CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';



    procedure Reopen(var EmployeeChangeRequest: Record "Employee Change Request")
    begin
        IF EmployeeChangeRequest."Approval Status" = EmployeeChangeRequest."Approval Status"::Open THEN EXIT;
        ClearReleaseFields(EmployeeChangeRequest);
        EmployeeChangeRequest."Approval Status" := EmployeeChangeRequest."Approval Status"::Open;
        EmployeeChangeRequest.Modify(true);
    end;

    procedure Reject(var EmployeeChangeRequest: Record "Employee Change Request")
    begin
        ClearReleaseFields(EmployeeChangeRequest);
        EmployeeChangeRequest."Approval Status" := EmployeeChangeRequest."Approval Status"::Open;
        EmployeeChangeRequest.Modify(true);
    end;

    procedure PerformManualRelease(var EmployeeChangeRequest: Record "Employee Change Request")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.RUN(CODEUNIT::"Release Employee Change Req", EmployeeChangeRequest);
    end;

    procedure PerformManualReopen(var EmployeeChangeRequest: Record "Employee Change Request")
    begin
        IF EmployeeChangeRequest."Approval Status" = EmployeeChangeRequest."Approval Status"::"Pending Approval" THEN ERROR(CancelOrCompleteToReopenDocErr);
        Reopen(EmployeeChangeRequest);
    end;

    procedure PerformManualReject(var EmployeeChangeRequest: Record "Employee Change Request")
    begin
        IF EmployeeChangeRequest."Approval Status" = EmployeeChangeRequest."Approval Status"::"Pending Approval" THEN ERROR(CancelOrCompleteToReopenDocErr);
        Reject(EmployeeChangeRequest);
    end;

    local procedure ClearReleaseFields(var EmployeeChangeRequest: Record "Employee Change Request")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterEmployeeChangeRequestRelease(var EmployeeChangeRequest: Record "Employee Change Request")
    begin
    end;

}

