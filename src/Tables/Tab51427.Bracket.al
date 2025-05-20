table 51427 "Bracket"
{
    // version THL- Payroll 1.0
    DrillDownPageID = Bracket;
    LookupPageID = Bracket;

    fields
    {
        field(1; "Table Code"; Code[10])
        {
            TableRelation = "Bracket Table";
        }
        field(2; Band; Code[10])
        {
        }
        field(3; "Base Amount"; Decimal)
        {
        }
        field(4; Percentage; Decimal)
        {
        }
        field(5; "Lower Limit"; Decimal)
        {
        }
        field(6; "Upper Limit"; Decimal)
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; "From Date"; Date)
        {
        }
        field(9; "End Date"; Date)
        {
        }
        field(10; "Pay period"; Date)
        {
        }
        field(11; "Taxable Amount"; Decimal)
        {
        }
        field(12; "Total taxable"; Decimal)
        {
        }
        field(13; "Factor Without Housing"; Decimal)
        {
            DecimalPlaces = 2: ;
        }
        field(14; "Factor With Housing"; Decimal)
        {
            DecimalPlaces = 2: ;
        }
        field(15; Institution; Code[20])
        {
            TableRelation = Institution;
        }
        field(16; "Contribution Rates Inclusive"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Table Code", Band)
        {
        }
    }
    fieldgroups
    {
    }
}
