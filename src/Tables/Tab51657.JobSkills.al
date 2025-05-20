table 51657 "Job Skills"
{
    LookupPageId = "Job Skills";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Level;Enum "Job Level")
        {
            DataClassification = CustomerContent;
            Caption = 'Level';
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
