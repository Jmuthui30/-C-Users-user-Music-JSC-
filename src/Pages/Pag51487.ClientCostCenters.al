page 51487 "Client Cost Centers"
{
    // version THL- Client Payroll 1.0
    PageType = List;
    SourceTable = "Client Cost Center";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Client; Rec.Client)
                {
                    ApplicationArea = All;
                }
                field("Cost Center"; Rec."Cost Center")
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
