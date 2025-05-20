table 51464 "Client Salary Scale"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Client Salary Scales";
    LookupPageID = "Client Salary Scales";

    fields
    {
        field(1; Scale; Code[10])
        {
        }
        field(2; "Minimum Level"; Code[10])
        {
            TableRelation = "Client Salary Level".Level;
        }
        field(3; "Maximum Level"; Code[10])
        {
            TableRelation = "Client Salary Level".Level;
        }
        field(4; "Inpatient Limit"; Decimal)
        {
        }
        field(5; "Outpatient Limit"; Decimal)
        {
        }
        field(6; Client; Code[10])
        {
        }
    }
    keys
    {
        key(Key1; Client, Scale)
        {
        }
    }
    fieldgroups
    {
    }
}
