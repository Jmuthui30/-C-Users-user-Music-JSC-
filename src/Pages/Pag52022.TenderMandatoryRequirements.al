page 52022 "Tender Mandatory Requirements"
{
    PageType = List;
    SourceTable = "Tender Mandatory Requirements";
    MultipleNewLines = true;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Mandatory Requirement"; Rec."Mandatory Requirement")
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
