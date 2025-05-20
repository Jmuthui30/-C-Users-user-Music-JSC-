table 51900 "Appraisal Formats"
{
    fields
    {
        field(1; "Appraisal Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Appraisal Types".Code;
        }
        field(2; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Question, "Heading 2", Category, "Heading 1";
        }
        field(4; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(5; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Entry By"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "After Entry Of Prev. Group"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Allow Previous Groups Rights"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "In Put"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Grades, Marks, Details;
        }
        field(10; "Appraisal Heading Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Objectives,Core Values,Core Competencies,Managerial and Supervisory,Mid-year Appraisal,Annual Appraisal,Training Needs';
            OptionMembers = " ", Objectives, "Core Values", "Core Competencies", "Managerial and Supervisory", "Mid-year Appraisal", "Annual Appraisal", "Training Needs";
        }
        field(11; "Appraisal Header"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Appraisal Format Header";
        }
        field(12; Value; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Bold; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appraisal Code", "Line No.")
        {
        }
        key(Key2; "Appraisal Code", Sequence)
        {
        }
    }
    fieldgroups
    {
    }
}
