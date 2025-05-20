page 51457 "Client Payroll Setup"
{
    // version THL- Client Payroll 1.0
    Caption = 'Payroll Setup';
    DeleteAllowed = false;
    MultipleNewLines = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Client Payroll Setup";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Client; Rec.Client)
                {
                }
                field("Tax Table"; Rec."Tax Table")
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
                field("Owner occupier interest"; Rec."Owner occupier interest")
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
                field("Net Pay Rounding Precision"; Rec."Net Pay Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Net Pay Rounding Type"; Rec."Net Pay Rounding Type")
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
