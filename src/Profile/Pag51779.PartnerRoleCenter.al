page 51779 "Partner Role Center"
{
    // version THL- HRM 1.0
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'Business Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control16; "Payroll Activities")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = All;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                /*Commented by Henry*/
                //AccessByPermission = TableData "Assisted Setup"=R;
                ApplicationArea = All;
                Caption = '';
                ToolTip = 'Specifies the view of your business assistance';
            }
            part(Control46; "Team Member Activities")
            {
                ApplicationArea = All;
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
                        RunObject = Report Payslip;
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
                        RunObject = Report "Master Roll Report";
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
                        RunObject = Report "Monthly PAYE Report";
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
                        RunObject = Report Earnings;
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
                        RunObject = Report Deductions;
                    }
                    action("SHIF Report")
                    {
                        ApplicationArea = All;
                        Caption = 'SHIF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report SHIF;
                        ToolTip = 'View SHIF Report';
                    }
                    action("NSSF Report")
                    {
                        ApplicationArea = All;
                        Caption = 'NSSF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report NSSF;
                        ToolTip = 'View NSSF Report';
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
                        RunObject = Report "Bank Instruction Format 2";
                        ToolTip = 'Generate Instruction to the Bank';
                    }
                    action("Company Totals")
                    {
                        ApplicationArea = All;
                        Caption = 'Company Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Company Totals";
                        ToolTip = 'View the Company Totals Report';
                    }
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
                        RunObject = Report P9A;
                        ToolTip = 'View Employee P9A Report';
                    }
                }
                group("Staff Records")
                {
                    Caption = 'Staff Records';
                    Image = ReferenceData;

                    action("Employee Details")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee Details';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Employee Details";
                        ToolTip = 'View Employee Details';
                    }
                    action("Leave Balances")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Balances';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Leave Balance";
                        ToolTip = 'View Employee Leave Balances';
                    }
                    action("Outstanding Leave Days")
                    {
                        ApplicationArea = All;
                        Caption = 'Outstanding Leave Days';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Outstanding Leave Days";
                        ToolTip = 'View Outstanding Leave Days for all staff';
                    }
                    action("Staff On Leave")
                    {
                        ApplicationArea = All;
                        Caption = 'Staff On Leave';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Staff On Leave";
                        ToolTip = 'View Staff On Leave';
                    }
                    action("Leave Grant Paid")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Grant Paid';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Leave Grant Paid";
                        ToolTip = 'View Staff whose Leave grant has been paid';
                    }
                    action("Staff on Excuse Duty")
                    {
                        ApplicationArea = All;
                        Caption = 'Staff on Excuse Duty';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Excuse Duty";
                        ToolTip = 'View Staff on excuse duty';
                    }
                    action("Imprest Summary")
                    {
                        ApplicationArea = All;
                        Caption = 'Imprest Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Imprest Summary";
                    }
                    action("Petty Cash Summary")
                    {
                        ApplicationArea = All;
                        Caption = 'Petty Cash Summary';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Petty Cash Summary";
                    }
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';

            action("Employee Master")
            {
                ApplicationArea = All;
                Caption = 'Employee Master';
                RunObject = Page "Payroll Employee List";
                ToolTip = 'Open the list of employees.';
            }
            action("Requests to Approve")
            {
                ApplicationArea = All;
                Caption = 'Requests to Approve';
                Image = Approvals;
                RunObject = Page "Requests to Approve";
                ToolTip = 'View the number of approval requests that require your approval.';
            }
            action("Time Sheet Approval")
            {
                ApplicationArea = All;
                Caption = 'Time Sheet Approval';
                RunObject = Page "Manager Time Sheet List";
            }
            action("Store Items")
            {
                ApplicationArea = All;
                Caption = 'Store Items';
                RunObject = Page "Item List";
            }
            action(Jobs)
            {
                ApplicationArea = All;
                Caption = 'Jobs';
                RunObject = Page "Job List";
            }
            action(Resources)
            {
                ApplicationArea = All;
                Caption = 'Resources';
                RunObject = Page "Resource List";
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                RunObject = Page "Customer List";
            }
            action("Account Schedules")
            {
                ApplicationArea = All;
                Caption = 'Account Schedules';
                RunObject = Page "Account Schedule Names";
            }
            action("Chart of Accounts")
            {
                ApplicationArea = All;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
            }
            action(Budget)
            {
                ApplicationArea = All;
                Caption = 'Budget';
                RunObject = Page "G/L Budget Names";
            }
            action("Bank Accounts")
            {
                ApplicationArea = All;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
            }
            action("Fixed Assets")
            {
                ApplicationArea = All;
                Caption = 'Fixed Assets';
                RunObject = Page "Fixed Asset List";
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                RunObject = Page "Vendor List";
            }
            action("Company Documents")
            {
                ApplicationArea = All;
                Caption = 'Company Documents';
                Image = PersonInCharge;
                RunObject = Page "Company Documents";
            }
        }
        area(sections)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                ToolTip = 'Approve requests made by other users.';

                action(Action77)
                {
                    ApplicationArea = All;
                    Caption = 'Requests to Approve';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'View the number of approval requests that require your approval.';
                }
                action(Action30)
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheet Approval';
                    RunObject = Page "Manager Time Sheet List";
                }
            }
            group(ActionGroup35)
            {
                Caption = 'Staff Records';
                Image = HRSetup;
                ToolTip = 'All staff electronic records';

                action("My Staff Profile")
                {
                    ApplicationArea = All;
                    Caption = 'My Staff Profile';
                    Image = PersonInCharge;
                    RunObject = Page "SS Staff Profile";
                }
                action(Action34)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Master';
                    Image = PersonInCharge;
                    RunObject = Page "HR Employee List";
                    ToolTip = 'View the employee details';
                }
                action("Staff User Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Staff User Setup';
                    RunObject = Page "QuantumJumps User Setup";
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                Image = Capacities;
                ToolTip = 'All staff leave records';

                action("Create Leave Application for Employee")
                {
                    ApplicationArea = All;
                    Caption = 'Create Leave Application for Employee';
                    Image = PersonInCharge;
                    RunObject = Page "Leave Applications - Open";
                }
                action("Leave Applications Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications Pending Approval';
                    RunObject = Page "Leave Applications-Approval";
                }
                action("Approved Leave Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Applications';
                    RunObject = Page "Leave Applications-Approved";
                }
            }
            group("Internal Memos")
            {
                Caption = 'Internal Memos';
                Image = Alerts;
                ToolTip = 'Posting Internal Communication to Staff';

                action("New Internal Memo")
                {
                    ApplicationArea = All;
                    Caption = 'New Internal Memo';
                    Image = PersonInCharge;
                    RunObject = Page "Internal Memos - Open";
                }
                action("Posted Internal Memo")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Internal Memo';
                    RunObject = Page "Internal Memos - Posted";
                }
                action("Archived Internal Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Archived Internal Memos';
                    RunObject = Page "Internal Memos - Archived";
                }
            }
            group("Medical Covers Management")
            {
                Caption = 'Medical Covers Management';
                Image = CashFlow;
                ToolTip = 'Tracking Medical Cover Expenditure';

                action("Employee Medical Covers")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Medical Covers';
                    Image = PersonInCharge;
                    RunObject = Page "Employee Medical Covers";
                }
            }
            group("Project Management")
            {
                Caption = 'Project Management';
                Image = Job;
                ToolTip = 'Tracking Jobs and Resources';

                action(Action20)
                {
                    ApplicationArea = All;
                    Caption = 'Jobs';
                    RunObject = Page "Job List";
                }
                action(Action22)
                {
                    ApplicationArea = All;
                    Caption = 'Resources';
                    RunObject = Page "Resource List";
                }
                action("Time Sheets")
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheets';
                    RunObject = Page "Time Sheet List";
                }
                action(Action29)
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheet Approval';
                    RunObject = Page "Manager Time Sheet List";
                }
                action(Action27)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
            }
            group(CRM)
            {
                Caption = 'CRM';
                Image = Marketing;
                ToolTip = 'Customer Relationship Management';

                action(Action60)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
                action(Contacts)
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    Image = PersonInCharge;
                    RunObject = Page "Contact List";
                }
            }
            group("Management Reporting")
            {
                Caption = 'Management Reporting';
                Image = Payables;

                action(Action31)
                {
                    ApplicationArea = All;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                }
            }
            group("General Ledger")
            {
                Caption = 'General Ledger';
                Image = Ledger;

                action(Action68)
                {
                    ApplicationArea = All;
                    Caption = 'Chart of Accounts';
                    RunObject = Page "Chart of Accounts";
                }
                action(Action67)
                {
                    ApplicationArea = All;
                    Caption = 'Budget';
                    RunObject = Page "G/L Budget Names";
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                Image = Bank;

                action(Action51)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                }
            }
            group(Payroll)
            {
                Caption = 'Payroll';
                Image = ResourcePlanning;

                action(Action25)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Master';
                    RunObject = Page "Payroll Employee List";
                }
            }
            group(ActionGroup24)
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;

                action(Action23)
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                }
            }
            group(Receivables)
            {
                Caption = 'Receivables';
                Image = Receivables;

                action(Action11)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                }
                action("Sales Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Invoice';
                    RunObject = Page "Sales Invoice List";
                }
                action("Sales Credit Memo")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Credit Memo';
                    RunObject = Page "Sales Credit Memos";
                }
            }
            group(Payables)
            {
                Caption = 'Payables';
                Image = Payables;

                action(Action4)
                {
                    ApplicationArea = All;
                    Caption = 'Vendors';
                    RunObject = Page "Vendor List";
                }
                action("Purchase Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoice';
                    RunObject = Page "Purchase Invoices";
                }
                action("Purchase Credit Memo")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memo';
                    RunObject = Page "Purchase Credit Memos";
                }
            }
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Acess Services from HR Department';

                action("Time Sheet")
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheet';
                    RunObject = Page "Time Sheet List";
                }
                action("New Leave Application")
                {
                    ApplicationArea = All;
                    Caption = 'New Leave Application';
                    Image = PersonInCharge;
                    RunObject = Page "SS Leave Applications - Open";
                }
                action(Action112)
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications Pending Approval';
                    RunObject = Page "SS Leave Applications-Approval";
                }
                action(Action111)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Applications';
                    RunObject = Page "SS Leave Applications-Approved";
                }
                action("New Appraisal Form")
                {
                    ApplicationArea = All;
                    Caption = 'New Appraisal Form';
                    RunObject = Page "SS Appraisal List - Open";
                }
                action("Appraisal Forms Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Forms Pending Approval';
                    RunObject = Page "SS Appraisal List - Approval";
                }
                action("Approved Appraisal Forms")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Appraisal Forms';
                    RunObject = Page "SS Appraisal List - Approved";
                }
                action(Action107)
                {
                    ApplicationArea = All;
                    Caption = 'Internal Memos';
                    RunObject = Page "Internal Memos - Self Service";
                }
                action("New Medical Claim")
                {
                    ApplicationArea = All;
                    Caption = 'New Medical Claim';
                    RunObject = Page "SS Medical Claims - Open";
                }
                action("Medical Claims Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Claims Pending Approval';
                    RunObject = Page "SS Medical Claims - Approval";
                }
                action("Approved Medical Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Medical Claims';
                    RunObject = Page "SS Medical Claims - Approved";
                }
                action("New CSR Activity")
                {
                    ApplicationArea = All;
                    Caption = 'New CSR Activity';
                    RunObject = Page "SS CSR List - Open";
                }
                action("CSR Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'CSR Pending Approval';
                    RunObject = Page "SS CSR List - Approval";
                }
                action("Approved CSR")
                {
                    ApplicationArea = All;
                    Caption = 'Approved CSR';
                    RunObject = Page "SS CSR List - Approved";
                }
                action("New Training")
                {
                    ApplicationArea = All;
                    Caption = 'New Training';
                    RunObject = Page "SS Training List - Open";
                }
                action("Training Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Training Pending Approval';
                    RunObject = Page "SS Training List - Approval";
                }
                action("Approved Training")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Training';
                    RunObject = Page "SS Training List - Approved";
                }
                action("New Petty Cash Request")
                {
                    ApplicationArea = All;
                    Caption = 'New Petty Cash Request';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const(Open));
                }
                action("Petty Cash Requests Pending Aproval")
                {
                    ApplicationArea = All;
                    Caption = 'Petty Cash Requests Pending Aproval';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const(Released));
                }
                group("SS Archives")
                {
                    Caption = 'Archives';

                    action("Processed Petty Cash Requests")
                    {
                        ApplicationArea = All;
                        Caption = 'Processed Petty Cash Requests';
                        RunObject = Page "SS Petty Cash";
                        RunPageView = where(Status = const(Released), Posted = const(true));
                    }
                }
            }
        }
    }
}
