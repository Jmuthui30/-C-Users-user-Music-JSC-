page 51476 "Client Employee Contract Types"
{
    // version THL- Client Payroll 1.0
    PageType = List;
    SourceTable = "Client Employee Contract Type";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Contract; Rec.Contract)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
