page 51503 "Bal Admin App. Score Card List"
{
    PageType = List;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    CardPageId = "Bal Admin Appraisal Score Card";
    SourceTable = "Bal Score Card Header";
    SourceTableView = where("Document Type"=const(Appraisal), Status=const(Released));
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Supervisor's Name"; Rec."Supervisor's Name")
                {
                    ApplicationArea = All;
                }
                field("Progress Review Period"; Rec."Progress Review Period")
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
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
                        Rec.Status:=Rec.Status::Closed;
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
                    // ReleaseBalScoreCardDoc.PerformManualReopen(Rec);
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
        CalculatePerformanceRating;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance;
        CalculatePerformanceRating;
    end;
    trigger OnOpenPage()
    begin
        SetControlAppearance;
        CalculatePerformanceRating;
    end;
    var //BookingMngt: Codeunit "Booking Management";
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
    end;
    local procedure CalculatePerformanceRating()
    begin
        Rec.CalcFields(Rec."Expected Score", Rec."Expected Global Score", Score, "Global Score");
        if((Rec.Score + Rec."Global Score") <> 0)then Rec."Combined Score":=Round((((Rec.Score + Rec."Global Score") / (Rec."Expected Global Score" + Rec."Expected Score")) * 100), 0.01);
        if Rec."Combined Score" > 90 then Rec."Performance Rating":='A'
        else if((Rec."Combined Score" > 75) and (Rec."Combined Score" < 90))then Rec."Performance Rating":='B'
            else if((Rec."Combined Score" > 62.5) and (Rec."Combined Score" < 75))then Rec."Performance Rating":='C'
                else if Rec."Combined Score" < 62.5 then Rec."Performance Rating":='D';
        Rec.Modify(true);
    end;
}
