table 51901 "Appraisal Periods"
{
    DrillDownPageID = "Appraisal Periods";
    LookupPageID = "Appraisal Periods";

    fields
    {
        field(1; Period; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Comments; Text[250])
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
    }
    keys
    {
        key(Key1; Period)
        {
        }
    }
    fieldgroups
    {
    }
}
