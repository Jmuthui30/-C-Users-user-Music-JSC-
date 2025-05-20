page 52168 "EFT Payment Card"
{
    // version CSHBK
    PageType = Card;
    SourceTable = "EFT Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Paying Bank Account"; Rec."Paying Bank Account")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Process Module"; Rec."Process Module")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("EFT Posted"; Rec."EFT Posted")
                {
                    ApplicationArea = All;
                }
            }
            part(Control1000000049; "EFT Lines")
            {
                ApplicationArea = All;
                Editable = false;
                SubPageLink = "EFT No"=FIELD(No);
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Make Payment")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    CashMgnt.MakeEFTPayment(Rec);
                end;
            }
            action("Post Processed EFT")
            {
                ApplicationArea = All;
                Caption = 'Post Processed EFT';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CashMgnt.PostProcessedEFT(Rec);
                end;
            }
            action("Send Related Email")
            {
                ApplicationArea = All;
                Caption = 'Send Related Email';
                Image = MailAttachment;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = true;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::"Processed by Bank" then begin
                        CashMgnt.SendEmail(Rec);
                        Message('Email successfully sent');
                    end;
                end;
            }
            action("Return EFT")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CashMgnt.ReturnEFT(Rec);
                end;
            }
            action("Import Adhoc EFT Lines")
            {
                ApplicationArea = All;
                Caption = 'Import Adhoc EFT Lines';
                Image = Import;

                trigger OnAction()
                begin
                    EftLines.Reset;
                    EftLines.SetRange("EFT No", Rec.No);
                    Rec.TestField(Status, Rec.Status::Logged);
                    Rec.TestField("Process Module", Rec."Process Module"::Adhoc);
                    if EftLines.Count <> 0 then Error('Importation can only be done for a new record ');
                    eftImport.GetRecHeader(Rec);
                    eftImport.Run;
                end;
            }
            action(PayPost)
            {
                ApplicationArea = All;
                Caption = 'Pay & Post';
                Image = PostApplication;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    CashMgnt.EFTPayAndPost(Rec);
                end;
            }
        }
    }
    trigger OnDeleteRecord(): Boolean begin
    /*IF Posted THEN
        ERROR('You cannot delete the details of the payment voucher at this stage');
        */
    end;
    trigger OnModifyRecord(): Boolean begin
    /*IF Posted THEN
        ERROR('You cannot change the details of the payment voucher at this stage');
        */
    end;
    trigger OnOpenPage()
    begin
        //CurrPage.EDITABLE:=TRUE;
        CanPost:=false;
        if UserPersonalization.Get(UserSecurityId)then begin
            if(UserPersonalization."Profile ID" = 'AL Finance Manger Role Center') or (UserPersonalization."Profile ID" = 'IT ADMIN')then begin
                CanPost:=true;
                exit end;
            if(UserPersonalization."Profile ID" = 'FINCON PROCESSOR')then begin
                if Rec."Process Module" <> Rec."Process Module"::PVs then CanPost:=true
                else
                    CanPost:=false end;
        end;
        isautopost:=false;
    end;
    var eftpost: Codeunit EftPost;
    EftLines: Record "EFT Lines";
    resp: Text;
    Payment: Record "PV Header";
    dup: Dialog;
    // RecPayTypes: Record "Receipts and Payment Types";
    // TarriffCodes: Record "Tarriff Codes1";
    GenJnlLine: Record "Gen. Journal Line";
    DefaultBatch: Record "Gen. Journal Batch";
    LineNo: Integer;
    CustLedger: Record "Vendor Ledger Entry";
    CustLedger1: Record "Vendor Ledger Entry";
    Amt: Decimal;
    FaDepreciation: Record "FA Depreciation Book";
    BankAcc: Record "Bank Account";
    PVLines: Record "PV Lines";
    LastPVLine: Integer;
    PolicyRec: Record "Sales Cr.Memo Header";
    PremiumControlAmt: Decimal;
    BasePremium: Decimal;
    TotalTax: Decimal;
    TotalTaxPercent: Decimal;
    TotalPercent: Decimal;
    SalesInvoiceHeadr: Record "Sales Cr.Memo Header";
    AdjustConversion: Codeunit "Adjust Gen. Journal Balance";
    ApprovalMgt: Codeunit "Approvals Mgmt. Ext";
    LastEntry: Integer;
    BankLedger: Record "Bank Account Ledger Entry";
    GlLineNo: Integer;
    GLSetup: Record "General Ledger Setup";
    Link: Text[250];
    PRHeader: Record "Request for Payment";
    PRLines: Record "Request for Payment Lines";
    IncomingDocumentAttachment: Record "Incoming Document Attachment";
    ImprestManagement: Codeunit "Imprest Management";
    ImprestHeader: Record "Imprest Header";
    StaffClaimVoucherReport: Report "Staff Claim Voucher Report";
    CashAdvanceVoucherReport: Report "Imprest Request";
    CanPost: Boolean;
    UserPersonalization: Record "User Personalization";
    eftImport: XMLport "Import Eft Lines";
    isautopost: Boolean;
    AdvFinance: Record "Advanced Finance Setup";
    FinanceMgt: Codeunit "Finance Management";
    CashMgnt: Codeunit "Cash Management";
}
