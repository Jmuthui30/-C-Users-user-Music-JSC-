table 51665 "Job Qualifications"
{
    fields
    {
        field(1; "Job Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; "Qualification Type"; Enum "Qualification Types")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Qualification Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            NotBlank = true;
            TableRelation = Qualification.Code WHERE("Qualification Type" = FIELD("Qualification Type"));

            trigger OnValidate()
            begin
                QualificationSetUp.Reset;
                QualificationSetUp.SetRange(QualificationSetUp.Code, "Qualification Code");
                if QualificationSetUp.Find('-') then Qualification := QualificationSetUp.Description;
            end;
        }
        field(4; Qualification; Text[2000])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
        }
        field(5; "Area of Specialization"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Priority; Enum "Criticality Status")
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Education Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Education Levels";

            trigger OnValidate()
            begin
                if EducationLevels.Get(Rec."Education Code") then begin
                    Rec."Education Level" := EducationLevels.Description;
                    Rec.Level := EducationLevels.level;
                end
            end;
        }
        field(9; "Education Level"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Level; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Mandatory; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Job Id", "Qualification Type", "Qualification Code")
        {
            Clustered = true;
            SumIndexFields = "Score ID";
        }
    }
    var
        QualificationSetUp: Record Qualification;
        EducationLevels: Record "Education Levels";
}
