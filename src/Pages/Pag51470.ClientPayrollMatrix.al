page 51470 "Client Payroll Matrix"
{
    // version THL- Client Payroll 1.0
    //PageType = ListPart;
    SourceTable = "Client Payroll Matrix";
    PageType = List;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Payroll Period"; Rec."Payroll Period")
                {
                    ApplicationArea = All;
                }
                field("Expected Hrs"; Rec."Expected Hrs")
                {
                    ApplicationArea = All;
                }
                field("Worked Hrs"; Rec."Worked Hrs")
                {
                    ApplicationArea = All;
                }
                field("No. of Units"; Rec."No. of Units")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Employer Amount"; Rec."Employer Amount")
                {
                    ApplicationArea = All;
                }
                field("Earning/Deduction Type"; Rec."Earning/Deduction Type")
                {
                    ApplicationArea = All;
                }
                field("Opening Balance"; Rec."Opening Balance")
                {
                    ApplicationArea = all;
                }
                field("Opening Balance Company"; Rec."Opening Balance Company")
                {
                    ApplicationArea = all;
                }
                field("Taxable amount"; Rec."Taxable amount")
                {
                    ApplicationArea = All;
                }
                field(AKI; Rec.AKI)
                {
                    ApplicationArea = All;
                }
                field("Cetificate Expiry date"; Rec."Cetificate Expiry date")
                {
                    ApplicationArea = All;
                }
                field("Prorating Type"; Rec."Prorating Type")
                {
                    ApplicationArea = All;
                }
                field("Prorate Date"; Rec."Prorate Date")
                {
                    ApplicationArea = All;
                }
                field(Prorate; Rec.Prorate)
                {
                    ApplicationArea = All;
                }
                field("Job Grade"; Rec."Job Grade")
                {
                    ApplicationArea = All;
                }
                field("Salary Level"; Rec."Salary Level")
                {
                    ApplicationArea = All;
                }
                field("Less Pension Contribution"; "Less Pension Contribution")
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
