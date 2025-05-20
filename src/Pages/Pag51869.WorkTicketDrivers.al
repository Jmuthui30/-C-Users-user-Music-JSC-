page 51869 "Work Ticket Drivers"
{
    // version THL- PRM 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Work Ticket Drivers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Vehicle; Rec.Vehicle)
                {
                    ApplicationArea = All;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
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
