page 51762 "Facilitator Evaluation"
{
    // version THL- HRM 1.0
    PageType = Card;
    SourceTable = "Training Evaluation";

    layout
    {
        area(content)
        {
            group("Course Details")
            {
                Editable = false;

                field("Course Title"; Rec."Course Title")
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
            }
            group("Facilitator Evaluation")
            {
                field("On a scale of 1-10 rate today's training facilitator. (This form should be anonymously filled).";'')
                {
                    ApplicationArea = All;
                    Caption = 'On a scale of 1-10 rate today''s training facilitator. (This form should be anonymously filled).';
                    Style = StandardAccent;
                    StyleExpr = TRUE;
                }
                field("Name of Facilitator"; Rec."Name of Facilitator")
                {
                    ApplicationArea = All;
                }
                field("Clear objectives"; Rec."Clear objectives")
                {
                    ApplicationArea = All;
                }
                field(Organization; Rec.Organization)
                {
                    ApplicationArea = All;
                }
                field(Ease; Rec.Ease)
                {
                    ApplicationArea = All;
                }
                field(Usefulness; Rec.Usefulness)
                {
                    ApplicationArea = All;
                }
                field("Meeting Objectives"; Rec."Meeting Objectives")
                {
                    ApplicationArea = All;
                }
                field("Addresses Non-compliance"; Rec."Addresses Non-compliance")
                {
                    ApplicationArea = All;
                }
                field("Participants Engagement"; Rec."Participants Engagement")
                {
                    ApplicationArea = All;
                }
                field("Pratical Examples"; Rec."Pratical Examples")
                {
                    ApplicationArea = All;
                }
                field("Pro-social behaviour"; Rec."Pro-social behaviour")
                {
                    ApplicationArea = All;
                }
                field("Constructive Feedback"; Rec."Constructive Feedback")
                {
                    ApplicationArea = All;
                }
                field("Use of materials"; Rec."Use of materials")
                {
                    ApplicationArea = All;
                }
                field(Competency; Rec.Competency)
                {
                    ApplicationArea = All;
                }
                field("Communication Skills"; Rec."Communication Skills")
                {
                    ApplicationArea = All;
                }
                field("General Observations"; Rec."General Observations")
                {
                    ApplicationArea = All;
                }
                field("Areas of Improvement"; Rec."Areas of Improvement")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Print)
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51611, true, false, Rec);
                end;
            }
        }
    }
}
