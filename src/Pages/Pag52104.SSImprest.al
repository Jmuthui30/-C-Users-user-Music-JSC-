page 52104 "SS Imprest"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Imprest';
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';
    PageType = Card;
    SourceTable = "Imprest Header";
    SourceTableView = WHERE(Type=CONST(Request), "Staff Claim"=CONST(false));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status = Rec.Status::Open;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                // Editable = false;
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
                field(Designation; Rec.Designation)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("P/No"; Rec."P/No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Job Group"; Rec."Job Group")
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
                field("Imprest Type"; Rec."Imprest Type")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Imprest Memo"; Rec."Imprest Memo")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field(Purpose; Rec.Purpose)
                {
                    ApplicationArea = All;
                    Caption = 'Purpose of the activity';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Caption = 'Travel Date';
                }
                field("Total Days in the Field"; Rec."Total Days in the Field")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Return Date';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field("Location Description"; Rec."Location Description")
                {
                    ApplicationArea = All;
                }
                field("External Application"; Rec."External Application")
                {
                    ApplicationArea = All;
                }
                field("Total ITO Cost"; Rec."Total ITO Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Total Amount';
                }
                field("Total Request Amount"; Rec."Total Request Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Amount';
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
            part(Control2; "SS Imprest Details")
            {
                Editable = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
                UpdatePropagation = Both;
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
            // group
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
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
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
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=Rec.Type::Request;
        Rec."Staff Claim":=false;
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
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
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
}
