page 51688 "Scheme Expense Code"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Medical Schemes";

    layout
    {
        area(content)
        {
            group("Expense Account")
            {
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = All;
                }
                field(Expense; Rec.Expense)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pay Claim To"; Rec."Pay Claim To")
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
