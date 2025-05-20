page 51514 "Bal Score Card Rating"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bal Score Card Rating";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
