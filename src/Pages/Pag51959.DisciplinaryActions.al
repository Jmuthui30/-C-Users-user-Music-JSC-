page 51959 "Disciplinary Actions"
{
    PageType = List;
    SourceTable = "Disciplinary Actions";

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                ShowCaption = false;

                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Terminate; Rec.Terminate)
                {
                    ApplicationArea = All;
                }
                field(Document; Rec.Document)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
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
