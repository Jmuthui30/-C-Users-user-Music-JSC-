page 51516 "Bal Score Plan Review Period"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = "Bal Score Plan Review Period";
    Caption = 'Appraisal Planning Periods';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the start date copied from the linked appraisal period.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the end date copied from the linked appraisal period.';
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee appraisal period linked to this appraisal planning period.';
                }
                field(Active; Rec.Active)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Create Employee Appraisal Planning")
            {
                Promoted = true;
                // Legacy caption retained in action name for compatibility.
                // Caption = 'Create Appraisal Planning';
                Caption = 'Create Employee Appraisals';
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = CreateReminders;

                trigger OnAction()
                begin
                    BalScoreMgnt.CreateEmployeeAppraisalPlanning;
                end;
            }
            action("Suggest Review Dates")
            {
                ApplicationArea = All;
                Caption = 'Suggest Review Dates';
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                // Date suggestion belongs on Appraisal Review Periods, where the dates are reviewed and edited.
                ToolTip = 'Suggests start and end dates on appraisal review periods from this appraisal period. Due dates are not changed.';

                trigger OnAction()
                begin
                    BalScoreMgnt.SuggestReviewPeriodDates(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
    var BalScoreMgnt: Codeunit "Bal Score Card Mngt.";
}
