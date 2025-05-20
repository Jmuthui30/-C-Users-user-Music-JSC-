table 50038 "Portal Attachment"
{
    // Caption = 'PortalAttachment';
    DataClassification = CustomerContent;
    DrillDownPageId = "Attachment Lines";
    LookupPageId = "Attachment List";

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            AutoIncrement = true;
        }
        field(2; Attachment; Text[100])
        {
            Caption = 'Attachment';
        }
    }
    keys
    {
        key(PK; Attachment)
        {
            Clustered = true;
        }
    }
}
