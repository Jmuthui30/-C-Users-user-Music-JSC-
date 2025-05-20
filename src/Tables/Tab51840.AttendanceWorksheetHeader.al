table 51840 "Attendance Worksheet Header"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Attendance List";
    LookupPageID = "Attendance List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Raised By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(5; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "No. Lines"; Integer)
        {
            CalcFormula = Count("Attendance Worksheet Lines" WHERE("Document No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(8; "Working Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        "Raised By":=UserId;
        "Posting Date":=Today;
        Admins.Reset;
        Admins.SetRange("User ID", "Raised By");
        if Admins.FindFirst then "Shortcut Dimension 1 Code":=Admins."Shortcut Dimension 1 Code";
    end;
    var Admins: Record Admins;
}
