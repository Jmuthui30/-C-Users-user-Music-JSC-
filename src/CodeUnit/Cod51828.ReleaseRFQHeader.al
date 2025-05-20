codeunit 51828 "Release RFQ Header"
{
    //Ibrahim Wasiu
    TableNo = "RFQ Header";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseRFQ(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var RFQ: Record "RFQ Header")
    begin
        if RFQ.Status = RFQ.Status::Open then exit;
        ClearReleaseFields(RFQ);
        RFQ.Status:=RFQ.Status::Open;
        RFQ.Modify(true);
    end;
    procedure Reject(var RFQ: Record "RFQ Header")
    begin
        ClearReleaseFields(RFQ);
        RFQ.Status:=RFQ.Status::Open;
        RFQ.Modify(true);
    end;
    procedure PerformManualRelease(var RFQ: Record "RFQ Header")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release RFQ Header", RFQ);
    end;
    procedure PerformManualReopen(var RFQ: Record "RFQ Header")
    begin
        if RFQ.Status = RFQ.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(RFQ);
    end;
    procedure PerformManualReject(var RFQ: Record "RFQ Header")
    begin
        if RFQ.Status = RFQ.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(RFQ);
    end;
    local procedure ClearReleaseFields(var RFQ: Record "RFQ Header")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseRFQ(var RFQ: Record "RFQ Header")
    begin
    end;
}
