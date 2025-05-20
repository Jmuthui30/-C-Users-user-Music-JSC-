page 52166 "EFT Lines"
{
    AutoSplitKey = true;
    Editable = false;
    PageType = ListPart;
    SourceTable = "EFT Lines";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                ShowCaption = false;

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
        area(processing)
        {
            action("Return to Approved list")
            {
                ApplicationArea = All;
                Image = SendToMultiple;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    recHeader.Reset;
                    recHeader.SetRange(No, Rec."EFT No");
                    recHeader.FindFirst;
                    if(Rec.Status <> Rec.Status::Logged) and (Rec.Status <> Rec.Status::Failed)then Error('You cannot return a record that have been processed');
                    if recHeader."Process Module" = recHeader."Process Module"::PVs then begin
                        Payment.Reset;
                        Payment.Get(Rec."PV No");
                        if Payment.EFT_No = Rec."EFT No" then begin
                            Payment.EFT_No:='';
                            Payment.Modify;
                        end;
                    end;
                    if recHeader."Process Module" = recHeader."Process Module"::"Imprest" then begin
                        ImprestHeader.Reset;
                        ImprestHeader.Get(Rec."PV No");
                        if ImprestHeader."EFT No" = Rec."EFT No" then begin
                            ImprestHeader."EFT No":='';
                            ImprestHeader.Modify;
                        end;
                    end;
                    if recHeader."Process Module" = recHeader."Process Module"::"Staff Claim" then begin
                        ImprestHeader.Reset;
                        ImprestHeader.Get(Rec."PV No");
                        if ImprestHeader."EFT No" = Rec."EFT No" then begin
                            ImprestHeader."EFT No":='';
                            ImprestHeader.Modify;
                        end;
                    end;
                    if recHeader."Process Module" = recHeader."Process Module"::Surrender then begin
                        ImprestHeader.Reset;
                        ImprestHeader.Get(Rec."PV No");
                        if ImprestHeader."Surrender EFT No" = Rec."EFT No" then begin
                            ImprestHeader."Surrender EFT No":='';
                            ImprestHeader.Modify;
                        end;
                    end;
                    Rec.Status:=Rec.Status::Returned;
                    Rec.Modify;
                end;
            }
        }
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
    recHeader: Record "EFT Header";
    Payment: Record "PV Header";
    ImprestHeader: Record "Imprest Header";
}
