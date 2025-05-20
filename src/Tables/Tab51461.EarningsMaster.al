table 51461 "Earnings Master"
{
    // version THL- Client Payroll 1.0
    DrillDownPageID = "Earnings Master";
    LookupPageID = "Earnings Master";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Pay Type"; Option)
        {
            OptionMembers = Recurring, "Non-recurring";
        }
        field(4; Taxable; Boolean)
        {
        }
        field(5; "Calculation Method"; Option)
        {
            OptionMembers = "Flat amount", "% of Basic pay", "% of Gross pay", "% of Insurance Amount", "% of Taxable income", "% of Basic after tax", "Based on Hourly Rate", "Based on Daily Rate", "% of Salary Recovery", "% of Loan Amount", "% of SHIF";
        }
        field(6; "Flat Amount"; Decimal)
        {
        }
        field(7; Percentage; Decimal)
        {
            DecimalPlaces = 2: 4;
        }
        field(8; "G/L Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(9; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE(Type=CONST(Payment), Code=FIELD(Code), "Payroll Group"=FIELD("Posting Group Filter"), "Payroll Period"=FIELD("Pay Period Filter"), "Employee No"=FIELD("Employee Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Date Filter"; Date)
        {
        }
        field(11; "Posting Group Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Employee Groups";
        }
        field(12; "Pay Period Filter"; Date)
        {
            ClosingDates = false;
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(13; "Non-Cash Benefit"; Boolean)
        {
        }
        field(14; "Minimum Limit"; Decimal)
        {
        }
        field(15; "Maximum Limit"; Decimal)
        {
        }
        field(16; "Reduces Tax"; Boolean)
        {
        }
        field(17; "Overtime Factor"; Decimal)
        {
        }
        field(18; "Employee Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(19; Counter; Integer)
        {
        }
        field(20; "Low Interest Benefit"; Boolean)
        {
        }
        field(21; "Show Balance"; Boolean)
        {
        }
        field(22; CoinageRounding; Boolean)
        {
        }
        field(23; OverTime; Boolean)
        {
        }
        field(24; "Global Dimension 1 Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(25; "Show on Report"; Boolean)
        {
        }
        field(26; "Time Sheet"; Boolean)
        {
        }
        field(27; "Total Days"; Decimal)
        {
        }
        field(28; "Total Hrs"; Decimal)
        {
        }
        field(29; Weekend; Boolean)
        {
        }
        field(30; Weekday; Boolean)
        {
        }
        field(31; "Basic Salary Code"; Boolean)
        {
        }
        field(32; "Earning Type"; Option)
        {
            OptionMembers = "Normal Earning", "Owner Occupier", "Home Savings", "Low Interest", "Tax Relief", "Insurance Relief";
        }
        field(33; "Applies to All"; Boolean)
        {
        }
        field(34; "Show on Master Roll"; Boolean)
        {
        }
        field(35; "House Allowance Code"; Boolean)
        {
        }
        field(36; "Responsibility Allowance Code"; Boolean)
        {
        }
        field(37; "Commuter Allowance Code"; Boolean)
        {
        }
        field(38; Block; Boolean)
        {
        }
        field(39; "Basic Pay Arrears"; Boolean)
        {
        }
        field(40; "Market Rate"; Decimal)
        {
            DecimalPlaces = 2: 5;
        }
        field(41; "Company Rate"; Decimal)
        {
            DecimalPlaces = 2: 5;
        }
        field(42; Fringe; Boolean)
        {
        }
        field(43; "Salary Recovery"; Boolean)
        {
            Description = 'For PAYE Manual calculation';
        }
        field(44; "Loan Code"; Code[20])
        {
        }
        field(45; "Global Dimension 2 Filter"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(46; Company; Code[10])
        {
            TableRelation = "Client Company Information";
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
