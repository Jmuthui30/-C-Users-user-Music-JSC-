page 50019 "Attachments"
{
    // version THL
    Caption = 'Attachments';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Attachment;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec."Attachment File")
                {
                    ApplicationArea = All;
                }
                field("File Extension"; Rec."File Extension")
                {
                    ApplicationArea = All;
                }
                field("Read Only"; Rec."Read Only")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
