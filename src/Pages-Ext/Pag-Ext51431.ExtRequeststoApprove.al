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
    }
}
