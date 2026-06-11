page 52591 "Appraisal Outcome Card"
{
    ApplicationArea = All;
    Caption = 'Appraisal Outcome';
    PageType = Card;
    SourceTable = "Appraisal Outcome";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Outcome No."; Rec."Outcome No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Outcome Type"; Rec."Outcome Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Department Code"; Rec."Department Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    Caption = 'Review Period';
                    Editable = false;
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group(LetterContent)
            {
                Caption = 'Content';

                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field("Letter Body"; Rec."Letter Body")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Print Letter")
            {
                ApplicationArea = All;
                Caption = 'Print Letter';
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    PrintCurrentOutcome();
                end;
            }
            action("Email Letter")
            {
                ApplicationArea = All;
                Caption = 'Email Letter';
                Image = SendEmailPDF;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Emails the appraisal outcome letter to the employee and marks it as issued after successful sending.';

                trigger OnAction()
                var
                    OutcomeMgt: Codeunit "Appraisal Outcome Mgt.";
                begin
                    OutcomeMgt.EmailOutcomeLetter(Rec);
                    CurrPage.Update(false);
                    Message('The appraisal outcome letter has been emailed to %1.', Rec."Employee Name");
                end;
            }
            action("Mark Issued")
            {
                ApplicationArea = All;
                Caption = 'Mark Issued';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    Rec.MarkIssued();
                end;
            }
        }
    }

    local procedure PrintCurrentOutcome()
    var
        Outcome: Record "Appraisal Outcome";
    begin
        Outcome.SetRange("Appraisal No.", Rec."Appraisal No.");
        Outcome.SetRange("Outcome Type", Rec."Outcome Type");
        Outcome.SetRange("Line No.", Rec."Line No.");
        Report.RunModal(Report::"Appraisal Outcome Letter", true, false, Outcome);
    end;
}
