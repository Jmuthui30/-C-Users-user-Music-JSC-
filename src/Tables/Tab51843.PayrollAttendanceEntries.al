table 51843 "Payroll Attendance Entries"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Attendance Entries List";
    LookupPageID = "Attendance Entries List";

    fields
    {
        field(1; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'External,Management';
            OptionMembers = External, Management;
        }
        field(4; "Posting Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Holiday,Overtime,Absent,Late,Sick Off,Sick Leave,Marternity,Parternity,Annual,Unpaid Leave,Normal_Day,Relief';
            OptionMembers = " ", Holiday, Overtime, Absent, Late, "Sick Off", "Sick Leave", Marternity, Parternity, Annual, "Unpaid Leave", Normal_Day, Relief;
        }
        field(5; "Working Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "P/No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(11; Holiday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Normal Day"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Absent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Normal Overtime"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Overtime Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Posted By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(17; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Leave; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Relief; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Sunday; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Special Overtime"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(22; Hours; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Late; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Reason; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Line No", "Document No.", Type, "Posting Type", "Working Date", "Employee No.")
        {
        }
    }
    fieldgroups
    {
    }
}
