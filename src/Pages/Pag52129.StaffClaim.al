page 52129 "Staff Claim"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Staff Claim';
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Imprest Header";
    SourceTableView = WHERE(Type = CONST(Surrender), "Staff Claim" = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Total Surrender Amount"; Rec."Total Surrender Amount")
                {
                    Caption = 'Total Claim';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pending Approvals Ext"; Rec."Pending Approvals Ext")
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
                field(Approvers; Rec.Approvers)
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
            group("Payment Details")
            {
                Visible = Rec.Status = Rec.Status::Released;

                field("Claim Pay Mode"; Rec."Claim Pay Mode")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        PayModeEditability;
                    end;
                }
                field("Claim Paying Account"; Rec."Claim Paying Account")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Editable = EFTEditable;
                }
                field("Claim Payment Tx No"; Rec."Claim Payment Tx No")
                {
                    ApplicationArea = All;
                    Editable = EFTEditable;
                }
            }
            part(Control14; "Staff Claim Details")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            part(Control2; "Cash & Claim Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No."), "Table ID" = CONST(50463);
            }
            systempart(Control13; Notes)
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
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Staff Claim Voucher Report", true, false, Rec);
                end;
            }
        }
        area(processing)
        {
            action("Check for Cash Availability")
            {
                ApplicationArea = All;
                Image = CheckLedger;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Claim Posted" = false));

                trigger OnAction()
                begin
                    ImprestMgt.CheckForCashAvailability(Rec);
                end;
            }
            action(ImportDocument)
            {
                Caption = 'Import Document to Sharepoint';
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    SharepointHandler: Codeunit "Portal Integration";
                begin
                    SharepointHandler.UploadFilesToSharePoint(Rec."No.", 'IMPREST SURRENDER');
                end;
            }

            action("Sharepoint Attachments")
            {
                ApplicationArea = all;
                Ellipsis = true;
                Image = Attachments;
                Visible = true;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Portal Uploads";
                RunPageLink = "Document No" = field("No.");
            }
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                Visible = false;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = Page "Cash & Claim Documents";
                RunPageLink = "Document No." = FIELD("No."), "Table ID" = CONST(50463);
            }
            action("View SharePoint Documents")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;
                Promoted = true;
                Visible = false;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec."SharePoint Link" = '' then
                        Error('There is no link to documents uploaded in SharePoint. Please contact the SharePoint Administrator.')
                    else
                        HyperLink(Rec."SharePoint Link");
                end;
            }
            action("Post Payment")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Claim Posted" = false));

                trigger OnAction()
                begin
                    if Rec."Claim Pay Mode" = 'EFT' then begin
                        if DIALOG.Confirm('This transaction is an eft transaction, Are you sure its before implementation of EFT') <> true then begin
                            Error('You cannot post EFT Transactions from here');
                        end;
                    end;
                    ImprestMgt.PostStaffClaim(Rec);
                end;
            }
            action("Stop Payment")
            {
                ApplicationArea = All;
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Claim Posted" = false));

                trigger OnAction()
                begin
                    if Confirm('You are about to close this Staff Claim Voucher, Be aware that you wont be able to recover this Voucher!', false) = true then begin
                        Rec."Request Posted" := true;
                        Rec."Request Posted By" := UserId;
                        Rec."Request Posted Date" := Today;
                        Rec.Type := Rec.Type::Surrender;
                        Rec."Surrender Date" := Today;
                        Rec."Surrender Posted" := true;
                        Rec."Surrender Posted By" := UserId;
                        Rec."Surrender Posted Date" := Today;
                        Rec.Status := Rec.Status::Closed;
                        Rec."Claim Posted" := true;
                        Rec."Claim Posted By" := UserId;
                        Rec."Claim Posted Date" := Today;
                        Rec.Modify;
                        Message('Voucher Closed.');
                    end;
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
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Imprest Header", 0, Rec."No.");
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
                        ApprovalsMgt.OnSendImprestForApproval(Rec);
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
                        ApprovalsMgt.OnCancelImprestApprovalRequest(Rec);
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
                        ReleaseImprest: Codeunit "Release Imprest";
                    begin
                        Rec.TestField(Rec."Claim Posted", false);
                        ReleaseImprest.PerformManualRelease(Rec);
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
                        ReleaseImprest: Codeunit "Release Imprest";
                    begin
                        Rec.TestField(Rec."Claim Posted", false);
                        ReleaseImprest.PerformManualReopen(Rec);
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
    trigger OnOpenPage()
    begin
        PayModeEditability;
    end;

    trigger OnInit()
    begin
        PayModeEditability;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type := Rec.Type::Surrender;
        Rec."Staff Claim" := true;
        Rec."Surrender Date" := Today;
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        PayModeEditability;
    end;

    local procedure PayModeEditability()
    begin
        if Rec."Claim Pay Mode" = 'EFT' then
            EFTEditable := false
        else
            EFTEditable := true;
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;

    var
        ImprestMgt: Codeunit "Imprest Management";
        ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        EFTEditable: Boolean;
}
