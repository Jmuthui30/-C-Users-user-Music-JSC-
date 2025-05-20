page 51479 "Client Earnings"
{
    // version THL- Client Payroll 1.0
    MultipleNewLines = false;
    //PageType = ListPart;
    PageType = List;
    SourceTable = "Client Earnings";
    ApplicationArea = All;

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
                field("Pay Type"; Rec."Pay Type")
                {
                    ApplicationArea = All;
                }
                field(Taxable; Rec.Taxable)
                {
                    ApplicationArea = All;
                }
                field("Calculation Method"; Rec."Calculation Method")
                {
                    ApplicationArea = All;
                }
                field("Flat Amount"; Rec."Flat Amount")
                {
                    ApplicationArea = All;
                }
                field(Percentage; Rec.Percentage)
                {
                    ApplicationArea = All;
                }
                field("G/L Account"; Rec."G/L Account")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; Rec."Total Amount")
                {
                    ApplicationArea = All;
                }
                field("Non-Cash Benefit"; Rec."Non-Cash Benefit")
                {
                    ApplicationArea = All;
                }
                field("Reduces Tax"; Rec."Reduces Tax")
                {
                    ApplicationArea = All;
                }
                field("Overtime Factor"; Rec."Overtime Factor")
                {
                    ApplicationArea = All;
                }
                field("Regular Cash Allowance"; Rec."Regular Cash Allowance")
                {
                    ApplicationArea = All;
                }
                field("Low Interest Benefit"; Rec."Low Interest Benefit")
                {
                    ApplicationArea = All;
                }
                field("Show Balance"; Rec."Show Balance")
                {
                    ApplicationArea = All;
                }
                field(OverTime; Rec.OverTime)
                {
                    ApplicationArea = All;
                }
                field("Show on Report"; Rec."Show on Report")
                {
                    ApplicationArea = All;
                }
                field("Time Sheet"; Rec."Time Sheet")
                {
                    ApplicationArea = All;
                }
                field("Basic Salary Code"; Rec."Basic Salary Code")
                {
                    ApplicationArea = All;
                }
                field("Earning Type"; Rec."Earning Type")
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
                field("House Allowance Code"; Rec."House Allowance Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Allowance Code"; Rec."Responsibility Allowance Code")
                {
                    ApplicationArea = All;
                }
                field("Commuter Allowance Code"; Rec."Commuter Allowance Code")
                {
                    ApplicationArea = All;
                }
                field(Block; Rec.Block)
                {
                    ApplicationArea = All;
                }
                field("Basic Pay Arrears"; Rec."Basic Pay Arrears")
                {
                    ApplicationArea = All;
                }
                field(Company; Rec.Company)
                {
                    ApplicationArea = All;
                }
                field("Minimum Limit"; Rec."Minimum Limit")
                {
                    ApplicationArea = All;
                }
                field("Maximum Limit"; Rec."Maximum Limit")
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
