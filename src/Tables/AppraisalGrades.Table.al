table 52038 "Appraisal Grades"
{
    DataClassification = CustomerContent;
    Caption = 'Appraisal Grades';
    fields
    {
        field(1; Score; Decimal)
        {
            Caption = 'Score';
        }
        field(2; Rating; Text[50])
        {
            Caption = 'Rating';
        }
        field(3; Description; Text[250])
        {
            Caption = 'Description';
        }
        field(4; Grade; Text[250])
        {
            Caption = 'Grade';
        }
        field(5; Points; Text[250])
        {
            Caption = 'Points';
        }
    }

    keys
    {
        key(Key1; Score)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}





