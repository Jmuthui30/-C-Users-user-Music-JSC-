page 51443 "Payroll GL Mapping"
{
    // version THL- Payroll 1.0
    PageType = List;
    SourceTable = "Payroll GL Mapping";

    layout
    {
        area(content)
        {
            repeater(Mapping)
            {
                field(Group; Rec.Group)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("ED Code"; Rec."ED Code")
                {
                    ApplicationArea = All;
                }
                field("Group Name"; Rec."Group Name")
                {
                    ApplicationArea = All;
                }
                field("ED Name"; Rec."ED Name")
                {
                    ApplicationArea = All;
                }
                field("Employee G/L Account"; Rec."Employee G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Employer G/L Account"; Rec."Employer G/L Account")
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
