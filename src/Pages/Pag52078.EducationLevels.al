page 52078 "Education Levels"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Education Levels";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(level; Rec.level)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
}
