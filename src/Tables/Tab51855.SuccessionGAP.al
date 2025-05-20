table 51855 "Succession GAP"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Job Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Qualification Type"; Option)
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            OptionMembers = " ", Academic, Professional, Technical, Experience, "Personal Attributes";
        }
        field(4; "Qualification Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = true;

            trigger OnValidate()
            begin
                QualificationSetUp.Reset;
                QualificationSetUp.SetRange(QualificationSetUp.Code, Qualification);
                if QualificationSetUp.Find('-')then "Qualification Code":=QualificationSetUp.Description;
            end;
        }
        field(5; Qualification; Text[200])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(6; "Job Requirements"; Text[250])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(7; Priority; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", High, Medium, Low;
        }
        field(8; "Job Specification"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Academic, Professional, Technical, Experience;
        }
        field(9; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
            TableRelation = Qualification."Qualified Employees";
        }
    }
    keys
    {
        key(Key1; "Employee No", "Job Id", "Qualification Code")
        {
        }
    }
    fieldgroups
    {
    }
    var QualificationSetUp: Record HR_Qualifications;
}
