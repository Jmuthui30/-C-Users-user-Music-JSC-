page 52204 "Prepayment Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Amortization Header";
    SourceTableView = WHERE(Type=CONST(Prepayment));

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("No of Periods"; Rec."No of Periods")
                {
                    ApplicationArea = All;
                }
                field("Period Length"; Rec."Period Length")
                {
                    ApplicationArea = All;
                }
                field("Starting Period"; Rec."Starting Period")
                {
                    ApplicationArea = All;
                }
                field("Ending Period"; Rec."Ending Period")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Amount"; Rec."Prepayment Amount")
                {
                    ApplicationArea = All;
                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Account"; Rec."Prepayment Account")
                {
                    ApplicationArea = All;
                }
                field("Expense Account"; Rec."Expense Account")
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
                field("Shortcut Dimension 3 Code"; Rec."Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(3, Rec."Shortcut Dimension 3 Code");
                    end;
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        Rec.LookupShortcutDimCode(4, Rec."Shortcut Dimension 4 Code");
                    end;
                }
                field(Addition; Rec.Addition)
                {
                    ApplicationArea = All;
                }
                field("Total Additions"; Rec."Total Addition")
                {
                    ApplicationArea = All;
                    Caption = 'Total Additions';
                    Editable = false;
                }
                field("Expensed Amount"; Rec."Expensed Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Periods Expensed"; Rec."Periods Expensed")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Outstanding Perods"; Rec."Outstanding Perods")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control1000000027; "Prepayment Lines")
            {
                SubPageLink = No=FIELD(No);
                ApplicationArea = All;
            }
        }
        area(factboxes)
        {
            systempart(Control1000000026; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Amortize Prepayment")
            {
                ApplicationArea = All;
                Image = AmountByPeriod;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.AmortizePrepayment(Rec.No);
                end;
            }
            action("Distribute Costs")
            {
                ApplicationArea = All;
                Image = Insert;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange(No, Rec.No);
                    REPORT.Run(52201, true, false, Rec);
                end;
            }
            action("Prepayment Schedule")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange(No, Rec.No);
                    REPORT.Run(52202, true, false, Rec);
                end;
            }
            action("Post Prepayment Journal")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.GenerateCurrentMonthJournal(Rec.No);
                end;
            }
            action("Post Additions")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.GenerateAdditionsJournal(Rec.No);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::Prepayment;
    end;
}
