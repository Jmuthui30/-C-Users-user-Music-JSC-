pageextension 51805 "ExtVendor List" extends "Vendor List"
{
    layout
    {
        addafter("No.")
        {
            field("Vendor App. No."; Rec."Vendor Application No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
