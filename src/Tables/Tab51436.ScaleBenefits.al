table 51436 "Scale Benefits"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Scale Benefits";
    LookupPageID = "Scale Benefits";

    fields
    {
        field(1; Scale; Code[10])
        {
        }
        field(2; Level; Code[10])
        {
        }
        field(3; Earning; Code[10])
        {
        }
        field(4; Description; Text[50])
        {
        }
        field(5; Amount; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; Scale, Level, Earning)
        {
        }
    }
    fieldgroups
    {
    }
}
