page 51764 "Excuse Duty Hospitals"
{
    // version THL- HRM 1.0
    PageType = ListPart;
    SourceTable = "Excuse Duty Hospitals";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Hospital Visited"; Rec."Hospital Visited")
                {
                    ApplicationArea = All;
                }
                field("Is a HMO Hospital?"; Rec."Is a HMO Hospital?")
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
