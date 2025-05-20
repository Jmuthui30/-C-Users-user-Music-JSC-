table 50026 "Titles of Sample Writings"
{
    fields
    {
        field(1; "Source No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Title"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Attachment Link"; Text[250])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
        }
        field(4; "Sample No"; Code[200])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Job ID"; Code[200])
        {
        }
        field(6; "Entry No"; Integer)
        {

        }
    }
    keys
    {
        key(Key1; "Source No", Title)
        {
            Clustered = true;
        }
        key(key2; "Entry No") { }
        key(key3; "Job ID") { }
    }
}
