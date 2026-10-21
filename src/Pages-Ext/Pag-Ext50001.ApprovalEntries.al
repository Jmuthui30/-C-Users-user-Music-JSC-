pageextension 50001 "Approval Entries" extends "Approval Entries"
{
    Editable = true;


    actions
    {
        addlast(Processing)
        {
            action(open)
            {
                ApplicationArea = All;
                Caption = 'Open';
                ToolTip = 'Open the selected entry.';
                Image = Open;

                trigger OnAction()
                begin
                    // Logic to open the entry
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                ToolTip = 'Approve the selected entry.';
                Image = Approve;


                trigger OnAction()
                begin
                    // Logic to close the entry
                end;
            }


        }
    }
}
