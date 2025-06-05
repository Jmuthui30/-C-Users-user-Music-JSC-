page 51954 "Company Jobs"
{
    Caption = 'Establishment';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Functions,Job';
    SourceTable = "Company Jobs";
    // Editable = true;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = Rec.Status = Rec.Status::Open;
                Caption = 'General';

                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = all;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Memo Ref No."; Rec."Memo Ref No.")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                }
                field("Description Programme Code"; "Description Programme Code")
                {
                    ApplicationArea = all;
                }
                field("Job Grade"; rec.Grade)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Deployment Center"; Rec."Deployment Center")
                {
                    ApplicationArea = all;
                }
                field("Deployment Center Name"; Rec."Deployment Center Name")
                {
                    ApplicationArea = all;
                }
                field("No of Posts"; Rec."No of Posts")
                {
                    ApplicationArea = all;
                    BlankZero = true;
                    ShowMandatory = true;
                }
                field("Occupied Positions"; Rec."Occupied Position")
                {
                    ApplicationArea = all;
                    Caption = 'Occupied Positions';
                }
                field("Vacant Posistions"; Rec."Vacant Posistions")
                {
                    ApplicationArea = All;
                }
                field("Male Ocupants"; Rec."Male Ocupants")
                {
                    ApplicationArea = all;
                }
                field("Female Ocupants"; Rec."Female Ocupants")
                {
                    ApplicationArea = all;
                }
                field("Reporting Postion"; Rec."Reporting Postion")
                {
                    ApplicationArea = all;
                }
                field("Reporting Postion Name"; Rec."Reporting Postion Name")
                {
                    ApplicationArea = all;
                }
                field("Reason for Job creation"; rec."Reason for Job creations")
                {
                    ApplicationArea = all;
                }
                field(Profession; Rec.Profession)
                {
                    ApplicationArea = all;
                    ShowMandatory = true;
                }
                field("Vacancy Announcement"; Rec."Vacancy Announcement")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Job Purpose"; Rec."Job Purpose")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Objective"; Rec."Objective")
                {
                    ApplicationArea = all;
                    MultiLine = true;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Min. Years of Experience"; Rec."Min. Years of Experience")
                {
                    Caption = 'Min. yrs of experience';
                    ApplicationArea = all;
                }
                field("Sample Writing"; Rec."Sample Writings")
                {
                    ToolTip = 'Does this Establishment require Sample Writings?';
                    ApplicationArea = All;
                    Caption = 'Sample Writing';
                }
                field("Minimum Sample Writings"; "Minimum Sample Writings")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                    Importance = Additional;
                }
            }
            part(Academics; "Job Academic Qualifications")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part(ProfessionalCertificates; "Job Professional Certs")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part("Relevant Experience"; "Job Work Experience")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part(ProfessionalBodies; "Job Professional Bodies")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part("Core Compitencies"; "Job Compitencies")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part(Responsibility; "&Job Responsibilities")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part("Terms & Conditions"; "Job Terms & Conditions")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part("Job Attachments"; "Job Attachments")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job Id" = field("Job ID");
                ApplicationArea = All;
            }
            part("Titles of Sample Writings"; "Titles of Sample Writings")
            {
                Editable = Rec.Status = Rec.Status::Open;
                SubPageLink = "Job ID" = field("Job ID");
                ApplicationArea = All;
            }

            //Titles of Sample Writings (50028, ListPart)
        }
        area(factboxes)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                Editable = Rec.Status = Rec.Status::Open;
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(Database::"Company Jobs"), "No." = FIELD("Job ID");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("&Academics")
            {
                ApplicationArea = All;
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Academic Qualifications";
                RunPageLink = "Job Id" = field("Job ID");
            }
            action("&Professional Certificates")
            {
                ApplicationArea = All;
                Image = JobListSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Professional Certs";
                RunPageLink = "Job Id" = field("Job ID"), "Qualification Type" = const(Professional);
            }
            action("&Experience")
            {
                ApplicationArea = All;
                Image = WorkCenter;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Work Experience";
                RunPageLink = "Job Id" = field("Job ID");
            }
            action("&Professional Bodies")
            {
                ApplicationArea = All;
                Image = BOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Professional Bodies";
                RunPageLink = "Job Id" = field("Job ID");
            }
            action("&Competencies")
            {
                ApplicationArea = All;
                Image = CompleteLine;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Compitencies";
                RunPageLink = "Job Id" = field("Job ID");
            }
            action("&Responsibilities")
            {
                ApplicationArea = All;
                Image = Responsibility;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "&Job Responsibilities";
                RunPageLink = "Job Id" = field("Job ID");
            }
            action("&Terms & Conditions")
            {
                ApplicationArea = All;
                Image = ReminderTerms;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Terms & Conditions";
                RunPageLink = "Job Id" = field("Job ID");
            }
            action("&Job Attachments")
            {
                ApplicationArea = All;
                Image = Attachments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Job Attachments";
                RunPageLink = "Job Id" = field("Job ID");
            }
            action("&Titles of Sample Writings")
            {
                ApplicationArea = All;
                Image = Account;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "Sample Writings Setup";
                RunPageLink = "Job Id" = field("Job ID");
            }


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
                    PromotedCategory = New;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        ApprovalsMgmtExt.OnSendCompanyEstablishmentForApproval(Rec);
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
                    PromotedCategory = New;
                    PromotedOnly = true;
                    ToolTip = 'Cancel the approval request.';
                    AboutTitle = 'Cancel Approval Request';
                    AboutText = 'Incase of Corrections recall the document by clicking **Cancel Approval Request**';

                    trigger OnAction();
                    begin
                        ApprovalsMgmtExt.OnCancelCompanyEstablishmentApprovalRequest(Rec);
                        CurrPage.Close();
                    end;
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
                        PromotedCategory = New;
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
            action(Attachments)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

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
    }
    // trigger OnInit()
    // begin
    //     isAdmin := false;
    // end;
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
        if Usersetup.Get(UserId) then begin
            isAdmin := Usersetup."HR Admin"
        end;
    end;

    var
        isAdmin: Boolean;
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
