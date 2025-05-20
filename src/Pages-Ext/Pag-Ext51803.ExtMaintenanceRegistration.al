pageextension 51803 "ExtMaintenance Registration" extends "Maintenance Registration"
{
    layout
    {
        // Add changes to page layout here
        addafter("Service Agent Phone No.")
        {
            field("Next Service Date"; Rec."Next Service Date")
            {
                ApplicationArea = All;
            }
        }
    }
    var myInt: Integer;
}
