table 51508 "Bal Scoring Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bal Score Percipectives"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Percipectives";
        }
        field(2; "Bal Score Emp Categories"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bal Score Emp Categories";
        }
        field(3; Type; Option)
        {
            OptionMembers = " ", Global, Sales, None_Sales;
        }
        field(4; "Percentage Score"; Decimal)
        {
            MinValue = 1;
            MaxValue = 100;
        }
    }
    keys
    {
        key(Key1; "Bal Score Percipectives", "Bal Score Emp Categories", Type)
        {
            Clustered = true;
        }
    }
}
