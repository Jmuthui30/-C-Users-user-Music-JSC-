page 52114 "SS Imprest Surrender Details"
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
                field("Expense Code"; Rec."Expense Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Expense; Rec.Expense)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Request Amount"; Rec."Request Amount")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Actual Spent"; Rec."Actual Spent")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field(Claim; Rec.Claim)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Refund; Rec.Refund)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
            }
        }
    }
}
