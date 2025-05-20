page 51440 "Payroll Matrix"
{
    // version THL- Payroll 1.0
    PageType = ListPart;
    SourceTable = "Payroll Matrix";

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
                field("No. Of Days Worked"; Rec."No. Of Days Worked")
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
            }
        }
    }
    actions
    {
    }
}
