table 51435 "Salary Level"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Salary Levels";
    LookupPageID = "Salary Levels";

    fields
    {
        field(1; Level; Code[10])
        {
        }
        field(2; "Basic Pay int"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Basic Pay"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Level)
        {
        }
    }
    fieldgroups
    {
    }
}
