table 51911 "Education Levels"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Education Levels";
    LookupPageId = "Education Levels";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; level; Integer)
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
