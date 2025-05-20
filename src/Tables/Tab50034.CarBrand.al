table 50034 "Car Brand"
{
    Caption = 'Car Brand';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(3; "Country"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country';
        }
    }
    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }
}
