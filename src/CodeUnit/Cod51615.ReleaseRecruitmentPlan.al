codeunit 51615 "Release Recruitment Plan"
{
    // AddedbyGraceforJSC
    TableNo = "Recruitment Plan";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //Rec.TestField(Posted, false);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseRecruitmentPlan(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var RecruitmentPlan: Record "Recruitment Plan")
    begin
        if RecruitmentPlan.Status = RecruitmentPlan.Status::Open then exit;
        ClearReleaseFields(RecruitmentPlan);
        RecruitmentPlan.Status:=RecruitmentPlan.Status::Open;
        RecruitmentPlan.Modify(true);
    end;
    procedure Reject(var RecruitmentPlan: Record "Recruitment Plan")
    begin
        ClearReleaseFields(RecruitmentPlan);
        RecruitmentPlan.Status:=RecruitmentPlan.Status::Open;
        RecruitmentPlan.Modify(true);
    end;
    procedure PerformManualRelease(var RecruitmentPlan: Record "Recruitment Plan")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Recruitment Plan", RecruitmentPlan);
    end;
    procedure PerformManualReopen(var RecruitmentPlan: Record "Recruitment Plan")
    begin
        if RecruitmentPlan.Status = RecruitmentPlan.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(RecruitmentPlan);
    end;
    procedure PerformManualReject(var RecruitmentPlan: Record "Recruitment Plan")
    begin
        if RecruitmentPlan.Status = RecruitmentPlan.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(RecruitmentPlan);
    end;
    local procedure ClearReleaseFields(var RecruitmentPlan: Record "Recruitment Plan")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseRecruitmentPlan(var RecruitmentPlan: Record "Recruitment Plan")
    begin
    end;
}
