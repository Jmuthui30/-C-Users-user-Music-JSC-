page 51958 "Disciplinary Cases"
{
    PageType = List;
    SourceTable = "Disciplinary Cases";
    Caption = 'Offence Types';

    layout
    {
        area(content)
        {
            repeater(Control5)
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
                field(Rating; Rec.Rating)
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
