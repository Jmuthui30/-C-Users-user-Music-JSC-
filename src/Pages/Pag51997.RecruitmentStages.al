page 51997 "Recruitment Stages"
{
    PageType = Card;
    SourceTable = "Recruitment Stages";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                ShowCaption = false;

                field("Recruitement Stage"; Rec."Recruitement Stage")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Failed Response Templates"; Rec."Failed Response Templates")
                {
                    ApplicationArea = All;
                }
                field("Passed Response Templates"; Rec."Passed Response Templates")
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
