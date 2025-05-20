table 51668 "Job Terms & Conditions"
{
    fields
    {
        field(1; "Job Id"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Sequence; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Job Id", Description)
        {
            Clustered = true;
        }
    }
}
