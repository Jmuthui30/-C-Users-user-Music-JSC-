page 50069 "Job Attachments"
{
    PageType = ListPart;
    SourceTable = "Job Attachments";

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;
                field(count; count) { ApplicationArea = All; ToolTip = 'Specifies the value of the Job ID field'; }
                field("Job ID"; Rec."Job ID")
                {
                    Visible = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Job ID field';
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Attachment field';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field';
                }
                field(Header; Header)
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