table 50036 AttachmentUrl
{
    Caption = 'AttachmentUrl';

    fields
    {
        field(1; "Attachment"; code[100])
        {
            Caption = 'Attachment';
        // TableRelation = Attachment;
        }
        field(2; "URL"; Text[150])
        {
            ExtendedDatatype = URL;
            Caption = 'URL';
        }
    }
    keys
    {
        key(PK; "Attachment")
        {
            Clustered = true;
        }
    }
}
