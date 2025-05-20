table 51862 "Training Source"
{
    DrillDownPageID = "Training Sources";
    LookupPageID = "Training Sources";

    fields
    {
        field(1; Source; Code[50])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Remarks; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; Source)
        {
        }
    }
    fieldgroups
    {
    }
}
