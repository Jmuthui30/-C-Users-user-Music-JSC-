page 52590 "Appraisal Outcome List"
{
    ApplicationArea = All;
    Caption = 'Appraisal Outcomes';
    CardPageId = "Appraisal Outcome Card";
    PageType = List;
    SourceTable = "Appraisal Outcome";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Outcome No."; Rec."Outcome No.")
                {
                    ApplicationArea = All;
                }
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                }
                field("Outcome Type"; Rec."Outcome Type")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                }
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
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
            action("Email Letter")
            {
                ApplicationArea = All;
                Caption = 'Email Letter';
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Emails the selected appraisal outcome letter to the employee.';

                trigger OnAction()
                var
                    OutcomeMgt: Codeunit "Appraisal Outcome Mgt.";
                begin
                    OutcomeMgt.EmailOutcomeLetter(Rec);
                    CurrPage.Update(false);
                    Message('The appraisal outcome letter has been emailed to %1.', Rec."Employee Name");
                end;
            }
        }
    }
}
