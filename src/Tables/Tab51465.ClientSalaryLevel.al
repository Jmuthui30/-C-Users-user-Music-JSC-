table 51465 "Client Salary Level"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Salary Levels";
    LookupPageID = "Client Salary Levels";

    fields
    {
        field(1; Client; Code[10])
        {
        }
        field(2; Level; Code[10])
        {
        }
    }
    keys
    {
        key(Key1; Client, Level)
        {
        }
    }
    fieldgroups
    {
    }
}
