page 51838 "RFQ List"
{
    // version THL- PRM 1.0
    CardPageID = "RFQ Header";
    DeleteAllowed = false;
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "RFQ Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
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
                field("RFP/RFQ Type"; Rec."RFP/RFQ Type")
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    ApplicationArea = All;
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control23; "RFQ Documents Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD(No), "Table ID"=CONST(51805);
            }
            systempart(Control13; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
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
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"RFQ Header", 0, Rec.No);
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
                        //Check attach document
                        if Rec."RFP/RFQ Type" = Rec."RFP/RFQ Type"::RFP then begin
                            Attach.Reset();
                            Attach.SetRange("Document No.", Rec.No);
                            if Attach.FindFirst()then if(Attach.Description = '') and (Attach."Attachment No." = 0)then Error('You have not attach your RFP document''s');
                        end
                        else
                            ApprovalsMgt.OnSendRFQForApproval(Rec);
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
                        IF CONFIRM('Are you sure you want to cancel the RFQ-RFP %1. Do you want to continue?', FALSE, Rec.No)THEN ApprovalsMgt.OnCancelRFQApprovalRequest(Rec);
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
                    ToolTip = 'Release the document to the next stage of processing. When a document is released, it will be included in all availability calculations from the expected receipt date of the items. You must reopen the document before you can make changes to it.';

                    trigger OnAction()
                    var
                        ReleaseRFQ: Codeunit "Release RFQ Header";
                    begin
                        ReleaseRFQ.PerformManualRelease(Rec);
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
                    ToolTip = 'Reopen the document to change it after it has been approved. Approved documents have the Released status and must be opened before they can be changed';

                    trigger OnAction()
                    var
                        ReleaseRFQ: Codeunit "Release RFQ Header";
                    begin
                        ReleaseRFQ.PerformManualReopen(Rec);
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
                        IF CONFIRM('Are you sure you want to approve the Procurement Plan %1. Do you want to continue?', FALSE, Rec.No)THEN ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                        IF CONFIRM('Are you sure you want to reject the Procurement Plan %1. Do you want to continue?', FALSE, Rec.No)THEN ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
                action("View Quotes")
                {
                    ApplicationArea = All;
                    Image = View;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        RFQVendors.Reset;
                        RFQVendors.SetRange("RFQ No", Rec.No);
                        if RFQVendors.FindSet then begin
                            repeat QuoteRec.Reset;
                                if QuoteRec.Get(QuoteRec."Document Type"::Quote, RFQVendors."Quote No")then PAGE.Run(49, QuoteRec)
                                else
                                    Error('A quote has not been generated for %1', RFQVendors.Name);
                            until RFQVendors.Next = 0;
                        end
                        else
                            Error('No vendors have been assigned for this RFQ.');
                    end;
                }
                action("Generate RFQ")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = (Rec.Status = Rec.Status::Released);

                    trigger OnAction()
                    begin
                        RFQVendors.Reset;
                        RFQVendors.SetRange("RFQ No", Rec.No);
                        if RFQVendors.Find('-')then begin
                            repeat QuoteRec.Reset;
                                QuoteRec.SetRange("No.", RFQVendors."Quote No");
                                if QuoteRec.FindLast then begin
                                    REPORT.Run(51803, true, false, QuoteRec);
                                end;
                            until RFQVendors.Next = 0;
                        end;
                    end;
                }
                action("Quote Analysis")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = (Rec.Status = Rec.Status::Released);

                    trigger OnAction()
                    begin
                        RFQLines.Reset;
                        RFQLines.SetRange("RFQ No", Rec.No);
                        REPORT.Run(51801, true, false, RFQLines);
                    end;
                }
                action("Send RFQ via Email")
                {
                    ApplicationArea = All;
                    Image = ElectronicDoc;
                    Promoted = true;
                    PromotedIsBig = true;
                    Visible = (Rec.Status = Rec.Status::Released);

                    trigger OnAction()
                    begin
                        RFQVendors.Reset;
                        RFQVendors.SetRange("RFQ No", Rec.No);
                        if RFQVendors.Find('-')then begin
                            repeat QuoteRec.Reset;
                                QuoteRec.SetRange("No.", RFQVendors."Quote No");
                                if QuoteRec.FindLast then begin
                                    REPORT.Run(51804, false, false, QuoteRec);
                                end;
                            until RFQVendors.Next = 0;
                        end;
                    end;
                }
                action(Print)
                {
                    ApplicationArea = Suite;
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        Rec.RESET;
                        Rec.SETRANGE("No", Rec."No");
                        REPORT.RUN(Report::"REP RFQ1", TRUE, FALSE, Rec);
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
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
    var ProcurementMgt: Codeunit "Purchases Management";
    RFQLines: Record "RFQ Lines";
    RFQVendors: Record "RFQ Vendors";
    QuoteRec: Record "Purchase Header";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    Attach: Record Document;
}
