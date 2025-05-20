table 51821 "Motorpool Cost Matrix"
{
    fields
    {
        field(1; "Vehicle No."; Code[10])
        {
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
        }
        field(3; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
        }
        field(4; Period; Date)
        {
        }
        field(5; "Cost Code"; Code[10])
        {
        }
        field(6; Description; Text[50])
        {
        }
        field(7; Amount; Decimal)
        {
        }
        field(8; Closed; Boolean)
        {
        }
        field(9; "Closed By"; Code[50])
        {
        }
        field(10; "Closed Date"; Date)
        {
        }
        field(11; "Cost Center"; Code[10])
        {
        }
    }
    keys
    {
        key(Key1; "Vehicle No.", "Global Dimension 1 Code", "Global Dimension 2 Code", Period, "Cost Code")
        {
            SumIndexFields = Amount;
        }
    }
    fieldgroups
    {
    }
}
