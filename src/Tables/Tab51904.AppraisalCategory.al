table 51904 "Appraisal Category"
{
    DrillDownPageID = "Appraisal Category";
    LookupPageID = "Appraisal Category";

    fields
    {
        field(2; "Appraissal Category"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[60])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Appraissal Category")
        {
        }
    }
    fieldgroups
    {
    }
}
