page 52180 "Budget Category Dist. Header"
{
    // version BUDGET
    Caption = 'Budget Category Distribution';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Budget Category Dist. Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Business Unit"; Rec."Business Unit")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            group(Totals)
            {
                Caption = 'Budget Summaries';

                field("Internal Audit"; Rec."Internal Audit")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Internal Control"; Rec."Internal Control")
                {
                    ApplicationArea = All;
                }
                field("Fund Accounts"; Rec."Fund Accounts")
                {
                    ApplicationArea = All;
                }
                field("Financial Control"; Rec."Financial Control")
                {
                    ApplicationArea = All;
                }
                field("IT Governance"; Rec."IT Governance")
                {
                    ApplicationArea = All;
                }
                field(BPT; Rec.BPT)
                {
                    ApplicationArea = All;
                }
                field(ITOPS; Rec.ITOPS)
                {
                    ApplicationArea = All;
                }
                field("APP DEV"; Rec."APP DEV")
                {
                    ApplicationArea = All;
                }
                field("Data Management"; Rec."Data Management")
                {
                    ApplicationArea = All;
                }
                field("Investment Admin"; Rec."Investment Admin")
                {
                    ApplicationArea = All;
                }
                field(Reconciliation; Rec.Reconciliation)
                {
                    ApplicationArea = All;
                }
                field("Benefit Administration"; Rec."Benefit Administration")
                {
                    ApplicationArea = All;
                }
                field("Operational Risk"; Rec."Operational Risk")
                {
                    ApplicationArea = All;
                }
                field("Financial Risk"; Rec."Financial Risk")
                {
                    ApplicationArea = All;
                }
                field("Information Security"; Rec."Information Security")
                {
                    ApplicationArea = All;
                }
                field(Admin; Rec.Admin)
                {
                    ApplicationArea = All;
                }
                field("Human Resources"; Rec."Human Resources")
                {
                    ApplicationArea = All;
                }
                field(Legal; Rec.Legal)
                {
                    ApplicationArea = All;
                }
                field(Compliance; Rec.Compliance)
                {
                    ApplicationArea = All;
                }
                field("Company Secretary"; Rec."Company Secretary")
                {
                    ApplicationArea = All;
                }
                field("Customer Experience"; Rec."Customer Experience")
                {
                    ApplicationArea = All;
                }
                field(EMT; Rec.EMT)
                {
                    ApplicationArea = All;
                }
                field(HVC; Rec.HVC)
                {
                    ApplicationArea = All;
                }
                field(Sales; Rec.Sales)
                {
                    ApplicationArea = All;
                }
                field(MCC; Rec.MCC)
                {
                    ApplicationArea = All;
                }
                field("Business Support"; Rec."Business Support")
                {
                    ApplicationArea = All;
                }
                field("Business Analytics"; Rec."Business Analytics")
                {
                    ApplicationArea = All;
                }
                field("Corporate Strategy"; Rec."Corporate Strategy")
                {
                    ApplicationArea = All;
                }
                field("Investment Management"; Rec."Investment Management")
                {
                    ApplicationArea = All;
                }
                field("Executive Management"; Rec."Executive Management")
                {
                    ApplicationArea = All;
                }
                field("Grand Total"; Rec."Grand Total")
                {
                    ApplicationArea = All;
                }
                field("Total CAPEX"; Rec."Total CAPEX")
                {
                    ApplicationArea = All;
                }
                field("Total OPEX"; Rec."Total OPEX")
                {
                    ApplicationArea = All;
                }
            }
            part(Control9; "Budget Category Dist. Lines")
            {
                ApplicationArea = All;
                SubPageLink = Budget=FIELD(Budget), "Business Unit"=FIELD("Business Unit");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Copy from Previous Workings")
            {
                ApplicationArea = All;
                Image = Copy;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    BudgetMgt.CopyBudgetCategoryDistributionLines(Rec);
                end;
            }
            action("Suggest Budget Categories")
            {
                ApplicationArea = All;
                Image = SuggestLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    BudgetMgt.SugestBudgetCategoryDistributionLines(Rec);
                end;
            }
            action("Distribute Budget Category")
            {
                ApplicationArea = All;
                Image = Allocate;
                Promoted = true;
                PromotedIsBig = true;
            // RunObject = Report "RSA Statement ARM-stamped";
            }
        }
    }
    var BudgetMgt: Codeunit "Budget Management";
}
