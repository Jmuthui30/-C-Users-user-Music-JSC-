table 51858 "Job Requirements"
{
    DrillDownPageID = "Job Requirements";
    LookupPageID = "Job Requirements";

    fields
    {
        field(1; "Job Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(2; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(3; "Qualification Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = true;
            TableRelation = HR_Qualifications.Code WHERE("Qualification Type"=FIELD("Qualification Type"));

            trigger OnValidate()
            begin
                QualificationSetUp.Reset;
                QualificationSetUp.SetRange(QualificationSetUp.Code, "Qualification Code");
                if QualificationSetUp.Find('-')then Qualification:=QualificationSetUp.Description;
            end;
        }
        field(4; Qualification; Text[200])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(5; "Job Requirements"; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(6; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", High, Medium, Low;
        }
        field(7; "Job Specification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Academic, Professional, Technical, Experience;
        }
        field(8; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job Id", "Qualification Type", "Qualification Code")
        {
            SumIndexFields = "Score ID";
        }
    }
    fieldgroups
    {
    }
    var QualificationSetUp: Record HR_Qualifications;
}
