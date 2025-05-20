table 51651 "Qualitative Deliverables"
{
    fields
    {
        field(1; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(2; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(3; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(4; "No."; Code[10])
        {
        }
        field(5; "Focus Area"; Text[30])
        {
        }
        field(6; Description; Text[250])
        {
        }
        field(7; Section; Option)
        {
            OptionCaption = 'B,C';
            OptionMembers = B, C;
        }
    }
    keys
    {
        key(Key1; "Global Dimension 1 Code", "Global Dimension 2 Code", "Global Dimension 3 Code", "No.")
        {
        }
    }
    fieldgroups
    {
    }
}
