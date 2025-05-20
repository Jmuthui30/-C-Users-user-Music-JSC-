tableextension 50003 AttachmentExt extends Attachment
{
    fields
    {
        field(50000; "Attachment"; Text[100])
        {
            Caption = 'Attachment';
            TableRelation = AttachmentUrl;
            // DataClassification = ToBeClassified;
        }
        field(50001; "URL"; Text[250])
        {
            // DataClassification = ToBeClassified;
            ExtendedDatatype = URL;
            Caption = 'URL';
        }

    }
}
