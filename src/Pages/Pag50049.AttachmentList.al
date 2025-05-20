page 50049 "Attachment List"
{
    ApplicationArea = All;
    Caption = 'Attachment List';
    PageType = List;
    SourceTable = "Portal Attachment";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
