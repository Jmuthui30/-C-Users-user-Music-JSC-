page 50059 "Imprest Memo Header"
{
    ApplicationArea = All;
    Caption = 'Imprest Memo Header';
    PageType = Card;
    SourceTable = "Imprest Memo Header";

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
                field(From; Rec.From)
                {
                }
                field("To"; Rec."To")
                {
                }
                field(Subject; Rec.Subject)
                {
                }
                field(Memo; Rec.Memo)
                {
                    MultiLine = true;
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
                //  field()
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

            group(Options)
            {
                Caption = 'Options';

                group(DefaultOptions)
                {
                    Caption = 'Default';

                    field(International; Rec.International)
                    {
                    }
                    field(DSA; Rec.DSA)
                    {
                    }
                    field("Cordination Allowance"; Rec."Cordination Allowance")
                    {
                    }
                    field("Facilitator Allowance"; Rec."Facilitator Allowance")
                    {
                    }
                    field("Secretariat Allowance"; Rec."Secretariat Allowance")
                    {
                    }
                    field("Rapporteur Allowance"; Rec."Rapporteur Allowance")
                    {
                    }
                    field("Driver Allowance"; Rec."Driver Allowance")
                    {
                    }
                    field("Retreat Allowance"; Rec."Retreat Allowance")
                    {
                    }
                    field("Expert Allowance"; Rec."Expert Allowance")
                    {
                    }
                }
                group(OptionalOptions)
                {
                    Caption = 'Optional';

                    field("Air Ticket"; Rec."Air Ticket")
                    {
                    }
                    field(Conference; Rec.Conference)
                    {
                    }
                    field("Ground Transport"; Rec."Ground Transport")
                    {
                    }
                    field(Accomodation; Rec.Accomodation)
                    {
                    }
                    field("Out of Pocket Allowance"; Rec."Out of Pocket Allowance")
                    {
                    }
                    field("Tuition Fee"; Rec."Tuition Fee")
                    {
                    }
                    field("Mileage Allowance"; Rec."Mileage Allowance")
                    {
                    }
                    field("Quarter Per Diem"; Rec."Quarter Per Diem")
                    {
                    }
                }
            }
            group(Financials)
            {
                Caption = 'Financials';

                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    Importance = Additional;
                }
                field("Amount on Budget"; Rec."Amount on Budget")
                {
                    trigger OnDrillDown()
                    var
                        BudgetAnalysis: Record "Imprest Budget Analysis";
                        CommitmentMgt: Codeunit "Commitment Management";
                    begin
                        CommitmentMgt.ImprestMemoBudgetCheck(Rec);
                        Commit();
                        BudgetAnalysis.Reset();
                        BudgetAnalysis.SetRange("Memo No.", Rec."No.");
                        if Page.RunModal(Page::"Imprest Budget Analysis", BudgetAnalysis) = Action::LookupOK then CurrPage.Update();
                    end;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                }
                field("Budget Available"; Rec."Budget Available")
                {
                }
                field(Committed; Rec.Committed)
                {
                }
            }

            group(message)
            {
                field("Message body"; "Message body")
                {
                    MultiLine = true;
                }
                field("Message body 1"; "Message body 1")
                {
                    MultiLine = true;

                }
            }

            part(Control01; "Imprest Memo Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
                UpdatePropagation = Both;
            }
        }
    }
    actions
    {
        area(Processing)
        {

            group(Sharepoint)
            {
                action(ImportDocument)
                {
                    Caption = 'Import Document to Sharepoint';
                    ApplicationArea = All;
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                    trigger OnAction()
                    var
                        SharepointHandler: Codeunit "Portal Integration";
                    begin
                        SharepointHandler.UploadFilesToSharePoint(Rec."No.", 'MEMO');
                    end;
                }

                action("Sharepoint Attachments")
                {
                    ApplicationArea = all;
                    Ellipsis = true;
                    Image = Attachments;
                    Visible = true;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = page "Portal Uploads";
                    RunPageLink = "Document No" = field("No.");
                }
            }
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
                        ApprovalsMngt.OnSendImprestMemoForApproval(Rec);
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
                        ApprovalsMngt.OnCancelImprestMemoApprovalRequest(Rec);
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
                        else begin
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
                action(ExpenseDecision)
                {
                    ApplicationArea = All;

                    ;
                    Caption = 'Procurement Decision';
                    Image = SelectMore;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    //Visible = Rec.Status = Rec.Status::Released;
                    trigger OnAction()
                    var
                        Expenses: Record "Imprest Procurement Decision";
                    begin
                        CommitmentMgt.InsertImprestExpenses(Rec);
                        CommitmentMgt.ImprestMemoExpenseCheck(Rec);
                        Commit();
                        Expenses.Reset();
                        Expenses.SetRange("Memo No.", Rec."No.");
                        if Page.RunModal(Page::"Imprest Procurement Decision", Expenses) = Action::LookupOK then CurrPage.Update();
                    end;
                }
                action(Procurement)
                {
                    ApplicationArea = All;
                    Caption = 'Request for Procurement';
                    Image = GetOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    //Visible = Rec.Status = Rec.Status::Released;
                    trigger OnAction()
                    var
                        ImprestMgt: Codeunit "Imprest Management";
                    begin
                        CommitmentMgt.ImprestMemoExpenseCheck(Rec);
                        Commit();
                        ImprestMgt.CreateImprestMemoPR(Rec);
                    end;
                }
                action(Budget)
                {
                    ApplicationArea = All;
                    Caption = 'Budget Check';
                    Image = LedgerBudget;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    //Visible = Rec.Status = Rec.Status::Released;
                    trigger OnAction()
                    begin
                        CommitmentMgt.InsertImprestBudgetAnalysis(Rec);
                        Commit();
                        CommitmentMgt.ImprestMemoBudgetCheck(Rec);
                        Message('Completed');
                    end;
                }
                action(Commit)
                {
                    ApplicationArea = All;

                    ;
                    Caption = 'Commit';
                    Image = Confirm;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if Rec.Status <> Rec.Status::Released then Error('You can only commit an approved Memo.');
                        CommitmentMgt.ImprestMemoCommitment(Rec);
                        Message('Committed Successfully');
                    end;
                }
                action(UnCommit)
                {
                    ApplicationArea = All;

                    ;
                    Caption = 'UnCommit';
                    Image = UndoFluent;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    trigger OnAction()
                    begin
                        if not Rec.Committed then Error('This memo has not been committed.');
                        CommitmentMgt.UndoImprestMemoCommitment(Rec);
                        Message('UnCommitted Successfully');
                    end;
                }
                action(Payroll)
                {
                    ApplicationArea = All;
                    Caption = 'Create Payroll Claims';
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
                        ImprestMgt.CreateImprestPayrollClaims(Rec);
                    end;
                }
            }
            group(Notification)
            {
                action(Notify)
                {
                    ApplicationArea = All;

                    ;
                    Caption = 'Notify Participants';
                    Image = SendConfirmation;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;

                    //Visible = Rec.Status = Rec.Status::Released;
                    trigger OnAction()
                    begin
                        HRCom.SendImprestMemoEmail(Rec);
                        Message('Completed');
                    end;
                }
            }
        }
    }
    local procedure SetControlAppearance()
    var
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
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
        Rec.Status := Rec.Status::Open;
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.Status := Rec.Status::Open;
    end;

    var
        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        ShowWorkflowStatus: Boolean;
        DocumentIsPosted: Boolean;
        CanCancelApprovalForRecord: Boolean;
        CanRequestApprovalForFlow: Boolean;
        CanCancelApprovalForFlow: Boolean;
        ApprovalsMngt: Codeunit "Approvals Mgmt. Ext";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Text000: Label 'Are you sure you want to approve the Imprest Memo %1 ?';
        Text001: Label 'Are you sure you want to reject the Imprest Memo %1 ?';
        HRCom: Codeunit "HR Communication Management";
        CommitmentMgt: Codeunit "Commitment Management";
        GeneralSettings: Codeunit GeneralSettings;
}
