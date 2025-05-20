page 51435 "Deductions"
{
    // version THL- Payroll 1.0
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = Deductions;

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
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Reduces Taxable Amt"; Rec."Reduces Taxable Amt")
                {
                    ApplicationArea = All;
                }
                field(Advance; Rec.Advance)
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field(Loan; Rec.Loan)
                {
                    ApplicationArea = All;
                }
                field("Maximum Amount"; Rec."Maximum Amount")
                {
                    ApplicationArea = All;
                }
                field("Pension Scheme"; Rec."Pension Scheme")
                {
                    ApplicationArea = All;
                }
                field("Deduction Table"; Rec."Deduction Table")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Employer"; Rec."G/L Account Employer")
                {
                    ApplicationArea = All;
                }
                field("Percentage Employer"; Rec."Percentage Employer")
                {
                    ApplicationArea = All;
                }
                field("Minimum Amount"; Rec."Minimum Amount")
                {
                    ApplicationArea = All;
                }
                field("Flat Amount Employer"; Rec."Flat Amount Employer")
                {
                    ApplicationArea = All;
                }
                field("Total Amount Employer"; Rec."Total Amount Employer")
                {
                    ApplicationArea = All;
                }
                field("Loan Type"; Rec."Loan Type")
                {
                    ApplicationArea = All;
                }
                field("Show Balance"; Rec."Show Balance")
                {
                    ApplicationArea = All;
                }
                field(Shares; Rec.Shares)
                {
                    ApplicationArea = All;
                }
                field("Show on report"; Rec."Show on report")
                {
                    ApplicationArea = All;
                }
                field("Non-Interest Loan"; Rec."Non-Interest Loan")
                {
                    ApplicationArea = All;
                }
                field("Exclude when on Leave"; Rec."Exclude when on Leave")
                {
                    ApplicationArea = All;
                }
                field("Co-operative"; Rec."Co-operative")
                {
                    ApplicationArea = All;
                }
                field("Total Shares"; Rec."Total Shares")
                {
                    ApplicationArea = All;
                }
                field("PAYE Code"; Rec."PAYE Code")
                {
                    ApplicationArea = All;
                }
                field("Total Days"; Rec."Total Days")
                {
                    ApplicationArea = All;
                }
                field("Pension Limit Percentage"; Rec."Pension Limit Percentage")
                {
                    ApplicationArea = All;
                }
                field("Pension Limit Amount"; Rec."Pension Limit Amount")
                {
                    ApplicationArea = All;
                }
                field("Applies to All"; Rec."Applies to All")
                {
                    ApplicationArea = All;
                }
                field("Show on Master Roll"; Rec."Show on Master Roll")
                {
                    ApplicationArea = All;
                }
                field("Pension Scheme Code"; Rec."Pension Scheme Code")
                {
                    ApplicationArea = All;
                }
                field("Main Deduction Code"; Rec."Main Deduction Code")
                {
                    ApplicationArea = All;
                }
                field("Insurance Code"; Rec."Insurance Code")
                {
                    ApplicationArea = All;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Institution Code"; Rec."Institution Code")
                {
                    ApplicationArea = All;
                }
                field("Show on Payslip Information"; Rec."Show on Payslip Information")
                {
                    ApplicationArea = All;
                }
                field("Voluntary Percentage"; Rec."Voluntary Percentage")
                {
                    ApplicationArea = All;
                }
                field("Salary Recovery"; Rec."Salary Recovery")
                {
                    ApplicationArea = All;
                }
                field(Gratuity; Rec.Gratuity)
                {
                    ApplicationArea = All;
                }
                field("Gratuity Arrears"; Rec."Gratuity Arrears")
                {
                    ApplicationArea = All;
                }
                field(Informational; Rec.Informational)
                {
                    ApplicationArea = All;
                }
                field(Board; Rec.Board)
                {
                    ApplicationArea = All;
                }
                field("Pension Arrears"; Rec."Pension Arrears")
                {
                    ApplicationArea = All;
                }
                field("SHIF Code"; Rec."SHIF Code")
                {
                    ApplicationArea = All;
                }
                field("NSSF Code"; Rec."NSSF Code")
                {
                    ApplicationArea = ALL;
                }
            }
        }
    }
    actions
    {
    }
}
