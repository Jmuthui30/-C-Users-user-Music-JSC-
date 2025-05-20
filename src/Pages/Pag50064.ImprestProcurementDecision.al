page 50064 "Imprest Procurement Decision"
{
    ApplicationArea = All;
    Caption = 'Imprest Procurement Decision';
    PageType = List;
    SourceTable = "Imprest Procurement Decision";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                }
                field(Currency; Rec.Currency)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field(Decision; Rec.Decision)
                {
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
            }
        }
    }
}
