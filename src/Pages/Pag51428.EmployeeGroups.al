page 51428 "Employee Groups"
{
    // version THL- Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Employee Groups";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Basic Salary Account"; Rec."Basic Salary Account")
                {
                    ApplicationArea = All;
                }
                field("Income Tax account"; Rec."Income Tax account")
                {
                    ApplicationArea = All;
                }
                field("NSSF Employer Account"; Rec."NSSF Employer Account")
                {
                    ApplicationArea = All;
                }
                field("NSSF Total Account"; Rec."NSSF Total Account")
                {
                    ApplicationArea = All;
                }
                field("Pension Employee Account"; Rec."Pension Employee Account")
                {
                    ApplicationArea = All;
                }
                field("Pension Employer Account"; Rec."Pension Employer Account")
                {
                    ApplicationArea = All;
                }
                field("Net Pay Account"; Rec."Net Pay Account")
                {
                    ApplicationArea = All;
                }
                field(Permanent; Rec.Permanent)
                {
                    ApplicationArea = All;
                }
                field("Temporary"; Rec."Temporary")
                {
                    ApplicationArea = All;
                }
                field(Intern; Rec.Intern)
                {
                    ApplicationArea = All;
                }
                field(Secondment; Rec.Secondment)
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
