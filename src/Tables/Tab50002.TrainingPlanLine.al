table 50002 "Training Plan Line"
{
    Caption = 'Training Plan Line';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
            Editable = false;
        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;
        }
        field(4; "Course Description"; Text[250])
        {
            Caption = 'Course Description';
            DataClassification = CustomerContent;
        }
        field(5; "Planned Start Date"; Date)
        {
            Caption = 'Planned Start Date';
            DataClassification = CustomerContent;
        }
        field(6; "Planned End Date"; Date)
        {
            Caption = 'Planned End Date';
            DataClassification = CustomerContent;
        }
        field(7; "Course Provide Code"; Code[20])
        {
            Caption = 'Course Provide Code';
            DataClassification = CustomerContent;
        }
        field(8; "Course Provider Name"; Text[250])
        {
            Caption = 'Course Provider Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code", "Line No.")
        {
            Clustered = true;
        }
    }
}
