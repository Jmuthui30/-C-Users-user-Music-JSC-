page 52001 "Work Order"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Work Order Header";
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter no.';
                }
                field("Work Order Type"; Rec."Work Order Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter work order type';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter work order description';
                }
                field("Service Level"; Rec."Service Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter Service level';
                }
                field("Asset Location"; Rec."Asset Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter asset location';
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter priority';
                }
                field("Work Notes"; Rec."Work Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter work notes';
                }
                field("Work Date"; Rec."Work Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter work date';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter currency code';
                }
                field("Actual Start Date"; Rec."Actual Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter actual start date';
                }
                field("Actual End Date"; Rec."Actual End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter actual end date';
                }
                field("Expected Start Date"; Rec."Expected Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter expected start date';
                }
                field("Expected End Date"; Rec."Expected End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter expected end date';
                }
                field("Scheduled Start Date"; Rec."Scheduled Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter scheduled start date';
                    Visible = (Rec.Status = Rec.Status::Released);
                }
                field("Scheduled End Date"; Rec."Scheduled End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter scheduled end date';
                    Visible = (Rec.Status = Rec.Status::Released);
                }
                field(Responsible; Rec.Responsible)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter responsible';
                }
                field("Raised by"; Rec."Raised by")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter raised by';
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
                        Entries.SetRange("Table ID", 51941);
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
                        Entries.SetRange("Table ID", 51941);
                        Entries.SetRange("Document No.", Rec."No.");
                        Entries.SetFilter(Status, '=%1', Entries.Status::Approved);
                        Page.RunModal(Page::"Custom Approval Entries", Entries);
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Work Order Lifecycle State"; Rec."Work Order Lifecycle State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter work order lifecycle state';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
            }
            group("Vendor Details")
            {
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    Caption = 'Vendor No.';
                    ApplicationArea = All;
                    ToolTip = 'Enter the number of the vendor who repairs the assets';
                }
                field("Buy-from Vendor Name"; Rec."Buy-from Vendor Name")
                {
                    Caption = 'Vendor Name';
                    ApplicationArea = All;
                    ToolTip = 'Enter vendor name';
                }
                field("Buy-from Address"; Rec."Buy-from Address")
                {
                    Caption = 'Address';
                    ApplicationArea = all;
                    ToolTip = 'Enter the vendor''s buy-from address.';
                }
                field("Buy-from Post Code"; Rec."Buy-from Post Code")
                {
                    Caption = 'Post Code';
                    ApplicationArea = all;
                    ToolTip = 'Enter the vendor''s post code.';
                }
                field("Buy-from City"; Rec."Buy-from City")
                {
                    Caption = 'City';
                    ApplicationArea = all;
                    ToolTip = 'Enter the vendor''s city on the purchase document.';
                }
                field("Buy-from Country/Region Code"; Rec."Buy-from Country/Region Code")
                {
                    Caption = 'Country';
                    ApplicationArea = all;
                    ToolTip = 'Enter the vendor''s country on the purchase document.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    Caption = 'Posting Date';
                    ApplicationArea = all;
                    ToolTip = 'Enter posting date.';
                    Visible = false;
                }
                field("Vendor Invoice No."; Rec."Vendor Invoice No.")
                {
                    Caption = 'Vendor No.';
                    ApplicationArea = All;
                    ToolTip = 'Enter vendor no.';
                }
            }
            part(Control16; "Work Order Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Work No"=FIELD("No.");
            }
        }
        area(factboxes)
        {
            part(Control23; "Work Order Documents Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51941);
            }
            systempart(Control15; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                RunObject = Page "Work Order Documents";
                RunPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51941);
            }
            action(Schedule)
            {
                ApplicationArea = All;
                Image = ServiceHours;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    if Rec.Status = Rec.Status::Released then Rec."Scheduled Start Date":=CurrentDateTime;
                    Rec."Scheduled End Date":=CurrentDateTime + (4 * 60 * 60 * 1000);
                    //"Scheduled End Date" := CREATEDATETIME(TODAY,TIME + (3600000*4));
                    Rec."Work Order Lifecycle State":=Rec."Work Order Lifecycle State"::Scheduled;
                end;
            }
            action("View Repair Requisition")
            {
                ApplicationArea = All;
                Image = ServiceAgreement;
                Promoted = true;
                PromotedCategory = Category10;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RepairReq.RESET;
                    RepairReq.SETRANGE("No.", Rec."Repair Request No.");
                    RepairReq.SetRange(Status, RepairReq.Status::Closed);
                    PAGE.RUN(52091, RepairReq);
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
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Vendor Reg. Request", 0, Rec."No.");
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
                    /*TestField(Status, Status::Open);
                        TestField("Company Name");
                        TestField("Cert. Of Incorporation No");
                        ApprovalsMgt.OnSendVendorRegForApproval(Rec);*/
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
                        //ApprovalsMgt.OnCancelVendorRegApprovalRequest(Rec);
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
                    //ReleaseVendorReg: Codeunit "Release Vendor Reg. Request";
                    begin
                    //ReleaseVendorReg.PerformManualRelease(Rec);
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
                    //ReleaseVendorReg: Codeunit "Release Vendor Reg. Request";
                    begin
                    //ReleaseVendorReg.PerformManualReopen(Rec);
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
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
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
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    RepairReq: Record "Repair Header";
}
