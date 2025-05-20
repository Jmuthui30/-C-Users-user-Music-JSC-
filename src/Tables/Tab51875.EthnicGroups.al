table 51875 "Ethnic Groups"
{
    DrillDownPageID = "Ethnic Groups";
    LookupPageID = "Ethnic Groups";

    fields
    {
        field(1; "Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[30])
        {
            DataClassification = ToBeClassified;
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
