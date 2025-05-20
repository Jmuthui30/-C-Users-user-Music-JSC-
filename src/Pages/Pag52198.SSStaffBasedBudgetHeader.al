page 52198 "SS Staff Based Budget Header"
{
    PageType = Card;
    SourceTable = "Staff Based Budget Header";
    Caption = 'Departmental Staff Based Budget';
    DeleteAllowed = false;
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Budget; Rec.Budget)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Reference Date"; Rec."Reference Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Control25; "Staff Based Budget")
            {
                ApplicationArea = All;
                SubPageLink = Budget=field(Budget), Department=field("Global Dimension 1 Code");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Distribute Staff Based Budget")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = DistributionGroup;

                trigger OnAction()
                begin
                    BudgetMgnt.DistributeStaffBasedBudget(Rec);
                end;
            }
            action("Staff Based Budget")
            {
                ApplicationArea = All;
                Caption = 'Import';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                RunObject = xmlport "Staff Based Budget";
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
                        ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Vendor Reg. Request", 0, Rec."No.");
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
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField(Budget);
                        Rec.TestField("Global Dimension 1 Code");
                        ApprovalsMgt.OnSendStaffBasedBudgetForApproval(Rec);
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
                        ApprovalsMgt.OnCancelStaffBasedBudgetApprovalRequest(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Status:=Rec.Status::Open;
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst()then begin
            if Emp.Get(UserSetup."Employee No.")then begin
                Emp.TestField("Global Dimension 1 Code");
                Rec.Validate("Global Dimension 1 Code", Emp."Global Dimension 1 Code");
                Rec.Validate("Global Dimension 2 Code", Emp."Global Dimension 2 Code");
                Rec.Validate("Global Dimension 3 Code", Emp."Global Dimension 3 Code");
            end;
        end
        else
            Error(Text000);
    end;
    trigger OnOpenPage()
    begin
        UserSetup.Reset();
        UserSetup.SetRange("User ID", UserId);
        if UserSetup.FindFirst()then begin
            if Emp.Get(UserSetup."Employee No.")then begin
                Emp.TestField("Global Dimension 1 Code");
                Rec.SetRange("Global Dimension 1 Code", Emp."Global Dimension 1 Code");
            end;
        end
        else
            Error(Text000);
    end;
    var StaffBasedBudget: XmlPort "Staff Based Budget";
    BudgetMgnt: Codeunit "Budget Management";
    UserSetup: Record "User Setup";
    Emp: Record "Employee Master";
    Text000: Label 'Please Contact For QuantumJumps User Setup';
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
}
