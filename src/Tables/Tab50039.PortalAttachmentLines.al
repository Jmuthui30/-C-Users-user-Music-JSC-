table 50039 "Portal Attachment Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(2; "Attachment"; text[250])
        {
            Caption = 'Attachment';
            DataClassification = CustomerContent;
        }
        field(3; "URL"; Text[50])
        {
            Caption = 'URL';
            DataClassification = CustomerContent;
        }
        field(4; Code; Code[100])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Code, Attachment)
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
