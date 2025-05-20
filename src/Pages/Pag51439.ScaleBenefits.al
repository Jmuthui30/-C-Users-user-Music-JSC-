page 51439 "Scale Benefits"
{
    // version THL- Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Scale Benefits";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                field(Earning; Rec.Earning)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
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
