page 53291 "Leave Planner App Card"
{
    ApplicationArea = All;
    Caption = 'Leave Planner App Card';
    PageType = Card;
    SourceTable = "Leave Planner Header";
    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Created;
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    Editable = false;
                }
                field(employeeCode; Rec."Employee Code")
                {
                    ToolTip = 'Specifies the value of the Employee Code field.';
                    caption = 'Employee No.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ToolTip = 'Specifies the value of the Employee Name field.';
                    Editable = false;
                }
                field(responsibilityCenter; Rec."Responsibility Center")
                {
                    ToolTip = 'Specifies the value of the Responsibility Center field.';
                    caption = 'Responsibility Center';
                    Editable = false;
                }
                field("Email Adress"; Rec."Email Adress")
                {
                    ToolTip = 'Specifies the value of the Email Adress field.';
                    Editable = false;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ToolTip = 'Specifies the value of the Mobile No field.';
                    Editable = false;
                }
                field("Leave Period"; Rec."Leave Period")
                {
                    ToolTip = 'Specifies the value of the Leave Period field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                    Editable = false;
                }
            }
            part(LeavePlannerLines; "Leave Planner Lines")
            {
                Caption = 'Leave Planner Lines';
                SubPageLink = "Document No." = field("No.");
                Editable = Rec.Status = Rec.Status::Created;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Enabled = Rec.Status = Rec.Status::Created;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to approve the Leave Plan?', false) then begin
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();
                    end;
                end;
            }
            action("Send For Approval")
            {
                Caption = 'Send Approval Request';
                Enabled = Rec."Status" = Rec."Status"::Open;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Send Approval Request action';

                trigger OnAction()
                var
                    LeaveType: Record "Leave Type";
                begin
                    Rec.TestField("Leave Period");

                    if approvalsMgmt.CheckLeavePlannerWorkflowEnabled(Rec) then
                        ApprovalsMgmt.OnSendLeavePlannerforApproval(Rec);


                    Commit();

                    Rec."Send Approval Date" := workDate;
                    Rec.Modify();
                    Message('Approval request sent successfully.');
                    CurrPage.Close();

                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Cancel Approval Request action';

                trigger OnAction()
                begin
                    ApprovalManagement.OnCancelLeavePlannerApproval(Rec);
                    message('Approval request cancelled successfully.');
                    CurrPage.Close();
                end;
            }
            action(ViewApprovals)
            {
                Caption = 'Approvals';
                Enabled = Rec."Status" = Rec."Status"::"Pending Approval";
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                ToolTip = 'Executes the Approvals action';

                trigger OnAction()
                var
                    Approvals: Record "Approval Entry";
                    Approvalentries: Page "Approval Entries";
                begin
                    Approvals.Reset();
                    Approvals.SetRange("Table ID", Database::"Leave Planner Header");
                    Approvals.SetRange("Document No.", Rec."No.");
                    ApprovalEntries.SetTableView(Approvals);
                    ApprovalEntries.RunModal();
                end;
            }
        }
    }
    var
        ApprovalManagement: Codeunit "Approval Mgt HR Ext";
        ApprovalsMgmt: Codeunit "Approval Mgt HR Ext";
        HRMgt: Codeunit "HR Management";
}






