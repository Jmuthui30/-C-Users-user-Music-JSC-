page 52146 "Branch Manager Role Center"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control1904257908; "Resource Manager Activities")
                {
                    ApplicationArea = All;
                }
                part(Control1907692008; "My Customers")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                part(Control18; "Time Sheet Chart")
                {
                    ApplicationArea = All;
                }
                systempart(Control1901377608; MyNotes)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(reporting)
        {
            action("Resource &Statistics")
            {
                ApplicationArea = All;
                Caption = 'Resource &Statistics';
                Image = "Report";
                RunObject = Report "Resource Statistics";
            }
            action("Resource &Utilization")
            {
                ApplicationArea = All;
                Caption = 'Resource &Utilization';
                Image = "Report";
                RunObject = Report "Resource Usage";
            }
            action("Resource - &Price List")
            {
                ApplicationArea = All;
                Caption = 'Resource - &Price List';
                Image = "Report";
                RunObject = Report "Resource - List";
            }
            action("Resource - Cost &Breakdown")
            {
                ApplicationArea = All;
                Caption = 'Resource - Cost &Breakdown';
                Image = "Report";
                RunObject = Report "Resource - Cost Breakdown";
            }
        }
        area(embedding)
        {
            action(Resources)
            {
                ApplicationArea = All;
                Caption = 'Resources';
                RunObject = Page "Resource List";
            }
            action(ResourcesPeople)
            {
                ApplicationArea = All;
                Caption = 'People';
                RunObject = Page "Resource List";
                RunPageView = WHERE(Type=FILTER(Person));
            }
            action(ResourcesMachines)
            {
                ApplicationArea = All;
                Caption = 'Machines';
                RunObject = Page "Resource List";
                RunPageView = WHERE(Type=FILTER(Machine));
            }
            action("Resource Groups")
            {
                ApplicationArea = All;
                Caption = 'Resource Groups';
                RunObject = Page "Resource Groups";
            }
            action(ResourceJournals)
            {
                ApplicationArea = All;
                Caption = 'Resource Journals';
                RunObject = Page "Resource Jnl. Batches";
                RunPageView = WHERE(Recurring=CONST(false));
            }
            action(RecurringResourceJournals)
            {
                ApplicationArea = All;
                Caption = 'Recurring Resource Journals';
                RunObject = Page "Resource Jnl. Batches";
                RunPageView = WHERE(Recurring=CONST(true));
            }
            action(Jobs)
            {
                ApplicationArea = All;
                Caption = 'Jobs';
                Image = Job;
                RunObject = Page "Job List";
            }
            action("Time Sheets")
            {
                ApplicationArea = All;
                Caption = 'Time Sheets';
                RunObject = Page "Time Sheet List";
            }
            action("Manager Time Sheets")
            {
                ApplicationArea = All;
                Caption = 'Manager Time Sheets';
                RunObject = Page "Manager Time Sheet List";
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

                action(Action71)
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
                    Visible = false;
                }
                action("Create New Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status=const(Open));
                }
                action("Payment Vouchers Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Vouchers Pending Approval';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Payment Vouchers")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Payment Vouchers';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status=const(Released));
                    Visible = false;
                }
                action("Create New Cash Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Cash Receipt';
                    RunObject = Page "Receipts";
                    RunPageView = where(Posted=const(false));
                }
                action("Approved Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Requests';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status=const(Released));
                }
                action("Posted Petty Cash")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Petty Cash';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status=const(Released), Posted=const(true));
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

                action(Action60)
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

                action(Action45)
                {
                    ApplicationArea = All;
                    Caption = 'Company Documents';
                    Image = PersonInCharge;
                    RunObject = Page "Company Documents";
                }
            }
            group(Finance)
            {
                Caption = 'Finance';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Acess Services from HR Department';

                action("New Imprest")
                {
                    ApplicationArea = All;
                    Caption = 'New Imprest';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status=const(Open));
                }
                action("Imprests Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprests Pending Approval';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Imprests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Imprests';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status=const(Released));
                }
                action("UnSurrendered Cash")
                {
                    ApplicationArea = All;
                    Caption = 'UnSurrendered Cash';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status=const(Open), "Surrender Posted"=const(false));
                }
                action("Imprest Surrenders Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrenders Pending Approval';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status=const(Released), "Surrender Posted"=const(false));
                }
                action("Surrendered Imprest")
                {
                    Caption = 'Surrendered Imprest';
                    ApplicationArea = All;
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status=const(Released), "Surrender Posted"=const(true));
                }
                action("New Petty Cash Request")
                {
                    ApplicationArea = All;
                    Caption = 'New Petty Cash Request';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status=const(Open));
                }
                action("Petty Cash Requests Pending Aproval")
                {
                    ApplicationArea = All;
                    Caption = 'Petty Cash Requests Pending Aproval';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action(Action22)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status=const(Released));
                }
                action("Processed Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status=const(Released), Posted=const(true));
                }
            }
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;

                action("Resource Costs")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Costs';
                    RunObject = Page "Resource Costs";
                }
                action("Resource Prices")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Prices';
                    RunObject = Page "Resource Prices";
                }
                action("Resource Service Zones")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Service Zones';
                    Image = Resource;
                    RunObject = Page "Resource Service Zones";
                }
                action("Resource Locations")
                {
                    ApplicationArea = All;
                    Caption = 'Resource Locations';
                    Image = Resource;
                    RunObject = Page "Resource Locations";
                }
                action("Work Types")
                {
                    ApplicationArea = All;
                    Caption = 'Work Types';
                    RunObject = Page "Work Types";
                }
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
            Caption = 'Tasks';
            IsHeader = true;
            }
            action("Adjust R&esource Costs/Prices")
            {
                ApplicationArea = All;
                Caption = 'Adjust R&esource Costs/Prices';
                Image = "Report";
                RunObject = Report "Adjust Resource Costs/Prices";
            }
            action("Resource P&rice Changes")
            {
                ApplicationArea = All;
                Caption = 'Resource P&rice Changes';
                Image = ResourcePrice;
                RunObject = Page "Resource Price Changes";
            }
            action("Resource Pr&ice Chg from Resource")
            {
                ApplicationArea = All;
                Caption = 'Resource Pr&ice Chg from Resource';
                Image = "Report";
                RunObject = Report "Suggest Res. Price Chg. (Res.)";
            }
            action("Resource Pri&ce Chg from Prices")
            {
                ApplicationArea = All;
                Caption = 'Resource Pri&ce Chg from Prices';
                Image = "Report";
                RunObject = Report "Suggest Res. Price Chg.(Price)";
            }
            action("I&mplement Resource Price Changes")
            {
                ApplicationArea = All;
                Caption = 'I&mplement Resource Price Changes';
                Image = ImplementPriceChange;
                RunObject = Report "Implement Res. Price Change";
            }
            action("Create Time Sheets")
            {
                ApplicationArea = All;
                Caption = 'Create Time Sheets';
                Image = NewTimesheet;
                RunObject = Report "Create Time Sheets";
            }
        }
    }
}
