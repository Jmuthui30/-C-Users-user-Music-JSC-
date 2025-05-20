table 51820 "Work Ticket Drivers"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Work Ticket Drivers";
    LookupPageID = "Work Ticket Drivers";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; Vehicle; Code[10])
        {
            TableRelation = Vehicle;
        }
        field(3; "Driver No."; Code[20])
        {
            TableRelation = Driver;

            trigger OnValidate()
            begin
                if Drivers.Get("Driver No.")then "Driver Name":=Drivers.Name;
            end;
        }
        field(4; "Driver Name"; Text[100])
        {
        }
    }
    keys
    {
        key(Key1; "No.", Vehicle, "Driver No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Drivers: Record Driver;
}
