page 51746 "Coaching List"
{
    // version THL- HRM 1.0
    CardPageID = "Coaching Header";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Staff Coaching Header";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Counsellor No."; Rec."Counsellor No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
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
    }
}
