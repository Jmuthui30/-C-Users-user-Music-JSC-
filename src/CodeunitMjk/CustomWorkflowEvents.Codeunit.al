Codeunit 50040 "Custom Workflow Events"
{
    trigger OnRun()
    begin
        AddEventsToLib();
    end;

    var
        WFHandler: Codeunit "Workflow Event Handling";
        WorkflowManagement: Codeunit "Workflow Management";
        WFEventHandler: Codeunit "Workflow Event Handling";
        WFResponseHandler: Codeunit "Workflow Response Handling";


    procedure AddEventsToLib()
    begin
        //---------------------------------------------1. Approval Events--------------------------------------------------------------
        //Membership Application
        WFHandler.AddEventToLibrary(RunWorkflowOnSendMembershipApplicationForApprovalCode, Database::"Employee Change Request", 'Approval of Membership Application is Requested.', 0, false);
        WFHandler.AddEventToLibrary(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, Database::"Employee Change Request", 'An Approval request for  Membership Application is canceled.', 0, false);
        //-------------------------------------------End Approval Events-------------------------------------------------------------
        //-------------------------------------------End Approval Events-------------------------------------------------------------

    end;

    procedure AddEventsPredecessor()
    begin
        //--------1.Approval,Rejection,Delegation Predecessors----------------------
        //1. Membership Application
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);
        WFHandler.AddEventPredecessor(WFHandler.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendMembershipApplicationForApprovalCode);

    end;
    //...............................................................................................................................................................................
    //A)Membership Applications
    procedure RunWorkflowOnSendMembershipApplicationForApprovalCode(): Code[128] //
    begin
        exit(UpperCase('RunWorkflowOnSendMembershipApplicationForApproval'));
    end;

    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequestCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelMembershipApplicationApprovalRequest'));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Altairetro ApprovalsCodeUnit", 'FnOnSendMembershipApplicationForApproval', '', false, false)]
    procedure RunWorkflowOnSendMembershipApplicationForApproval(var MembershipApplication: Record "Employee Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnSendMembershipApplicationForApprovalCode, MembershipApplication);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Altairetro ApprovalsCodeUnit", 'FnOnCancelMembershipApplicationApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelMembershipApplicationApprovalRequest(var MembershipApplication: Record "Employee Change Request")
    begin
        WorkflowManagement.HandleEvent(RunWorkflowOnCancelMembershipApplicationApprovalRequestCode, MembershipApplication);
    end;



}