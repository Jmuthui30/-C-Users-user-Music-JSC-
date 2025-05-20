page 52032 "SS Appraisal Objectives Card"
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
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Caption = 'Employee No(Appraisee)';
                    Editable = false;
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
                SubPageLink = "Employee No"=FIELD("Employee No"), "Appraisal Period"=FIELD("Appraisal Period"), "Appraisal Type"=FIELD("Appraisal Type"), "Appraisal No"=FIELD("Objective No");
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("Appraisal Objective")
            {
                Caption = 'Appraisal Objective';

                action("Send Approval Request")
                {
                    ApplicationArea = All;
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;

                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Open);
                        Rec.TestField("Appraisal Type");
                        Rec.TestField("Appraisal Period");
                        AppraisalObjectivesLines.Reset;
                        AppraisalObjectivesLines.SetRange("Employee No", Rec."Employee No");
                        AppraisalObjectivesLines.SetRange("Appraisal No", Rec."Objective No");
                        AppraisalObjectivesLines.SetRange("Appraisal Period", Rec."Appraisal Period");
                        AppraisalObjectivesLines.SetRange("Appraisal Type", Rec."Appraisal Type");
                        AppraisalObjectivesLines.SetFilter("No.", '<>%1', ' ');
                        if not AppraisalObjectivesLines.FindSet then Error('You have not set any Appraisal Objective for %1', Rec."Appraisee Name")
                        else if AppraisalObjectivesLines.FindSet then repeat begin
                                    AppraisalObjectivesLines.TestField("Key Responsibility");
                                    AppraisalObjectivesLines.TestField("Key Indicators");
                                    AppraisalObjectivesLines.TestField(Weighting);
                                end;
                                until AppraisalObjectivesLines.Next = 0;
                        ApprovalsMgt.OnSendAppraisalObjectiveForApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    ApplicationArea = All;
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;

                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::"Pending Approval");
                        ApprovalsMgt.OnCancelAppraisalObjectiveApprovalRequest(Rec);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
    //OnAfterGetCurrRecord;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
    //OnAfterGetCurrRecord;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Appraisee ID", UserId);
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    AppraisalObjectivesLines: Record "Appraisal Objectives Lines";
/* local procedure OnAfterGetCurrRecord()
     begin
         xRec := Rec;
          if Status=Status::Released then
            CurrPage.Editable:=false
          else
            CurrPage.Editable:=true;
     end;*/
}
