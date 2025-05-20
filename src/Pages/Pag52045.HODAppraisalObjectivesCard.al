page 52045 "HOD Appraisal Objectives Card"
{
    SourceTable = "Employee Appraisal Objectives";
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Objective No"; Rec."Objective No")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No(Appraisee)';
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                    ApplicationArea = All;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee Department';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Job ID';
                }
                field("Appraisee's Job Title"; Rec."Appraisee's Job Title")
                {
                    ApplicationArea = All;
                }
                field("Appraisee ID"; Rec."Appraisee ID")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee USER ID';
                }
                field("Job Group"; Rec."Job Group")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Job Group';
                }
                field("Appraiser No"; Rec."Appraiser No")
                {
                    ApplicationArea = All;
                }
                field("Appraisers Name"; Rec."Appraisers Name")
                {
                    ApplicationArea = All;
                }
                field("Appraiser's Job Title"; Rec."Appraiser's Job Title")
                {
                    ApplicationArea = All;
                }
                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    ApplicationArea = All;
                    Caption = 'Appraiser USER ID';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Control1; "Appraisal Objective Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Employee No"=FIELD("Employee No"), "Appraisal Period"=FIELD("Appraisal Period");
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("Appraisal Objective")
            {
                Caption = 'Appraisal Objective';

                action("Send Approval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                    //IF ApprovalMgt.SendApprObjApprovalRequest(Rec) THEN;
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Visible = false;

                    trigger OnAction()
                    begin
                    //IF ApprovalMgt.CancelApprObjApprovalRequest(Rec,TRUE,TRUE) THEN;
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = All;
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        Rec.TestField("HOD Created", true);
                        Rec.TestField("Appraisal Type");
                        Rec.TestField("Appraisal Period");
                        Rec.TestField("Appraiser ID");
                        AppraisalObjectivesLines.Reset;
                        AppraisalObjectivesLines.SetRange("Employee No", Rec."Employee No");
                        AppraisalObjectivesLines.SetFilter("No.", '<>%1', ' ');
                        if not AppraisalObjectivesLines.FindSet then Error('You have not set any Appraisal Objective for %1', Rec."Appraisee Name")
                        else if AppraisalObjectivesLines.FindSet then repeat begin
                                    AppraisalObjectivesLines.TestField("Key Responsibility");
                                    AppraisalObjectivesLines.TestField("Key Indicators");
                                    AppraisalObjectivesLines.TestField(Weighting);
                                end;
                                until AppraisalObjectivesLines.Next = 0;
                        Rec.Status:=Rec.Status::Released;
                        Rec.Modify(true);
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

                    trigger OnAction()
                    var
                        ReleaseAppraisal: Codeunit "Release Govt. Emp Objectives";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ReleaseAppraisal.PerformManualReopen(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
    //OnAfterGetCurrRecord;
    end;
    trigger OnInit()
    begin
        Rec."HOD Created":=true;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."HOD Created":=true;
    //OnAfterGetCurrRecord;
    end;
    trigger OnOpenPage()
    begin
    //SETRANGE("Appraisee ID",USERID);
    end;
    var ApprovalMgt: Codeunit "Approvals Mgmt.";
    AppraisalObjectivesLines: Record "Appraisal Objectives Lines";
/*local procedure OnAfterGetCurrRecord()
    begin
        xRec := Rec;
         if Status=Status::Released then
           CurrPage.Editable:=false
         else
           CurrPage.Editable:=true;
    end;*/
}
