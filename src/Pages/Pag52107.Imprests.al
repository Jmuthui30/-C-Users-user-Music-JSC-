page 52107 "Imprests"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Imprests';
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';
    CardPageID = "Imprest";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Imprest Header";
    SourceTableView = WHERE(Type=CONST(Request), "Staff Claim"=CONST(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
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
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total ITO Cost"; Rec."Total ITO Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
                }
            }
        }
        area(factboxes)
        {
            part(Control12; "Document Attachment Details")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No."), "Table ID"=CONST(50463);
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
            action("Imprest Summary")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    REPORT.Run(Report::"Imprest Summary", true, false, Rec);
                end;
            }
            action("Imprest Analysis")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    REPORT.Run(Report::"Imprest Summary Analysis", true, false, Rec);
                end;
            }
        }
        area(processing)
        {
            action("Send to EFT")
            {
                Image = Purchase;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Clear(ImprestHeader);
                    Clear(ImprestHeader2);
                    CurrPage.SaveRecord;
                    CurrPage.SetSelectionFilter(ImprestHeader);
                    CurrPage.SetSelectionFilter(ImprestHeader2);
                    ImprestHeader2.SetRange("EFT No", '');
                    ImprestHeader2.SetFilter("Pay Mode", '<>%1', 'EFT');
                    if ImprestHeader2.FindFirst then Error('One or more selected record is not with EFT Paymode, Kindly select only EFT Transactions');
                    ImprestHeader.SetRange("EFT No", '');
                    ImprestHeader.SetRange("Pay Mode", 'EFT');
                    ImprestHeader.SetRange("Request Posted", false);
                    if ImprestHeader.FindFirst then begin
                        // Check Request Amount;
                        repeat ImprestHeader.CalcFields("Total Request Amount");
                            ImprestHeader.TestField("Total Request Amount");
                        until ImprestHeader.Next() = 0;
                        // create eft header
                        EFTHeader.Init;
                        EFTHeader.No:=CashMgnt.GenerateEFTNo;
                        EFTHeader."Transaction Date":=Today;
                        EFTHeader."Process Module":=EFTHeader."Process Module"::"Imprest";
                        EFTHeader."Paying Bank Account":=EFTHeader."Paying Bank Account";
                        EFTHeader.Status:=EFTHeader.Status::Logged;
                        EFTHeader.Insert(true);
                        // CREATE EFT LINES
                        repeat CashMgnt.PostCashAdvanceEFT(Rec, EFTHeader);
                        until ImprestHeader.Next = 0;
                        Message('Selected Record(s) successfully sent to EFT Page for Processing');
                        PAGE.Run(Page::"EFT Payment Card", EFTHeader);
                    end
                    else
                        Error('No Selected Record(s) or selected records already transfer');
                end;
            }
            action("Check for Cash Availability")
            {
                ApplicationArea = All;
                Image = CheckLedger;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Request Posted" = false));

                trigger OnAction()
                begin
                    ImprestMgt.CheckForCashAvailability(Rec);
                end;
            }
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;

                // RunObject = Page "Cash & Claim Documents";
                // RunPageLink = "Document No." = FIELD("No."),
                //               "Table ID" = CONST(50463);
                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                    CashAdTable: Record "Imprest Header";
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            //"Table ID" = CONST(50463);
            }
            action("View SharePoint Documents")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec."SharePoint Link" = '' then Error('There is no link to documents uploaded in SharePoint. Please contact the SharePoint Administrator.')
                    else
                        HyperLink(Rec."SharePoint Link");
                end;
            }
            action("Issue The Imprest")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Request Posted" = false));

                trigger OnAction()
                begin
                    if Rec."Pay Mode" = 'EFT' then Error('You cannot post an EFT Transaction')
                    else
                        ImprestMgt.PostImprestRequest(Rec);
                //Commitments."Process UnCommitment Entry"("No.",'ITO','');
                end;
            }
            action("Create Request for Payment")
            {
                ApplicationArea = All;
                Image = "Action";
                Promoted = true;
                PromotedCategory = Process;
                // Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Request Posted" = false));
                Visible = false;

                trigger OnAction()
                begin
                    ImprestMgt.CreateRequestForPayment(Rec);
                end;
            }
            action("View Request for Payment")
            {
                ApplicationArea = All;
                Image = View;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = false;

                trigger OnAction()
                begin
                    ImprestMgt.ViewImprestRequestPVs(Rec);
                end;
            }
            action("Close ITO")
            {
                ApplicationArea = All;
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                //Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Request Posted" = false));
                Visible = false;

                trigger OnAction()
                begin
                    if Confirm('You are about to close this Imprest, please confirm that all PVs and POs from this Imprest have been generated and submitted!', false) = true then begin
                        Rec."Request Posted":=true;
                        Rec."Request Posted By":=UserId;
                        Rec."Request Posted Date":=Today;
                        Rec.Type:=Rec.Type::Surrender;
                        Rec."Surrender Date":=Today;
                        Rec."Surrender Posted":=true;
                        Rec."Surrender Posted By":=UserId;
                        Rec."Surrender Posted Date":=Today;
                        Rec.Status:=Rec.Status::Closed;
                        Rec.Modify;
                        Message('Imprest Closed.');
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
                        Rec.TestField("Request Posted", false);
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
                        Rec.TestField("Request Posted", false);
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=Rec.Type::Request;
        Rec."Staff Claim":=false;
        Rec."FIN Created":=true;
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
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
    var ImprestMgt: Codeunit "Imprest Management";
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    Commitments: Codeunit Commitments;
    ImprestHeader: Record "Imprest Header";
    ImprestHeader2: Record "Imprest Header";
    EFTHeader: Record "EFT Header";
    CashMgnt: Codeunit "Cash Management";
}
