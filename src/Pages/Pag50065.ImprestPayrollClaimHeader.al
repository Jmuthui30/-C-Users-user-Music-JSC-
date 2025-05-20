page 50065 "Imprest Payroll Claim Header"
{
    ApplicationArea = All;
    Caption = 'Imprest Payroll Claim Header';
    PageType = Card;
    SourceTable = "Imprest Payroll Claims Header";

    layout
    {
        area(content)
        {
            group(Activity)
            {
                Caption = 'Activity';

                field("No."; Rec."No.")
                {
                }
                field("Date"; Rec."Date")
                {
                }
                field("Imprest Memo"; Rec."Imprest Memo")
                {
                }
                field(From; Rec.From)
                {
                    Importance = Additional;
                }
                field("To"; Rec."To")
                {
                    Importance = Additional;
                }
                field(Subject; Rec.Subject)
                {
                }
                field(Memo; Rec.Memo)
                {
                    MultiLine = true;
                    Importance = Additional;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    Importance = Additional;
                }
                field("Sender Email"; Rec."Sender Email")
                {
                    Importance = Additional;
                }
                field("Recipient Name"; Rec."Recipient Name")
                {
                    Importance = Additional;
                }
                field("Recipient Email"; Rec."Recipient Email")
                {
                    Importance = Additional;
                }
                field(Purpose; Rec.Purpose)
                {
                }
                field("Activity Location"; Rec."Activity Location")
                {
                }
                field("Departure Location"; Rec."Departure Location")
                {
                }
                field("Departure Date"; Rec."Departure Date")
                {
                }
                field("Return Location"; Rec."Return Location")
                {
                }
                field("Return Date"; Rec."Return Date")
                {
                }
                field(Justification; Rec.Justification)
                {
                    Importance = Additional;
                }
                field("Start Date"; Rec."Start Date")
                {
                }
                field("Total Days in the Field"; Rec."Total Days in the Field")
                {
                }
                field("End Date"; Rec."End Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Approvers; Rec.Approvers)
                {
                }
            }
            part(Control01; "Imprest Payroll Claim Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Approval)
            {
                Caption = 'Approval';

                action("Send Approval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Enabled = NOT OpenApprovalEntriesExist;

                    trigger OnAction()
                    begin
                        ApprovalsMngt.OnSendImprestPayrollClaimForApproval(Rec);
                        CurrPage.Close();
                    end;
                }
                action("Cancel Approval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Request';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Enabled = CanCancelApprovalForRecord;

                    trigger OnAction()
                    begin
                        ApprovalsMngt.OnCancelImprestPayrollClaimApprovalRequest(Rec);
                        CurrPage.Close();
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close();
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Reject the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        if Confirm(StrSubstNo(Text001, Rec."No."), false) = true then begin
                            ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                            CurrPage.Update(true);
                        end
                        else
                        begin
                            exit;
                        end;
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Close();
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = Page "Approval Comments";
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                        CurrPage.Close();
                    end;
                }
                action(Payroll)
                {
                    ApplicationArea = All;
                    Caption = 'Process to Payroll';
                    Image = Payroll;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    //Visible = Rec.Status = Rec.Status::Released;
                    trigger OnAction()
                    var
                        ImprestMgt: Codeunit "Imprest Management";
                    begin
                        ImprestMgt.ProcessImprestClaimsToPayroll(Rec);
                    end;
                }
            }
        }
    }
    local procedure SetControlAppearance()
    var
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    // if GeneralSettings.IsSelfService() then
    //     Rec.SetRange("Created By", UserId);
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec.Status:=Rec.Status::Open;
    end;
    var OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    ShowWorkflowStatus: Boolean;
    DocumentIsPosted: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    ApprovalsMngt: Codeunit "Approvals Mgmt. Ext";
    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    Text000: Label 'Are you sure you want to approve the Imprest Claim %1 ?';
    Text001: Label 'Are you sure you want to reject the Imprest Claim %1 ?';
    HRCom: Codeunit "HR Communication Management";
    CommitmentMgt: Codeunit "Commitment Management";
    GeneralSettings: Codeunit GeneralSettings;
}
