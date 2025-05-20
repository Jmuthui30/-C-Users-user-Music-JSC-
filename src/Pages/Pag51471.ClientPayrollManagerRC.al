page 51471 "Client Payroll Manager RC"
{
    // version THL- Client Payroll 1.0
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'Business Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control16; "Client Payroll Activities")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = Basic, Suite;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                Caption = '';
                ToolTip = 'Specifies the view of your business assistance';
            }
            part(Control46; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part("Favorite Accounts"; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Favorite Accounts';
            }
            part(Control96; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            // part(Control98; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part("PR Payroll Activities Cue"; "Client Payroll Activities")
            {
                Caption = 'PAYROLL ACTIVITIES';
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(processing)
        {
            group(New)
            {
                Caption = 'New';

                action("Payroll Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Setup';
                    Image = PayrollStatistics;
                    RunObject = Page "Client Payroll Setup";
                    RunPageMode = Edit;
                    ToolTip = 'Modify a value in the Payroll Setup';
                }
                action("Employee Groups")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Groups';
                    Image = EmployeeAgreement;
                    RunObject = Page "Client Employee Groups";
                    RunPageMode = Edit;
                    ToolTip = 'Edit or Add new Emloyee Groups';
                }
                action("Payroll Periods")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payroll Periods';
                    Image = PaymentPeriod;
                    RunObject = Page "Client Payroll Periods";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Payroll Periods';
                }
                action(Earnings)
                {
                    ApplicationArea = Suite;
                    Caption = 'Earnings';
                    Image = PaymentJournal;
                    RunObject = Page "Earnings Master";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Employee Earnings';
                }
                action(Deductions)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deductions';
                    Image = Receipt;
                    RunObject = Page "Deductions Master";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or create new earnings';
                }
                action("Bracket Tables")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bracket Tables';
                    Image = Database;
                    RunObject = Page "Client Bracket Tables";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Bracket Tables';
                }
            }
            group(Payments)
            {
                Caption = 'Payments';

                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    Image = Reconcile;

                    action("Payroll Run")
                    {
                        ApplicationArea = Basic, Suite;
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
                    action("Generate Payroll Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Payroll Journal';
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Transfer Client Journal to GL";
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
                        RunObject = Report "Client Master Roll Report";
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
                        RunObject = Report "Client Bank Instruction";
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
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';

            action("Employee Master")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employee Master';
                RunObject = Page "Client Payroll List";
                ToolTip = 'Open the list of employees.';
            }
        }
        area(sections)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                ToolTip = 'Approve requests made by other users.';

                action("Requests to Approve")
                {
                    ApplicationArea = Suite;
                    Caption = 'Requests to Approve';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'View the number of approval requests that require your approval.';
                }
            }
        }
    }
}
