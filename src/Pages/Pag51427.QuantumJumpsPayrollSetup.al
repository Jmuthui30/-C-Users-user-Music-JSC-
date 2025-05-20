page 51427 "QuantumJumps Payroll Setup"
{
    // version THL- Payroll 1.0
    Caption = 'Payroll Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "QuantumJumps Payroll Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Activate Payroll"; Rec."Activate Payroll")
                {
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Table"; Rec."Tax Table")
                {
                    ApplicationArea = All;
                }
                field("Corporation Tax"; Rec."Corporation Tax")
                {
                    ApplicationArea = All;
                }
                field("Housing Earned Limit"; Rec."Housing Earned Limit")
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
                field("Round Down"; Rec."Round Down")
                {
                    ApplicationArea = All;
                }
                field("Working Hours"; Rec."Working Hours")
                {
                    ApplicationArea = All;
                }
                field("Time Sheet Penalty Code"; Rec."Time Sheet Penalty Code")
                {
                    ApplicationArea = All;
                }
                field("Salary Advance Code"; Rec."Salary Advance Code")
                {
                    ApplicationArea = All;
                }
                field("Payroll Rounding Precision"; Rec."Payroll Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Payroll Rounding Type"; Rec."Payroll Rounding Type")
                {
                    ApplicationArea = All;
                }
                field("Company overtime hours"; Rec."Company overtime hours")
                {
                    ApplicationArea = All;
                }
                field("Loan Product Type Nos."; Rec."Loan Product Type Nos.")
                {
                    ApplicationArea = All;
                }
                field("Tax Relief Amount"; Rec."Tax Relief Amount")
                {
                    ApplicationArea = All;
                }
                field("General Payslip Message"; Rec."General Payslip Message")
                {
                    ApplicationArea = All;
                }
                field("SHIF No"; Rec."SHIF No")
                {
                    ApplicationArea = All;
                }
                field("NSSF No."; Rec."NSSF No.")
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
