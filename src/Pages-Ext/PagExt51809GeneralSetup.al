pageextension 51809 "Ext General Ledger Setup" extends "General Ledger Setup"
{
    layout
    {
        // Add changes to page layout here
        // Allow Deferral Posting To
        addafter("Allow Deferral Posting To")
        {
            field("Current Budget Start Date"; "Current Budget Start Date")
            {
                ApplicationArea = All;
            }
            field("Current Budget End Date"; "Current Budget End Date")
            {
                ApplicationArea = All;
            }
            field("Current Budget"; "Current Budget")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}