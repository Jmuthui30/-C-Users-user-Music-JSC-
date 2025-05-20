page 51793 "AL Finance, HR & Admin Manager"
{
    // version THL- HRM 1.0
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'Finance, HR and Admin Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control260; "Headline RC Business Manager")
            {
                ApplicationArea = All;
            }
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
            part("Favorite Accounts"; "My Accounts")
            {
                ApplicationArea = All;
                Caption = 'Favorite Accounts';
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
                action("Employee Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Groups';
                    Image = EmployeeAgreement;
                    RunObject = Page "Employee Groups";
                    RunPageMode = Edit;
                    ToolTip = 'Edit or Add new Emloyee Groups';
                }
                action("Payroll Periods")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Periods';
                    Image = PaymentPeriod;
                    RunObject = Page "Payroll Periods";
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Payroll Periods';
                }
                action(Earnings)
                {
                    ApplicationArea = All;
                    Caption = 'Earnings';
                    Image = PaymentJournal;
                    RunObject = Page Earnings;
                    RunPageMode = Edit;
                    ToolTip = 'Manage or Create new Employee Earnings';
                }
                action(Deductions)
                {
                    ApplicationArea = All;
                    Caption = 'Deductions';
                    Image = Receipt;
                    RunObject = Page Deductions;
                    RunPageMode = Edit;
                    ToolTip = 'Manage or create new earnings';
                }
                action("Bracket Tables")
                {
                    ApplicationArea = All;
                    Caption = 'Bracket Tables';
                    Image = Database;
                    RunObject = Page "Bracket Tables";
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
                        ApplicationArea = All;
                        Caption = 'Payroll Run';
                        Image = Calculate;
                        RunObject = Report "Payroll Calculator";
                        ToolTip = 'Calculate Payroll';
                    }
                    action("Email Payslips")
                    {
                        ApplicationArea = All;
                        Caption = 'Email Payslips';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Payslips";
                        ToolTip = 'Email Payslips';
                    }
                    action("Generate Payroll Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Payroll Journal';
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Transfer Journal to GL";
                    }
                    action("Create Employee Imprest Accounts")
                    {
                        ApplicationArea = All;
                        Caption = 'Create Employee Imprest Accounts';
                        RunObject = Report "Create Employee Customer AC";
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
                    action("Accounted Time")
                    {
                        ApplicationArea = All;
                        Caption = 'Accounted Time';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Time Sheet Entries";
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
                group("HR & Admin Reports")
                {
                    Caption = 'HR & Admin Reports';
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
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;

                action("Company Settings")
                {
                    ApplicationArea = All;
                    Caption = 'Company Settings';
                    Image = CompanyInformation;
                    RunObject = Page "Company Information";
                    ToolTip = 'Enter the company name, address, and bank information that will be inserted on your business documents.';
                }
                action("User Setup")
                {
                    ApplicationArea = All;
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
            }
            group("Journals ")
            {
                Caption = 'Journals ';
                Image = Ledger;

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
                action(PurchaseJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Purchases), Recurring = CONST(false));
                }
                action(SalesJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales), Recurring = CONST(false));
                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"), Recurring = CONST(false));
                }
                action(PaymentJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments), Recurring = CONST(false));
                }
                action(ICGeneralJournals)
                {
                    ApplicationArea = All;
                    Caption = 'IC General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Intercompany), Recurring = CONST(false));
                }
                action(GeneralJournals)
                {
                    ApplicationArea = All;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General), Recurring = CONST(false));
                }
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                Image = Bank;

                action("Bank Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                }
                action("Create New Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status = const(Open));
                }
                action("Payment Vouchers Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Vouchers Pending Approval';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Payment Vouchers")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Payment Vouchers';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status = const(Released));
                }
                action("Create New Cash Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Cash Receipt';
                    RunObject = Page "Receipts";
                    RunPageView = where(Posted = const(false));
                }
                action("Bank Reconciliation")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Reconciliation';
                    RunObject = Page "Bank Acc. Reconciliation List";
                }
                action("New Petty Cash Request")
                {
                    ApplicationArea = All;
                    Caption = 'New Petty Cash Request';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const(Open));
                }
                action("Petty Cash Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Petty Cash Pending Approval';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Requests';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const(Released));
                }
                action("Posted Petty Cash")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Petty Cash';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const(Released), Posted = const(true));
                }
                action("Unsettled Employee Medical Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Unsettled Employee Medical Claims';
                    RunObject = Page "Medical Claims - Unsettled";
                }
                action("Settled Employee Medical Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Settled Employee Medical Claims';
                    RunObject = Page "Medical Claims - Settled";
                }
                action("Imprests Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprests Pending Approval';
                    RunObject = Page "Imprests";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Imprests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Imprests';
                    RunObject = Page "Imprests";
                    RunPageView = where(Status = const(Released));
                }
                action("Unritired Cash")
                {
                    ApplicationArea = All;
                    Caption = 'UnSurrendered Cash';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = const(open), "Surrender Posted" = const(false));
                }
                action("Imprest Surrenders")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrenders';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(false));
                }
            }
            group("3rd Party Payrolls")
            {
                Caption = '3rd Party Payrolls';
                Image = Sales;
                ToolTip = 'Third Party Payroll Outsourcing Services';

                action(Clients)
                {
                    ApplicationArea = All;
                    Caption = 'Clients';
                    Image = PersonInCharge;
                    RunObject = Page "Client List";
                    ToolTip = 'View the client details';
                }
                action("Clients Payroll List")
                {
                    ApplicationArea = All;
                    Caption = 'Clients Payroll List';
                    RunObject = Page "Client Payroll List";
                }
                action("Import Employee Details")
                {
                    ApplicationArea = All;
                    Caption = 'Import Employee Details';
                    RunObject = Page "Employee Import";
                }
                action("Created Employee Details")
                {
                    ApplicationArea = All;
                    Caption = 'Created Employee Details';
                    RunObject = Page "Employee Import-Posted";
                }
                action(Action196)
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Periods';
                    RunObject = Page "Client Payroll Periods";
                }
                action("Outsourcing Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Outsourcing Setup';
                    RunObject = Page "Outsourcing Setup";
                }
                action("Earnings Master")
                {
                    ApplicationArea = All;
                    Caption = 'Earnings Master';
                    RunObject = Page "Earnings Master";
                }
                action("Deductions Master")
                {
                    ApplicationArea = All;
                    Caption = 'Deductions Master';
                    RunObject = Page "Deductions Master";
                }
                action(Action192)
                {
                    ApplicationArea = All;
                    Caption = 'Commercial Banks';
                    RunObject = Page "Commercial Banks";
                }
            }
            group("Management Reporting")
            {
                Caption = 'Management Reporting';
                Image = Payables;

                action("Account Schedules")
                {
                    ApplicationArea = All;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;

                action(Action187)
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                }
                action(Insurance)
                {
                    ApplicationArea = All;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets), Recurring = CONST(false));
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                }
                action("Insurance Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                }
                action("<Action3>")
                {
                    ApplicationArea = All;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General), Recurring = CONST(true));
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                }
            }
            group(Receivables)
            {
                Caption = 'Receivables';
                Image = Receivables;

                action(Customers)
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

                action(Vendors)
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
            group("Admin Operations")
            {
                Caption = 'Admin Operations';
                Image = LotInfo;
                ToolTip = 'Management of Administration Tasks';

                action("Store Items")
                {
                    ApplicationArea = All;
                    Caption = 'Store Items';
                    RunObject = Page "Item List";
                }
                action("New Store Transactions")
                {
                    ApplicationArea = All;
                    Caption = 'New Store Transactions';
                    RunObject = Page "Store Transactions-Open";
                }
                action("Posted Store Transactions")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Store Transactions';
                    RunObject = Page "Store Transactions-Posted";
                }
                action("New Purchase Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'New Purchase Requisition';
                    RunObject = Page "SS Purch Requisitions - Open";
                }
                action("Purchase Requisitions Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisitions Pending Approval';
                    RunObject = Page "Purch Requisitions - Pendin";
                }
                action("Approved Purchase Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Purchase Requisitions';
                    RunObject = Page "Purch Requisitions - Approv";
                }
                action("Closed Purchase Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Purchase Requisitions';
                    RunObject = Page "Purch Requisitions - Closed";
                }
                action("Vendors/Suppliers")
                {
                    ApplicationArea = All;
                    Caption = 'Vendors/Suppliers';
                    RunObject = Page "Vendor List";
                }
                action("Purchase Quotes")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Quotes';
                    RunObject = Page "Purchase Quotes";
                }
                action("Purchase Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Orders';
                    RunObject = Page "Purchase Order List";
                }
                action("Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                }
                action("Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page "Purchase Credit Memos";
                }
                action("Posted Purchase Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                }
                action("Posted Purchase Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
            }
            group("Employee Onboarding")
            {
                Caption = 'Employee Onboarding';
                Image = HumanResources;
                ToolTip = 'Handling of new staff joining the organization';

                action("Approved Positions")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Positions';
                    RunObject = Page "Pending Approval Positions";
                }
                action(MyRecruitRequests)
                {
                    ApplicationArea = All;
                    Caption = 'My Recruitment Requests';
                    RunObject = Page "SS Recruitment Requests";
                }
                action(MyRecruitRequestsNew)
                {
                    ApplicationArea = All;
                    Caption = 'New/Recalled';
                    RunObject = Page "SS Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Open), Rejected = CONST(false));
                }
                action(MyRecruitRequestsRejected)
                {
                    ApplicationArea = All;
                    Caption = 'Rejected';
                    RunObject = Page "SS Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Open), Rejected = CONST(true));
                }
                action(MyRecruitRequestsPending)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval';
                    RunObject = Page "SS Recruitment Requests";
                    RunPageView = WHERE(Status = CONST("Pending Approval"));
                }
                action(MyRecruitRequestsApproved)
                {
                    ApplicationArea = All;
                    Caption = 'Approved';
                    RunObject = Page "SS Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Released), Advertised = CONST(false));
                }
                action(MyRecruitRequestsAdvertised)
                {
                    ApplicationArea = All;
                    Caption = 'Advertised';
                    RunObject = Page "SS Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Released), Advertised = CONST(true), Closed = CONST(false));
                }
                action(MyRecruitRequestsClosed)
                {
                    ApplicationArea = All;
                    Caption = 'Closed';
                    RunObject = Page "SS Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Released), Advertised = CONST(true), Closed = CONST(true));
                }
                action(AllRecruitRequests)
                {
                    ApplicationArea = All;
                    Caption = 'All Recruitment Requests';
                    RunObject = Page "Recruitment Requests";
                }
                action(AllRecruitRequestsNew)
                {
                    ApplicationArea = All;
                    Caption = 'New/Recalled';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Open), Rejected = CONST(false));
                }
                action(AllRecruitRequestsRejected)
                {
                    ApplicationArea = All;
                    Caption = 'Rejected';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Open), Rejected = CONST(true));
                }
                action(AllRecruitRequestsPending)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = WHERE(Status = CONST("Pending Approval"));
                }
                action(AllRecruitRequestsApproved)
                {
                    ApplicationArea = All;
                    Caption = 'Approved';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Released), Advertised = CONST(false));
                }
                action(AllRecruitRequestsAdvertised)
                {
                    ApplicationArea = All;
                    Caption = 'Advertised';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Released), Advertised = CONST(true), Closed = CONST(false));
                }
                action(AllRecruitRequestsClosed)
                {
                    ApplicationArea = All;
                    Caption = 'Closed';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = WHERE(Status = CONST(Released), Advertised = CONST(true), Closed = CONST(true));
                }
                action("Applicant Master")
                {
                    ApplicationArea = All;
                    Caption = 'Applicant Master';
                    Image = PersonInCharge;
                    RunObject = Page "Applicant List";
                    ToolTip = 'View the applicants details';
                }
                action("Offers Made")
                {
                    ApplicationArea = All;
                    Caption = 'Offers Made';
                    RunObject = Page "Applicant List-Offer Made";
                }
                action("Offers Accepted")
                {
                    ApplicationArea = All;
                    Caption = 'Offers Accepted';
                    RunObject = Page "Applicant List-Offer Accepted";
                }
                action("Staff Orientation Checklist Awaiting Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Orientation Checklist Awaiting Approval';
                    RunObject = Page "Orientation List-Approval";
                }
                action("Approved Staff Orientation Checklist")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Staff Orientation Checklist';
                    RunObject = Page "Orientation List-Approved";
                }
                action("Reported to Work")
                {
                    ApplicationArea = All;
                    Caption = 'Reported to Work';
                    RunObject = Page "Applicant List-Reported";
                }
                action("Offers Rejected")
                {
                    ApplicationArea = All;
                    Caption = 'Offers Rejected';
                    RunObject = Page "Applicant List-Offer Rejected";
                }
            }
            group("Staff Records")
            {
                Caption = 'Staff Records';
                Image = HRSetup;
                ToolTip = 'All staff electronic records';

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
            group("Project Management")
            {
                Caption = 'Project Management';
                Image = Job;
                ToolTip = 'Tracking Jobs and Resources';

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
                action("Time Sheets")
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheets';
                    RunObject = Page "Time Sheet List";
                }
                action("Time Sheet Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheet Approval';
                    RunObject = Page "Manager Time Sheet List";
                }
                action(Action146)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
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
                action("Excuse Duty Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Excuse Duty Registration';
                    RunObject = Page "Excuse Duty Registration";
                }
            }
            group("Performance Management")
            {
                Caption = 'Performance Management';
                Image = Statistics;
                ToolTip = 'Performance Appraisals Module';

                action("AL Appraisal Forms Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal forms pending approval';
                    Image = PersonInCharge;
                    RunObject = Page "Appraisal List - Approval";
                }
                action("Approved Appraisal Forms")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Appraisal Forms';
                    RunObject = Page "Appraisal List - Approved";
                }
                action("Closed Appraisal Forms")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Appraisal Forms';
                    RunObject = Page "Appraisal List - Closed";
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
                action("Exhausted Medical Covers")
                {
                    ApplicationArea = All;
                    Caption = 'Exhausted Medical Covers';
                    RunObject = Page "Employee Medical Covers-Exhaus";
                }
                action("Medical Claims Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Claims Pending Approval';
                    RunObject = Page "Medical Claims - Approval";
                }
                action("Approved Medical Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Medical Claims';
                    RunObject = Page "Medical Claims - Approved";
                }
                action(Action74)
                {
                    ApplicationArea = All;
                    Caption = 'Unsettled Employee Medical Claims';
                    RunObject = Page "Medical Claims - Unsettled";
                }
                action("Historical Employee Medical Covers")
                {
                    ApplicationArea = All;
                    Caption = 'Historical Employee Medical Covers';
                    RunObject = Page "Employee Medical Covers-Closed";
                }
                action(Action84)
                {
                    ApplicationArea = All;
                    Caption = 'Settled Employee Medical Claims';
                    RunObject = Page "Medical Claims - Settled";
                }
            }
            group("Training & Development")
            {
                Caption = 'Training & Development';
                Image = Marketing;
                ToolTip = 'Track Employee Training & Development';

                action(Coaching)
                {
                    ApplicationArea = All;
                    Caption = 'Coaching';
                    RunObject = Page "Coaching List";
                }
                action("Training Needs Assesment")
                {
                    ApplicationArea = All;
                    Caption = 'Training Needs Assesment';
                    RunObject = Page "New Training Needs Assesment";
                }
                action("Training Nomination")
                {
                    ApplicationArea = All;
                    Caption = 'Training Nomination';
                    RunObject = Page "Training Nomination List";
                }
                action("Training Evaluation")
                {
                    ApplicationArea = All;
                    Caption = 'Training Evaluation';
                    RunObject = Page "Training Evaluation List";
                }
                action("Training Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Training Pending Approval';
                    Image = PersonInCharge;
                    RunObject = Page "Training List - Approval";
                }
                action("Approved Training")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Training';
                    RunObject = Page "Training List - Approved";
                }
            }
            group(HSE)
            {
                Caption = 'Incidence & Grievances';
                Image = Travel;
                ToolTip = 'Health, Safety and Environment Issues';

                action("New Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'New Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "Incidences/Grievances";
                    RunPageView = where(Status = const(New));
                }
                action("Reported Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'Reported Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "Incidences/Grievances";
                    RunPageView = where(Status = const(Reported));
                }
                action("Closed Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'Closed/Resolved Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "Incidences/Grievances";
                    RunPageView = where(Status = const(Closed));
                }
            }
            group("HR Setup")
            {
                Caption = 'HR Setup';
                Image = Setup;
                ToolTip = 'All hr module setups';

                action("Orientation Checklist Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Orientation Checklist Setup';
                    Image = PersonInCharge;
                    RunObject = Page "Orientation Checklist Setup";
                }
                action(Action26)
                {
                    ApplicationArea = All;
                    Caption = 'Staff User Setup';
                    RunObject = Page "QuantumJumps User Setup";
                }
                action(Action30)
                {
                    ApplicationArea = All;
                    Caption = 'HR Setup';
                    //RunObject = Page "QuantumJumps HR Setup";
                }
                action("Leave Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Setup';
                    RunObject = Page "Leave Setup";
                }
                action("Appraisal Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Setup';
                    RunObject = Page "Appraisal Setup";
                }
                action("Appraisal Questions")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Questions';
                    RunObject = Page "Appraisal Questions";
                }
                action("Appraisal Rating")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Rating';
                    RunObject = Page "Appraisal Rating";
                }
                action("Appraisal General Instructions")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal General Instructions';
                    RunObject = Page "Appraisal General Instructions";
                }
                action("Internal Memo Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Internal Memo Setup';
                    RunObject = Page "Internal Memo Setup";
                }
                action("Mail Distribution Lists")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Distribution Lists';
                    RunObject = Page "Mail Distribution Lists";
                }
                action("Medical Schemes")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Schemes';
                    RunObject = Page "Medical Schemes";
                }
                action("Medical Cover Limits")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Cover Limits';
                    RunObject = Page "Medical Cover Limits";
                }
                action("Medical Covers Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Medical Covers Setup';
                    RunObject = Page "Medical Covers Setup";
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

                action("Posted Payment Vouchers")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Payment Vouchers';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Posted = const(true));
                }
                action("Posted Cash Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Cash Receipts';
                    RunObject = Page "Receipts";
                    RunPageView = where(Posted = const(true));
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                }
                action(Action254)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("Issued Reminders")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Reminders';
                    Image = OrderReminder;
                    RunObject = Page "Issued Reminder List";
                }
                action("Issued Fin. Charge Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Fin. Charge Memos';
                    Image = PostedMemo;
                    RunObject = Page "Issued Fin. Charge Memo List";
                }
                action("G/L Registers")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Registers';
                    Image = GLRegisters;
                    RunObject = Page "G/L Registers";
                }
                action("Cost Accounting Registers")
                {
                    ApplicationArea = All;
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page "Cost Registers";
                }
                action("Cost Accounting Budget Registers")
                {
                    ApplicationArea = All;
                    Caption = 'Cost Accounting Budget Registers';
                    RunObject = Page "Cost Budget Registers";
                }
            }
            group("Finance Setup")
            {
                Caption = 'Finance Setup';
                Image = Administration;

                action(Currencies)
                {
                    ApplicationArea = All;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                }
                action("Accounting Periods")
                {
                    ApplicationArea = All;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                }
                action("Number Series")
                {
                    ApplicationArea = All;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                }
                action("Analysis Views")
                {
                    ApplicationArea = All;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                }
                action(Action103)
                {
                    ApplicationArea = All;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                }
                action(Dimensions)
                {
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page Dimensions;
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                }
                action("Bank Account Posting Groups")
                {
                    ApplicationArea = All;
                    Caption = 'Bank Account Posting Groups';
                    RunObject = Page "Bank Account Posting Groups";
                }
                action("Cash Management Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Cash Management Setup';
                    RunObject = Page "Cash Management Setup List";
                }
                action("Transaction Type")
                {
                    ApplicationArea = All;
                    Caption = 'Transaction Type';
                    RunObject = Page "Transaction Type";
                }
                action("Pay Mode")
                {
                    ApplicationArea = All;
                    Caption = 'Pay Mode';
                    RunObject = Page "Pay Mode";
                }
                action("Advanced Finance Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Advanced Finance Setup';
                    //RunObject = Page "Advanced Finance Setup";
                }
                action("Expense Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Expense Codes';
                    RunObject = Page "Expense Codes";
                }
                action("Employee Customer AC Mapping")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Customer AC Mapping';
                    RunObject = Page "Employee Customer AC Mapping";
                }
            }
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Acess Services from HR Department';

                action("My Staff Profile")
                {
                    ApplicationArea = All;
                    Caption = 'My Staff Profile';
                    RunObject = Page "SS Staff Profile";
                }
                action("Time Sheet")
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheet';
                    RunObject = Page "Time Sheet List";
                }
                action(Action133)
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
                action(Action22)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const(Released));
                }
                action("Processed Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const(Released), Posted = const(true));
                }
                action("New Imprest")
                {
                    ApplicationArea = All;
                    Caption = 'New Imprest';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const(Open));
                }
                action(Action184)
                {
                    ApplicationArea = All;
                    Caption = 'Imprests Pending Approval';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action(Action183)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Imprests';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const(Released));
                }
                action(Action182)
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Open), "Surrender Posted" = const(false));
                }
                action("Imprest Surrender Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrenders Pending Approval';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(false));
                }
                action("Closed Imprest Surrenders")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Imprest Surrenders';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(true));
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
                action(Action108)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Appraisal Forms';
                    RunObject = Page "SS Appraisal List - Approved";
                }
                action("Internal Memos")
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
                action(Action116)
                {
                    ApplicationArea = All;
                    Caption = 'Medical Claims Pending Approval';
                    RunObject = Page "SS Medical Claims - Approval";
                }
                action(Action117)
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
                action(Action122)
                {
                    ApplicationArea = All;
                    Caption = 'Training Pending Approval';
                    RunObject = Page "SS Training List - Approval";
                }
                action(Action123)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Training';
                    RunObject = Page "SS Training List - Approved";
                }
            }
        }
    }
}
