codeunit 51616 "Release Cons. Recruitment Plan"
{
    // AddedbyGraceforJSC
    TableNo = "Consolidated Recruitment Plan";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //Rec.TestField(Posted, false);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseConsolidatedRecruitmentPlan(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
        if ConsolidatedRecruitmentPlan.Status = ConsolidatedRecruitmentPlan.Status::Open then exit;
        ClearReleaseFields(ConsolidatedRecruitmentPlan);
        ConsolidatedRecruitmentPlan.Status:=ConsolidatedRecruitmentPlan.Status::Open;
        ConsolidatedRecruitmentPlan.Modify(true);
    end;
    procedure Reject(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
        ClearReleaseFields(ConsolidatedRecruitmentPlan);
        ConsolidatedRecruitmentPlan.Status:=ConsolidatedRecruitmentPlan.Status::Open;
        ConsolidatedRecruitmentPlan.Modify(true);
    end;
    procedure PerformManualRelease(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Cons. Recruitment Plan", ConsolidatedRecruitmentPlan);
    end;
    procedure PerformManualReopen(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
        if ConsolidatedRecruitmentPlan.Status = ConsolidatedRecruitmentPlan.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(ConsolidatedRecruitmentPlan);
    end;
    procedure PerformManualReject(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
        if ConsolidatedRecruitmentPlan.Status = ConsolidatedRecruitmentPlan.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(ConsolidatedRecruitmentPlan);
    end;
    local procedure ClearReleaseFields(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseConsolidatedRecruitmentPlan(var ConsolidatedRecruitmentPlan: Record "Consolidated Recruitment Plan")
    begin
    end;
}
