pageextension 50012 "workflowsExt" extends Workflows
{
    trigger OnOpenPage()
    var
        CustomWorkFlowEvents: Codeunit "Workflow Event Handling";
        WorkflowRepsonse: Codeunit "Workflow Response Handling Ext";
    //  CustomWorkFlowEvents: Codeunit "Custom Workflow Events";
    // WorkflowRepsonse: Codeunit "Custom Workflow Responses";
    begin
        CustomWorkFlowEvents.CreateEventsLibrary();


        Message('Updated');
    end;
}
