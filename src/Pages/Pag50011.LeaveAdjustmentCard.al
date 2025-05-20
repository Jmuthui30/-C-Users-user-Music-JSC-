page 50011 "Leave Adjustment Card"
{
    ApplicationArea = All;
    Caption = 'Leave Adjustment Card';
    PageType = Card;
    SourceTable = "Leave Adjustment Header";
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Leave Adjustments No."; Rec."Leave Adjustments No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Job Group"; Rec."Job Group")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("No. Of Days"; Rec."No. Of Days")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Leave Type Name"; Rec."Leave Type Name")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
            part("Leave Adjustments"; "Leave Adjustment Matrix")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Leave Adjustments';
                SubPageLink = "No." = FIELD("Leave Adjustments No.");
            }
            group(Audit)
            {
                Caption = 'Audit';

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = Basic, Suite;
                }
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
                PromotedOnly = true;

                // RunObject = Page "Document Attachment Details";
                // RunPageLink = "No." = FIELD("Leave Adjustments No."),
                //               "Table ID" = CONST(51602);
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
        }
        area(navigation)
        {
            // action("Assign Employees")
            // {
            //     ApplicationArea = Basic, Suite;
            //     Image = Add;
            //     Promoted = true;
            //     PromotedCategory = Process;
            //     PromotedIsBig = true;
            //     trigger OnAction()
            //     begin
            //         Clear(LeaveADjEmployeeLookup);
            //         Rec.TestField("Leave Type");
            //         Employee.Reset;
            //         LeaveTypes.Get(Rec."Leave Type");
            //         if LeaveTypes.Gender <> LeaveTypes.Gender::Other then begin
            //             Message('%1', LeaveTypes.Gender);
            //             if LeaveTypes.Gender = LeaveTypes.Gender::Male then
            //                 Employee.SetRange(Gender, Employee.Gender::Male)
            //             else
            //                 Employee.SetRange(Gender, Employee.Gender::Female);
            //         end;
            //         Employee.SetRange(Status, Employee.Status::Active);
            //         if Employee.FindSet then begin
            //             LeaveADjEmployeeLookup.SetTableView(Employee);
            //             LeaveADjEmployeeLookup.LookupMode := true;
            //             LeaveADjEmployeeLookup.InitializePaarams(Rec."Leave Adjustments No.", Rec."No. Of Days");
            //             LeaveADjEmployeeLookup.RunModal;
            //         end;
            //     end;
            // }
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Image = AdjustEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EntryNo: Integer;
                begin
                    Rec.TestField("Leave Type");
                    LeaveTypes.Get(Rec."Leave Type");
                    LeaveAdjustmentsLine.Reset();
                    LeaveAdjustmentsLine.SetRange("No.", Rec."Leave Adjustments No.");
                    if LeaveAdjustmentsLine.FindFirst() then begin
                        repeat
                            LeaveEntries.Reset;

                            LeaveEntries.SetRange("Employee No", LeaveAdjustmentsLine."Employee No.");
                            LeaveEntries.SetRange("Leave Code", Rec."Leave Type");
                            if LeaveEntries.FindLast then begin
                                Message('mjk');

                                Message('no of is %1', LeaveAdjustmentsLine."Adjustment Days");

                                LeaveEntries."Balance Brought Forward" := LeaveEntries."Balance Brought Forward" + LeaveAdjustmentsLine."Adjustment Days";
                                LeaveEntries.Modify();
                                Rec.Status := Rec.Status::Closed;
                                Rec.Modify();
                            end;
                        until LeaveAdjustmentsLine.Next() = 0;
                    end;
                    Message('Successfully posted');
                    CurrPage.Close();
                end;
            }
            action("Send Approval Request")
            {
                ApplicationArea = Basic, Suite;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalsMgtExt: Codeunit "Approvals Mgmt. Ext";
                begin
                    Rec.TestField(Status, Rec.Status::New);
                    Rec.TestField("Leave Type");
                    //TESTFIELD(Type);
                    Rec.TestField(Description);
                    Rec.TestField("No. Of Days");
                    if not Confirm('Are you sure you want to send the document for approval') then exit;
                    if not CheckForLines then //  IF ApprovalsMgmt.CheckLeaveAdjApprovalPossible(Rec) THEN
                                              //   ApprovalsMgmt.OnSendLeaveAdjForApproval(Rec);
                                              // ApprovalsMgtExt.OnsendLeaveAdjustmentForApproval(Rec);
                        CurrPage.Close();
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Basic, Suite;
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ApprovalsMgtExt: Codeunit "Approvals Mgmt. Ext";
                begin
                    Rec.TestField(Status, Rec.Status::"Pending Approval");
                    Rec.TestField("Leave Type");
                    Rec.TestField(Type);
                    Rec.TestField(Description);
                    Rec.TestField("No. Of Days");
                    if not Confirm('Are you sure you want to cancel Approval Request') then
                        exit
                    else begin
                        // ApprovalsMgmt.OnCancelLeaveAdjForRequest(Rec);
                        //   ApprovalsMgtExt.OnCancelLeaveAdjustmentApprovalRequest(Rec);
                        CurrPage.Close();
                    end;
                end;
            }
            action(Approve)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Approve';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Approve the requested changes.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if not Confirm('Are you sure you want to Approve the document?') then exit;
                    ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    CurrPage.Close();
                end;
            }
            action(Reject)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Reject the approval request.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if not Confirm('Are you sure you want to Reject the document?') then exit;
                    ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    CurrPage.Close;
                end;
            }
            action(Delegate)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Delegate';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'Delegate the approval to a substitute approver.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    if not Confirm('Are you sure you want to Approve the document?') then exit;
                    ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    CurrPage.Close();
                end;
            }
            action(Comment)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category4;
                ToolTip = 'View or add comments for the record.';
                Visible = OpenApprovalEntriesExistForCurrUser;

                trigger OnAction()
                var
                    ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                begin
                    ApprovalsMgmt.GetApprovalComment(Rec);
                end;
            }
            group(Approvals)
            {
                action("Approval Entries")
                {
                    ApplicationArea = All;
                    Enabled = OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ApprovalMgt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalMgt.OpenApprovalEntriesPage(Rec.RecordId);
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        LeaveAdjustmentsLine.Reset;
        LeaveAdjustmentsLine.SetRange("No.", Rec."Leave Adjustments No.");
        if LeaveAdjustmentsLine.FindFirst then begin
            repeat
                LeaveAdjustmentsLine.Validate("Employee No.");
                LeaveAdjustmentsLine.Modify;
            until LeaveAdjustmentsLine.Next = 0;
        end;
    end;

    var
        Text000: Label 'Completed Successfully.';
        Employee: Record Employee;
        //        LeaveADjEmployeeLookup: Page "Leave Adj. Employee Lookup";
        LeaveAdjustmentsLine: Record "Leave Adjustment Line";
        Ok: Boolean;
        Window: Dialog;
        LeaveEntries: Record "Employee Leaves";
        LeaveTypes: Record "Leave Setup";
        UserSetup: Record "User Setup";
        LineNo: Integer;
        LeaveSetup: Record "Leave Setup";
        JournalBatch: Code[40];
        JournalTemplate: Code[50];
        LeaveYearPeriod: Code[30];
        EmployeesHR: Record Employee;
        LeaveEntryType: Option Positive,Negative,Reimbursement,OpeinigBalance;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExist: Boolean;
        OpenApprovalEntriesExistForCurrUser: Boolean;

    local procedure CheckForLines(): Boolean
    begin
        LeaveAdjustmentsLine.Reset;
        LeaveAdjustmentsLine.SetRange("No.", Rec."Leave Adjustments No.");
        exit(LeaveAdjustmentsLine.FindFirst);
    end;

    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
    end;
}
