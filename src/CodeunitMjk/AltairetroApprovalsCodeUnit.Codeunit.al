Codeunit 50039 "Altairetro ApprovalsCodeUnit"
{
    trigger OnRun()
    begin
    end;

    var
        MembApplicationTable: Record "Employee Change Request";





    //LoanRecoveryApplicationTable: Record "Loan Recovery Header";
    var
        Psalmkitswfevents: Codeunit "Custom Workflow Events";
        NoWorkflowEnabledErr: Label 'No Approval workflow for this record type is enabled';
        WorkflowManagement: Codeunit "Workflow Management";
    //1)--------------------------------------------------------------------Send Membership Applications request For Approval start
    procedure SendMembershipApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var MembershipApplications: Record "Employee Change Request")
    begin
        if FnCheckIfMembershipApplicationApprovalsWorkflowEnabled(MembershipApplications) then begin
            FnOnSendMembershipApplicationForApproval(MembershipApplications);
        end;
    end;

    local procedure FnCheckIfMembershipApplicationApprovalsWorkflowEnabled(var MembershipApplications: Record "Employee Change Request"): Boolean;
    begin
        if not IsMembershipApplicationApprovalsWorkflowEnabled(MembershipApplications) then Error(NoWorkflowEnabledErr);
        exit(true);
    end;
    //.
    procedure CancelMembershipApplicationsRequestForApproval(MemberApplicationNo: Code[40]; var MembershipApplications: Record "Employee Change Request")
    begin
        FnOnCancelMembershipApplicationApprovalRequest(MembershipApplications);
    end;

    local procedure IsMembershipApplicationApprovalsWorkflowEnabled(var MembershipApplication: Record "Employee Change Request"): Boolean
    begin
        exit(WorkflowManagement.CanExecuteWorkflow(MembershipApplication, Psalmkitswfevents.RunWorkflowOnSendMembershipApplicationForApprovalCode));
    end;

    local procedure FnCheckIfBOSAAccountRegistrationIsAllowed()
    begin
        Error('Procedure FnCheckIfBOSAAccountRegistrationIsAllowed not implemented.');
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Employee Change Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Employee Change Request")
    begin
    end;




}