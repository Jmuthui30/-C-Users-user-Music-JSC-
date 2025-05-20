page 51744 "Coaching Header"
{
    // version THL- HRM 1.0
    PageType = Card;
    SourceTable = "Staff Coaching Header";

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Counsellor No."; Rec."Counsellor No.")
                {
                    ApplicationArea = All;
                }
                field("Counsellor Name"; Rec."Counsellor Name")
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
                field("Counsellee No."; Rec."Counsellee No.")
                {
                    ApplicationArea = All;
                }
                field("Counsellee's Name"; Rec."Counsellee's Name")
                {
                    ApplicationArea = All;
                }
                field("Reason for Coaching"; Rec."Reason for Coaching")
                {
                    ApplicationArea = All;
                }
            }
            part(Control20; "Couselling Performance Issues")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
            group("Feedback Assesment")
            {
                field("Staff Free to Express Self"; Rec."Staff Free to Express Self")
                {
                    ApplicationArea = All;
                }
                field("Staff Comfortable"; Rec."Staff Comfortable")
                {
                    ApplicationArea = All;
                }
                field("More Notes"; Rec."More Notes")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Issues Affect Performance"; Rec."Issues Affect Performance")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control19; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Coaching Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51607, true, false, Rec);
                end;
            }
        }
    }
}
