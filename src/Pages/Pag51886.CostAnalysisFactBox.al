page 51886 "Cost Analysis FactBox"
{
    // version THL- PRM 1.0
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Cost Apportionment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Total Amount Spent"; Rec."Total Amount Spent")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                }
            }
        }
    }
    actions
    {
    }
}
