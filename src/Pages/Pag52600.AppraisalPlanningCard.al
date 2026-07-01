page 52600 "Appraisal Planning Card"
{
    ApplicationArea = All;
    Caption = 'Appraisal Planning Card';
    PageType = Card;
    PromotedActionCategories = 'New,Process,Report,Review';
    SourceTable = "Appraisal Planning Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the appraisal planning number.';
                }
                field("Planning Status"; Rec."Planning Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the planning status.';
                }
                field("Actual Appraisal No."; Rec."Actual Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the actual appraisal created from this plan.';
                }
            }
            group("Period Under Planning")
            {
                Caption = 'Period Under Planning';
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    ToolTip = 'Specifies the appraisal period for the plan.';
                }
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal period start date.';
                }
                field("Period End"; Rec."Period End")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal period end date.';
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee No.';
                    Editable = PlanEditable;
                    ToolTip = 'Specifies the employee whose appraisal objectives are being planned.';
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee Name';
                    ToolTip = 'Specifies the appraisee name.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee job title.';
                }
                field("Job Group"; Rec."Job Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee job group.';
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee responsibility center.';
                }
                field("Directorate Code"; Rec."Directorate Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee directorate code.';
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee directorate name.';
                }
            }
            group(Appraiser)
            {
                Caption = 'Appraiser';
                field("Appraiser No."; Rec."Appraiser No.")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    ToolTip = 'Specifies the appraiser.';
                }
                field("Appraiser Name"; Rec."Appraiser Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser name.';
                }
            }
            part(Objectives; "Appraisal Planning Lines")
            {
                ApplicationArea = All;
                Caption = 'Objective Planning Lines';
                SubPageLink = "Plan No." = field("No.");
            }
            group("Personal Development")
            {
                Caption = 'Personal Development';
                field("Personal Dev. Objectives"; Rec."Personal Dev. Objectives")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    MultiLine = true;
                    ToolTip = 'Specifies personal development objectives agreed during planning.';
                }
                field("Additional Responsibilities"; Rec."Additional Responsibilities")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    MultiLine = true;
                    ToolTip = 'Specifies additional responsibilities agreed during planning.';
                }
                field("Knowledge Innovation"; Rec."Knowledge Innovation")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    MultiLine = true;
                    ToolTip = 'Specifies planned knowledge and innovation contribution.';
                }
            }
            group("Core Values")
            {
                Caption = 'Core Values';
                field("Core Values Maintained"; Rec."Core Values Maintained")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    MultiLine = true;
                    ToolTip = 'Specifies core values to maintain.';
                }
                field("Core Values Maintenance"; Rec."Core Values Maintenance")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    MultiLine = true;
                    ToolTip = 'Specifies actions to maintain core values.';
                }
                field("Core Values To Develop"; Rec."Core Values To Develop")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    MultiLine = true;
                    ToolTip = 'Specifies core values to develop.';
                }
                field("Core Values Development"; Rec."Core Values Development")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    MultiLine = true;
                    ToolTip = 'Specifies actions to develop core values.';
                }
            }
            group("Review and Agreement")
            {
                Caption = 'Review and Agreement';
                field("Employee Agreed"; Rec."Employee Agreed")
                {
                    ApplicationArea = All;
                    Editable = PlanEditable;
                    ToolTip = 'Specifies whether the appraisee has agreed to the planned objectives.';
                }
                field("Appraiser Agreed"; Rec."Appraiser Agreed")
                {
                    ApplicationArea = All;
                    Editable = AppraiserAgreementEditable;
                    ToolTip = 'Specifies whether the appraiser has agreed to the planned objectives.';
                }
                field("Review Round"; Rec."Review Round")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of review submissions.';
                }
                field("Last Review Reason"; Rec."Last Review Reason")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last return reason.';
                }
                field("Submitted At"; Rec."Submitted At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the plan was submitted.';
                }
                field("Objectives Agreed At"; Rec."Objectives Agreed At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the appraiser accepted the objectives.';
                }
                field("HR Approved At"; Rec."HR Approved At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when HR created the actual appraisal.';
                }
            }
            part(ReviewHistory; "Appr. Planning Review Hist.")
            {
                ApplicationArea = All;
                Caption = 'Review History';
                SubPageLink = "Plan No." = field("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(PrintPlanningReport)
            {
                ApplicationArea = All;
                Caption = 'Print Appraisal Planning Report';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Prints the appraisal planning report.';

                trigger OnAction()
                begin
                    Report.RunModal(Report::"Appraisal Planning Report", true, false, Rec);
                end;
            }
            action(SendForAppraiserReview)
            {
                ApplicationArea = All;
                Caption = 'Send for Appraiser Review';
                Enabled = PlanEditable;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Sends the appraisal planning document to the appraiser for review.';

                trigger OnAction()
                begin
                    AppraisalPlanningMgt.SubmitPlan(Rec."No.", '');
                    CurrPage.Update(false);
                end;
            }
            action(ReturnForChanges)
            {
                ApplicationArea = All;
                Caption = 'Return for Changes';
                Enabled = ReturnEnabled;
                Image = Return;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Returns the appraisal planning document for changes.';

                trigger OnAction()
                var
                    ReturnReason: Record "Appraisal Planning Review" temporary;
                begin
                    ReturnReason.Init();
                    if Page.RunModal(Page::"Appr. Planning Return Reason", ReturnReason) = Action::OK then begin
                        AppraisalPlanningMgt.ReturnPlan(Rec."No.", '', ReturnReason.Comment);
                        CurrPage.Update(false);
                    end;
                end;
            }
            action(AcceptForHRApproval)
            {
                ApplicationArea = All;
                Caption = 'Accept and Send to HR';
                Enabled = AcceptEnabled;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Accepts the planned objectives and sends the document for HR approval.';

                trigger OnAction()
                begin
                    AppraisalPlanningMgt.AcceptPlanForHrApproval(Rec."No.", '');
                    CurrPage.Update(false);
                end;
            }
            action(CreateActualAppraisal)
            {
                ApplicationArea = All;
                Caption = 'Create Actual Appraisal';
                Enabled = CreateAppraisalEnabled;
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Creates the actual Employee Appraisal card from the approved planning document.';

                trigger OnAction()
                var
                    EmployeeAppraisal: Record "Employee Appraisal";
                    AppraisalNo: Code[20];
                begin
                    AppraisalNo := AppraisalPlanningMgt.CreateAppraisalFromApprovedPlan(Rec."No.", '');
                    CurrPage.Update(false);
                    if EmployeeAppraisal.Get(AppraisalNo) then
                        Page.Run(Page::"Appraisal Card-Review", EmployeeAppraisal);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    begin
        SetControlAppearance();
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance();
    end;

    var
        AppraisalPlanningMgt: Codeunit "Appraisal Planning Mgt.";
        AcceptEnabled: Boolean;
        AppraiserAgreementEditable: Boolean;
        CreateAppraisalEnabled: Boolean;
        PlanEditable: Boolean;
        ReturnEnabled: Boolean;

    local procedure SetControlAppearance()
    begin
        PlanEditable :=
            (Rec."Planning Status" = Rec."Planning Status"::Draft) or
            (Rec."Planning Status" = Rec."Planning Status"::"Returned for Changes");
        AppraiserAgreementEditable := Rec."Planning Status" = Rec."Planning Status"::"Pending Appraiser Review";
        ReturnEnabled :=
            (Rec."Planning Status" = Rec."Planning Status"::"Pending Appraiser Review") or
            (Rec."Planning Status" = Rec."Planning Status"::"Pending HR Approval");
        AcceptEnabled := Rec."Planning Status" = Rec."Planning Status"::"Pending Appraiser Review";
        CreateAppraisalEnabled := Rec."Planning Status" = Rec."Planning Status"::"Pending HR Approval";
    end;
}
