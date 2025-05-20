table 51822 "Motorpool Cost"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[50])
        {
        }
        field(3; "Total Amount"; Decimal)
        {
            CalcFormula = Sum("Motorpool Cost Matrix".Amount WHERE("Cost Code"=FIELD(Code), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"), Period=FIELD("Date Filter"), "Vehicle No."=FIELD("Vehicle Filter")));
            FieldClass = FlowField;
        }
        field(4; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(5; "Vehicle Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Vehicle;
        }
        field(6; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,1,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; "Distribution Method"; Option)
        {
            OptionCaption = 'Based on Mileage,Based on Staff Numbers,Based on office Space Covered,Based on Electronic Footprint';
            OptionMembers = "Based on Mileage", "Based on Staff Numbers", "Based on office Space Covered", "Based on Electronic Footprint";
        }
        field(9; "Cost Analysis"; Option)
        {
            OptionCaption = 'Per Cost Center,Per Vehicle';
            OptionMembers = "Per Cost Center", "Per Vehicle";
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
