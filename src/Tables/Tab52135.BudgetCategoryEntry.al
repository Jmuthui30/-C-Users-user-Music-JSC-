table 52135 "Budget Category Entry"
{
    DrillDownPageID = "Budget Category Entries";
    LookupPageID = "Budget Category Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
        }
        field(2; "Document No."; Code[20])
        {
        }
        field(3; "Posting Date"; Date)
        {
        }
        field(4; Type; Option)
        {
            OptionCaption = 'Initial Entry,Application';
            OptionMembers = "Initial Entry", Application;
        }
        field(5; "Category Code"; Code[20])
        {
        }
        field(6; Amount; Decimal)
        {
        }
        field(7; Budget; Code[10])
        {
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(10; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
        }
        key(Key2; "Category Code", Budget, "Global Dimension 1 Code", "Global Dimension 2 Code", "Global Dimension 3 Code", "Document No.")
        {
        }
    }
    fieldgroups
    {
    }
}
