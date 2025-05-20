table 51832 "Fuel Voucher Stations"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Name; Text[100])
        {
        }
        field(3; Address; Text[50])
        {
        }
        field(4; Phone; Text[20])
        {
        }
        field(5; "Bulk Fuel Voucher Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(6; "Vehicle Fuel Voucher Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Motorcycle Fuel Voucher Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
}
