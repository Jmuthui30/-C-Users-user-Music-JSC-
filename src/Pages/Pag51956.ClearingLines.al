page 51956 "Clearing Lines"
{
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Separation Lines";

    layout
    {
        area(content)
        {
            repeater(Control6)
            {
                ShowCaption = false;

                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field(Cleared; Rec.Cleared)
                {
                    ApplicationArea = All;
                }
                field("Cleared Date"; Rec."Cleared Date")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
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
