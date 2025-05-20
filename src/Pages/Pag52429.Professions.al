page 52429 "Professions"
{
    ApplicationArea = All;
    Caption = 'Professions';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Professions;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
