page 52126 "Payment Request"
{
    // version THL-Basic Fin 1.0
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "PV Header";
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';
    SourceTableView = WHERE("Payment Type"=CONST("Payment Voucher"));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = (((Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::Released)) AND Rec.Posted = false);

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit then CurrPage.Update;
                    end;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Payee; Rec.Payee)
                {
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean begin
                        BeneficiaryBanks.Reset;
                        if PAGE.RunModal(Page::"Beneficiary Bank Details", BeneficiaryBanks) = ACTION::LookupOK then begin
                            Rec."Ben ID":=BeneficiaryBanks."BEN ID";
                            Rec.Payee:=BeneficiaryBanks."BENEFICIARY NAME";
                            Rec."Payee Account Name":=BeneficiaryBanks."FULL BEN NAME";
                            Rec."Payee Account No.":=BeneficiaryBanks."BEN ACCT NO";
                            Rec."Payee Bank Code":=BeneficiaryBanks."BANK CODE";
                            Rec."Payee Bank":=BeneficiaryBanks.BANKNAME;
                            Rec."Branch Code":=BeneficiaryBanks."BRANCH CODE";
                            Rec."Branch Name":=BeneficiaryBanks."BRANCH NAME";
                            Rec."Sort Code":=BeneficiaryBanks."BC.SORT.CODE";
                        end;
                    end;
                }
                field("Payee Bank Code"; Rec."Payee Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Payee Bank"; Rec."Payee Bank")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Sort Code"; Rec."Sort Code")
                {
                    ApplicationArea = All;
                }
                field("Payee Account No."; Rec."Payee Account No.")
                {
                    ApplicationArea = All;
                }
                field("Payee Account Name"; Rec."Payee Account Name")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = ShowEFT;
                }
                field("Save Bank Details"; Rec."Save Bank Details")
                {
                    ApplicationArea = All;
                    ToolTip = 'Check this to save the beneficiary bank details for future use';
                }
                field(Cashier; Rec.Cashier)
                {
                    ApplicationArea = All;
                    Caption = 'Prepared By';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                // Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                // Visible = false;
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
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        Entries: Record "Approval Entry";
                    begin
                        Entries.Reset();
                        Entries.SetRange("Table ID", 50463);
                        Entries.SetRange("Document No.", Rec."No.");
                        Entries.SetFilter(Status, '%1|%2', Entries.Status::Open, Entries.Status::Created);
                        Page.RunModal(Page::"Custom Approval Entries", Entries);
                    end;
                }
                field("Approvals Trail"; Rec."Approvals Trail")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        Entries: Record "Approval Entry";
                    begin
                        Entries.Reset();
                        Entries.SetRange("Table ID", 50463);
                        Entries.SetRange("Document No.", Rec."No.");
                        Entries.SetFilter(Status, '=%1', Entries.Status::Approved);
                        Page.RunModal(Page::"Custom Approval Entries", Entries);
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Control4; "Payment Voucher Lines")
            {
                Editable = (((Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::Released)) AND Rec.Posted = false);
                ApplicationArea = All;
                UpdatePropagation = Both;
                SubPageLink = No=FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(Control2; "PV Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(50000);
            }
            systempart(Control1; Notes)
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
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Pay Mode" = 'RTGS/EFT' then begin
            ShowEFT:=true;
            ShowMpesa:=false;
        end
        else if Rec."Pay Mode" = 'M-PESA' then begin
                ShowEFT:=false;
                ShowMpesa:=true;
            end
            else
            begin
                ShowEFT:=true;
                ShowMpesa:=true;
            end;
    // CurrPage.Update;
    end;
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        if Rec."Pay Mode" = 'RTGS/EFT' then begin
            ShowEFT:=true;
            ShowMpesa:=false;
        end
        else if Rec."Pay Mode" = 'M-PESA' then begin
                ShowEFT:=false;
                ShowMpesa:=true;
            end
            else
            begin
                ShowEFT:=true;
                ShowMpesa:=true;
            end;
    end;
    trigger OnInit()
    begin
        SalaryAdvanced:=false;
        ShowEFT:=false;
        ShowMpesa:=false;
    end;
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
        EditPayrollPeriod:=false;
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
}
