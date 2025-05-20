pageextension 51807 PurchaseQuoteList extends "Purchase Quotes"
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
