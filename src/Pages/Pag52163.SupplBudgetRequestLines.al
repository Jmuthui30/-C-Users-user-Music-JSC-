page 52163 "Suppl. Budget Request Lines"
{
    PageType = ListPart;
    SourceTable = "Suppl. Budget Request Lines";
    MultipleNewLines = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Transfer From"; Rec."Transfer From")
                {
                    ApplicationArea = All;
                    Style = Unfavorable;
                }
                field("Transfer To"; Rec."Transfer To")
                {
                    ApplicationArea = All;
                    Style = Favorable;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Style = Strong;
                }
            }
        }
    }
}
