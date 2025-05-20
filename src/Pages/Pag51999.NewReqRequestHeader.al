page 51999 "New Req. Request Header"
{
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE(Status=CONST(Open));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Requested By"; Rec."Requested By")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Approved; Rec.Approved)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Date Approved"; Rec."Date Approved")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(Details)
            {
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                // trigger OnValidate()
                // var
                //     CompanyJobs: Record "Company Jobs";
                // begin
                //     GetRecord(CompanyJobs);
                //     if CompanyJobs.Status <> CompanyJobs.Status::Released
                //     then
                //         Error('Kindly note you can only request for approved establishments');
                // end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Objective; Rec.Objective)
                {
                    ApplicationArea = All;
                }
                field(Profession; Rec.Profession)
                {
                    ApplicationArea = All;
                }
                field(Priority; Rec.Priority)
                {
                    ApplicationArea = All;
                }
                field(Positions; Rec.Positions)
                {
                    ApplicationArea = All;
                    TableRelation = "Company Jobs"."Vacant Posistions";
                    //TableRelation = "Recruitment Needs".Positions;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = All;
                }
                field("No Filter"; Rec."No Filter")
                {
                    ApplicationArea = All;
                }
                field("Show Salary"; Rec."Show Salary")
                {
                    ApplicationArea = All;
                }
                field("Tems of Service"; Rec."Tems of Service")
                {
                    ApplicationArea = All;
                }
                field("Area Of Deployment"; Rec."Area Of Deployment")
                {
                    ApplicationArea = All;
                }
                field("Vacancy Announcement"; Rec."Vacancy Announcement")
                {
                    ApplicationArea = All;
                }
                field("Job Purpose"; Rec."Job Purpose")
                {
                    ApplicationArea = All;
                }
                field("Min. Years of Experience"; Rec."Min. Years of Experience")
                {
                    ApplicationArea = all;
                }
                field("Sample Writings"; Rec."Sample Writings")
                {
                    ApplicationArea = All;
                }
                group("Salary Details")
                {
                    Visible = Rec."Show Salary" = true;
                    Enabled = Rec."Show Salary" = true;

                    field("Minimum Salary"; Rec."Minimum Salary")
                    {
                        ApplicationArea = All;
                    }
                    field("Maximum Salary"; Rec."Maximum Salary")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(Dates)
            {
                field("Expected Reporting Date"; Rec."Expected Reporting Date")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
            }
            group(Administration)
            {
                field("Appointment Type"; Rec."Appointment Type")
                {
                    ApplicationArea = All;
                    NotBlank = true;
                    ShowMandatory = true;
                }
                field("Turn Around Time"; Rec."Turn Around Time")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Reason for Recruitment"; Rec."Reason for Recruitment")
                {
                    ApplicationArea = All;
                }
                field("Documentation Link"; Rec."Documentation Link")
                {
                    ApplicationArea = All;
                }
            }
        /*     field("Show Salary"; Rec."Show Salary")
                {
                    ApplicationArea = All;
                }
                group("Salary Details")
                {
                    Visible = Rec."Show Salary" = true;
                    Enabled = Rec."Show Salary" = true;

                    field("Minimum Salary"; Rec."Minimum Salary")
                    {
                        ApplicationArea = All;
                    }
                    field("Maximum Salary"; Rec."Maximum Salary")
                    {
                        ApplicationArea = All;
                    }
                } */
        }
    }
    actions
    {
        // area(creation)
        // {
        //     action(Approve)
        //     {
        //         ApplicationArea = All;
        //         Image = Approve;
        //         Promoted = true;
        //         PromotedCategory = Process;
        //         PromotedIsBig = true;
        //         trigger OnAction()
        //         begin
        //             Rec.Status := Rec.Status::Released;
        //             Rec.TestField(Positions);
        //             Rec.Approved := true;
        //             Rec.Validate(Approved);
        //             Rec.Modify;
        //         end;
        //     }
        // }
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
                    Enabled = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    Image = SendApprovalRequest;
                    Promoted = true;
                    // PromotedCategory = Category6;
                    PromotedIsBig = true;
                    // PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        PlanLines.TestField(PlanLines."Required Positions", PlanLines."Required Positions");
                        ApprovalsMgmtExt.OnSendRecruitmentNeedForApproval(Rec);
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
                    //PromotedCategory = Category7;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';
                    AboutTitle = 'Cancel Approval Request';
                    AboutText = 'Incase of Corrections recall the document by clicking **Cancel Approval Request**';

                    trigger OnAction();
                    begin
                        ApprovalsMgmtExt.OnCancelRecruitmentNeedApprovalRequest(Rec);
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
                    //PromotedCategory = Category4;
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
                    //PromotedCategory = Category4;
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
                    //PromotedCategory = Category4;
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
                    // PromotedCategory = Category4;
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
                    //PromotedCategory = Category7;
                    ToolTip = 'View a list of the records that are waiting to be approved. For example, you can see who requested the record to be approved, when it was sent, and when it is due to be approved.';

                    trigger OnAction()
                    var
                        //WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.OpenApprovalEntriesPage(Rec.RecordId);
                    //VOKOTHWorkflowsEntriesBuffer.RunWorkflowEntriesPage(Rec.RecordId, DATABASE::"Recruitment Plan", 0, Rec."No.");
                    end;
                }
            }
        }
    }
    trigger OnInit()
    begin
        isAdmin:=false;
    end;
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
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
        IsOfficeAddin:=OfficeMgt.IsAvailable;
        if Usersetup.Get(UserId)then begin
            isAdmin:=Usersetup."HR Admin" end;
    end;
    var isAdmin: Boolean;
    Usersetup: Record "User Setup";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    OfficeMgt: Codeunit "Office Management";
    IsOfficeAddin: Boolean;
    ApprovalsMgmtExt: Codeunit "Approvals Mgmt. Ext";
    PlanLines: Record "Recruitment Plan Lines";
}
