page 51518 "Bal Score Emp Categories"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bal Score Emp Categories";

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
            }
        }
        area(Factboxes)
        {
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control23; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control24; Links)
            {
                ApplicationArea = All;
            }
        }
    }
}
