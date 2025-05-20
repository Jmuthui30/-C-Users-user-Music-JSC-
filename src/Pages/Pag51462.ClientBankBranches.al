page 51462 "Client Bank Branches"
{
    // version THL- Client Payroll 1.0
    PageType = ListPart;
    SourceTable = "Client Bank Branches";

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
