table 51506 "Bal Score Card Rating"
{
    Caption = 'Appraisal Rating Scale';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Score; Decimal)
        {
            Caption = 'Score';
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Description';
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
