page 51885 "Cost Appointment"
{
    // version THL- PRM 1.0
    PageType = ListPart;
    SourceTable = "Cost Apportionment";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Total Amount Spent"; Rec."Total Amount Spent")
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
