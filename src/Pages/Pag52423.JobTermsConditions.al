page 52423 "Job Terms & Conditions"
{
    PageType = ListPart;
    SourceTable = "Job Terms & Conditions";
    SourceTableView = SORTING(Sequence)ORDER(Ascending);

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                ShowCaption = false;

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
