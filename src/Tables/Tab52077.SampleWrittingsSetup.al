table 52077 "Sample Writtings Setup"
{
    Caption = 'Sample Writtings Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            NotBlank = true;
        }
        field(2; "Title"; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Attachment Link"; Text[250])
        {
            DataClassification = ToBeClassified;
            //Subtype = Memo;
        }
        field(4; "Sample No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Sample Header"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }


    }
    keys
    {
        key(Key1; "Job ID", "Sample No")
        {
            Clustered = true;
        }
    }
}
