page 51667 "Medical Covers Setup"
{
    // version THL- HRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Medical Covers Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Claims Gen. Journal Template"; Rec."Claims Gen. Journal Template")
                {
                    ApplicationArea = All;
                }
                field("Claims Payroll Code"; Rec."Claims Payroll Code")
                {
                    ApplicationArea = All;
                }
                field("Cover Nos."; Rec."Cover Nos.")
                {
                    ApplicationArea = All;
                }
                field("Claim Nos."; Rec."Claim Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control6; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
