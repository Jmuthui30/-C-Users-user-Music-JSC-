page 50023 "Client Payroll List B"
{ // version THL- Client Payroll 1.0
    Caption = 'Payroll B Employee Master';
    CardPageID = "Client Employee Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Client Employee Master";
    SourceTableView = where("Company Code"=filter('PAYROLLB'), Status=filter(Active));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number for the employee.';
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s first name.';
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s last name.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s job title.';
                }
                field("Company Code"; Rec."Company Code")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ApplicationArea = All;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone extension.';
                }
                field(Country; Rec.Country)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s telephone number.';
                    Visible = false;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Mobile Phone No."; Rec."Mobile Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the employee''s mobile telephone number.';
                    Visible = false;
                }
                field("Email Address"; Rec."Email Address")
                {
                    ApplicationArea = All;
                }
                field("Postal Address"; Rec."Postal Address")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
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
            group(Payments)
            {
                Caption = 'Payments';

                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    Image = Reconcile;

                    action("Payroll Run")
                    {
                        ApplicationArea = All;
                        Caption = 'Payroll Run';
                        Image = Calculate;
                        RunObject = Report "Client Payroll Calculator";
                        ToolTip = 'Calculate Payroll';
                    }
                    action("Email Payslips")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email Payslips';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Client Payslips";
                        ToolTip = 'Email Payslips';
                    }
                    action("Email P9A")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email P9 Report';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Client P9";
                        ToolTip = 'Email P9A';
                    }
                }
                group("Process Payments")
                {
                    Caption = 'Process Payments';
                    Image = Reconcile;

                    action("EFT Payments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'EFT Payments';
                        Image = Payment;
                        RunObject = Page "New EFT Entries";
                        ToolTip = 'Process EFT Payments';
                    }
                }
            }
            group(Reports)
            {
                Caption = 'Reports';

                group("Management Reports")
                {
                    Caption = 'Management Reports';
                    Image = ReferenceData;

                    action(Payslips)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payslips';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Payslip";
                        ToolTip = 'View Employee Payslips';
                    }
                    action("Master Roll")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Master Roll';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Master Roll Report2";
                        ToolTip = 'View Master Roll Report';
                    }
                    action("Monthly PAYE Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Monthly PAYE Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Monthly PAYE Report";
                        ToolTip = 'View the monthly PAYE Report';
                    }
                    action("Earnings Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Earnings Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Earnings";
                        ToolTip = 'View Earnings Report';
                    }
                    action("Deductions Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Deductions Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Deductions";
                    }
                    action("SHIF Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'SHIF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client SHIF";
                        ToolTip = 'View SHIF Report';
                    }
                    action("NSSF Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'NSSF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client NSSF";
                        ToolTip = 'View NSSF Report';
                    }
                    action("Bank Instruction")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Instruction';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Bank Inst Format 2";
                        ToolTip = 'Generate Instruction to the Bank';
                    }
                    action("Company Totals")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Company Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Company Totals";
                        ToolTip = 'View the Company Totals Report';
                    }
                    action("GTN Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'GTN Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "GTN Report";
                        ToolTip = 'View GTNl Report';
                    }
                    action("Variance(Net Pay)")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variance(Net Pay)';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Recon Combined";
                    }
                    action("Variance(Detail)")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variance(Detail)';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Reconciliation";
                    }
                    action("12 Month Report")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = '12 Month Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Salary 12 Month Report";
                    }
                }
                group("Statutory Reports")
                {
                    Caption = 'Statutory Reports';
                    Image = ReferenceData;

                    action(P9A)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P9A';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client P9A";
                        ToolTip = 'View Employee P9A Report';
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;

                action("Company Settings")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Settings';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                    ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                }
                action("User Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'User Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "QuantumJumps User Setup";
                    ToolTip = 'Set up core functionality for users';
                }
                group("Commercial Banks")
                {
                    Caption = 'Commercial Banks';
                    Image = ServiceSetup;

                    action("Employee Banks")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Banks';
                        Image = NonStockItemSetup;
                        RunObject = Page "Client Commercial Banks";
                        ToolTip = 'Manage Employee Banks';
                    }
                    action("Bank Branches")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Bank Branches';
                        Image = ServiceTasks;
                        RunObject = Page "Client Bank Branches";
                        ToolTip = 'Manage Bank Branches';
                    }
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        IF UserSetup.GET(USERID)THEN IF NOT UserSetup.Payroll THEN ERROR(TEXT001);
    end;
    var PayrollInt: Codeunit "Client Payroll Mgt";
    UserSetup: Record "User Setup";
    TEXT001: Label 'Kindly Note that you are not Allowed to View Payroll.Consult your System Administrator for Setup';
}
