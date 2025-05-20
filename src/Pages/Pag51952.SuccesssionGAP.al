page 51952 "Successsion GAP"
{
    PageType = ListPart;
    SourceTable = "Succession GAP";

    layout
    {
        area(content)
        {
            repeater(Control5)
            {
                Editable = false;
                ShowCaption = false;

                field("Qualification Type"; Rec."Qualification Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Qualification Code"; Rec."Qualification Code")
                {
                    ApplicationArea = All;
                }
                field(Qualification; Rec.Qualification)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
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
