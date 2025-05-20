table 51895 "Appraisal Types"
{
    LookupPageID = "Appraisal Types";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Use Template"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Template Link"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Max. Weighting"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Max. Score"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Minimum Job Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
        }
        field(9; "Maximum Job Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale";
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
