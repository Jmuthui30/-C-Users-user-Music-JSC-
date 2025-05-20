table 51852 "Score Setup"
{
    DrillDownPageID = "Score Setup";
    LookupPageID = "Score Setup";

    fields
    {
        field(1; "Score ID"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Score; Text[30])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Score ID")
        {
        }
    }
    fieldgroups
    {
    }
}
