table 51478 "Client Department"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Departments";
    LookupPageID = "Client Departments";

    fields
    {
        field(1; Client; Code[10])
        {
        }
        field(2; Department; Code[50])
        {
        }
        field(3; Description; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; Client, Department)
        {
        }
    }
    fieldgroups
    {
    }
}
