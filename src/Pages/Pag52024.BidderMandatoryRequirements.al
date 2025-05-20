page 52024 "Bidder Mandatory Requirements"
{
    SourceTable = "Bidder Mandatory Requirements";

    layout
    {
        area(content)
        {
            repeater(Control3)
            {
                ShowCaption = false;

                field("Mandatory Requirement"; Rec."Mandatory Requirement")
                {
                    ApplicationArea = All;
                }
                field(Complied; Rec.Complied)
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
