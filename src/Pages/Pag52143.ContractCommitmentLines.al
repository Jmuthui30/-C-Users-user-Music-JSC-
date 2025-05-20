page 52143 "Contract Commitment Lines"
{
    AutoSplitKey = true;
    Caption = 'Commitment Lines';
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Contract Commitment Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Commitment Date"; Rec."Commitment Date")
                {
                    ApplicationArea = All;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = All;
                }
                field("Expense Description"; Rec."Expense Description")
                {
                    ApplicationArea = All;
                }
                field("GL Account No."; Rec."GL Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
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
