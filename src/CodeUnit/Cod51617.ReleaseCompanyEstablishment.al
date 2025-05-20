codeunit 51617 "Release Company Establishment"
{
    // AddedbyGraceforJSC
    TableNo = "Company Jobs";

    trigger OnRun()
    begin
        if Rec.Status = Rec.Status::Released then exit;
        if Rec.Status in[Rec.Status::Open, Rec.Status::Rejected]then Error(StrSubstNo(CanReleasedIfStatusErr, Rec.Status::"Pending Approval"));
        //Rec.TestField(Posted, false);
        Rec.Status:=Rec.Status::Released;
        Rec.Modify(true);
        OnAfterReleaseCompanyEstablishment(Rec);
    end;
    var NothingToReleaseErr: Label 'There is nothing to release for the incoming document number %1.', Comment = '%1 = Incoming Document Entry No';
    DocReleasedWhenApprovedErr: Label 'This document can only be released when the approval process is complete.';
    CancelOrCompleteToReopenDocErr: Label 'The approval process must be cancelled or completed to reopen this document.';
    CanReleasedIfStatusErr: Label 'It is only possible to release the record when the status is %1.', Comment = '%1 = status released, %2 = status pending approval';
    procedure Reopen(var CompanyEstablishment: Record "Company Jobs")
    begin
        if CompanyEstablishment.Status = CompanyEstablishment.Status::Open then exit;
        ClearReleaseFields(CompanyEstablishment);
        CompanyEstablishment.Status:=CompanyEstablishment.Status::Open;
        CompanyEstablishment.Modify(true);
    end;
    procedure Reject(var CompanyEstablishment: Record "Company Jobs")
    begin
        ClearReleaseFields(CompanyEstablishment);
        CompanyEstablishment.Status:=CompanyEstablishment.Status::Open;
        CompanyEstablishment.Modify(true);
    end;
    procedure PerformManualRelease(var CompanyEstablishment: Record "Company Jobs")
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        CODEUNIT.Run(CODEUNIT::"Release Company Establishment", CompanyEstablishment);
    end;
    procedure PerformManualReopen(var CompanyEstablishment: Record "Company Jobs")
    begin
        if CompanyEstablishment.Status = CompanyEstablishment.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reopen(CompanyEstablishment);
    end;
    procedure PerformManualReject(var CompanyEstablishment: Record "Company Jobs")
    begin
        if CompanyEstablishment.Status = CompanyEstablishment.Status::"Pending Approval" then Error(CancelOrCompleteToReopenDocErr);
        Reject(CompanyEstablishment);
    end;
    local procedure ClearReleaseFields(var CompanyEstablishment: Record "Company Jobs")
    begin
    /*IncomingDocument.Released := FALSE;
        IncomingDocument."Released Date-Time" := 0DT;
        CLEAR(IncomingDocument."Released By User ID");*/
    end;
    [IntegrationEvent(false, false)]
    procedure OnAfterReleaseCompanyEstablishment(var CompanyEstablishment: Record "Company Jobs")
    begin
    end;
}
