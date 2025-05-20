table 51908 "Interview"
{
    DrillDownPageID = "Interviewers Marks Allocation";
    LookupPageID = "Interviewers Marks Allocation";

    fields
    {
        field(1; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Applicant No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Interviewer; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Interviewer Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[250])
        {
            Caption = 'Recommendation';
            DataClassification = ToBeClassified;
        }
        field(6; Marks; Decimal)
        {
            DataClassification = ToBeClassified;
            MaxValue = 100;
            MinValue = 0;
        }
        field(7; "Vacancy No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = true;
            TableRelation = "Recruitment Needs"."No.";
        }
    }
    keys
    {
        key(Key1; "Line No.", "Applicant No", Interviewer, "Vacancy No.")
        {
        }
    }
    fieldgroups
    {
    }
}
