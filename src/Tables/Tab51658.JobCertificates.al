table 51658 "Job Certificates"
{
    LookupPageId = "Job Certificates";
    DrillDownPageId = "Job Certificates";
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }
    keys
    {
        key(Pk; Code)
        {
            Clustered = true;
        }
    }
}
