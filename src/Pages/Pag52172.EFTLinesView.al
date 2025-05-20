page 52172 "EFT Lines View"
{
    AutoSplitKey = true;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    PageType = List;
    SourceTable = "EFT Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

                field("EFT No"; Rec."EFT No")
                {
                    ApplicationArea = All;
                }
                field("PV No"; Rec."PV No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Bank Account No"; Rec."Bank Account No")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
                field("Sort Code"; Rec."Sort Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Payment Response"; Rec."Payment Response")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    var GenJnlLine: Record "Gen. Journal Line";
    DefaultBatch: Record "Gen. Journal Batch";
    CurrExchRate: Record "Currency Exchange Rate";
    Amt: Decimal;
    CustLedger: Record "Cust. Ledger Entry";
    CustLedger1: Record "Cust. Ledger Entry";
    VendLedger: Record "Vendor Ledger Entry";
    VendLedger1: Record "Vendor Ledger Entry";
    PolicyRec: Record "Sales Invoice Header";
    PremiumControlAmt: Decimal;
    BasePremium: Decimal;
    TotalTax: Decimal;
    TotalTaxPercent: Decimal;
    TotalPercent: Decimal;
    SalesInvoiceHeadr: Record "Sales Cr.Memo Header";
}
