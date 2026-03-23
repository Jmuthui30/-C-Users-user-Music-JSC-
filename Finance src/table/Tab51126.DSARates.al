table 51126 "DSA Rates"
{
    Caption = 'DSA Rates';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job Group"; Code[30])
        {
            Caption = 'Job Group';
            TableRelation = "Client Salary Scale".Scale;
        }
        field(2; Rates; Decimal)
        {
            Caption = 'Rates';
        }
    }
    keys
    {
        key(PK; "Job Group")
        {
            Clustered = true;
        }
    }
}
