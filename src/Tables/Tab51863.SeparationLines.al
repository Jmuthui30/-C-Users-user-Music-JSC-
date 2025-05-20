table 51863 "Separation Lines"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Item Description"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Cleared; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Cleared Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Department Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(7; Remarks; Text[80])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Employee No", "Line No")
        {
        }
    }
    fieldgroups
    {
    }
}
