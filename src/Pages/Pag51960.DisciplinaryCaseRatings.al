page 51960 "Disciplinary Case Ratings"
{
    PageType = List;
    SourceTable = "Disciplinary Case Ratings";
    Caption = 'Offence Types Ratings';

    layout
    {
        area(content)
        {
            repeater(Control4)
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
