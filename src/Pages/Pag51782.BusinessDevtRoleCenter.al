page 51782 "Business Devt. Role Center"
{
    // version THL- HRM 1.0
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control1; "Sales & Relationship Mgr. Act.")
            {
                ApplicationArea = All;
            }
            part(Control16; "Team Member Activities")
            {
                ApplicationArea = All;
            }
            part(Control4; "Sales Pipeline Chart")
            {
                ApplicationArea = All;
            }
            part(Control6; "Opportunity Chart")
            {
                ApplicationArea = All;
            }
            part(Control11; "Relationship Performance")
            {
                ApplicationArea = All;
            }
            // part(Control2; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = All;
            // }
        }
    }
    actions
    {
        area(reporting)
        {
            action("Customer - &Order Summary")
            {
                ApplicationArea = All;
                Caption = 'Customer - &Order Summary';
                Image = "Report";
                RunObject = Report "Customer - Order Summary";
                ToolTip = 'View the quantity not yet shipped for each customer in three periods of 30 days each, starting from a selected date. There are also columns with orders to be shipped before and after the three periods and a column with the total order detail for each customer. The report can be used to analyze a company''s expected sales volume.';
            }
            action("Customer - &Top 10 List")
            {
                ApplicationArea = All;
                Caption = 'Customer - &Top 10 List';
                Image = "Report";
                RunObject = Report "Customer - Top 10 List";
                ToolTip = 'View which customers purchase the most or owe the most in a selected period. Only customers that have either purchases during the period or a balance at the end of the period will be included.';
            }
            separator(Separator17)
            {
            }
            action("S&ales Statistics")
            {
                ApplicationArea = All;
                Caption = 'S&ales Statistics';
                Image = "Report";
                RunObject = Report "Sales Statistics";
                ToolTip = 'View detailed information about sales to your customers.';
            }
            action("Salesperson - Sales &Statistics")
            {
                ApplicationArea = All;
                Caption = 'Salesperson - Sales &Statistics';
                Image = "Report";
                RunObject = Report "Salesperson - Sales Statistics";
                ToolTip = 'View amounts for sales, profit, invoice discount, and payment discount, as well as profit percentage, for each salesperson for a selected period. The report also shows the adjusted profit and adjusted profit percentage, which reflect any changes to the original costs of the items in the sales.';
            }
            action("Salesperson - &Commission")
            {
                ApplicationArea = All;
                Caption = 'Salesperson - &Commission';
                Image = "Report";
                RunObject = Report "Salesperson - Commission";
                ToolTip = 'View a list of invoices for each salesperson for a selected period. The following information is shown for each invoice: Customer number, sales amount, profit amount, and the commission on sales amount and profit amount. The report also shows the adjusted profit and the adjusted profit commission, which are the profit figures that reflect any changes to the original costs of the goods sold.';
            }
            separator(Separator22)
            {
            }
            action("Campaign - &Details")
            {
                ApplicationArea = All;
                Caption = 'Campaign - &Details';
                Image = "Report";
                RunObject = Report "Campaign - Details";
            }
        }
        area(embedding)
        {
            action("Time Sheets")
            {
                ApplicationArea = All;
                Caption = 'Time Sheets';
                Gesture = None;
                RunObject = Page "Time Sheet List";
                ToolTip = 'View all time sheets.';
            }
            action("Sales Quotes")
            {
                ApplicationArea = All;
                Caption = 'Sales Quotes';
                Image = Quote;
                RunObject = Page "Sales Quotes";
                ToolTip = 'Open the list of sales quotes where you offer items or services to customers.';
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Open the list of sales orders where you can sell items and services.';
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'Open the list of items that you trade in.';
            }
            action(Contacts)
            {
                ApplicationArea = All;
                Caption = 'Contacts';
                Image = CustomerContact;
                RunObject = Page "Contact List";
                ToolTip = 'View a list of all your contacts.';
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'Open the list of customers.';
            }
            action(Opportunities)
            {
                ApplicationArea = All;
                Caption = 'Opportunities';
                RunObject = Page "Opportunity List";
                ToolTip = 'View the sales opportunities that are handled by salespeople for the contact. Opportunities must involve a contact and can be linked to campaigns.';
            }
            action("Active Segments")
            {
                ApplicationArea = All;
                Caption = 'Active Segments';
                RunObject = Page "Segment List";
                ToolTip = 'View segments that are currently used in active campaigns.';
            }
            action("Logged Segments")
            {
                ApplicationArea = All;
                Caption = 'Logged Segments';
                RunObject = Page "Logged Segments";
                ToolTip = 'View a list of the segments that you have logged.';
            }
            action("Sales Cycles")
            {
                ApplicationArea = All;
                Caption = 'Sales Cycles';
                RunObject = Page "Sales Cycles";
                ToolTip = 'View the different sales cycles that you use to manage sales opportunities.';
            }
            action("Sales Persons")
            {
                ApplicationArea = All;
                Caption = 'Sales Persons';
                RunObject = Page "Salespersons/Purchasers";
                ToolTip = 'View a list of your sales people.';
            }
        }
        area(sections)
        {
            group(Sales)
            {
                Caption = 'Sales';
                Image = AdministrationSalesPurchases;

                action(Salespeople)
                {
                    ApplicationArea = All;
                    Caption = 'Salespeople';
                    RunObject = Page "Salespersons/Purchasers";
                    ToolTip = 'View a list of your sales people and your purchasers.';
                }
                action("Cust. Invoice Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Cust. Invoice Discounts';
                    RunObject = Page "Cust. Invoice Discounts";
                    ToolTip = 'View or edit invoice discounts that you grant to certain customers.';
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';

                action("Sales Analysis Reports")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Analysis Reports';
                    RunObject = Page "Analysis Report Sale";
                    ToolTip = 'Analyze the dynamics of your sales according to key sales performance indicators that you select, for example, sales turnover in both amounts and quantities, contribution margin, or progress of actual sales against the budget. You can also use the report to analyze your average sales prices and evaluate the sales performance of your sales force.';
                }
                action("Sales Analysis by Dimensions")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Analysis by Dimensions';
                    RunObject = Page "Analysis View List Sales";
                }
                action("Sales Budgets")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Budgets';
                    RunObject = Page "Budget Names Sales";
                }
                action(Action38)
                {
                    ApplicationArea = All;
                    Caption = 'Contacts';
                    Image = CustomerContact;
                    RunObject = Page "Contact List";
                    ToolTip = 'View a list of all your contacts.';
                }
                action(Action21)
                {
                    ApplicationArea = All;
                    Caption = 'Customers';
                    Image = Customer;
                    RunObject = Page "Customer List";
                    ToolTip = 'Open the list of customers.';
                }
            }
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

                action(Action84)
                {
                    ApplicationArea = All;
                    Caption = 'My Staff Profile';
                    Image = PersonInCharge;
                    RunObject = Page "SS Staff Profile";
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

                action(Action74)
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

                action(Action59)
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
                    RunPageView = where(Status = const(Open));
                }
                action("Imprests Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprests Pending Approval';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Imprests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Imprests';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const(Released));
                }
                action("UnSurrendered Cash")
                {
                    ApplicationArea = All;
                    Caption = 'UnSurrendered Cash';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Open), "Surrender Posted" = const(false));
                }
                action("Imprest Surrenders Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrenders Pending Approval';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(false));
                }
                action("Imprest Surrender")
                {
                    Caption = 'Imprest Surrender';
                    ApplicationArea = All;
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(true));
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
                action("Processed Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const(Released), Posted = const(true));
                }
            }
        }
        area(processing)
        {
            group(New)
            {
                Caption = 'New';

                action(NewContact)
                {
                    ApplicationArea = All;
                    Caption = 'Contact';
                    Image = AddContacts;
                    RunObject = Page "Contact Card";
                    RunPageMode = Create;
                    ToolTip = 'Create a new contact.';
                }
                action(NewOpportunity)
                {
                    ApplicationArea = All;
                    Caption = 'Opportunity';
                    Image = NewOpportunity;
                    RunObject = Page "Opportunity Card";
                    RunPageMode = Create;
                    ToolTip = 'View the sales opportunities that are handled by salespeople for the contact. Opportunities must involve a contact and can be linked to campaigns.';
                }
                action(NewSegment)
                {
                    ApplicationArea = All;
                    Caption = 'Segment';
                    Image = Segment;
                    RunObject = Page Segment;
                    RunPageMode = Create;
                    ToolTip = 'Create a new segment where you manage interactions with a contact.';
                }
            }
            group("Sales Prices")
            {
                Caption = 'Sales Prices';

                action("Sales Price &Worksheet")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Price &Worksheet';
                    Image = PriceWorksheet;
                    RunObject = Page "Sales Price Worksheet";
                    ToolTip = 'Change the unit price for one or more items or change the price agreement for one or more customers.';
                }
                action("Sales &Prices")
                {
                    ApplicationArea = All;
                    Caption = 'Sales &Prices';
                    Image = SalesPrices;
                    RunObject = Page "Sales Prices";
                    ToolTip = 'Define how to set up sales price agreements. These sales prices can be for individual customers, for a group of customers, for all customers, or for a campaign.';
                }
                action("Sales Line &Discounts")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Line &Discounts';
                    Image = SalesLineDisc;
                    RunObject = Page "Sales Line Discounts";
                    ToolTip = 'View the sales line discounts that are available. These discount agreements can be for individual customers, for a group of customers, for all customers or for a campaign.';
                }
            }
        }
    }
}
