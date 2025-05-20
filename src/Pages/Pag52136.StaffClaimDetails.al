page 52136 "Staff Claim Details"
{
    // version THL- ADV.FIN 1.0
    AutoSplitKey = true;
    Caption = 'Staff Claim Details';
    InsertAllowed = false;
    DeleteAllowed = false;
    MultipleNewLines = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Imprest Details";
    SourceTableView = SORTING("No.", "Line No");

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ApplicationArea = All;
                    Caption = 'Expenditure Amount';

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Decision:=Rec.Decision::"Pay Cash to Traveller";
    end;
}
