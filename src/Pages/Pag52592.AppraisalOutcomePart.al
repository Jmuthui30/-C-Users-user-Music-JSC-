page 52592 "Appraisal Outcome Part"
{
    ApplicationArea = All;
    Caption = 'Appraisal Outcomes';
    CardPageId = "Appraisal Outcome Card";
    PageType = ListPart;
    SourceTable = "Appraisal Outcome";

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
                field("Outcome Type"; Rec."Outcome Type")
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
                field("Issued By"; Rec."Issued By")
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
