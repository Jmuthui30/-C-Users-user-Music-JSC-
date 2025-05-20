page 51908 "MD Role Center"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Managing Director';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control99; "Finance Performance")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control1902304208; "Account Manager Activities")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                chartpart(Control108; "Generic Charts")
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
            action("&G/L Trial Balance")
            {
                ApplicationArea = All;
                Caption = '&G/L Trial Balance';
                Image = "Report";
                RunObject = Report "Trial Balance";
                ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
            }
            action("&Bank Detail Trial Balance")
            {
                ApplicationArea = All;
                Caption = '&Bank Detail Trial Balance';
                Image = "Report";
                RunObject = Report "Bank Acc. - Detail Trial Bal.";
                ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
            }
            action("&Account Schedule")
            {
                ApplicationArea = All;
                Caption = '&Account Schedule';
                Image = "Report";
                RunObject = Report "Account Schedule";
                ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
            }
            action("Bu&dget")
            {
                ApplicationArea = All;
                Caption = 'Bu&dget';
                Image = "Report";
                RunObject = Report Budget;
                ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
            }
            action("Trial Bala&nce/Budget")
            {
                ApplicationArea = All;
                Caption = 'Trial Bala&nce/Budget';
                Image = "Report";
                RunObject = Report "Trial Balance/Budget";
                ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
            }
            action("Trial Balance by &Period")
            {
                ApplicationArea = All;
                Caption = 'Trial Balance by &Period';
                Image = "Report";
                RunObject = Report "Trial Balance by Period";
                ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
            }
            action("&Fiscal Year Balance")
            {
                ApplicationArea = All;
                Caption = '&Fiscal Year Balance';
                Image = "Report";
                RunObject = Report "Fiscal Year Balance";
                ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
            }
            action("Balance Comp. - Prev. Y&ear")
            {
                ApplicationArea = All;
                Caption = 'Balance Comp. - Prev. Y&ear';
                Image = "Report";
                RunObject = Report "Balance Comp. - Prev. Year";
                ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
            }
            action("&Closing Trial Balance")
            {
                ApplicationArea = All;
                Caption = '&Closing Trial Balance';
                Image = "Report";
                RunObject = Report "Closing Trial Balance";
                ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
            }
            separator(Separator49)
            {
            }
            action("Cash Flow Date List")
            {
                ApplicationArea = All;
                Caption = 'Cash Flow Date List';
                Image = "Report";
                RunObject = Report "Cash Flow Date List";
                ToolTip = 'View forecast entries for a period of time that you specify. The registered cash flow forecast entries are organized by source types, such as receivables, sales orders, payables, and purchase orders. You specify the number of periods and their length.';
            }
            separator(Separator115)
            {
            }
            action("Aged Accounts &Receivable")
            {
                ApplicationArea = All;
                Caption = 'Aged Accounts &Receivable';
                Image = "Report";
                RunObject = Report "Aged Accounts Receivable";
                ToolTip = 'View an overview of when your receivables from customers are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
            }
            action("Aged Accounts Pa&yable")
            {
                ApplicationArea = All;
                Caption = 'Aged Accounts Pa&yable';
                Image = "Report";
                RunObject = Report "Aged Accounts Payable";
                ToolTip = 'View an overview of when your payables to vendors are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
            }
            action("Reconcile Cus&t. and Vend. Accs")
            {
                ApplicationArea = All;
                Caption = 'Reconcile Cus&t. and Vend. Accs';
                Image = "Report";
                RunObject = Report "Reconcile Cust. and Vend. Accs";
                ToolTip = 'View if a certain general ledger account reconciles the balance on a certain date for the corresponding posting group. The report shows the accounts that are included in the reconciliation with the general ledger balance and the customer or the vendor ledger balance for each account and shows any differences between the general ledger balance and the customer or vendor ledger balance.';
            }
            separator(Separator53)
            {
            }
            action("&VAT Registration No. Check")
            {
                ApplicationArea = All;
                Caption = '&VAT Registration No. Check';
                Image = "Report";
                RunObject = Report "VAT Registration No. Check";
                ToolTip = 'Use an EU VAT number validation service to validated the VAT number of a business partner.';
            }
            action("VAT E&xceptions")
            {
                ApplicationArea = All;
                Caption = 'VAT E&xceptions';
                Image = "Report";
                RunObject = Report "VAT Exceptions";
                ToolTip = 'View the VAT entries that were posted and placed in a general ledger register in connection with a VAT difference. The report is used to document adjustments made to VAT amounts that were calculated for use in internal or external auditing.';
            }
            action("VAT &Statement")
            {
                ApplicationArea = All;
                Caption = 'VAT &Statement';
                Image = "Report";
                RunObject = Report "VAT Statement";
                ToolTip = 'View a statement of posted VAT and calculate the duty liable to the customs authorities for the selected period.';
            }
            action("VAT - VIES Declaration Tax Aut&h")
            {
                ApplicationArea = All;
                Caption = 'VAT - VIES Declaration Tax Aut&h';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Tax Auth";
                ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
            }
            action("VAT - VIES Declaration Dis&k")
            {
                ApplicationArea = All;
                Caption = 'VAT - VIES Declaration Dis&k';
                Image = "Report";
                RunObject = Report "VAT- VIES Declaration Disk";
                ToolTip = 'Report your sales to other EU countries or regions to the customs and tax authorities. If the information must be printed out on a printer, you can use the VAT- VIES Declaration Tax Auth report. The information is shown in the same format as in the declaration list from the customs and tax authorities.';
            }
            action("EC Sales &List")
            {
                ApplicationArea = All;
                Caption = 'EC Sales &List';
                Image = "Report";
                RunObject = Report "EC Sales List";
                ToolTip = 'Calculate VAT amounts from sales, and submit the amounts to a tax authority.';
            }
            separator(Separator60)
            {
            }
            separator(Separator4)
            {
            }
            action("Cost Accounting P/L Statement")
            {
                ApplicationArea = All;
                Caption = 'Cost Accounting P/L Statement';
                Image = "Report";
                RunObject = Report "Cost Acctg. Statement";
                ToolTip = 'View the credit and debit balances per cost type, together with the chart of cost types.';
            }
            action("CA P/L Statement per Period")
            {
                ApplicationArea = All;
                Caption = 'CA P/L Statement per Period';
                Image = "Report";
                RunObject = Report "Cost Acctg. Stmt. per Period";
                ToolTip = 'View profit and loss for cost types over two periods with the comparison as a percentage.';
            }
            action("CA P/L Statement with Budget")
            {
                ApplicationArea = All;
                Caption = 'CA P/L Statement with Budget';
                Image = "Report";
                RunObject = Report "Cost Acctg. Statement/Budget";
                ToolTip = 'View a comparison of the balance to the budget figures and calculates the variance and the percent variance in the current accounting period, the accumulated accounting period, and the fiscal year.';
            }
            action("Cost Accounting Analysis")
            {
                ApplicationArea = All;
                Caption = 'Cost Accounting Analysis';
                Image = "Report";
                RunObject = Report "Cost Acctg. Analysis";
                ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
            }
        }
        area(embedding)
        {
            action(Action2)
            {
                ApplicationArea = All;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'View the chart of accounts.';
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View a list of vendors that you can buy items from.';
            }
            action(VendorsBalance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action(PurchaseOrders)
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Open the list of ongoing purchase orders.';
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = All;
                Caption = 'Pending Confirmation';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersCommitted)
            {
                ApplicationArea = All;
                Caption = 'Committed';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Released), "Last Receiving No." = FILTER(''));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = All;
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Released), Receive = FILTER(true), "Completely Received" = FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action(PurchaseOrdersReceived)
            {
                ApplicationArea = All;
                Caption = 'Fully Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Released), "Last Receiving No." = FILTER(<> ''), Invoice = CONST(false));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action(PurchaseOrdersInvoiced)
            {
                ApplicationArea = All;
                Caption = 'Invoiced';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status = FILTER(Released), Invoice = CONST(true));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action(Budgets)
            {
                ApplicationArea = All;
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
                ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = All;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up your customers'' and vendors'' bank accounts. You can set up any number of bank accounts for each.';
            }
            action("VAT Statements")
            {
                ApplicationArea = All;
                Caption = 'VAT Statements';
                RunObject = Page "VAT Statement Names";
                ToolTip = 'View a statement of posted VAT and calculate the duty liable to the customs authorities for the selected period.';
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'Open the list of items that you trade in.';
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'Open the list of customers.';
            }
            action(CustomersBalance)
            {
                ApplicationArea = All;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
                ToolTip = 'Open the list of ongoing sales orders.';
            }
            action(Reminders)
            {
                ApplicationArea = All;
                Caption = 'Reminders';
                Image = Reminder;
                RunObject = Page "Reminder List";
                ToolTip = 'View the reminders that you have sent to customer because of late payment.';
            }
            action("Finance Charge Memos")
            {
                ApplicationArea = All;
                Caption = 'Finance Charge Memos';
                Image = FinChargeMemo;
                RunObject = Page "Finance Charge Memo List";
                ToolTip = 'View the list of finance charge memos that you have sent to customers.';
            }
            action("Incoming Documents")
            {
                ApplicationArea = All;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                ToolTip = 'View the list of incoming documents, such as vendor invoices in PDF, that you can manually or automatically create documents for, such as purchase invoices.';
            }
            action("EC Sales List")
            {
                ApplicationArea = All;
                Caption = 'EC Sales List';
                RunObject = Page "EC Sales List Reports";
                ToolTip = 'Prepare the EC Sales List report so you can submit VAT amounts to a tax authority.';
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
            group(Journals)
            {
                Caption = 'Journals';
                Image = Journals;

                action("Chart of Accounts")
                {
                    ApplicationArea = All;
                    Caption = 'Chart of Accounts';
                    RunObject = Page "Chart of Accounts";
                }
                action("New Contractual Commitments")
                {
                    ApplicationArea = All;
                    Caption = 'New Contractual Commitments';
                    RunObject = Page "Contract Commitments";
                    RunPageView = where(Commited = const(false));
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
                    ToolTip = 'Post purchase transactions directly to the general ledger. The purchase journal may already contain journal lines that are created as a result of related functions.';
                }
                action(SalesJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Sales), Recurring = CONST(false));
                    ToolTip = 'Post sales transactions directly to the general ledger. The sales journal may already contain journal lines that are created as a result of related functions.';
                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST("Cash Receipts"), Recurring = CONST(false));
                    ToolTip = 'Register received payments by applying them to the related customer, vendor, or bank ledger entries.';
                }
                action(PaymentJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Payments), Recurring = CONST(false));
                    ToolTip = 'Open the list of payment journals where you can register payments to vendors.';
                }
                action(ICGeneralJournals)
                {
                    ApplicationArea = All;
                    Caption = 'IC General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Intercompany), Recurring = CONST(false));
                    ToolTip = 'Post intercompany transactions. IC general journal lines must contain either an IC partner account or a customer or vendor account that has been assigned an intercompany partner code.';
                }
                action(GeneralJournals)
                {
                    ApplicationArea = All;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General), Recurring = CONST(false));
                    ToolTip = 'Open the list of general journal, for example, to record or post a payment that has no related document.';
                }
            }
            group(Travel)
            {
                Caption = 'Imprests';
                Image = Travel;

                action("ImprestsPending Approval")
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
                action("UnSurrendered Cash")
                {
                    ApplicationArea = All;
                    Caption = 'UnSurrendered Cash';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = const(open), "Surrender Posted" = const(false));
                }
                action("Unposted Imprest Surrenders")
                {
                    ApplicationArea = All;
                    Caption = 'Unposted Imprest Surrenders';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(false));
                }
                action("Closed Imprest Surrenders")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Imprest Surrenders';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(true));
                }
            }
            group("Staff Claim")
            {
                Caption = 'Staff Claim';
                Image = Calculator;

                action("Create New Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Staff Claim';
                    RunObject = Page "SS Staff Claims";
                    RunPageView = where(Status = const(Open));
                }
                action("Staff Claim Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Claim Pending Approval';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Staff Claim';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status = const(Released));
                }
                action("Posted Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Staff Claim';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status = const(Released), "Claim Posted" = const(true));
                }
            }
            group("Expense Claims")
            {
                Caption = 'Expense Claims';
                Image = CostAccounting;

                action("New Expense Claim Request")
                {
                    ApplicationArea = All;
                    Caption = 'New Expense Claim Request';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const(Open));
                }
                action("Expense Claim Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Expense Claim Pending Approval';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Expense Claim Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Expense Claim Requests';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const(Released));
                }
                action("Posted Expense Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Expense Claim';
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
            }
            group("Cash Management")
            {
                Caption = 'Cash Management';
                Image = Bank;

                action(Action134)
                {
                    ApplicationArea = All;
                    Caption = 'Bank Accounts';
                    Image = BankAccount;
                    RunObject = Page "Bank Account List";
                }
                action("New Requests for Payment")
                {
                    ApplicationArea = All;
                    Caption = 'New Payment Requests';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Status = const(Open));
                }
                action("Requests for Payment Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Requests Pending Approval';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Requests for Payment")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Payment Requests';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Status = const(Released));
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
                action("New EFT Entries")
                {
                    ApplicationArea = All;
                    Caption = 'New EFT Entries';
                    RunObject = Page "New EFT Entries";
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
                action("Project Details")
                {
                    ApplicationArea = All;
                    Caption = 'Project Details';
                    RunObject = Page "Project Details";
                }
                action("Project Report")
                {
                    ApplicationArea = All;
                    Caption = 'Project Report';
                    RunObject = Page "Project Report";
                }
                action("Analysis Views")
                {
                    ApplicationArea = All;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                }
                action("Status of Funds")
                {
                    ApplicationArea = All;
                    Caption = 'Status of Funds';
                    RunObject = Page "Status of Fund";
                }
            }
            group("Fixed Assets")
            {
                Caption = 'Fixed Assets';
                Image = FixedAssets;

                action(Action17)
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                    ToolTip = 'Manage periodic depreciation of your machinery or machines, keep track of your maintenance costs, manage insurance policies related to fixed assets, and monitor fixed asset statistics.';
                }
                action(Insurance)
                {
                    ApplicationArea = All;
                    Caption = 'Insurance';
                    RunObject = Page "Insurance List";
                    ToolTip = 'Manage insurance policies for fixed assets and monitor insurance coverage.';
                }
                action("Fixed Assets G/L Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets G/L Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(Assets), Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation, in integration with the general ledger. The FA G/L Journal is a general journal, which is integrated into the general ledger.';
                }
                action("Fixed Assets Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(false));
                    ToolTip = 'Post fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
                action("Fixed Assets Reclass. Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets Reclass. Journals';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ToolTip = 'Transfer, split, or combine fixed assets by preparing reclassification entries to be posted in the fixed asset journal.';
                }
                action("Insurance Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Insurance Journals';
                    RunObject = Page "Insurance Journal Batches";
                    ToolTip = 'Post entries to the insurance coverage ledger.';
                }
                action("<Action3>")
                {
                    ApplicationArea = All;
                    Caption = 'Recurring General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type" = CONST(General), Recurring = CONST(true));
                    ToolTip = 'Define how to post transactions that recur with few or no changes to general ledger, bank, customer, vendor, or fixed asset accounts';
                }
                action("Recurring Fixed Asset Journals")
                {
                    ApplicationArea = All;
                    Caption = 'Recurring Fixed Asset Journals';
                    RunObject = Page "FA Journal Batches";
                    RunPageView = WHERE(Recurring = CONST(true));
                    ToolTip = 'Post recurring fixed asset transactions, such as acquisition and depreciation book without integration to the general ledger.';
                }
            }
            group(Receivables)
            {
                Caption = 'Receivables';
                Image = Receivables;

                action(Action167)
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

                action(Action163)
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
            group("Inhouse Payroll")
            {
                Caption = 'Inhouse Payroll';
                Image = ResourcePlanning;

                action("Employee Master")
                {
                    ApplicationArea = All;
                    Caption = 'Employee Master';
                    RunObject = Page "Payroll Employee List";
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
                action("Payroll Periods")
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
                action("Commercial Banks")
                {
                    ApplicationArea = All;
                    Caption = 'Commercial Banks';
                    RunObject = Page "Commercial Banks";
                }
            }
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                Image = AdministrationSalesPurchases;

                action("My New Purchase Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'My New Purchase Requisition';
                    RunObject = Page "SS Purch Requisitions - Open";
                }
                action("My Purchase Requisitions Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'My Purchase Requisitions Pending Approval';
                    RunObject = Page "SS Purch Requisitions - Pendin";
                }
                action("My Approved Purchase Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'My Approved Purchase Requisitions';
                    RunObject = Page "SS Purch Requisitions - Approv";
                }
                action("My Fullfilled Purchase Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'My Fullfilled Purchase Requisitions';
                    RunObject = Page "SS Purch Requisitions - Closed";
                }
                action("New Imprest")
                {
                    ApplicationArea = All;
                    Caption = 'New Imprest';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const(Open));
                }
                action("Imprest Requests Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'IImprests Pending Approval';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("ApprovedCashAdvances")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Imprests';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const(Released));
                }
                action("UnSurrenderedCash")
                {
                    ApplicationArea = All;
                    Caption = 'UnSurrendered Cash';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Open), "Surrender Posted" = const(false));
                }
                action("Imprest Surrenders Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'ITO Imprest Surrenders Pending Approval';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(false));
                }
                action("CashRetirement")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(true));
                }
                action("My Staff Profile")
                {
                    ApplicationArea = All;
                    Caption = 'My Staff Profile';
                    RunObject = Page "SS Staff Profile";
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
                action("Processed Requests for Payment")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Requests for Payment';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Posted = const(true));
                }
                action("Contractual Commitments")
                {
                    ApplicationArea = All;
                    Caption = 'Contractual Commitments';
                    RunObject = Page "Contract Commitments";
                    RunPageView = where(Commited = const(false));
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
                action("Posted Purchase Invoices")
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
            group(Administration)
            {
                Caption = 'Administration';
                Image = Administration;

                action(Action84)
                {
                    ApplicationArea = All;
                    Caption = 'Commercial Banks';
                    RunObject = Page "Commercial Banks";
                }
                action(Currencies)
                {
                    ApplicationArea = All;
                    Caption = 'Currencies';
                    Image = Currency;
                    RunObject = Page Currencies;
                    ToolTip = 'View the different currencies that you trade in.';
                }
                action("Accounting Periods")
                {
                    ApplicationArea = All;
                    Caption = 'Accounting Periods';
                    Image = AccountingPeriods;
                    RunObject = Page "Accounting Periods";
                    ToolTip = 'Set up the number of accounting periods, such as 12 monthly periods, within the fiscal year and specify which period is the start of the new fiscal year.';
                }
                action("Number Series")
                {
                    ApplicationArea = All;
                    Caption = 'Number Series';
                    RunObject = Page "No. Series";
                    ToolTip = 'View or edit the number series that are used to organize transactions';
                }
                action(Action43)
                {
                    ApplicationArea = All;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action(Action93)
                {
                    ApplicationArea = All;
                    Caption = 'Account Schedules';
                    RunObject = Page "Account Schedule Names";
                    ToolTip = 'Open your account schedules to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
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
                    ToolTip = 'Set up posting groups, so that payments in and out of each bank account are posted to the specified general ledger account.';
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
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                ApplicationArea = All;
                Caption = 'Sales &Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }
            action("P&urchase Credit Memo")
            {
                ApplicationArea = All;
                Caption = 'P&urchase Credit Memo';
                Image = CreditMemo;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase credit memo so you can manage returned items to a vendor.';
            }
        }
        area(processing)
        {
            separator(Tasks)
            {
                Caption = 'Tasks';
                IsHeader = true;
            }
            action("Cas&h Receipt Journal")
            {
                ApplicationArea = All;
                Caption = 'Cas&h Receipt Journal';
                Image = CashReceiptJournal;
                RunObject = Page "Cash Receipt Journal";
                ToolTip = 'Apply received payments to the related non-posted sales documents.';
            }
            action("Pa&yment Journal")
            {
                ApplicationArea = All;
                Caption = 'Pa&yment Journal';
                Image = PaymentJournal;
                RunObject = Page "Payment Journal";
                ToolTip = 'Make payments to vendors.';
            }
            separator(Separator67)
            {
            }
            action("Analysis &Views")
            {
                ApplicationArea = All;
                Caption = 'Analysis &Views';
                Image = AnalysisView;
                RunObject = Page "Analysis View List";
                ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
            }
            action("Analysis by &Dimensions")
            {
                ApplicationArea = All;
                Caption = 'Analysis by &Dimensions';
                Image = AnalysisViewDimension;
                RunObject = Page "Analysis by Dimensions";
                ToolTip = 'Analyze activities using dimensions information.';
            }
            action("Calculate Deprec&iation")
            {
                ApplicationArea = All;
                Caption = 'Calculate Deprec&iation';
                Ellipsis = true;
                Image = CalculateDepreciation;
                RunObject = Report "Calculate Depreciation";
                ToolTip = 'Calculate depreciation according to the conditions that you define. If the fixed assets that are included in the batch job are integrated with the general ledger (defined in the depreciation book that is used in the batch job), the resulting entries are transferred to the fixed assets general ledger journal. Otherwise, the batch job transfers the entries to the fixed asset journal. You can then post the journal or adjust the entries before posting, if necessary.';
            }
            action("Import Co&nsolidation from Database")
            {
                ApplicationArea = All;
                Caption = 'Import Co&nsolidation from Database';
                Ellipsis = true;
                Image = ImportDatabase;
                RunObject = Report "Import Consolidation from DB";
                ToolTip = 'Import entries from the business units that will be included in a consolidation. You can use the batch job if the business unit comes from the same database in Dynamics NAV as the consolidated company.';
            }
            action("Bank Account R&econciliation")
            {
                ApplicationArea = All;
                Caption = 'Bank Account R&econciliation';
                Image = BankAccountRec;
                RunObject = Page "Bank Acc. Reconciliation";
                ToolTip = 'View the entries and the balance on your bank accounts against a statement from the bank.';
            }
            action("Payment Reconciliation Journals")
            {
                ApplicationArea = All;
                Caption = 'Payment Reconciliation Journals';
                Image = ApplyEntries;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Pmt. Reconciliation Journals";
                RunPageMode = View;
                ToolTip = 'Reconcile your bank account by importing transactions and applying them, automatically or manually, to open customer ledger entries, open vendor ledger entries, or open bank account ledger entries.';
            }
            action("Adjust E&xchange Rates")
            {
                ApplicationArea = All;
                Caption = 'Adjust E&xchange Rates';
                Ellipsis = true;
                Image = AdjustExchangeRates;
                //   RunObject = Report "Adjust Exchange Rates";
                ToolTip = 'Adjust general ledger, customer, vendor, and bank account entries to reflect a more updated balance if the exchange rate has changed since the entries were posted.';
            }
            action("P&ost Inventory Cost to G/L")
            {
                ApplicationArea = All;
                Caption = 'P&ost Inventory Cost to G/L';
                Image = PostInventoryToGL;
                RunObject = Report "Post Inventory Cost to G/L";
                ToolTip = 'Record the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
            }
            separator(Separator97)
            {
            }
            action("C&reate Reminders")
            {
                ApplicationArea = All;
                Caption = 'C&reate Reminders';
                Ellipsis = true;
                Image = CreateReminders;
                RunObject = Report "Create Reminders";
                ToolTip = 'Create reminders for one or more customers with overdue payments.';
            }
            action("Create Finance Charge &Memos")
            {
                ApplicationArea = All;
                Caption = 'Create Finance Charge &Memos';
                Ellipsis = true;
                Image = CreateFinanceChargememo;
                RunObject = Report "Create Finance Charge Memos";
                ToolTip = 'Create finance charge memos for one or more customers with overdue payments.';
            }
            separator(Separator73)
            {
            }
            action("Calc. and Pos&t VAT Settlement")
            {
                ApplicationArea = All;
                Caption = 'Calc. and Pos&t VAT Settlement';
                Image = SettleOpenTransactions;
                RunObject = Report "Calc. and Post VAT Settlement";
                ToolTip = 'Close open VAT entries and transfers purchase and sales VAT amounts to the VAT settlement account. For every VAT posting group, the batch job finds all the VAT entries in the VAT Entry table that are included in the filters in the definition window.';
            }
            separator(Separator80)
            {
                Caption = 'Administration';
                IsHeader = true;
            }
            action("General &Ledger Setup")
            {
                ApplicationArea = All;
                Caption = 'General &Ledger Setup';
                Image = Setup;
                RunObject = Page "General Ledger Setup";
                ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
            }
            action("&Sales && Receivables Setup")
            {
                ApplicationArea = All;
                Caption = '&Sales && Receivables Setup';
                Image = Setup;
                RunObject = Page "Sales & Receivables Setup";
                ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
            }
            action("&Purchases && Payables Setup")
            {
                ApplicationArea = All;
                Caption = '&Purchases && Payables Setup';
                Image = Setup;
                RunObject = Page "Purchases & Payables Setup";
                ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
            }
            action("&Fixed Asset Setup")
            {
                ApplicationArea = All;
                Caption = '&Fixed Asset Setup';
                Image = Setup;
                RunObject = Page "Fixed Asset Setup";
                ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
            }
            action("Cash Flow Setup")
            {
                ApplicationArea = All;
                Caption = 'Cash Flow Setup';
                Image = CashFlowSetup;
                RunObject = Page "Cash Flow Setup";
                ToolTip = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.';
            }
            action("Cost Accounting Setup")
            {
                ApplicationArea = All;
                Caption = 'Cost Accounting Setup';
                Image = CostAccountingSetup;
                RunObject = Page "Cost Accounting Setup";
                ToolTip = 'Specify how you transfer general ledger entries to cost accounting, how you link dimensions to cost centers and cost objects, and how you handle the allocation ID and allocation document number.';
            }
            separator(History)
            {
                Caption = 'History';
                IsHeader = true;
            }
            action("Navi&gate")
            {
                ApplicationArea = All;
                Caption = 'Navi&gate';
                Image = Navigate;
                RunObject = Page Navigate;
                ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
            }
        }
    }
}
