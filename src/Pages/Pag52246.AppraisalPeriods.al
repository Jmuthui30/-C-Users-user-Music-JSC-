page 52246 "Appraisal Periods"
{
    ApplicationArea = All;
    PageType = List;
    SourceTable = "Appraisal Periods";
    Caption = 'Appraisal Periods';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Rec.Period)
                {
                    ToolTip = 'Specifies the value of the Period field';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ToolTip = 'Specifies the value of the Start Date field';
                }
                field("End Date"; Rec."End Date")
                {
                    ToolTip = 'Specifies the value of the End Date field';
                }
                field("Submission Due Date"; Rec."Submission Due Date")
                {
                    ToolTip = 'Specifies the value of the Submission Due Date field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                }
                field("Appraisal Type"; Rec."Appraisal Type")
                {
                    Visible = false;
                    // Legacy mid-year/final-year selector hidden; review stages are now controlled by Appraisal Review Periods.
                    ToolTip = 'Specifies the value of the Appraisal Type field';
                }
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Generate Employee Appraisals")
            {
                ApplicationArea = All;
                Caption = 'Generate Employee Appraisals';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Creates or updates employee appraisal cards for the selected appraisal period.';

                trigger OnAction()
                var
                    BalScoreCardMgt: Codeunit "Bal Score Card Mngt.";
                begin
                    BalScoreCardMgt.CreateEmployeeAppraisalsForAppraisalPeriod(Rec.Period);
                end;
            }
        }
    }
}





