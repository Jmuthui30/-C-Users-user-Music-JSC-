codeunit 51618 "Release Recruitment Need"
{
    // AddedbyGraceforJSC
    TableNo = "Recruitment Needs";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //Rec.TestField(Posted, false);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseRecruitmentNeed(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        if RecruitmentNeed.Status = RecruitmentNeed.Status::Open then exit;
        ClearReleaseFields(RecruitmentNeed);
        RecruitmentNeed.Status:=RecruitmentNeed.Status::Open;
        RecruitmentNeed.Modify(true);
    end;
    procedure Reject(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        ClearReleaseFields(RecruitmentNeed);
        RecruitmentNeed.Status:=RecruitmentNeed.Status::Open;
        RecruitmentNeed.Modify(true);
    end;
    procedure PerformManualRelease(var RecruitmentNeed: Record "Recruitment Needs")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Recruitment Need", RecruitmentNeed);
    end;
    procedure PerformManualReopen(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        if RecruitmentNeed.Status = RecruitmentNeed.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(RecruitmentNeed);
    end;
    procedure PerformManualReject(var RecruitmentNeed: Record "Recruitment Needs")
    begin
        if RecruitmentNeed.Status = RecruitmentNeed.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(RecruitmentNeed);
    end;
    local procedure ClearReleaseFields(var RecruitmentNeed: Record "Recruitment Needs")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseRecruitmentNeed(var RecruitmentNeed: Record "Recruitment Needs")
    begin
    end;
}
