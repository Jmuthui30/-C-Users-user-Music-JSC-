pageextension 51428 "ExtPosted Purchase Receipt" extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Responsibility Center")
        {
            group("Invoice")
            {
                Caption = 'Vendor Invoice';

                field("Invoice No"; Rec."Invoice No")
                {
                    ApplicationArea = Suite;
                }
                field("Invoice Attachment"; Rec."Invoice Attachment")
                {
                    ApplicationArea = Suite;
                    ExtendedDatatype = url;
                    Enabled = false;
                }
                field("Invoice Date"; Rec."Invoice Date")
                {
                    ApplicationArea = Suite;
                }
            }
        }
    }
    actions
    {
        // Add changes to page actions 
        addafter("&Print")
        {
            action(GRN)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                PromotedOnly = true;
                Image = Print;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(51807, true, false, Rec);
                end;
            }
        }
        modify("&Print")
        {
            Visible = false;
        }
    }
    var myInt: Integer;
}
