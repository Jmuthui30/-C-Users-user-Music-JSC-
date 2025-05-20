page 51800 "Procurement Setup"
{
    // version THL- PRM 1.0
    PageType = Card;
    //InsertAllowed = false;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "Procurement Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Enable Email Notification"; Rec."Enable Email Notification")
                {
                    ApplicationArea = All;
                }
                field("Effective Procurement Plan"; Rec."Effective Procurement Plan")
                {
                    ApplicationArea = All;
                }
                field("Stores Control Email"; Rec."Stores Control Email")
                {
                    ApplicationArea = All;
                }
                field("Store Issue Template"; Rec."Store Issue Template")
                {
                    ApplicationArea = All;
                }
                field("Store Issue Batch"; Rec."Store Issue Batch")
                {
                    ApplicationArea = All;
                }
                field("Inspection Reviewer"; Rec."Inspection Reviewer")
                {
                    ApplicationArea = All;
                }
                field("International PO Address"; Rec."International PO Address")
                {
                    ApplicationArea = All;
                }
            }
            group(Numbering)
            {
                field("Purchase Req No"; Rec."Purchase Req No")
                {
                    ApplicationArea = All;
                }
                field("Store Requisition Nos."; Rec."Store Requisition Nos.")
                {
                    ApplicationArea = All;
                }
                field("S_Store Requisition Nos."; Rec."S_Store Requisition Nos.")
                {
                    ApplicationArea = All;
                }
                field("J_Store Requisition Nos."; Rec."J_Store Requisition Nos.")
                {
                    ApplicationArea = All;
                }
                field("Store Receipt Nos."; Rec."Store Receipt Nos.")
                {
                    ApplicationArea = All;
                }
                field("Store Issue Nos."; Rec."Store Issue Nos.")
                {
                    ApplicationArea = All;
                }
                field("Store Transfer Nos."; Rec."Store Transfer Nos.")
                {
                    ApplicationArea = All;
                }
                field("Request for Quotation Nos."; Rec."Request for Quotation Nos.")
                {
                    ApplicationArea = All;
                }
                field("Inspection Nos."; Rec."Inspection Nos.")
                {
                    ApplicationArea = All;
                }
                field("NBO PO Nos"; Rec."NBO PO Nos")
                {
                    ApplicationArea = All;
                }
                field("KSM PO Nos"; Rec."KSM PO Nos")
                {
                    ApplicationArea = All;
                }
                field("KCO PO Nos"; Rec."KCO PO Nos")
                {
                    ApplicationArea = All;
                }
                field("Request for Proposals Nos."; Rec."Request for Proposals Nos.")
                {
                    ApplicationArea = All;
                }
                field("Tenders Nos"; Rec."Tenders Nos")
                {
                    ApplicationArea = All;
                }
                field("Appointment Nos."; Rec."Appointment Nos.")
                {
                    ApplicationArea = All;
                }
                field("Vendor Reg Req Nos."; Rec."Vendor Reg Req Nos.")
                {
                    ApplicationArea = All;
                }
                field("Procurement Plan No."; Rec."Procurement Plan No.")
                {
                    ApplicationArea = All;
                }
                field("Repair Requisition No."; Rec."Repair Requisition No.")
                {
                    ApplicationArea = All;
                }
                field("Work Order No."; Rec."Work Order No.")
                {
                    ApplicationArea = All;
                }
                field("Mail No."; Rec."Mail No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
