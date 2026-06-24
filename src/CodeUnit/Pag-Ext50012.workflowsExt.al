pageextension 50012 "workflowsExt" extends Workflows
{


    trigger OnOpenPage()
    var
        CustomWorkFlowEvents: Codeunit "Workflow Event Handling";

        CustomWorkFlowEventsmjk: Codeunit "Custom Workflow Events";
        WorkflowRepsonse: Codeunit "Custom Workflow Responses";
    begin
        CustomWorkFlowEvents.CreateEventsLibrary();

        CustomWorkFlowEventsmjk.AddEventsToLib();
        WorkflowRepsonse.AddResponsePredecessors();
        Message('Updated');
    end;
}
