page 52111 "Imprest Surrender"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Imprest Surrender';
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Imprest Header";
    SourceTableView = WHERE(Type=const(Surrender), "Staff Claim"=CONST(false));

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
                    ShowMandatory = true;
                    ApplicationArea = All;
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
                field("Surrender Date"; Rec."Surrender Date")
                {
                    ApplicationArea = All;
                }
                field("CBK Website Address"; Rec."CBK Website Address")
                {
                    ApplicationArea = All;
                    Visible = Rec.Status = Rec.Status::Released;
                }
                field("Total ITO Cost"; Rec."Total ITO Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Amount';
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
            group("Surrender Details")
            {
                Editable = false;

                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
                field("Overdue Days"; Rec."Overdue Days")
                {
                    ApplicationArea = All;
                }
                field("Total Request Amount"; Rec."Total Request Amount")
                {
                    Caption = 'Advance Amount';
                    ApplicationArea = All;
                }
                field("Total Surrender Amount"; Rec."Total Surrender Amount")
                {
                    Caption = 'Retirement Amount';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Claim"; Rec."Total Claim")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Refund"; Rec."Total Refund")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Net Refund (Net Claim)"; Rec."Net Refund (Net Claim)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control14; "Imprest Surrender Details")
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
        area(processing)
        {
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
            action("Post Retirement")
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Surrender Posted" = false));

                trigger OnAction()
                begin
                    ImprestMgt.PostImprestSurrender(Rec);
                end;
            }
            action("Reject Retirement")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = ((Rec.Status = Rec.Status::Released) and (Rec."Surrender Posted" = false));

                trigger OnAction()
                begin
                    ImprestMgt.RejectCashRetirement(Rec);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=Rec.Type::Surrender;
        Rec."Staff Claim":=false;
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
}
