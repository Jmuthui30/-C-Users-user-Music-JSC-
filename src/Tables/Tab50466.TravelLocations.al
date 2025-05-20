table 50466 "Travel Locations"
{
    Caption = 'Travel Locations';
    DataClassification = ToBeClassified;
    LookupPageId = "Travel Locations";
    DrillDownPageId = "Travel Locations";

    fields
    {
        field(1; "Code"; Code[50])
        {
            Caption = 'Code';
        }
        field(2; International; Boolean)
        {
            Caption = 'International';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
