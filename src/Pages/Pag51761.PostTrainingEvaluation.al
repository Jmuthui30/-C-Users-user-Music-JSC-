page 51761 "Post-Training Evaluation"
{
    // version THL- HRM 1.0
    PageType = Card;
    SourceTable = "Training Evaluation";

    layout
    {
        area(content)
        {
            group("Staff Details")
            {
                Editable = false;

                field("Employee Name"; Rec."Employee Name")
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
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Course Title"; Rec."Course Title")
                {
                    ApplicationArea = All;
                }
                field(Venue; Rec.Venue)
                {
                    ApplicationArea = All;
                }
                field(Organizers; Rec.Organizers)
                {
                    ApplicationArea = All;
                }
            }
            group("Course Evaluation")
            {
                field("Is the course content relevant to your current job description?";'')
                {
                    ApplicationArea = All;
                    Caption = 'Is the course content relevant to your current job description?';
                }
                field("Relevance of Course"; Rec."Relevance of Course")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
                field("What are the three most important things [or skills] you learned during this training?";'')
                {
                    ApplicationArea = All;
                    Caption = 'What are the three most important things [or skills] you learned during this training?';
                }
                field("Learned Skill 1"; Rec."Learned Skill 1")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Learned Skill 2"; Rec."Learned Skill 2")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Learned Skill 3"; Rec."Learned Skill 3")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field(Control29;'')
                {
                    ApplicationArea = All;
                    Caption = 'Was an appropriate amount of material covered during the course?  If not, was too much material covered or too little?';
                }
                field("Material Covered"; Rec."Material Covered")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
                field("To what extent do you expect this training will make a difference in the way you do your job?";'')
                {
                    ApplicationArea = All;
                    Caption = 'To what extent do you expect this training will make a difference in the way you do your job?';
                }
                field("Rate the Training"; Rec."Rate the Training")
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                }
                field("Please rate the following aspects of the course:";'')
                {
                    ApplicationArea = All;
                    Caption = 'Please rate the following aspects of the course:';
                }
                field("Couse Content"; Rec."Couse Content")
                {
                    ApplicationArea = All;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                }
                field(Presentation; Rec.Presentation)
                {
                    ApplicationArea = All;
                }
                field("Relevance Rating"; Rec."Relevance Rating")
                {
                    ApplicationArea = All;
                }
                field(Recommend; Rec.Recommend)
                {
                    ApplicationArea = All;
                }
                field(Control30;'')
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
                field(Control31;'')
                {
                    ApplicationArea = All;
                    Caption = 'HR Comments';
                }
                field("HR Comments"; Rec."HR Comments")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ShowCaption = false;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control25; Notes)
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
                    Rec.SetRange(Rec."No.", Rec."No.");
                    REPORT.Run(51610, true, false, Rec);
                end;
            }
        }
    }
}
