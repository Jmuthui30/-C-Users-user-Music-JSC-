page 51955 "Training Sources"
{
    PageType = List;
    SourceTable = "Training Source";

    layout
    {
        area(content)
        {
            repeater(Control3)
            {
                ShowCaption = false;

                field(Source; Rec.Source)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
