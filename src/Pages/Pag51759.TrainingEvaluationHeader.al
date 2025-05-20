page 51759 "Training Evaluation Header"
{
    // version THL- HRM 1.0
    Caption = 'Training Evaluation';
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
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
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
                field("Training No."; Rec."Training No.")
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
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control17; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Post-Training Evaluation")
            {
                ApplicationArea = All;
                Image = Certificate;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Post-Training Evaluation";
                RunPageLink = "No."=FIELD("No.");
                RunPageOnRec = true;
            }
            action("Facilitator Evaluation")
            {
                ApplicationArea = All;
                Image = Certificate;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Facilitator Evaluation";
                RunPageLink = "No."=FIELD("No.");
                RunPageOnRec = true;
            }
            action("Post Training Evaluation Form")
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
            action("Facilitator Evaluation Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange(Rec."No.", Rec."No.");
                    REPORT.Run(51611, true, false, Rec);
                end;
            }
        }
    }
}
