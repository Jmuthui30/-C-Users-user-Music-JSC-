table 52147 "Amortization Distribution"
{
    DrillDownPageID = "Amortization Distribution";
    LookupPageID = "Amortization Distribution";

    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; Period; Date)
        {
        }
        field(3; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(4; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(5; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; "Distribution Share"; Integer)
        {
        }
        field(8; Addition; Decimal)
        {
        }
        field(9; "Total Addition"; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; No, Period, "Global Dimension 1 Code", "Global Dimension 2 Code", "Global Dimension 3 Code")
        {
            SumIndexFields = Amount, Addition;
        }
    }
    fieldgroups
    {
    }
}
