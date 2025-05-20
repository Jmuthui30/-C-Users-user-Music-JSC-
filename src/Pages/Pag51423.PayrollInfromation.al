page 51423 "Payroll Infromation"
{
    // version THL- Payroll 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Employee Master";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Pays Tax"; Rec."Pays Tax")
                {
                    ApplicationArea = All;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = All;
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = All;
                }
                field("Driving License No"; Rec."Driving License No")
                {
                    ApplicationArea = All;
                }
                field("Employee Group"; Rec."Employee Group")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Scale; Rec."Appraisal Supervisor")
                {
                    ApplicationArea = All;
                }
                field("Salary Currency"; Rec."Salary Currency")
                {
                    ApplicationArea = All;
                }
                field("Hourly Rate"; Rec."Hourly Rate")
                {
                    ApplicationArea = All;
                }
                field("Daily Rate"; Rec."Daily Rate")
                {
                    ApplicationArea = All;
                }
                field("Country Tax Table"; Rec."Country Tax Table")
                {
                    ApplicationArea = All;
                }
                field("Home Ownership Status"; Rec."Home Ownership Status")
                {
                    ApplicationArea = All;
                }
                field("Travels Customer Account"; Rec."Travels Customer Account")
                {
                    ApplicationArea = All;
                }
            }
            group("Banking Infromation")
            {
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = All;
                }
            }
            group("Statutory Numbers")
            {
                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                }
                field("NSSF No"; Rec."NSSF No")
                {
                    ApplicationArea = All;
                }
                field("SHIF No"; Rec."SHIF No")
                {
                    ApplicationArea = All;
                }
                field("HELB No"; Rec."HELB No")
                {
                    ApplicationArea = All;
                }
                field("Sacco No"; Rec."Sacco No")
                {
                    ApplicationArea = All;
                }
            }
            group("Time Sheets")
            {
                field("Use Timesheets"; Rec."Use Timesheets")
                {
                    ApplicationArea = All;
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control23; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Staff Earnings")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Payroll Matrix";
                //RunObject = page "Client Earnings";
                RunPageLink = "Employee No"=FIELD("No."), Type=filter(Payment), Closed=CONST(false);
            //RunPageLink = "Pay Type" = filter(Payment);
            }
            action("Staff Deductions")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Payroll Matrix";
                RunPageLink = "Employee No"=FIELD("No."), Type=CONST(Deduction), Closed=CONST(false);
            }
            action("Donor Apportionment")
            {
                ApplicationArea = All;
                Image = Split;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Donor Apportionment Card";
                RunPageLink = "Employee No"=FIELD("No."), Closed=CONST(false);
            }
            action(Payslip)
            {
                ApplicationArea = All;
                Image = PeriodEntries;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51425, true, false, Rec);
                end;
            }
        }
    }
}
