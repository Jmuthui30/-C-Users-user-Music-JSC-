page 51504 "Bal Admin Appraisal Score Card"
{
    PageType = Card;
    DeleteAllowed = false;
    InsertAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';
    SourceTable = "Bal Score Card Header";
    SourceTableView = where("Document Type"=const(Appraisal), Status=const(Released));

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Planning Doc No"; Rec."Planning Doc No")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }
                field("Progress Review Period"; Rec."Progress Review Period")
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
                    Importance = Additional;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field("Employee's Department"; Rec."Employee's Department")
                {
                    ApplicationArea = All;
                }
                field("Employee's Branch"; Rec."Employee's Branch")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Expected Score"; Rec."Expected Score")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field("Expected Global Score"; Rec."Expected Global Score")
                {
                    ApplicationArea = All;
                }
                field("Global Score"; Rec."Global Score")
                {
                    ApplicationArea = All;
                }
                field("Combined Score"; Rec."Combined Score")
                {
                    ApplicationArea = All;
                }
                field("Performance Rating"; Rec."Performance Rating")
                {
                    ApplicationArea = All;
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    Visible = NOT ReviewVisibility;
                }
                group("Supervisor Details")
                {
                    field(Supervisor; Rec.Supervisor)
                    {
                        ApplicationArea = All;
                    }
                    field("Supervisor's Name"; Rec."Supervisor's Name")
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                    }
                    field("Supervisor's Position"; Rec."Supervisor's Position")
                    {
                        ApplicationArea = All;
                    }
                    field("Supervisor's Department"; Rec."Supervisor's Department")
                    {
                        ApplicationArea = All;
                    }
                    field("Supervisor's Branch"; Rec."Supervisor's Branch")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part(Control17; "Bal Admin App Score Card Lines")
            {
                Editable = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                SubPageLink = DocNo=FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Recommendations)
            {
                field("Appraisee Comment"; Rec."Appraisee Comment")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Appraiser Recommendations"; Rec."Appraiser Recommendations")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    MultiLine = true;
                }
                field("HR's Review"; Rec."HR's Review")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    MultiLine = true;
                }
                part(Control002; "Training Needs Lines")
                {
                    Editable = Rec.Status = Rec.Status::Released;
                    ApplicationArea = All;
                    SubPageLink = "Employee No."=field("Employee No."), "Reference No."=field("No.");
                }
            }
        }
        area(factboxes)
        {
            part(Control2; "Bal Score Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(52273);
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
            action("Close Review")
            {
                ApplicationArea = All;
                Image = SuggestCustomerBill;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Visible = (Rec.Status = Rec.Status::Released) AND ReviewVisibility;

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::Released);
                    Rec.TestField("Appraisee Comment");
                    Rec.TestField("Appraiser Recommendations");
                    Rec.TestField("HR's Review");
                    // CloseBalAppraisalPeriod.GetAppraisalNo(Rec);
                    // CloseBalAppraisalPeriod.RunModal();
                    if Confirm(StrSubstNo(Text000, Rec."No."), false) = true then begin
                        Rec.Status:=rec.Status::Closed;
                        Rec.Modify(true);
                    end
                    else
                    begin
                        exit;
                    end;
                end;
            }
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                PromotedOnly = true;
                RunObject = Page "Bal Score Card Documents";
                RunPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(52273);
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
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Bal Score Card Header", 0, Rec."No.");
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
                        Rec.TestField("Employee No.");
                        Rec.TestField(Supervisor);
                        Rec.TestField(Status, Rec.Status::Open);
                        BalAppLines.Reset();
                        BalAppLines.SetRange(DocNo, Rec."No.");
                        BalAppLines.SetRange("Progress Review Period", Rec."Progress Review Period");
                        if BalAppLines.FindSet()then repeat begin
                                BalAppLines.TestField("Achievements ToDate");
                                If BalAppLines."Full Period Appraisal" = true then begin
                                    BalAppLines.TestField("Self Rating");
                                end;
                            end;
                            until BalAppLines.Next() = 0;
                        ApprovalsMgt.OnSendBalScoreCardForApproval(Rec);
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
                        ApprovalsMgt.OnCancelBalScoreCardApprovalRequest(Rec);
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
                        ReleaseBalScoreCardDoc: Codeunit "Release Bal Score Card";
                    begin
                        ReleaseBalScoreCardDoc.PerformManualRelease(Rec);
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
                        ReleaseBalScoreCardDoc: Codeunit "Release Bal Score Card";
                    begin
                        ReleaseBalScoreCardDoc.PerformManualReopen(Rec);
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
    trigger OnInit()
    begin
        Rec."Document Type":=Rec."Document Type"::Appraisal;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Document Type":=Rec."Document Type"::Appraisal;
    end;
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
    end;
    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;
    var // BookingMngt: Codeunit "Booking Management";
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    CloseBalAppraisalPeriod: Report "Close Bal Appraisal Period";
    BalAppLines: Record "Bal Score Card Lines";
    PreviewPeriod: Record "Bal Score Preview Periods";
    ReviewVisibility: Boolean;
    Text000: Label 'You are about to close %1 do you wish to continue?';
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        PreviewPeriod.Reset();
        PreviewPeriod.SetRange(Code, rec."Progress Review Period");
        PreviewPeriod.SetRange("Preview Period Type", PreviewPeriod."Preview Period Type"::"Full Period Appraisal");
        if PreviewPeriod.FindFirst()then ReviewVisibility:=false
        else
            ReviewVisibility:=true;
        Rec.CalcFields(Score);
        Rec."Rating Score":=Round(Rec.Score, 1);
        Rec.Modify(true);
    end;
}
