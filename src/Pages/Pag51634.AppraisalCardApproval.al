page 51634 "Appraisal Card - Approval"
{
    // version THL- HRM 1.0
    Caption = 'Appraisal Form Pending Approval';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Performance Appraisal";
    SourceTableView = WHERE(Status=CONST("Pending Approval"));

    layout
    {
        area(content)
        {
            group("Appraisee Details")
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(Manager; Rec.Manager)
                {
                    ApplicationArea = All;
                }
                field("Manager's Name"; Rec."Manager's Name")
                {
                    ApplicationArea = All;
                }
            }
            group("Appraisal Details")
            {
                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control18; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Review Responses")
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Text000, false) = true then PerformanceMgt.ReviewAppraiseeResponses(Rec)
                    else
                        Message(Text001);
                end;
            }
            action("Appraisal Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Commit;
                    Appraisal.Reset;
                    Appraisal.SetRange(Appraisal."Employee No", Rec."Employee No");
                    Appraisal.SetRange(Appraisal."Review Start Date", Rec."Review Start Date");
                    Appraisal.SetRange(Appraisal."Review End Date", Rec."Review End Date");
                    REPORT.Run(51616, true, false, Appraisal);
                end;
            }
            action("Section A: Quantitative Deliverables")
            {
                ApplicationArea = All;
                Caption = 'Section A: Quantitative Deliverables';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Quanitative Deliverables Respo";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section B: Qualitative Deliverables")
            {
                ApplicationArea = All;
                Caption = 'Section B: Qualitative Deliverables';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Qualitative Deliverables Other";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section C: Adherence to Company Culture")
            {
                ApplicationArea = All;
                Caption = 'Section C: Adherence to Company Culture';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Section C Responses";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section D: Personal development (E-Learning)")
            {
                ApplicationArea = All;
                Caption = 'Section D: Personal development (E-Learning)';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Section D Responses";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section E: Other Essential Information")
            {
                ApplicationArea = All;
                Caption = 'Section E: Other Essential Information';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Section E Responses";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
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
                    Visible = OpenApprovalEntriesExistForCurrUser;

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
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Document No."=FIELD("No. Series");
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
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    var PerformanceMgt: Codeunit "Performance Management";
    Text000: Label 'You are about to review the responses to the appraisal questions. Kindly note that you cannot abort this process once you start. Do you wish to continue?';
    Text001: Label 'Aborted Successfully';
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    ShowWorkflowStatus: Boolean;
    CanCancelApprovalForRecord: Boolean;
    DocumentIsPosted: Boolean;
    ApprovalsMgt: Codeunit "Approvals Mgmt.";
    Appraisal: Record "Appraisal Questions Entries";
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}
