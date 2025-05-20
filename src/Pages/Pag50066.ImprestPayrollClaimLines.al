page 50066 "Imprest Payroll Claim Lines"
{
    ApplicationArea = All;
    Caption = 'Imprest Payroll Claim Lines';
    PageType = ListPart;
    SourceTable = "Imprest Payroll Claim Lines";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No"; Rec."Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    Editable = false;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    Editable = false;
                }
                field(Expense; Rec.Expense)
                {
                    Editable = false;
                }
                field("Type"; Rec."Type")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account No"; Rec."Account No")
                {
                    Editable = false;
                    Visible = false;
                }
                field("Account Name"; Rec."Account Name")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Narration; Rec.Narration)
                {
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    Editable = false;
                }
                field("Payroll Code"; Rec."Payroll Code")
                {
                }
                field("Payroll Earning Code"; Rec."Payroll Earning Code")
                {
                }
                field("Payroll Description"; Rec."Payroll Description")
                {
                    Editable = false;
                }
            }
        }
    }
}
