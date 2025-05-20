pageextension 51436 "ExtPosted Purchase Invoices" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        modify("No.")
        {
            StyleExpr = Style;
        }
        modify("Vendor Invoice No.")
        {
            StyleExpr = Style;
        }
        modify("Buy-from Vendor No.")
        {
            StyleExpr = Style;
        }
        modify("Buy-from Vendor Name")
        {
            StyleExpr = Style;
        }
        modify("Currency Code")
        {
            StyleExpr = Style;
        }
        modify(Amount)
        {
            StyleExpr = Style;
        }
        modify("Amount Including VAT")
        {
            StyleExpr = Style;
        }
        modify("Location Code")
        {
            StyleExpr = Style;
        }
        modify("No. Printed")
        {
            StyleExpr = Style;
        }
        modify("Due Date")
        {
            StyleExpr = Style;
        }
        modify("Remaining Amount")
        {
            StyleExpr = Style;
        }
        modify(Closed)
        {
            StyleExpr = Style;
        }
        modify(Cancelled)
        {
            StyleExpr = Style;
        }
        modify(Corrective)
        {
            StyleExpr = Style;
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("Update Document")
        {
            action("Create Request For Payment")
            {
                ApplicationArea = All;
                Image = CreateSKU;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = not Rec."Payment Requested";

                trigger OnAction()
                begin
                    PaymentMgnt.InvoicePaymentRequest(Rec);
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetStyle;
    end;
    trigger OnAfterGetRecord()
    begin
        SetStyle;
    end;
    trigger OnOpenPage()
    begin
        SetStyle;
    end;
    local procedure SetStyle()
    begin
        //Style:
        Style:='';
        IF((Rec."Partial Payment Request") and (not Rec."Payment Requested"))then Style:='StrongAccent';
        IF Rec."Payment Requested" THEN Style:='Favorable';
    end;
    var PaymentMgnt: Codeunit "Payment Management";
    Style: Text;
}
