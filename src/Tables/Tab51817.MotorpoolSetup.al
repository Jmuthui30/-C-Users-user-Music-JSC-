table 51817 "Motorpool Setup"
{
    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Driver Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Vehicle Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Work Ticket Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(5; "Fuel Card Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "Vehicle Service Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Fuel Voucher Nos."; Code[20])
        {
            TableRelation = "No. Series";
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
