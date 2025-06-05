table 52075 Attachments
{
    DrillDownPageID = "Attachments Setup";
    LookupPageID = "Attachments Setup";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Attachment; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Attachment';
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Attachment Type"; Option)
        {
            OptionCaption = ',Job Attachments,Sample Writting';
            OptionMembers = ,"Job Attachments","Sample Writting";
        }
    }

    keys
    {
        key(Key1; Attachment)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}