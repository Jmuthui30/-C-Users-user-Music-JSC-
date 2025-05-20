page 51612 "Leave Application-Approval"
{
    // version THL- HRM 1.0
    Caption = 'Leave Application Pending Approval';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Employee Leave Application";
    SourceTableView = where(Status=const("Pending Approval"));
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';

    layout
    {
        area(content)
        {
            group(Application)
            {
                Caption = 'Application';

                field("Application No"; Rec."Application No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = true;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Code"; Rec."Leave Code")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Type';
                    NotBlank = true;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approver Email"; Rec."Approver Email")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requestor Email"; Rec."Requestor Email")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(PowerApps; Rec.PowerApps)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
            group(Balances)
            {
                Caption = 'Balances';

                field("Leave Entitlment"; Rec."Leave Entitlment")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Balance brought forward"; Rec."Balance brought forward")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Earned to Date"; Rec."Leave Earned to Date")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Earned to Date';
                    Editable = false;
                }
                field("Total Leave Days Taken"; Rec."Total Leave Days Taken")
                {
                    ApplicationArea = All;
                    Caption = 'No of Days Taken To Date';
                    Editable = false;
                }
                field("Recalled Days"; Rec."Recalled Days")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Days Absent"; Rec."Days Absent")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Off Days"; Rec."Off Days")
                {
                    ApplicationArea = All;
                    Caption = 'Off Days';
                    Editable = false;
                }
                field("Leave balance"; Rec."Leave balance")
                {
                    ApplicationArea = All;
                    Caption = 'Available Leave Balance';
                    Editable = false;
                }
            }
            group("Current Application Details")
            {
                Caption = 'Current Application Details';

                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date of Application';
                    Editable = false;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        if(Rec."Leave Code" <> 'SICK') and (Rec."Days Applied" > Rec."Leave balance")then Error('The days applied for are more than your leave balance');
                    end;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Resumption Date"; Rec."Resumption Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    NotBlank = true;
                }
                field("Annual Leave Entitlement Bal"; Rec."Annual Leave Entitlement Bal")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Balance';
                    Editable = false;
                }
                field("Duties Taken Over By"; Rec."Duties Taken Over By")
                {
                    ApplicationArea = All;
                }
                field("Reliever Name"; Rec."Reliever Name")
                {
                    ApplicationArea = All;
                }
                field("No. of Approvals"; Rec."No. of Approvals")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Pending Approver"; Rec."Pending Approver")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Leave Allowance Payable"; Rec."Leave Allowance Payable")
                {
                    ApplicationArea = All;
                }
                field("Leave Allowance Paid"; Rec."Leave Allowance Paid")
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Caption = 'Address During Leave';
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                PromotedOnly = true;

                // RunObject = Page "Leave Apps Documents";
                // RunPageLink = "Document No." = FIELD("Application No"),
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
            action("View SharePoint Documents")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."SharePoint Link" = '' then Error('There is no link to documents uploaded in SharePoint. Please contact the SharePoint Administrator.')
                    else
                        HyperLink(Rec."SharePoint Link");
                end;
            }
            action("Leave Application Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("Application No", Rec."Application No");
                    REPORT.Run(51600, true, false, Rec);
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
                    ToolTip = 'Approve the requested changes.';
                    //Visible = OpenApprovalEntriesExistForCurrUser;
                    Visible = OpenApprovalEntriesExist;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                        CurrPage.Update(true);
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
                    // Visible = OpenApprovalEntriesExistForCurrUser;
                    Visible = OpenApprovalEntriesExist;

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
                    //Visible = OpenApprovalEntriesExistForCurrUser;
                    Visible = OpenApprovalEntriesExist;

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
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Document No."=FIELD("No. series");
                    //Visible = OpenApprovalEntriesExistForCurrUser;
                    Visible = OpenApprovalEntriesExist;

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
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    var OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    ShowWorkflowStatus: Boolean;
    CanCancelApprovalForRecord: Boolean;
    DocumentIsPosted: Boolean;
    ApprovalsMgt: Codeunit "Approvals Mgmt.";
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}
