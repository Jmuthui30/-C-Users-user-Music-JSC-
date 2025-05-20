page 52071 "Procurement Plan Header"
{
    //Ibrahim Wasiu
    DeleteAllowed = false;
    Caption = 'Procurement Plan';
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Procurement Plan Header";
    PromotedActionCategories = 'New,Process,Report,Approval,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = ((Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::Released));

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit then CurrPage.Update;
                    end;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = true;
                }
                field("Financial Budget ID"; Rec."Financial Budget ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = true;
                }
                field("Financial Year Code"; Rec."Financial Year Code")
                {
                    ApplicationArea = All;
                    Editable = true;
                    Visible = true;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    //MultiLine = true;
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field("Procurement Date"; Rec."Procurement Date")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field("Raised By"; Rec."Raised By")
                {
                    ApplicationArea = All;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    ApplicationArea = All;
                    Visible = (Rec.status = Rec.status::Open) OR (Rec.status = Rec.status::"Pending Approval");
                }
                field(Verified; Rec.Verified)
                {
                    ApplicationArea = All;
                    Visible = Rec.status = Rec.status::Released;
                }
                field("Verified By"; Rec."Verified By")
                {
                    ApplicationArea = All;
                    Visible = Rec.status = Rec.status::Released;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Estimate"; Rec."Total Estimate")
                {
                    ApplicationArea = All;
                    Caption = 'Total Procurement Plan';
                }
                field("No. Of Items"; Rec."No. Of Items")
                {
                    ApplicationArea = All;
                    Caption = 'No. of Lines';
                }
                field("AGPO Reservation"; Rec."AGPO Reservation")
                {
                    ApplicationArea = All;
                }
                field("% of AGPO Reservation"; Rec."% of AGPO Reservation")
                {
                    ApplicationArea = All;
                }
            }
            part(Control4; "Procurement Plan Lines")
            {
                Editable = ((Rec.Status = Rec.Status::Open) OR (Rec.Status = Rec.Status::Released));
                ApplicationArea = All;
                UpdatePropagation = Both;
                SubPageLink = "Plan No"=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control1; Notes)
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
                Visible = false;
                ApplicationArea = All;
                Image = PrintVoucher;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::PV, true, false, Rec);
                end;
            }
        }
        area(Processing)
        {
            action("Import Procurement Plan")
            {
                ApplicationArea = All;
                Visible = Rec.status = Rec.status::Open;
                Caption = 'Import Procurement Plan';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;

                trigger OnAction()
                begin
                    Clear(ProcurementImp);
                    ProcurementImp.GetHeader(Rec);
                    ProcurementImp.Run();
                end;
            }
            action("Clear Details")
            {
                ApplicationArea = All;
                Visible = Rec.status = Rec.status::Open;
                Caption = 'Clear Details';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = ClearLog;

                trigger OnAction()
                begin
                    ProcurementList.Reset;
                    ProcurementList.Setrange("Plan No", Rec."No.");
                    ProcurementList.DeleteAll;
                    Message('Details Cleared');
                end;
            }
            group("Approval Details")
            {
                //Visible = NOT OpenApprovalEntriesExistForCurrUser;
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
                        //ApprovalsMgt.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Procurement Plan Header", 0, Rec."No.");
                        ApprovalsMgt.OpenApprovalEntriesPage(Rec.RecordId);
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
                        Rec.TestField("Procurement Date");
                        Rec.TestField(Description);
                        Rec.CalcFields("Empty No.");
                        if Rec."Empty No." = true then Error('The No. must be filled on the lines.');
                        Lines.Reset;
                        Lines.SetRange("Plan No", Rec."No.");
                        if Lines.FindSet then repeat Lines.TestField(Quantity);
                                Lines.TestField("Source of Funds");
                                //if (Lines."Department Code" = '') AND (Lines."Global Dimension 2 Code" = '') AND (Lines."Source of Funds" = '') then
                                if(Lines."Department Code" = '')then Error('The Department Code can not be blank for procurement plan lines %1', Lines."Line No");
                            until Lines.Next = 0;
                        ApprovalsMgt.OnSendProcurePlanForApproval(Rec);
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
                        IF CONFIRM('Are you sure you want to cancel the Procurement Plan %1. Do you want to continue?', FALSE, Rec."No.")THEN ApprovalsMgt.OnCancelProcurePlanApprovalRequest(Rec);
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
                        ReleaseProcurePlan: Codeunit "Release Procurement Plan";
                    begin
                        ReleaseProcurePlan.PerformManualRelease(Rec);
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
                        ReleaseProcurePlan: Codeunit "Release Procurement Plan";
                    begin
                        ReleaseProcurePlan.PerformManualReopen(Rec);
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
                        IF CONFIRM('Are you sure you want to approve the Procurement Plan %1. Do you want to continue?', FALSE, Rec."No.")THEN ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                        IF CONFIRM('Are you sure you want to reject the Procurement Plan %1. Do you want to continue?', FALSE, Rec."No.")THEN ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
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
    var ProcurementPlan: Record "Procurement Plan Header";
    ProcurementList: Record "Procurement Plan Lines";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    ProcurementImp: XmlPort "Import Procurement Plan";
    Lines: Record "Procurement Plan Lines";
    PurchMg: Codeunit "Purchases Management";
    PageEditable: Boolean;
    trigger OnOpenPage()
    begin
        if Rec.status = Rec.status::Released then PageEditable:=false
        else
            PageEditable:=true;
    end;
    trigger OnAfterGetCurrRecord()
    begin
        CalculatePercentage();
        if Rec.status = Rec.status::Released then PageEditable:=false
        else
            PageEditable:=true;
    end;
    local procedure CalculatePercentage(): Decimal begin
        if Rec."AGPO Reservation" <> 0 then begin
            Rec."% of AGPO Reservation":=(Rec."AGPO Reservation" / Rec."Total Estimate") * 100;
        end;
    end;
}
