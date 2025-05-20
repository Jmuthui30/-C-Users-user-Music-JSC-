page 51516 "Bal Score Plan Review Period"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bal Score Plan Review Period";

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
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
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
                Caption = 'Create Appraisal Planning';
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                Image = CreateReminders;

                trigger OnAction()
                begin
                    BalScoreMgnt.CreateEmployeeAppraisalPlanning;
                end;
            }
        }
    }
    var BalScoreMgnt: Codeunit "Bal Score Card Mngt.";
}
