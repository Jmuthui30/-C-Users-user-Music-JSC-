pageextension 51806 PurchaseOrderList extends "Purchase Order List"
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
