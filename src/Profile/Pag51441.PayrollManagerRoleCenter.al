page 51441 "Payroll Manager Role Center"
{
    // version THL- Payroll 1.0
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'Payroll Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            /*   part(Control16; "Payroll Activities")
              {
                  AccessByPermission = TableData "G/L Entry" = R;
                  ApplicationArea = All;
              } */
            // part(Control55; "Help And Chart Wrapper")
            // {
            //     /*Commented by Henry*///AccessByPermission = TableData "Assisted Setup"=R;
            //     ApplicationArea = All;
            //     Caption = '';
            //     ToolTip = 'Specifies the view of your business assistance';
            // }
            // part(Control46; "Team Member Activities")
            // {
            //     ApplicationArea = All;
            // }
            // part("Favorite Accounts"; "My Accounts")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Favorite Accounts';
            // }
            part(Headline; "Headline RC Payroll Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part("PR Payroll Activities Cue"; "Payroll Activities")
            {
                Caption = 'PAYROLL ACTIVITIES';
                ApplicationArea = Basic, Suite;
            }
            part(Control96; "Report Inbox Part")
            {
                ApplicationArea = All;
            }
            // part(Control98; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = All;
            // }
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
                    ApplicationArea = All;
                    Caption = 'Payroll Setup';
                    Image = PayrollStatistics;
                    RunObject = Page "QuantumJumps Payroll Setup";
                    RunPageMode = Edit;
                    ToolTip = 'Modify a value in the Payroll Setup';
                }
                action("Client Payroll Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Client Payroll Setup';
                    Image = PayrollStatistics;
                    RunObject = Page "Client Payroll Setup";
                    RunPageMode = Edit;
                    ToolTip = 'Modify a value in the Payroll Setup';
                }
                action("Client Employee Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Client Employee Groups';
                    Image = PayrollStatistics;
                    RunObject = Page "Client Employee Groups";
                    RunPageMode = Edit;
                    ToolTip = 'Modify a value in the Payroll Setup';
                }
                action("Payroll Periods")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Periods';
                    Image = PaymentPeriod;
                    RunObject = Page "Client Payroll Periods";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Payroll Periods';
                }
                action(Earnings)
                {
                    ApplicationArea = All;
                    Caption = 'Earnings';
                    Image = PaymentJournal;
                    RunObject = Page "Client Earnings";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Employee Earnings';
                }
                action(Deductions)
                {
                    ApplicationArea = All;
                    Caption = 'Deductions';
                    Image = Receipt;
                    RunObject = Page "Client Deductions";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or create new earnings';
                }
                action("Bracket Tables")
                {
                    ApplicationArea = All;
                    Caption = 'Bracket Tables';
                    Image = Database;
                    RunObject = Page "Client Bracket Tables";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Bracket Tables';
                }
                action(Clients)
                {
                    ApplicationArea = All;
                    Caption = 'Clients';
                    Image = Database;
                    RunObject = Page "Client List";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new clients';
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
                        ApplicationArea = All;
                        Caption = 'Payroll Run';
                        Image = Calculate;
                        //RunObject = Report "Payroll Calculator";
                        RunObject = report "Client Payroll Calculator";
                        ToolTip = 'Calculate Payroll';
                    }
                    action("Email Payslips")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email Payslips';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Client Payslips";
                        //RunObject = codeunit "Email Payslips";
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
                    action("Generate Payroll Journal per Group")
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Payroll Journal Per Group';
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Client Journal to GL New";
                    }
                    action("General Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'General Journal';
                        Image = Journals;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = page "General Journal";
                    }
                }
                group("Process Payments")
                {
                    Caption = 'Process Payments';
                    Image = Reconcile;

                    action("EFT Payments")
                    {
                        ApplicationArea = All;
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
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        Caption = 'Master Roll';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        // RunObject = Report "Client Master Roll Report";
                        RunObject = Report "Client Master Roll Report2";
                        ToolTip = 'View Master Roll Report';
                    }
                    action("Monthly PAYE Report")
                    {
                        ApplicationArea = All;
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
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        Caption = 'Deductions Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Deductions";
                    }
                    action("Third Parties Deductions Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Third Parties Deductions Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Deduction-Institution";
                    }
                    action("Total Deductions Only Per Employee")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Deductions Only Per Employee';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Total Deductions/Employee";
                    }
                    action("Total Earnings Only Per Employee")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Earnings Only Per Employee';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Total Earnings/Employee";
                    }
                    action("Bank List")
                    {
                        ApplicationArea = All;
                        Caption = 'Bank List';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Bank List";
                        ToolTip = 'View Bank List Report';
                    }
                    action("Bank Instruction")
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Instruction';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Bank Instruction";
                        ToolTip = 'Generate Instruction to the Bank';
                    }
                    action("Client Wage Bill")
                    {
                        ApplicationArea = All;
                        Caption = 'Client Wage Bill';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Wage Bill";
                        ToolTip = 'View the Company Totals Report';
                    }
                    action("Client Total Payroll Cost")
                    {
                        ApplicationArea = All;
                        Caption = 'Client Wagebill Per Employee Group';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Total Payroll Cost";
                        ToolTip = 'Client Total Payroll Cost';
                    }
                    action("Client A Third Rule Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Client A Third Rule Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "A Third Rule Report";
                        ToolTip = 'View Client A Third Rule Report';
                    }
                    action("Company Totals")
                    {
                        ApplicationArea = All;
                        Caption = 'Company Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Company Totals";
                        ToolTip = 'View the Company Totals Report';
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
                        ApplicationArea = All;
                        Caption = 'Detailed Variance Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Reconciliation";
                    }
                    action("Earnings Variance Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Earnings Variance Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Earn.Variance Recon.";
                    }
                    action("12 Month Report")
                    {
                        ApplicationArea = All;
                        Caption = '12 Month Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Salary 12 Month Report";
                    }


                    //   Payroll Reconciliation new

                }
                group("Statutory Reports")
                {
                    Caption = 'Statutory Reports';
                    Image = ReferenceData;

                    action(P9A)
                    {
                        ApplicationArea = All;
                        Caption = 'P9A';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client P9A";
                        ToolTip = 'View Employee P9A Report';
                    }
                    action("P10 B")
                    {
                        ApplicationArea = All;
                        Caption = 'KRA ITAX P10 Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "KRA ITAX P10 Report";
                        ToolTip = 'View Employee P10 B Report';
                    }
                    action("Housing Levy")
                    {
                        ApplicationArea = All;
                        Caption = 'Housing Levy';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Housing Levy";
                        ToolTip = 'View Employee Housing Levy Report';
                    }
                    action("P10 A")
                    {
                        ApplicationArea = All;
                        Caption = 'P10 A';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "P10 A";
                        ToolTip = 'View Employee P10 A Report';
                    }
                    action("SHIF Report")
                    {
                        ApplicationArea = All;
                        Caption = 'SHIF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client SHIF";
                        ToolTip = 'View SHIF Report';
                    }
                    action("PROVIDENT")
                    {
                        ApplicationArea = All;
                        Caption = 'PROVIDENT Fund Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Provident Fund";
                        ToolTip = 'View PROVIDENT Fund Report';
                    }
                    action("PROVIDENT Arrears")
                    {
                        ApplicationArea = All;
                        Caption = 'PROVIDENT Fund Arrears Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Provident Fund Arrears";
                        ToolTip = 'View PROVIDENT Fund Arrears Report';
                    }
                    action("NSSF Report")
                    {
                        ApplicationArea = All;
                        Caption = 'NSSF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client NSSF";
                        ToolTip = 'View NSSF Report';
                    }
                    action("NSSF Report New")
                    {
                        ApplicationArea = All;
                        Caption = 'NSSF Report new';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report NSSF;
                        ToolTip = 'View NSSF Report';
                    }
                    action("NSSF Report New1")
                    {
                        ApplicationArea = All;
                        Caption = 'NSSF Report new1';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "NSSF New";
                        ToolTip = 'View NSSF Report';
                    }
                }
                group("Employee Statistics")
                {
                    action("Employee Details")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Employee Details';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Employee Details";
                        ToolTip = 'View Employee Details';
                    }
                    action("Staff Changes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Staff Changes';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Staff Changes Report";
                        ToolTip = 'View Staff Changes Report';
                    }
                    action("Payroll Reconciliation new")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Reconciliation new';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Reconciliation new";
                    }
                    action("Payroll Reconciliationtest")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Reconciliation test';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Reconciliation test";
                    }
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;

                action("Company Settings")
                {
                    ApplicationArea = All;
                    Caption = 'Company Settings';
                    Image = CompanyInformation;
                    RunObject = Page "Client Company Information";
                    ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                }
                action("Employee Groups")
                {
                    ApplicationArea = All;
                    Caption = 'User Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "QuantumJumps User Setup";
                    ToolTip = 'Set up core functionality for users';
                }
                action("User Setup")
                {
                    ApplicationArea = All;
                    Caption = 'User Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "QuantumJumps User Setup";
                    ToolTip = 'Set up core functionality for users';
                }

                action("Payroll Deduction SetupDelete")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Deduction SetupDate';
                    Image = QuestionaireSetup;
                    RunObject = report "Payroll Deduction SetupDelete";
                    ToolTip = 'Set up core functionality for users';
                }
                action("Payroll Deduction SetupDate")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Deduction SetupDate';
                    Image = QuestionaireSetup;
                    RunObject = report "Payroll Deduction SetupDate";
                    ToolTip = 'Set up core functionality for users';
                }


                group("Commercial Banks")
                {
                    Caption = 'Commercial Banks';
                    Image = ServiceSetup;

                    action("Employee Banks")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee Banks';
                        Image = NonStockItemSetup;
                        RunObject = Page "Commercial Banks";
                        ToolTip = 'Manage Employee Banks';
                    }
                    action("Bank Branches")
                    {
                        ApplicationArea = All;
                        Caption = 'Bank Branches';
                        Image = ServiceTasks;
                        RunObject = Page "Bank Branches";
                        ToolTip = 'Manage Bank Branches';
                    }
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';

            action("Employee Master A")
            {
                ApplicationArea = All;
                Caption = 'Employee Master A';
                RunObject = Page "Client Payroll List A";
                ToolTip = 'Open the list of employees in Payroll A.';
            }
            action("Employee Master B")
            {
                ApplicationArea = All;
                Caption = 'Employee Master B';
                RunObject = Page "Client Payroll List B";
                ToolTip = 'Open the list of employees in Payroll B.';
            }
            action("Imprest Payroll Claims")
            {
                ApplicationArea = All;
                Caption = 'Imprest Payroll Claims';
                RunObject = Page "Imprest Payroll Claims List";
            }
            action("Imprest Payroll Claims Open")
            {
                ApplicationArea = All;
                Caption = 'Open';
                RunObject = Page "Imprest Payroll Claims List";
                RunPageView = where(Status = const(Open));
            }
            action("Imprest Payroll Claims Pending")
            {
                ApplicationArea = All;
                Caption = 'Pending Approval';
                RunObject = Page "Imprest Payroll Claims List";
                RunPageView = where(Status = const("Pending Approval"));
            }
            action("Imprest Payroll Claims Approved")
            {
                ApplicationArea = All;
                Caption = 'Approved';
                RunObject = Page "Imprest Payroll Claims List";
                RunPageView = where(Status = const(Released));
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
                    ApplicationArea = All;
                    Caption = 'Requests to Approve';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'View the number of approval requests that require your approval.';
                }
            }
            group("Client Loan Management")
            {
                Caption = 'Client Loan Management';

                action("Client Loan Products")
                {
                    ApplicationArea = All;
                    Caption = 'Client Loan Products';
                    RunObject = Page "Client Loan Product Type list";
                }
                action("Client Loan Application")
                {
                    ApplicationArea = All;
                    Caption = 'Client Loan Application';
                    RunObject = Page "Client Loan Application List";
                }
            }
            group("Loan Management")
            {
                Caption = ' Loan Management';

                action("Loan Products")
                {
                    ApplicationArea = All;
                    Caption = 'Loan Products';
                    RunObject = Page "Client Loan Product Type list";
                }
                action("Loan Application")
                {
                    ApplicationArea = All;
                    Caption = ' Loan Application';
                    RunObject = Page "Client Loan Application List";
                }
            }
            group(HREmployeeManamentGroup)
            {
                Caption = 'Client Employee Management';
                Image = HumanResources;

                action(AllEmployees)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Management';
                    Image = Employee;
                    RunObject = Page "HR Employee List";
                }
                action(HREmployeesActive)
                {
                    Caption = 'All Active Staff';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Client Payroll List";
                    RunPageView = where(status = filter(<> inactive));
                }
                action(HREmployeesActive2)
                {
                    Caption = 'Board Members';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Client Payroll List";
                    RunPageView = where("Employee Group" = filter('BOARD'), Status = filter(Active));
                }
                action(HREmployeesActive3)
                {
                    Caption = 'Casual Staff';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Client Payroll List";
                    RunPageView = where("Employee Group" = filter('CASUALS'), Status = filter(Active));
                }
                action(HREmployeesActive4)
                {
                    Caption = 'Interdicted Staff';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Client Payroll List";
                    RunPageView = where(Status = filter(Active), status = filter(Interdicted));
                }
                action(HREmployeesInActive)
                {
                    Caption = 'In-Active Staff';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "Client Payroll List";
                    RunPageView = where(status = filter(Inactive));
                }
            }
        }
    }
}
