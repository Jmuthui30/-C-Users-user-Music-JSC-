page 50068 "Attachments Setup"
{
    ApplicationArea = All;
    Caption = 'Attachments Setup';
    PageType = List;
    SourceTable = Attachments;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Attachment; Rec.Attachment)
                {
                    ToolTip = 'Specifies the value of the Attachment field.', Comment = '%';
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ApplicationArea = all;
                }
            }
        }
    }
}
