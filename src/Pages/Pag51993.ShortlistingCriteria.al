page 51993 "Shortlisting Criteria"
{
    PageType = ListPart;
    SourceTable = "Shortlisting Criteria";
    Caption = 'Recruitment Criteria';

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                ShowCaption = false;

                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                }
                field("Desired Score"; Rec."Desired Score")
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
