table 51836 "Fuel Card Entries"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Fuel Card Entries";
    LookupPageID = "Fuel Card Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Card No"; Code[10])
        {
        }
        field(3; Date; Date)
        {
        }
        field(4; "Transaction Type"; Option)
        {
            OptionCaption = 'Top-up,Consumption';
            OptionMembers = "Top-up", Consumption;
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; USERID; Code[50])
        {
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
    }
    fieldgroups
    {
    }
}
