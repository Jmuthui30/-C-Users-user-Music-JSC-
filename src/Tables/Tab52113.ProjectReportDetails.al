table 52113 "Project Report Details"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Project Filter"; Code[10])
        {
        }
        field(4; "Start Date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; "Amount By Project"; Decimal)
        {
        }
        field(7; "Amount Other Projects"; Decimal)
        {
        }
        field(8; "Total Amount"; Decimal)
        {
        }
        field(9; "Annual Budget"; Decimal)
        {
        }
        field(10; "Budget Usage (%)"; Decimal)
        {
            DecimalPlaces = 4: 2;
        }
        field(11; Project; Code[10])
        {
        }
    }
    keys
    {
        key(Key1; Project, "Code")
        {
        }
    }
    fieldgroups
    {
    }
}
