pageextension 51433 "ExtPosted Purchase Invoice" extends "Posted Purchase Invoice"
{
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
    var PaymentMgnt: Codeunit "Payment Management";
}
