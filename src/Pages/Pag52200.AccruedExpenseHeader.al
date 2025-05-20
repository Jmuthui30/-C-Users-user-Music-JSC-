page 52200 "Accrued Expense Header"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Amortization Header";
    SourceTableView = WHERE(Type=CONST("Accrued Expenses"));

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
                field("Total Expense Amount"; Rec."Prepayment Amount")
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
                }
                field("Shortcut Dimension 4 Code"; Rec."Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
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
            part(Control1000000027; "Accrued Expenses Lines")
            {
                ApplicationArea = All;
                SubPageLink = No=FIELD(No);
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
            action("Amortize Expense")
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
            action("Expense Schedule")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange(No, Rec.No);
                    REPORT.Run(52200, true, false, Rec);
                end;
            }
            action("Post Expense Journal")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.GenerateCurrentMonthExpenseJournal(Rec.No);
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
                    Rec.GenerateExpenseAdditionsJournal(Rec.No);
                end;
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Type:=Rec.Type::"Accrued Expenses";
    end;
}
