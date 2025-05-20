page 51432 "Bank Branches"
{
    // version THL- Payroll 1.0
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Bank Branches";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Branch Code"; Rec."Branch Code")
                {
                    ApplicationArea = All;
                }
                field("Branch Name"; Rec."Branch Name")
                {
                    ApplicationArea = All;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
