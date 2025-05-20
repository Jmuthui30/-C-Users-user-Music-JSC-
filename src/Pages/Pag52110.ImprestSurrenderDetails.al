page 52110 "Imprest Surrender Details"
{
    // version THL- ADV.FIN 1.0
    AutoSplitKey = true;
    Caption = 'Imprest Surrender Details';
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Imprest Details";
    SourceTableView = SORTING("No.", "Line No");

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                Editable = false;

                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = All;
                }
                field(Expense; Rec.Expense)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                }
                field("Request Amount"; Rec."Request Amount")
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ApplicationArea = All;
                }
                field(Claim; Rec.Claim)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Refund; Rec.Refund)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
