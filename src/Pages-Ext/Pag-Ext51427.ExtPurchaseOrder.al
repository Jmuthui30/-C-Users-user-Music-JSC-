pageextension 51427 "ExtPurchase Order" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Order Type"; Rec."Order Type")
            {
                ApplicationArea = All;
                //ShowMandatory = true;
                Visible = false;
            }
            //Ibrahim Wasiu
            field("Purchase Order Status"; Rec."Purchase Order Status")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("Portal Status"; Rec."Portal Status")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter("No.")
        {
            field("Vendor Application No."; Rec."Vendor Application No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Vendor Invoice No.")
        {
            field("Invoice Attachment"; Rec."Invoice Attachment")
            {
                ApplicationArea = All;
                ExtendedDatatype = url;
                Enabled = false;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter("&Print")
        {
            action("Print LPO")
            {
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(51805, true, false, Rec);
                end;
            }
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                RunObject = Page "Order Documents";
                RunPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(38);
            }
            action("View Requisition")
            {
                ApplicationArea = All;
                Image = Purchasing;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Requisition.RESET;
                    Requisition.SETRANGE("No.", Rec."Requisition No");
                    PAGE.RUN(51834, Requisition);
                end;
            }
        }
        addafter("View Requisition")
        {
            action("Send for confirmation")
            {
                ApplicationArea = All;
                Image = ElectronicDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(51808, true, false, Rec);
                end;
            }
        }
    }
    var Requisition: Record "Requisition Header";
}
