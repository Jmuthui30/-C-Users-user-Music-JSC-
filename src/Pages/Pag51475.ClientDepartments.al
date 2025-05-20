page 51475 "Client Departments"
{
    // version THL- Client Payroll 1.0
    PageType = List;
    SourceTable = "Client Department";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Department; Rec.Department)
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
