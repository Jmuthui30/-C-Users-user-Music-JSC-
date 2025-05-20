page 50006 "Cash Management Setup Card"
{
    // version THL-Basic Fin 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    Caption = 'Cash Management Setup';
    PageType = Card;
    SourceTable = "Cash Management Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Payment Voucher Template"; Rec."Payment Voucher Template")
                {
                    ApplicationArea = All;
                }
                field("Receipt Template"; Rec."Receipt Template")
                {
                    ApplicationArea = All;
                }
                field("Cash/Claim  Template"; Rec."Cash/Claim  Template")
                {
                    ApplicationArea = All;
                }
                field("Post VAT"; Rec."Post VAT")
                {
                    ApplicationArea = All;
                }
                field("Rounding Type"; Rec."Rounding Type")
                {
                    ApplicationArea = All;
                }
                field("Rounding Precision"; Rec."Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Current Budget"; Rec."Current Budget")
                {
                    ApplicationArea = All;
                }
                field("Current Budget Start Date"; Rec."Current Budget Start Date")
                {
                    ApplicationArea = All;
                }
                field("Current Budget End Date"; Rec."Current Budget End Date")
                {
                    ApplicationArea = All;
                }
                field("EFT Files Path"; Rec."EFT Files Path")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                field("PV Nos"; Rec."PV Nos")
                {
                    ApplicationArea = All;
                }
                field("Receipt Nos"; Rec."Receipt Nos")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("GL Setup")
            {
                ApplicationArea = All;
                Image = Setup;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "General Ledger Setup";
            }
        }
    }
}
