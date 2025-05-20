page 50048 AttachmentUrl
{
    Caption = 'AttachmentUrl';
    PageType = List;
    SourceTable = AttachmentUrl;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    Caption = 'Attachment';
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                    caption = 'URL';
                }
            }
        }
    }
}
