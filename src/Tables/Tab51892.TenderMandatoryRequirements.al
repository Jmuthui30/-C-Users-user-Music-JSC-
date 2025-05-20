table 51892 "Tender Mandatory Requirements"
{
    DrillDownPageID = "Tender Mandatory Requirements";
    LookupPageID = "Tender Mandatory Requirements";

    fields
    {
        field(1; "Tender No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Mandatory Requirement"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(3; LineNo; Integer)
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Tender No", LineNo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
