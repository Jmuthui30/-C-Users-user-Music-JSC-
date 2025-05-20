page 51600 "Leave Setup"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Leave Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Days; Rec.Days)
                {
                    ApplicationArea = All;
                }
                field("Reserved Days"; Rec."Reserved Days")
                {
                    ApplicationArea = All;
                }
                field("Unlimited Days"; Rec."Unlimited Days")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
                field("Max Carry Forward Days"; Rec."Max Carry Forward Days")
                {
                    ApplicationArea = All;
                }
                field("Annual Leave"; Rec."Annual Leave")
                {
                    ApplicationArea = All;
                }
                field("Inclusive of Holidays"; Rec."Inclusive of Holidays")
                {
                    ApplicationArea = All;
                }
                field("Inclusive of Saturday"; Rec."Inclusive of Saturday")
                {
                    ApplicationArea = All;
                }
                field("Inclusive of Sunday"; Rec."Inclusive of Sunday")
                {
                    ApplicationArea = All;
                }
                field("Off/Holidays Days Leave"; Rec."Off/Holidays Days Leave")
                {
                    ApplicationArea = All;
                }
                field("Advance Notice(Days)"; Rec."Advance Notice(Days)")
                {
                    ApplicationArea = All;
                }
                field("Eligible Staff"; Rec."Eligible Staff")
                {
                    ApplicationArea = All;
                }
                field("Notify on Application"; Rec."Notify on Application")
                {
                    ApplicationArea = All;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Leave Fiscal Year Difference"; Rec."Leave Fiscal Year Difference")
                {
                    ApplicationArea = All;
                }
                field("Adjustment Nos"; Rec."Adjustment Nos")
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
