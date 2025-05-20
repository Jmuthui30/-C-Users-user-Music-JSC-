page 52127 "Payment Requests"
{
    CardPageID = "Payment Request";
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "PV Header";
    SourceTableView = WHERE("Payment Type"=CONST("Payment Voucher"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;
                }
                field("On behalf of"; Rec."On behalf of")
                {
                    ApplicationArea = All;
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                }
                field(Posted; Rec.Posted)
                {
                    ApplicationArea = All;
                }
                field("Posted By"; Rec."Posted By")
                {
                    ApplicationArea = All;
                }
                field("Posted Date"; Rec."Posted Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Purchase Invoice Amount"; Rec."Purchase Invoice Amount")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Gross Amount"; Rec."Gross Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Withholding Tax"; Rec."Total Withholding Tax")
                {
                    ApplicationArea = All;
                }
                field("Stamp Duty Amount"; Rec."Stamp Duty Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control21; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Reporting)
        {
            action(Print)
            {
                ApplicationArea = All;
                Image = PrintVoucher;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::PV, true, false, Rec);
                end;
            }
        }
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Released;

                trigger OnAction()
                begin
                    Rec.TestField("Paying Bank Account");
                    if Rec."Pay Mode" = 'EFT' then Error('You cannot post an EFT Transaction')
                    else
                        PVPost."Post Payment Voucher"(Rec);
                end;
            }
            action("Send to EFT")
            {
                ApplicationArea = All;
                Image = Purchase;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = Rec.Status = Rec.Status::Released;

                trigger OnAction()
                begin
                    Clear(Payment);
                    Clear(Payment2);
                    CurrPage.SaveRecord;
                    CurrPage.SetSelectionFilter(Payment);
                    CurrPage.SetSelectionFilter(Payment2);
                    Payment.SetRange(EFT_No, '');
                    Payment.SetFilter("Pay Mode", '<>%1', 'EFT');
                    if Payment.FindFirst then Error('One or more selected record is not with EFT Paymode, Kindly select only EFT Transactions');
                    Payment2.SetRange(EFT_No, '');
                    Payment2.SetRange("Pay Mode", 'EFT');
                    Payment2.SetRange(Posted, false);
                    if Payment2.Find('-')then begin
                        // Create EFT Header
                        EFTHeader.Init;
                        EFTHeader."Transaction Date":=Today;
                        EFTHeader."Process Module":=EFTHeader."Process Module"::PVs;
                        EFTHeader.Status:=EFTHeader.Status::Logged;
                        EFTHeader.Insert(true);
                        // CREATE EFT LINES
                        repeat CashMgnt.PostPVEft(Payment2, EFTHeader);
                        until Payment2.Next = 0;
                        Message('Selected Record(s) successfully sent to EFT Page for Processing');
                        PAGE.Run(Page::"EFT Payment Card", EFTHeader);
                    end
                    else
                        Error('No Selected Record(s) or selected records already transfer');
                end;
            }
            action("Send to EFT Generator")
            {
                ApplicationArea = All;
                Image = MachineCenterLoad;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    if Rec."Pay Mode" <> 'RTGS/EFT' then Error('The Pay Mode for this PV is not RTGS/EFT.');
                    Rec.TestField("Payee Bank Code");
                    Rec.TestField("Branch Code");
                    Rec.TestField("Payee Account No.");
                    Rec.TestField("Payee Account Name");
                    Rec.TestField(Payee);
                    Rec.CalcFields("Total Amount");
                    Ref:=Format(Rec."No.");
                    CashMgt.InsertEFTEntries(Rec."Payee Bank Code", Rec."Branch Code", Rec."Payee Account No.", Rec."Payee Account Name", Rec."Total Amount", Ref);
                    Message('EFT Entries Sent.');
                end;
            }
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = Page "PV Documents";
                RunPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(50000);
            }
            action("Select Approvers")
            {
                ApplicationArea = All;
                Image = SelectLineToApply;
                Promoted = true;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                begin
                    AdvancedFinanceSetup.Get;
                    AdvancedFinanceSetup.TestField("RFPY Workflow User Group");
                    Approvers.Reset;
                    Approvers.SetCurrentKey("Sequence No.");
                    Approvers.SetRange("Workflow User Group Code", AdvancedFinanceSetup."PV Workflow User Group");
                    PAGE.Run(1532, Approvers);
                end;
            }
            group("Approval Details")
            {
                Visible = NOT OpenApprovalEntriesExistForCurrUser;
                Caption = 'Approvals';

                action(Approvals)
                {
                    //AccessByPermission = TableData "Approval Entry" = R;
                    ApplicationArea = Suite;
                    Caption = 'Approvals';
                    Image = Approvals;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category7;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        ApprovalsMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"PV Header", 0, Rec."No.");
                    end;
                }
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Visible = NOT OpenApprovalEntriesExistForCurrUser;

                action(SendApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Date);
                        Rec.TestField(Payee);
                        ApprovalsMgt.OnSendPVForApproval(Rec);
                        Message('Approval error');
                    end;
                }
                action(CancelApprovalRequest)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()
                    var
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        ApprovalsMgt.OnCancelPVApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
            group("Manual Approval")
            {
                Caption = 'Release';
                Visible = NOT OpenApprovalEntriesExistForCurrUser;

                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleasePaymentVoucher: Codeunit "Release Payment Voucher";
                    begin
                        ReleasePaymentVoucher.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;
                    Promoted = true;
                    PromotedCategory = Category5;
                    PromotedOnly = true;

                    trigger OnAction()
                    var
                        ReleasePaymentVoucher: Codeunit "Release Payment Voucher";
                    begin
                        ReleasePaymentVoucher.PerformManualReopen(Rec);
                    end;
                }
            }
            group(Approval)
            {
                Caption = 'Approval';

                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'Delegate the requested changes to the substitute approver.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedOnly = true;
                    ToolTip = 'View or add comments for the record.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Payment Type":=Rec."Payment Type"::"Payment Voucher";
        Rec.Cashier:=UserId;
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Payment Type", Rec."Payment Type"::"Payment Voucher");
        Rec.SetRange(Cashier, UserId);
    end;
    procedure AssistEdit(PaymentVoucher: Record "PV Header"): Boolean begin
        PV:=Rec;
        GLSetup.Get();
        GLSetup.TestField(GLSetup."PV Nos");
        NoSeriesMgt.SelectSeries(GLSetup."PV Nos", PaymentVoucher."No. Series", PV."No. Series");
        Rec:=PV;
        exit(true);
    end;
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
    var PV: Record "PV Header";
    GLSetup: Record "Cash Management Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    PVPost: Codeunit "Finance Management";
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    [InDataSet]
    SalaryAdvanced: Boolean;
    ShowEFT: Boolean;
    ShowMpesa: Boolean;
    BeneficiaryBanks: Record "Payee Bank Details";
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    Approvers: Record "Workflow User Group Member";
    EditPayrollPeriod: Boolean;
    CashMgt: Codeunit "Cash Management";
    Ref: Text;
    Payment2: Record "PV Header";
    EFTHeader: Record "EFT Header";
    eftlines: Record "EFT Lines";
    PVLine: Record "PV Lines";
    Payment: Record "PV Header";
    CashMgnt: Codeunit "Cash Management";
}
