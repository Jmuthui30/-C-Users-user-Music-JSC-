page 52205 "Prepayment Lines"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = true;
    PageType = ListPart;
    SourceTable = "Amortization Lines";
    SourceTableView = SORTING(No, Period);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Period Name"; Rec."Period Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Expensed; Rec.Expensed)
                {
                    ApplicationArea = All;
                }
                field(Addition; Rec.Addition)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount Distributed"; Rec."Amount Distributed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Addition Distributed"; Rec."Addition Distributed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Distribution Base"; Rec."Distribution Base")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
}
