table 51506 "Bal Score Card Rating"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Score; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; Score)
        {
            Clustered = true;
        }
    }
}
