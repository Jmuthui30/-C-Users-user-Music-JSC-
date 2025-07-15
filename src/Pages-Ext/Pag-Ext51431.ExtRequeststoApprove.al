pageextension 51431 "ExtRequests to Approve" extends "Requests to Approve"
{


    actions
    {
        // Add changes to page actions here
        modify(Approve)
        {
            Enabled = true;
        }
        modify(Reject)
        {
            Enabled = true;
        }
        modify(Delegate)
        {
            Enabled = true;
        }
        modify(OpenRequests)
        {
            Enabled = true;
        }
        addlast(Processing)
        {
            // action(open)
            // {
            //     ApplicationArea = All;
            //     Caption = 'Open';
            //     ToolTip = 'Open the selected entry.';
            //     Image = Open;

            //     trigger OnAction()
            //     begin
            //         // Logic to open the entry
            //     end;
            // }


        }
    }
}
