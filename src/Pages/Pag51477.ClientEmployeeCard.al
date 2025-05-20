page 51477 "Client Employee Card"
{
    // version THL- Client Payroll 1.0
    Caption = 'Employee Card';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Client Employee Master";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies a number for the employee.';
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s title.';
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Middle Name"; Rec."Middle Name")
                {
                    ApplicationArea = All;
                    Caption = 'Middle Name/Initials';
                    ToolTip = 'Specifies the employee''s middle name.';
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s initials.';
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s gender.';
                }
                field("Marital Status"; Rec."Marital Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a salesperson or purchaser code for the employee, if the employee is a salesperson or purchaser in the company.';
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Employee Type"; Rec."Employee Type")
                {
                    ApplicationArea = All;
                }
                field("Residential Status"; Rec."Residential Status")
                {
                    ApplicationArea = All;
                }
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Cost Center Code"; Rec."Cost Center Code")
                {
                    ApplicationArea = All;
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                }
                field(Retirement; Retirement)
                {
                    Enabled = false;
                    Editable = false;
                    ApplicationArea = All;
                }
            }
            group("Leave Details")
            {
                field("Annual Leave Days Enttitled"; Rec."Annual Leave Days Enttitled")
                {
                    ApplicationArea = All;
                }
                field("Annual Days Taken"; Rec."Annual Days Taken")
                {
                    ApplicationArea = All;
                }
                field("Annual Leaves Balance"; Rec."Annual Leaves Balance")
                {
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';

                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the employee''s mobile telephone number.';
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s pager number.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment status of the employee.';
                }
                field("Contract Type"; Rec."Contract Type")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date Employee Agreement';
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the date when the employee began to work for the company.';
                }
                field("Last Salary Review Date"; Rec."Last Salary Review Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Last salary Level/Grade Update';
                }
                field("Next Increamental Date"; Rec."Next Increamental Date")
                {
                    Caption = 'Next Salary Review Date';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Next salary Level/Grade Update';
                }
                field("Halt Date"; Rec."Halt Date")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the last Date of employee Salary Increament that is the Highest Salary Level for the Staff';
                }
                field("Departure Date"; Rec."Departure Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the employee became inactive, due to disability or maternity leave, for example.';
                }
                field("ID Number"; Rec."ID Number")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the ID No.';
                }
                field("Passport No."; Rec."Passport No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a termination code for the employee who has been terminated.';
                }
                field("Driving License No"; Rec."Driving License No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employment contract code for the employee.';
                }
            }
            group("Payroll Information")
            {
                Caption = 'Payroll Information';

                field("PIN Number"; Rec."PIN Number")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ShowMandatory = true;
                    ToolTip = 'Specifies the employee''s date of birth.';
                }
                field("NSSF No"; Rec."NSSF No")
                {
                    ApplicationArea = All;
                    Importance = Promoted;
                    ToolTip = 'Specifies the Social Security number of the employee.';
                }
                field("SHIF No"; Rec."SHIF No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership code.';
                }
                field("HELB No"; Rec."HELB No")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s labor union membership number.';
                }
                field("Sacco No"; Rec."Sacco No")
                {
                    ApplicationArea = All;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;
                }
                field("Bank Account Number"; Rec."Bank Account Number")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Code"; Rec."Bank Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Branch"; Rec."Bank Branch")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Bank Branch Name"; Rec."Bank Branch Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(Scale; Rec.Scale)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    ApplicationArea = All;
                }
                field("Salary Currency"; Rec."Salary Currency")
                {
                    ApplicationArea = All;
                }
                field("Employee Group"; Rec."Employee Group")
                {
                    ApplicationArea = All;
                }
                field("Pays Tax"; Rec."Pays Tax")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies PAYE Tax Rates';
                }
                field("Country Tax Table"; Rec."Country Tax Table")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            part(Control3; "Client Employee Picture")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "No." = FIELD("No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = All;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = All;
                Visible = true;
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
                RunObject = Page "Client Payroll Matrix";
                RunPageLink = Company = FIELD("Company Code"), "Employee No" = FIELD("No."), Type = CONST(Payment), Closed = CONST(false);
            }
            action("Staff Deductions")
            {
                ApplicationArea = All;
                Image = Payment;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Client Payroll Matrix";
                RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Closed = CONST(false), Company = FIELD("Company Code");
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
                    REPORT.Run(51455, true, false, Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.CalcFields("Annual Days Taken");
        Rec."Annual Leaves Balance" := Rec."Annual Leave Days Enttitled" - Rec."Annual Days Taken";
    end;

    trigger OnOpenPage()
    begin
        Rec.CalcFields("Annual Days Taken");
        Rec."Annual Leaves Balance" := Rec."Annual Leave Days Enttitled" - Rec."Annual Days Taken";
    end;

    var
        ExternalEmployeesLeave: Record "External Employees Leave";
        Employee: Record Employee;
}
