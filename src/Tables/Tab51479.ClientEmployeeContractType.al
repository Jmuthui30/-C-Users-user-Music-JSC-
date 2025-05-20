table 51479 "Client Employee Contract Type"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Employee Contract Types";
    LookupPageID = "Client Employee Contract Types";

    fields
    {
        field(1; Client; Code[10])
        {
        }
        field(2; Contract; Code[50])
        {
        }
        field(3; Description; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; Client, Contract)
        {
        }
    }
    fieldgroups
    {
    }
}
