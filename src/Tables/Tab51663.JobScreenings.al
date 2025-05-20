table 51663 "Job Screenings"
{
    DataClassification = CustomerContent;
    LookupPageId = "Job Screenings";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[200])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
