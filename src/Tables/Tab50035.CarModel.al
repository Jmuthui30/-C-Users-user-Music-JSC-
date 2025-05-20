table 50035 "Car Model"
{
    Caption = 'Car Model';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(2; Description; Text[100])
        {
            // DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(3; "Brand Id"; Guid)
        {
            // DataClassification = ToBeClassified;
            Caption = 'Brand Id';
            TableRelation = "Car Brand".SystemId;
        }
        field(4; Power; Integer)
        {
            // DataClassification = ToBeClassified;
            Caption = 'Power (cc)';
        }
        field(5; "Fuel Type";Enum "Fuel Type")
        {
            // DataClassification = ToBeClassified;
            Caption = 'Fuel Type';
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
