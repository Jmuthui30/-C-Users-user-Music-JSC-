table 51485 "Client Cost Center"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Cost Centers";
    LookupPageID = "Client Cost Centers";

    fields
    {
        field(1; Client; Code[10])
        {
        }
        field(2; "Cost Center"; Code[50])
        {
        }
        field(3; Description; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; Client, "Cost Center")
        {
        }
    }
    fieldgroups
    {
    }
}
