page 51836 "RFQ Header"
{
    // version THL- PRM 1.0
    Caption = 'RFQ/RFP';
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';
    PageType = Card;
    SourceTable = "RFQ Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the number of the purchase document. The field is only visible if you have not set up a number series for the type of rfq/rfp document, or if the Manual Nos. field is selected for the number series.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Department';
                }
                field("RFP/RFQ Type"; Rec."RFP/RFQ Type")
                {
                    ApplicationArea = All;
                    Caption = 'RFP/RFQ';
                    ShowMandatory = true;
                    ToolTip = 'Specifies between the rfp/rfq';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the title of the rfp/rfq''s.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the description/ brief of the rfp/rfq''s.';
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the remark''s .';
                }
                field("Expected Opening Date"; Rec."Expected Opening Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the date of the expected opening date.';
                }
                field("Expected Closing Date"; Rec."Expected Closing Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the date of the expected closing date.';
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter a code for the location where you want the items to be placed when they are received.';
                }
                field("Pending Approvals"; Rec."Pending Approvals")
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        Entries: Record "Approval Entry";
                    begin
                        Entries.Reset();
                        Entries.SetRange("Table ID", 51805);
                        Entries.SetRange("Document No.", Rec.No);
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
                        Entries.SetRange("Table ID", 51805);
                        Entries.SetRange("Document No.", Rec.No);
                        Entries.SetFilter(Status, '=%1', Entries.Status::Approved);
                        Page.RunModal(Page::"Custom Approval Entries", Entries);
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    //Visible = false;
                    Editable = false;
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
            }
            part(Control16; "RFQ Lines")
            {
                ApplicationArea = All;
                SubPageLink = "RFQ No"=FIELD(No);
                Caption = 'RFQ/RFP Lines';
            //Visible = (Type = type::RFQ);
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
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "RFQ Documents";
                RunPageLink = "Document No."=FIELD(No), "Table ID"=CONST(51805);
            }
            action("Get Requisitions")
            {
                ApplicationArea = All;
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    ProcurementMgt.GetRequisitionsToRFQ(Rec);
                end;
            }
            action("Assign Vendor(s)")
            {
                ApplicationArea = All;
                Image = Allocate;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "RFQ Vendors";
                RunPageLink = "RFQ No"=FIELD(No);
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
                        //Check empty line
                        Rec.TestField(Title);
                        Rec.TestField(Description);
                        /*CalcFields("Empty No.");
                        if "Empty No." = true then
                            Error('The No. must be filled on the lines.');*/
                        //RFP
                        if Rec."RFP/RFQ Type" = Rec."RFP/RFQ Type"::RFP then begin
                            //Check attach document
                            Attach.Reset();
                            Attach.SetRange("Document No.", Rec.No);
                            Attach.SetFilter("Attachment No.", '<>0');
                            if Attach.FindFirst()then begin
                                ApprovalsMgt.OnSendRFQForApproval(Rec);
                            end
                            else if(Attach.Description = '') and (Attach."Attachment No." = 0)then Error('You have not attach your RFP document''s');
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
                            until Rec.Next = 0;
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
                            if QuoteRec."RFQ Status" = QuoteRec."RFQ Status"::Created then QuoteRec."RFQ Status":=QuoteRec."RFQ Status"::Sent;
                        end;
                        Message('RFQ has been sent to vendor''s.');
                        if Rec."RFQ Status" = Rec."RFQ Status"::Created then Rec."RFQ Status":=Rec."RFQ Status"::Sent;
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
