page 50055 "Consolidated Recruitment Plans"
{
    PromotedActionCategories = 'New,Process,Report,Approval,Manual Approval,Request Approval,Workflow,Attachments,Navigate';
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Consolidated Recruitment Plan";
    UsageCategory = Lists;
    CardPageId = "Consolidated Recruitment Plan";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Financial Year"; Rec."Fiscal Year")
                {
                    ApplicationArea = all;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = all;
                }
                field(Status; Status) { ApplicationArea = all; }
                // field(Consolidated;Consolidated){ApplicationArea = all;}
            }
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Consolidated Recruitment Plan"), "No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                Visible = NOT OpenApprovalEntriesExistForCurrUser;

                action("Send Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Send A&pproval Request';
                    Visible = Rec.Status = Rec.Status::Open;
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';
                    AboutTitle = 'Approval Request';
                    AboutText = 'Send the Application for Approval before creation of the Accounts by clicking **Send Approval Request**';

                    trigger OnAction();
                    begin
                        ApprovalsMgmtExt.OnSendConsolidatedRecruitmentPlanForApproval(Rec);
                        CurrPage.Close();
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cancel Approval Re&quest';
                    Visible = Rec.Status = Rec.Status::"Pending Approval";
                    Enabled = CanCancelApprovalForRecord OR CanCancelApprovalForFlow;
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category7;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';
                    AboutTitle = 'Cancel Approval Request';
                    AboutText = 'Incase of Corrections recall the document by clicking **Cancel Approval Request**';

                    trigger OnAction();
                    begin
                        ApprovalsMgmtExt.OnCancelConsolidatedRecruitmentPlanApprovalRequest(Rec);
                        CurrPage.Close();
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
                        Text001: Label 'You are about to approve the document, Do you wish to continue';
                        Text002: Label 'You have approved the document';
                    begin
                        if Confirm(Text001, false) = true then begin
                            ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                            Message(Text002);
                            CurrPage.Close();
                        end
                        else
                            exit;
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
                        Text001: Label 'You are about to Reject the document, Do you wish to continue';
                        Text002: Label 'You have rejected the document';
                    begin
                        if Confirm(Text001, false) = true then begin
                            ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                            Message(Text002);
                            CurrPage.Close();
                        end
                        else
                            exit;
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
                        Text001: Label 'You are about to Delegate the document, Do you wish to continue';
                        Text002: Label 'You have delegated the document';
                    begin
                        if Confirm(Text001, false) = true then begin
                            ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                            Message(Text002);
                            CurrPage.Close();
                        end
                        else
                            exit;
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
                    begin
                        ; //VOKOTHWorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Recruitment Plan", 0, Rec."No.");
                    end;
                }
            }
            action(Suggest)
            {
                Caption = 'Consolidate Recruitment Plans';
                Image = Suggest;
                Promoted = true;
                ApplicationArea = all;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    ConsPlanLines.Reset();
                    ConsPlanLines.SetRange("Document No.", Rec."No.");
                    if not ConsPlanLines.IsEmpty() then ConsPlanLines.DeleteAll();
                    Clear(UpdatedLines);
                    Rec.TestField("Fiscal Year");
                    RecruitmentPlan.Reset();
                    RecruitmentPlan.SetRange(Status, RecruitmentPlan.Status::Released);
                    RecruitmentPlan.SetRange("Fiscal Year", Rec."Fiscal Year");
                    RecruitmentPlan.SetRange(Status, RecruitmentPlan.Status::Released);
                    RecruitmentPlan.SetRange(Consolidated, false);
                    if RecruitmentPlan.FindSet then begin
                        repeat
                            RecruitmentPlanLines.Reset();
                            RecruitmentPlanLines.SetRange("Document No.", RecruitmentPlan."No.");
                            if RecruitmentPlanLines.FindSet() then begin
                                //Delete existing lines
                                repeat //Testfield
                                    //DeptPlanLines.TestField("Required Positions");
                                    ConsPlanLines.Init();
                                    ConsPlanLines."Document No." := Rec."No.";
                                    ConsPlanLines."Job ID" := RecruitmentPlanLines."Job ID";
                                    ConsPlanLines."Job Title" := RecruitmentPlanLines."Job Title";
                                    ConsPlanLines.Grade := RecruitmentPlanLines.Grade;
                                    ConsPlanLines."No of Posts" := RecruitmentPlanLines."No of Posts";
                                    ConsPlanLines."Position Reporting to Code" := RecruitmentPlanLines."Position Reporting to Code";
                                    ConsPlanLines."Position Reporting to Name" := RecruitmentPlanLines."Position Reporting to Name";
                                    ConsPlanLines."Occupied Positions" := RecruitmentPlanLines."Occupied Positions";
                                    ConsPlanLines."Vacant Positions" := RecruitmentPlanLines."Vacant Positions";
                                    ConsPlanLines."Required Positions" := RecruitmentPlanLines."Required Positions";
                                    ConsPlanLines."Global Dimension 1 Code" := RecruitmentPlan."Global Dimension 1 Code";
                                    ConsPlanLines."Global Dimension 2 Code" := RecruitmentPlan."Global Dimension 2 Code";
                                    ConsPlanLines."Department Name" := RecruitmentPlan."Department Name";
                                    ConsPlanLines."Plan No" := RecruitmentPlan."No.";
                                    UpdatedLines += 1;
                                    ConsPlanLines.Insert(true);
                                until RecruitmentPlanLines.Next() = 0;
                            end;
                            RecruitmentPlan.Consolidated := true;
                            RecruitmentPlan.Modify(true);
                        until RecruitmentPlan.Next() = 0;
                    end
                    else begin
                        Error(Err_NoDeptPlans, Rec."Fiscal Year");
                    end;
                    Message('[%1] recruitment plans have been consolidated to consolidated plan no. [ %2 ]', UpdatedLines, Rec."No.");
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
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
        IsOfficeAddin := OfficeMgt.IsAvailable;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        OfficeMgt: Codeunit "Office Management";
        IsOfficeAddin: Boolean;
        ApprovalsMgmtExt: Codeunit "Approvals Mgmt. Ext";
        RecruitmentPlan: Record "Recruitment Plan";
        RecruitmentPlanLines: Record "Recruitment Plan Lines";
        ConsPlanHeader: Record "Consolidated Recruitment Plan";
        ConsPlanLines: Record "Consolidated R. Plan Lines";
        UpdatedLines: Integer;
        Err_NoDeptPlans: Label 'There are no departmental plans that have been approved for the current financial year %1';
        Lbl_Confirm: Label 'Consolidate all approved departmental plan(s) to this document?';
}
