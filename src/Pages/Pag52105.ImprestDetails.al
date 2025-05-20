page 52105 "Imprest Details"
{
    // version THL- ADV.FIN 1.0
    AutoSplitKey = true;
    Caption = 'Imprest Details';
    InsertAllowed = false;
    DeleteAllowed = false;
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
                    Editable = False;
                }
                field(Expense; Rec.Expense)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Account No"; Rec."Account No")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Decision; Rec.Decision)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Narration; Rec.Narration)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                    Visible = false;
                }
                field(UoM; Rec.UoM)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Request Amount"; Rec."Request Amount")
                {
                    ApplicationArea = All;
                    Editable = False;

                    trigger OnValidate()
                    begin
                        CurrPage.Update;
                    end;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("PV No"; Rec."PV No")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("PO No."; Rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Decision:=Rec.Decision::"Pay Cash to Traveller";
    end;
}
