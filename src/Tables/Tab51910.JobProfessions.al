table 51910 "Job Professions"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Job Professions";
    DrillDownPageId = "Job Professions";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(key1; Code)
        {
            Clustered = true;
        }
    }
}
