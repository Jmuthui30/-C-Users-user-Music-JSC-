page 52103 "SS Imprests"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Imprests';
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';
    CardPageID = "SS Imprest";
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
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Total Request Amount"; Rec."Total Request Amount")
                {
                    ApplicationArea = All;
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
                    REPORT.Run(Report::"Imprest Request", true, false, Rec);
                end;
            }
        }
        area(Processing)
        {
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;

                // RunObject = Page "Cash & Claim Documents";
                // RunPageLink = "Document No." = FIELD("No.");
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
                        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        ApprovalsMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Imprest Header", 0, Rec."No.");
                    end;
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
                        Visible = ((Rec.Status = Rec.Status::Open) Or (Rec.Status = Rec.Status::Rejected) Or (Rec.Status = Rec.Status::"Pending Approval"));
                        Image = SendApprovalRequest;
                        Promoted = true;
                        PromotedCategory = Category6;
                        PromotedIsBig = true;
                        PromotedOnly = true;
                        ToolTip = 'Request approval of the document.';

                        trigger OnAction()
                        begin
                            Rec.TestField(Status, Rec.Status::Open);
                            Rec.TestField("Total Days in the Field");
                            ApprovalsMgt.OnSendImprestForApproval(Rec);
                        end;
                    }
                    action(CancelApprovalRequest)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cancel Approval Re&quest';
                        Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                        Visible = ((Rec.Status = Rec.Status::Open) Or (Rec.Status = Rec.Status::Rejected) Or (Rec.Status = Rec.Status::"Pending Approval"));
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
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
        Rec.Type:=Rec.Type::Request;
        Rec."Staff Claim":=false;
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
}
