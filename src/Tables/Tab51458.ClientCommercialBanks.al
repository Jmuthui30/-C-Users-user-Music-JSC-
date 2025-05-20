table 51458 "Client Commercial Banks"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Commercial Banks";
    LookupPageID = "Client Commercial Banks";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Name; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
}
