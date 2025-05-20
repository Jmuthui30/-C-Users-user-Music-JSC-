page 52027 "Appraisal Format Header"
{
    PageType = List;
    SourceTable = "Appraisal Format Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Header; Rec.Header)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
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
