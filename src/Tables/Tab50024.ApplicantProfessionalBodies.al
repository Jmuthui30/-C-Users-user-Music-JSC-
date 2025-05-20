table 50024 "Applicant Professional Bodies"
{
    DrillDownPageID = "Applicant Professional Bodies";
    LookupPageID = "Applicant Professional Bodies";

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Code; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = true;
            TableRelation = "Professional Bodies";

            trigger OnValidate()
            begin
                if ProfessionalBody.Get(Code) then Name := ProfessionalBody.Name;
            end;
        }
        field(3; Name; Text[1000])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(4; Description; Text[1250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Priority; Enum "Criticality Status")
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Membership/Registration No."; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Date of Admission"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Membership Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            OptionMembers = Active,Inactive;
        }
        field(11; "Attachment Link"; Text[1250])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Line No"; Integer)
        {

        }
    }
    keys
    {
        key(Key1; "Applicant No.", Code)
        {
            Clustered = true;
            SumIndexFields = "Score ID";
        }
        key(Key2; Code, "Applicant No.")
        {
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdowm; "Applicant No.", Code, Name)
        {
        }
        fieldgroup(Brick; "Applicant No.", Code, Name)
        {
        }
    }
    var
        ProfessionalBody: Record "Professional Bodies";
}
