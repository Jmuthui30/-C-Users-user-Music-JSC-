page 51759 "Training Evaluation Header"
{
    // version THL- HRM 1.0
    Caption = 'Training Evaluation Card';
    PageType = Card;
    SourceTable = "Training Evaluation";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'Training Evaluation No.';
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                    Caption = 'Personal No.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Name of participant';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Training Request No."; Rec."Training Request No.")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the approved training request being evaluated.';
                }
                field("Training Need"; Rec."Training Need")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the training need linked to the approved request.';
                }
                field("Training No."; Rec."Training No.")
                {
                    ApplicationArea = All;
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = All;
                    Caption = 'Training Name';
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Organizers; Rec.Organizers)
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
                field("Supervisor Comments"; Rec."Supervisor Comments")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Specifies supervisor comments on the staff skills gained and report.';
                }
                field("Supervisor Evaluated"; Rec."Supervisor Evaluated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the supervisor has evaluated the training outcome.';
                }
            }
            group("How relevant was the course content to your role?")
            {
                field("Course Title Evaluation Description"; Rec."Course Title Evaluation")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("What new knowledge or skills did you gain from the training?")
            {
                field("Knowledge Evaluation Description"; Rec."Knowledge Evaluation")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("Were your expectations for the training met?")
            {
                field("Were Expectations Met Description"; Rec."Were Expectations Met")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("How will this training improve your work performance?")
            {
                field("Training Impact Description"; Rec."Training Impact")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("Which weak areas will you improve, and how?")
            {
                field("Improve Weak Areas Description"; Rec."Improve Weak Areas")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("Were the training methods and facilitation effective?")
            {
                field("Training Techniques Satisfied Description"; Rec."Training Techniques Satisfied")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("Were you satisfied with the meals and refreshments?")
            {
                field("Food Served Satisfied Description"; Rec."Food Served Satisfied")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("What recommendations do you have for future trainings?")
            {
                field("Recommendations Description"; Rec.Recommendations)
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("If any answer was No or Unsatisfactory, please explain.")
            {
                field("No Answer Explanation Description"; Rec."No Answer Explanation")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("What personal action plans will you implement after this training?")
            {
                field("Personal Action Plans Description"; Rec."Personal Action Plans")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("What barriers may affect your action plans, and how will you address them?")
            {
                field("Action Plan Barriers Description"; Rec."Action Plan Barriers")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("How will you overcome assignment or workload challenges?")
            {
                field("How To Overcome Assignments Description"; Rec."How To Overcome Assignments")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
            group("What resources do you need to implement your action plans?")
            {
                field("Resource Requirements Description"; Rec."Resource Requirements")
                {
                    ApplicationArea = All;
                    Caption = 'Response';
                    MultiLine = true;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Notes)
            {
                ApplicationArea = All;
            }
            part(Attachments; "Doc. Attachment List Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = const(Database::"Training Evaluation"), "No." = field("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            // The employee post-training evaluation is now captured directly on this card.
            // action("Post-Training Evaluation")
            // {
            //     ApplicationArea = All;
            //     Image = Certificate;
            //     Promoted = true;
            //     PromotedIsBig = true;
            //     RunObject = Page "Post-Training Evaluation";
            //     RunPageLink = "No." = FIELD("No.");
            //     RunPageOnRec = true;
            // }
            group(Evaluation)
            {
                Caption = 'Evaluation';
                Image = Certificate;

                action("Facilitator Evaluation")
                {
                    ApplicationArea = All;
                    Caption = 'Evaluate Facilitator';
                    Image = Certificate;
                    Promoted = true;
                    PromotedIsBig = true;
                    RunObject = Page "Facilitator Evaluation";
                    RunPageLink = "No." = FIELD("No.");
                    RunPageOnRec = true;
                }
            }
            group(Reports)
            {
                Caption = 'Reports';
                Image = "Report";

                action("Training Evaluation Report")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        RunCurrentEvaluationReport(Report::"Post-Training Evaluation Form");
                    end;
                }
                action("Training Feedback Summary")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        RunCurrentEvaluationReport(Report::"Training Feedback Summary");
                    end;
                }
                action("Facilitator Evaluation Report")
                {
                    ApplicationArea = All;
                    Image = "Report";
                    Promoted = true;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        RunCurrentEvaluationReport(Report::"Facilitator Evaluation");
                    end;
                }
            }
        }
    }

    local procedure RunCurrentEvaluationReport(ReportId: Integer)
    var
        TrainingEvaluation: Record "Training Evaluation";
    begin
        TrainingEvaluation := Rec;
        TrainingEvaluation.SetRecFilter();
        Report.Run(ReportId, true, false, TrainingEvaluation);
    end;
}
