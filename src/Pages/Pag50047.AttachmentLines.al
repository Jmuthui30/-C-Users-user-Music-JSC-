page 50047 "Attachment Lines"
{
    MultipleNewLines = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = ListPart;
    SourceTable = "Portal Attachment Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Attachment; Rec.Attachment)
                {
                    ApplicationArea = All;
                    TableRelation = "Portal Attachment";
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
