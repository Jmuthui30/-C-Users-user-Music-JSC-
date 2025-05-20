table 51626 "Medical Cover Limits"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Medical Cover Limits";
    LookupPageID = "Medical Cover Limits";

    fields
    {
        field(1; Cover; Code[10])
        {
            TableRelation = "Medical Schemes";
        }
        field(2; Scale; Code[10])
        {
            TableRelation = "Salary Scale";
        }
        field(3; Level; Code[10])
        {
            TableRelation = "Salary Level";
        }
        field(4; Amount; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; Cover, Scale, Level)
        {
        }
    }
    fieldgroups
    {
    }
}
