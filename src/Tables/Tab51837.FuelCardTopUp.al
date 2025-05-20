table 51837 "Fuel Card Top Up"
{
    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Top Up Date"; Date)
        {
        }
        field(3; "Card No."; Code[10])
        {
        }
        field(4; "Card Name"; Text[50])
        {
        }
        field(5; Amount; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
}
