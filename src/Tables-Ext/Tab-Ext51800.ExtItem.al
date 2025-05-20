tableextension 51800 "ExtItem" extends Item
{
    fields
    {
        // Add changes to table fields here
        field(51423; "Item Status";Enum "Item Status")
        {
            DataClassification = CustomerContent;
        }
    }
    trigger OnInsert()
    begin
        "Item Status":="Item Status"::Active;
    end;
    var myInt: Integer;
}
