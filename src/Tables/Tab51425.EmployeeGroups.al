table 51425 "Employee Groups"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Employee Groups";
    LookupPageID = "Employee Groups";

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Basic Salary Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(4; "Income Tax account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(5; "NSSF Employer Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(6; "NSSF Total Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(7; "Pension Employee Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Pension Employer Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Net Pay Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(10; Permanent; Boolean)
        {
        }
        field(11; "Temporary"; Boolean)
        {
        }
        field(12; Intern; Boolean)
        {
        }
        field(13; Secondment; Boolean)
        {
        }
        field(14; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(50; "Posting Group"; Code[20])
        {
            TableRelation = "Employee Posting Group"."Code";
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
