codeunit 52117 "Event Handler"
{
    /// <summary>
    /// This event is used to handle the creation of approval requests for workflow user groups when the request comes from a non-GUI context e.g. a web service or web portal.
    /// It is triggered before the creation of approval requests for workflow user groups in the "Approvals Mgmt." codeunit.
    /// </summary>
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", OnBeforeCreateApprReqForApprTypeWorkflowUserGroup, '', false, false)]
    local procedure "Approvals Mgmt._OnBeforeCreateApprReqForApprTypeWorkflowUserGroup"(var Sender: Codeunit "Approvals Mgmt."; var WorkflowUserGroupMember: Record "Workflow User Group Member"; WorkflowStepArgument: Record "Workflow Step Argument"; ApprovalEntry: Record "Approval Entry"; SequenceNo: Integer; var IsHandled: Boolean)
    var
        UserSetup: Record "User Setup";
        ApprovalMgt: Codeunit "Approvals Mgmt.";
        ApproverId: Code[50];
        NoWFUserGroupMembersErr: Label 'A workflow user group with at least one member must be set up.';
        WFUserGroupNotInSetupErr: Label 'The workflow user group member with user ID %1 does not exist in the Approval User Setup window.', Comment = 'The workflow user group member with user ID NAVUser does not exist in the Approval User Setup window. %1 = User ID';
    begin
        if not GuiAllowed() then begin
            IsHandled := true;

            SequenceNo := ApprovalMgt.GetLastSequenceNo(ApprovalEntry);

            WorkflowUserGroupMember.SetCurrentKey("Workflow User Group Code", "Sequence No.");
            WorkflowUserGroupMember.SetRange("Workflow User Group Code", WorkflowStepArgument."Workflow User Group Code");
            if not WorkflowUserGroupMember.FindSet() then
                Error(NoWFUserGroupMembersErr);
            repeat
                ApproverId := WorkflowUserGroupMember."User Name";
                if not UserSetup.Get(ApproverId) then
                    Error(WFUserGroupNotInSetupErr, ApproverId);
                ApprovalMgt.MakeApprovalEntry(ApprovalEntry, SequenceNo + WorkflowUserGroupMember."Sequence No.", ApproverId, WorkflowStepArgument);
            until WorkflowUserGroupMember.Next() = 0;
        end;
    end;
}
