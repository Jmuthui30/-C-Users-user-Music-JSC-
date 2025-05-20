page 52039 "Appraisal Page 2"
{
    SourceTable = "Employee Appraisals";
    PageType = Card;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Category"; Rec."Appraisal Category")
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
                    Caption = 'Appraisee''s No.';
                }
                field("Employee.""First Name"" + ' ' + Employee.""Middle Name"" + ' ' + Employee.""Last Name"""; Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Names';
                }
                field("EmpNav.Position"; EmpNav.Position)
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Establishment';
                }
                field("Employee.""Job Title"""; Employee."Job Title")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Job Title';
                }
                field("Jobs.Grade"; Jobs.Grade)
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Grade';
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Control6; "Appraiser and Appraisee Narrat")
            {
                ApplicationArea = All;
                SubPageLink = "Appraisal No"=FIELD("Appraisal No");
            }
            field("General Comments"; Rec."General Comments")
            {
                ApplicationArea = All;
            }
            field(Rating; Rec.Rating)
            {
                ApplicationArea = All;
                Caption = 'Overall Rating';
            }
            field("Agreement With Rating"; Rec."Agreement With Rating")
            {
                ApplicationArea = All;
                Caption = 'Appraisee Agreement With Rating';
            }
            field("Rating Description"; Rec."Rating Description")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(Control1;'')
            {
                ApplicationArea = All;
                CaptionClass = Text19016900;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("<<Back")
            {
                ApplicationArea = All;
                Caption = '<<Back';
                Image = PreviousRecord;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if EmployeeAppraisals.Get(Rec."Appraisal No")then PAGE.RunModal(52040, EmployeeAppraisals);
                end;
            }
            action(Preview)
            {
                ApplicationArea = All;
                Caption = 'Preview';
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    EmployeeAppraisals.Reset;
                    EmployeeAppraisals.SetRange(EmployeeAppraisals."Employee No", Rec."Employee No");
                    EmployeeAppraisals.SetRange(EmployeeAppraisals."Appraisal Period", Rec."Appraisal Period");
                    EmployeeAppraisals.SetRange(EmployeeAppraisals."Appraisal Type", Rec."Appraisal Type");
                    EmployeeAppraisals.SetRange(EmployeeAppraisals."Appraisal No", Rec."Appraisal No");
                    if EmployeeAppraisals.Find('-')then begin
                        if EmployeeAppraisals."Appraisal Category" = 'Annual' then REPORT.RunModal(51851, true, false, EmployeeAppraisals)
                        else if EmployeeAppraisals."Appraisal Category" = 'Mid Year' then REPORT.RunModal(51852, true, false, EmployeeAppraisals);
                    end;
                end;
            }
            group(Approvals)
            {
                Caption = 'Approvals';

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
                        Rec.TestField("Appraisal Type");
                        Rec.TestField("Appraisal Period");
                        Rec.TestField(Status, Rec.Status::Open);
                        ApprovalMgt.OnSendEmployeeAppraisalForApproval(Rec);
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
                        ApprovalMgt.OnCancelEmployeeAppraisalApprovalRequest(Rec);
                    end;
                }
                action(Approve)
                {
                    ApplicationArea = All;
                    Image = Approve;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField("Appraisal Type");
                        Rec.TestField("Appraisal Period");
                        Rec.TestField("HOD Created", true);
                        Rec.TestField("General Comments");
                        Rec.TestField(Rating);
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
                    ApplicationArea = All;
                    Image = ReOpen;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedIsBig = true;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Rec.TestField(Status, Rec.Status::Released);
                        Rec.Status:=Rec.Status::Open;
                        Rec.Modify(true);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Employee.Get(Rec."Employee No")then //IF Employee.Position<>'' THEN
            if EmpNav.Get(Rec."Employee No")then if Jobs.Get(EmpNav.Position)then;
    end;
    var EmployeeAppraisals: Record "Employee Appraisals";
    Employee: Record Employee;
    EmpNav: Record "Employee Master";
    Jobs: Record "Company Jobs";
    ApprovalMgt: Codeunit "Approvals Mgmt. Ext";
    Text19016900: Label 'Overall Rating';
    AppraisalObjectivesLines: Record "Appraisal Objectives Lines";
}
