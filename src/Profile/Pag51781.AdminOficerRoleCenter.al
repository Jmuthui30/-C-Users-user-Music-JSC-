page 51781 "Admin Oficer Role Center"
{
    // version THL- HRM 1.0
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'Business Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
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

                group("My Reports")
                {
                    Caption = 'My Reports';
                    Image = ReferenceData;
                    Visible = false;

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
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';

            action("Time Sheet")
            {
                ApplicationArea = All;
                Caption = 'Time Sheet';
                RunObject = Page "Time Sheet List";
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
                action("Time Sheet Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Time Sheet Approval';
                    RunObject = Page "Manager Time Sheet List";
                }
            }
            group("My Staff Profile")
            {
                Caption = 'My Staff Profile';
                Image = HRSetup;
                ToolTip = 'All staff electronic records';

                action(Action34)
                {
                    ApplicationArea = All;
                    Caption = 'My Staff Profile';
                    Image = PersonInCharge;
                    RunObject = Page "SS Staff Profile";
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
                action("EFT Payments")
                {
                    ApplicationArea = All;
                    Caption = 'EFT Payments';
                    RunObject = Page "New EFT Entries";
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
                action("Unsettled Medical Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Unsettled Medical Claims';
                    RunObject = Page "Medical Claims - Unsettled";
                }
                action("Settled Medical Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Settled Medical Claims';
                    RunObject = Page "Medical Claims - Settled";
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
            group("Leave Management")
            {
                Caption = 'Leave Management';
                Image = Capacities;
                ToolTip = 'All staff leave records';

                action("New Leave Application")
                {
                    ApplicationArea = All;
                    Caption = 'New Leave Application';
                    Image = PersonInCharge;
                    RunObject = Page "SS Leave Applications - Open";
                }
                action("Leave Applications Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications Pending Approval';
                    RunObject = Page "SS Leave Applications-Approval";
                }
                action("Approved Leave Applications")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Applications';
                    RunObject = Page "SS Leave Applications-Approved";
                }
            }
            group("Performance Management")
            {
                Caption = 'Performance Management';
                Image = Statistics;
                ToolTip = 'Performance Appraisals Module';

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
            }
            group("Internal Memos")
            {
                Caption = 'Internal Memos';
                Image = Alerts;
                ToolTip = 'Posting Internal Communication to Staff';

                action(Action11)
                {
                    ApplicationArea = All;
                    Caption = 'Internal Memos';
                    RunObject = Page "Internal Memos - Self Service";
                }
            }
            group("Medical Covers Management")
            {
                Caption = 'Medical Covers Management';
                Image = CashFlow;
                ToolTip = 'Tracking Medical Cover Expenditure';

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
            }
            group("Employee CSR")
            {
                Caption = 'Employee CSR';
                Image = CostAccounting;
                ToolTip = 'Track Employee CSR Activities';

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
            }
            group("Training & Development")
            {
                Caption = 'Training & Development';
                Image = Marketing;
                ToolTip = 'Track Employee Training & Development';

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
                action("Training Needs Assesment")
                {
                    ApplicationArea = All;
                    Caption = 'Training Needs Assesment';
                    RunObject = Page "New Training Needs Assesment";
                }
            }
            group("Company Documents")
            {
                Caption = 'Company Documents';
                Image = RegisteredDocs;
                ToolTip = 'Electronics Document Management';

                action(Action102)
                {
                    ApplicationArea = All;
                    Caption = 'Company Documents';
                    Image = PersonInCharge;
                    RunObject = Page "Company Documents";
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
            group(Finance)
            {
                Caption = 'Finance';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Acess Services from HR Department';

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
                action("SS Approved Petty Cash Requests")
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
            }
        }
    }
    var
        UserSetup: Record "User Setup";
        NAVEmp: Record Employee;
}
