pageextension 51801 "ExtPurchase Quote" extends "Purchase Quote"
{
    layout
    {
        addbefore("Invoice Details")
        {
            group(Attachments)
            {
                part(AttachmentList; "Attachment Lines")
                {
                    ApplicationArea = all;
                    UpdatePropagation = Both;
                    SubPageLink = Code=field("No.");
                }
            }
        }
        // Add changes to page layout here
        addafter(Status)
        {
            field("RFQ Status"; Rec."RFQ Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Portal Status"; Rec."Portal Status")
            {
                ApplicationArea = All;
                Enabled = false;
            }
        }
        addafter("No.")
        {
            //Link RFQ to Quote
            field("Vendor Application No."; Rec."Vendor Application No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RFQNo; Rec.RFQNo)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RFQTitle; Rec.RFQTitle)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(RFQRemarks; Rec.RFQRemarks)
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Description; Rec.Description)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
    actions
    {
        // Add changes to page actions here   
        addbefore("Make order")
        {
            action(Return)
            {
                ApplicationArea = All;
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Purchaser Response";
            //RunPageLink =
            }
            action(Accept)
            {
                ApplicationArea = All;
                Image = Action;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Purchaser Response";
            //RunPageLink =
            }
            action("Reject-Quote")
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Purchaser Response";
            //RunPageLink =
            }
        }
    }
    var myInt: Integer;
    RFQ: Record "RFQ Header";
    Attachment: Record "Attachment";
}
