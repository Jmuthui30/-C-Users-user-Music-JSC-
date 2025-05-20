table 51643 "Training Needs"
{
    // version THL- HRM 1.0
    DrillDownPageID = "Training Needs";
    LookupPageID = "Training Needs";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Duration Units"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Hours, Days, Weeks, Months, Years;
        }
        field(6; Duration; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Cost Of Training"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Posted then begin
                    if Duration <> xRec.Duration then begin
                        Message('%1', 'You cannot change the costs after posting');
                        Duration:=xRec.Duration;
                    end end end;
        }
        field(8; Location; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Qualification; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = HR_Qualifications.Code;
        }
        field(10; "Re-Assessment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Source; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Training Source".Source;
        }
        field(12; "Need Source"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Appraisal,Succesion,Training,Employee,Employee Skill Plan';
            OptionMembers = Appraisal, Succesion, Training, Employee, "Employee Skill Plan";
        }
        field(13; Provider; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }
        field(14; Post; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Posted; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = true;
        }
        field(16; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(20; "Venue"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Financial Year Code"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Calender Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Calendar End Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(24; Status;Enum "Document Status")
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Created Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
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
