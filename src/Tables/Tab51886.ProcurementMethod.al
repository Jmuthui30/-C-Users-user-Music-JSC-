table 51886 "Procurement Method"
{
    DrillDownPageID = "Procurement Method";
    LookupPageID = "Procurement Method";

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
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
