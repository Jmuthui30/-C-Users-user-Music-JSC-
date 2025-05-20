table 51876 "Job Group Clusters"
{
    DrillDownPageID = "Job Group Clusters";
    LookupPageID = "Job Group Clusters";

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Rates; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Job Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Groups";
        }
    }
    keys
    {
        key(Key1; "Code", "Job Group")
        {
        }
    }
    fieldgroups
    {
    }
}
