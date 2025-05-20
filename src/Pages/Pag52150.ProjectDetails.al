page 52150 "Project Details"
{
    PageType = List;
    SourceTable = "Project Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Donor Code"; Rec."Donor Code")
                {
                    ApplicationArea = All;
                }
                field("Donor Description"; Rec."Donor Description")
                {
                    ApplicationArea = All;
                }
                field("Project Name"; Rec."Project Name")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approval Date"; Rec."Approval Date")
                {
                    ApplicationArea = All;
                }
                field(Currency; Rec.Currency)
                {
                    ApplicationArea = All;
                }
                field("Approved Amount"; Rec."Approved Amount")
                {
                    ApplicationArea = All;
                }
                field("Approval/Withdrawal"; Rec."Approval/Withdrawal")
                {
                    ApplicationArea = All;
                }
                field("Contract Date"; Rec."Contract Date")
                {
                    ApplicationArea = All;
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    ApplicationArea = All;
                }
                field("Expected Amount (Transfers)"; Rec."Expected Amount (Transfers)")
                {
                    ApplicationArea = All;
                }
                field("Actual Amount (Transfers)"; Rec."Actual Amount (Transfers)")
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
            action("Project Overview Report")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Project Overview Report";
            }
            action("List of Partners")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "List of Partners";
            }
        }
    }
}
