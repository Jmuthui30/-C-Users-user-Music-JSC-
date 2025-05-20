page 52153 "AL Finance Manager Role Center"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Accounting Manager', Comment = '{Dependency=Match,"ProfileDescription_ACCOUNTINGMANAGER"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control99; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control1902304208; "Accountant Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control1907692008; "My Accounts")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control103; "Trailing Sales Orders Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control106; "My Job Queue")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control9; "Help And Chart Wrapper")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specifies the view of your business assistance';
            }
            part(Control100; "Cash Flow Forecast Chart")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control108; "Report Inbox Part")
            {
                AccessByPermission = TableData "Report Inbox" = IMD;
                ApplicationArea = Basic, Suite;
            }
            // part(Control122; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
            part(Control123; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(reporting)
        {
            group("G/L Reports")
            {
                Caption = 'G/L Reports';

                action("&G/L Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&G/L Trial Balance';
                    Image = "Report";
                    RunObject = Report "Trial Balance";
                    ToolTip = 'View, print, or send a report that shows the balances for the general ledger accounts, including the debits and credits. You can use this report to ensure accurate accounting practices.';
                }
                action("&Bank Detail Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Bank Detail Trial Balance';
                    Image = "Report";
                    RunObject = Report "Bank Acc. - Detail Trial Bal.";
                    ToolTip = 'View, print, or send a report that shows a detailed trial balance for selected bank accounts. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("&Account Schedule")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Account Schedule';
                    Image = "Report";
                    RunObject = Report "Account Schedule";
                    ToolTip = 'Open an account schedule to analyze figures in general ledger accounts or to compare general ledger entries with general ledger budget entries.';
                }
                action("Bu&dget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bu&dget';
                    Image = "Report";
                    RunObject = Report Budget;
                    ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
                }
                action("Trial Bala&nce/Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Bala&nce/Budget';
                    Image = "Report";
                    RunObject = Report "Trial Balance/Budget";
                    ToolTip = 'View a trial balance in comparison to a budget. You can choose to see a trial balance for selected dimensions. You can use the report at the close of an accounting period or fiscal year.';
                }
                action("Trial Balance by &Period")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Trial Balance by &Period';
                    Image = "Report";
                    RunObject = Report "Trial Balance by Period";
                    ToolTip = 'Show the opening balance by general ledger account, the movements in the selected period of month, quarter, or year, and the resulting closing balance.';
                }
                action("&Fiscal Year Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Fiscal Year Balance';
                    Image = "Report";
                    RunObject = Report "Fiscal Year Balance";
                    ToolTip = 'View, print, or send a report that shows balance sheet movements for selected periods. The report shows the closing balance by the end of the previous fiscal year for the selected ledger accounts. It also shows the fiscal year until this date, the fiscal year by the end of the selected period, and the balance by the end of the selected period, excluding the closing entries. The report can be used at the close of an accounting period or fiscal year.';
                }
                action("Balance Comp. - Prev. Y&ear")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Balance Comp. - Prev. Y&ear';
                    Image = "Report";
                    RunObject = Report "Balance Comp. - Prev. Year";
                    ToolTip = 'View a report that shows your company''s assets, liabilities, and equity compared to the previous year.';
                }
                action("&Closing Trial Balance")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Closing Trial Balance';
                    Image = "Report";
                    RunObject = Report "Closing Trial Balance";
                    ToolTip = 'View, print, or send a report that shows this year''s and last year''s figures as an ordinary trial balance. The closing of the income statement accounts is posted at the end of a fiscal year. The report can be used in connection with closing a fiscal year.';
                }
                action("Dimensions - Total")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions - Total';
                    Image = "Report";
                    RunObject = Report "Dimensions - Total";
                    ToolTip = 'View how dimensions or dimension sets are used on entries based on total amounts over a specified period and for a specified analysis view.';
                }
            }
            group("Cash Flow")
            {
                Caption = 'Cash Flow';

                action("Cash Flow Date List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Date List';
                    Image = "Report";
                    RunObject = Report "Cash Flow Date List";
                    ToolTip = 'View forecast entries for a period of time that you specify. The registered cash flow forecast entries are organized by source types, such as receivables, sales orders, payables, and purchase orders. You specify the number of periods and their length.';
                }
            }
            group("Customers and Vendors")
            {
                Caption = 'Customers and Vendors';

                action("Aged Accounts &Receivable")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts &Receivable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Receivable";
                    ToolTip = 'View an overview of when your receivables from customers are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("Aged Accounts Pa&yable")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Aged Accounts Pa&yable';
                    Image = "Report";
                    RunObject = Report "Aged Accounts Payable";
                    ToolTip = 'View an overview of when your payables to vendors are due or overdue (divided into four periods). You must specify the date you want aging calculated from and the length of the period that each column will contain data for.';
                }
                action("Reconcile Cus&t. and Vend. Accs")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Reconcile Cus&t. and Vend. Accs';
                    Image = "Report";
                    RunObject = Report "Reconcile Cust. and Vend. Accs";
                    ToolTip = 'View if a certain general ledger account reconciles the balance on a certain date for the corresponding posting group. The report shows the accounts that are included in the reconciliation with the general ledger balance and the customer or the vendor ledger balance for each account and shows any differences between the general ledger balance and the customer or vendor ledger balance.';
                }
            }
            group("VAT Reports")
            {
                Caption = 'VAT Reports';

                action("&VAT Registration No. Check")
                {
                    ApplicationArea = VAT;
                    Caption = '&VAT Registration No. Check';
                    Image = "Report";
                    RunObject = Report "VAT Registration No. Check";
                    ToolTip = 'Use an EU VAT number validation service to validated the VAT number of a business partner.';
                }
                action("VAT E&xceptions")
                {
                    ApplicationArea = VAT;
                    Caption = 'VAT E&xceptions';
                    Image = "Report";
                    RunObject = Report "VAT Exceptions";
                    ToolTip = 'View the VAT entries that were posted and placed in a general ledger register in connection with a VAT difference. The report is used to document adjustments made to VAT amounts that were calculated for use in internal or external auditing.';
                }
                action("VAT &Statement")
                {
                    ApplicationArea = VAT;
                    Caption = 'VAT &Statement';
                    Image = "Report";
                    RunObject = Report "VAT Statement";
                    ToolTip = 'View a statement of posted VAT and calculate the duty liable to the customs authorities for the selected period.';
                }
                action("VAT - VIES Declaration Tax Aut&h")
                {
                    ApplicationArea = BasicEU;
                    Caption = 'VAT - VIES Declaration Tax Aut&h';
                    Image = "Report";
                    RunObject = Report "VAT- VIES Declaration Tax Auth";
                    ToolTip = 'View information to the customs and tax authorities for sales to other EU countries/regions. If the information must be printed to a file, you can use the VAT- VIES Declaration Disk report.';
                }
                action("VAT - VIES Declaration Dis&k")
                {
                    ApplicationArea = BasicEU;
                    Caption = 'VAT - VIES Declaration Dis&k';
                    Image = "Report";
                    RunObject = Report "VAT- VIES Declaration Disk";
                    ToolTip = 'Report your sales to other EU countries or regions to the customs and tax authorities. If the information must be printed out on a printer, you can use the VAT- VIES Declaration Tax Auth report. The information is shown in the same format as in the declaration list from the customs and tax authorities.';
                }
                action("EC Sales &List")
                {
                    Visible = false;
                    ApplicationArea = BasicEU;
                    Caption = 'EC Sales &List';
                    Image = "Report";
                    RunObject = Report "EC Sales List";
                    ToolTip = 'Calculate VAT amounts from sales, and submit the amounts to a tax authority.';
                }
            }
            group("Cost Accounting")
            {
                Caption = 'Cost Accounting';

                action("Cost Accounting P/L Statement")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting P/L Statement';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement";
                    ToolTip = 'View the credit and debit balances per cost type, together with the chart of cost types.';
                }
                action("CA P/L Statement per Period")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'CA P/L Statement per Period';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Stmt. per Period";
                    ToolTip = 'View profit and loss for cost types over two periods with the comparison as a percentage.';
                }
                action("CA P/L Statement with Budget")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'CA P/L Statement with Budget';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Statement/Budget";
                    ToolTip = 'View a comparison of the balance to the budget figures and calculates the variance and the percent variance in the current accounting period, the accumulated accounting period, and the fiscal year.';
                }
                action("Cost Accounting Analysis")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Analysis';
                    Image = "Report";
                    RunObject = Report "Cost Acctg. Analysis";
                    ToolTip = 'View balances per cost type with columns for seven fields for cost centers and cost objects. It is used as the cost distribution sheet in Cost accounting. The structure of the lines is based on the chart of cost types. You define up to seven cost centers and cost objects that appear as columns in the report.';
                }
            }
            group(Reports)
            {
                Caption = 'Reports';

                group("Financial Statements")
                {
                    Caption = 'Financial Statements';
                    Image = ReferenceData;

                    action("Balance Sheet")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Balance Sheet";
                        ToolTip = 'View a report that shows your company''s assets, liabilities, and equity.';
                    }
                    action("Income Statement")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Income Statement";
                        ToolTip = 'View a report that shows your company''s income and expenses.';
                    }
                    action("Statement of Cash Flows")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Cash Flows';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Statement of Cashflows";
                        ToolTip = 'View a financial statement that shows how changes in balance sheet accounts and income affect the company''s cash holdings, displayed for operating, investing, and financing activities respectively.';
                    }
                    action("Statement of Retained Earnings")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Statement of Retained Earnings';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Retained Earnings Statement";
                        ToolTip = 'View a report that shows your company''s changes in retained earnings for a specified period by reconciling the beginning and ending retained earnings for the period, using information such as net income from the other financial statements.';
                    }
                }
                group("Excel Reports")
                {
                    Caption = 'Excel Reports';
                    Image = Excel;

                    action(ExcelTemplatesBalanceSheet)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Balance Sheet';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Balance Sheet";
                        ToolTip = 'Open a spreadsheet that shows your company''s assets, liabilities, and equity.';
                    }
                    action(ExcelTemplateIncomeStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Income Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Income Stmt.";
                        ToolTip = 'Open a spreadsheet that shows your company''s income and expenses.';
                    }
                    action(ExcelTemplateCashFlowStmt)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Cash Flow Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template CashFlow Stmt.";
                        ToolTip = 'Open a spreadsheet that shows how changes in balance sheet accounts and income affect the company''s cash holdings.';
                    }
                    action(ExcelTemplateRetainedEarn)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Retained Earnings Statement';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Retained Earn.";
                        ToolTip = 'Open a spreadsheet that shows your company''s changes in retained earnings based on net income from the other financial statements.';
                    }
                    action(ExcelTemplateTrialBalance)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Trial Balance';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Trial Balance";
                        ToolTip = 'Open a spreadsheet that shows a summary trial balance by account.';
                    }
                    action(ExcelTemplateAgedAccPay)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Payable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Pay.";
                        ToolTip = 'Open a spreadsheet that shows a list of aged remaining balances for each vendor by period.';
                    }
                    action(ExcelTemplateAgedAccRec)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Aged Accounts Receivable';
                        Image = "Report";
                        RunObject = Codeunit "Run Template Aged Acc. Rec.";
                        ToolTip = 'Open a spreadsheet that shows when customer payments are due or overdue by period.';
                    }
                }
                action("Run Consolidation")
                {
                    ApplicationArea = Suite;
                    Caption = 'Run Consolidation';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Run the Consolidation report.';
                }
            }
        }
        area(embedding)
        {
            action(ChartofAccounts)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
            }
            action(Prepayments)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Prepayments';
                RunObject = Page "Prepayments List";
            }
            action(AccruedExpenses)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Accrued Expenses';
                RunObject = Page "Accrued Expenses List";
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action("Incoming Documents")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action(CustomersBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action(Vendors)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View or edit detailed information for the vendors that you trade with. From each vendor card, you can open related information, such as purchase statistics and ongoing orders, and you can define special prices and line discounts that the vendor grants you if certain conditions are met.';
            }
            action(VendorsBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Vendor List";
                RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Purchase Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action("Purchase Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                Image = Invoice;
                RunObject = Page "Purchase Invoices";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(RequestsforPayment)
            {
                ApplicationArea = All;
                Caption = 'Payment Requests';
                RunObject = Page "Payment Requests";
            }
            action(NewRequestsForPayment)
            {
                ApplicationArea = All;
                Caption = 'New Payment Request';
                RunObject = Page "Payment Requests";
                RunPageView = where(Status = const(Open));
            }
            action(RequestsForPaymentPendingApproval)
            {
                ApplicationArea = All;
                Caption = 'Payment Requests Pending Approval';
                RunObject = Page "Payment Requests";
                RunPageView = where(Status = const("Pending Approval"));
            }
            action(ApprovedRequestsForPayment)
            {
                ApplicationArea = All;
                Caption = 'Approved RPayment Requests';
                RunObject = Page "Payment Requests";
                RunPageView = where(Status = const(Released), Posted = const(false));
            }
            action(ProcessedRequestsForPayment)
            {
                ApplicationArea = All;
                Caption = 'Processed Payment Requests';
                RunObject = Page "Payment Requests";
                RunPageView = where(Status = const(Released), Posted = const(true));
            }
            action(PaymentVourcher)
            {
                ApplicationArea = All;
                Caption = 'Payment Vourchers';
                RunObject = Page "Payment Voucher List";
            }
            action(CreatePaymentVourcher)
            {
                ApplicationArea = All;
                Caption = 'Create Payment Vourcher';
                RunObject = Page "Payment Voucher List";
                RunPageView = where(Status = const(Open));
            }
            action(PendingApprovalPaymentVoucher)
            {
                ApplicationArea = All;
                Caption = 'Pending Approval Payment Voucher';
                RunObject = Page "Payment Voucher List";
                RunPageView = where(Status = const("Pending Approval"));
            }
            action(ApprovedUnpostedPaymentVoucher)
            {
                ApplicationArea = All;
                Caption = 'Approved & Unposted Payment Voucher';
                RunObject = Page "Payment Voucher List";
                RunPageView = where(Status = const(Released), Posted = const(false));
            }
            action(PostedPaymentVoucher)
            {
                ApplicationArea = All;
                Caption = 'Posted Payment Voucher';
                RunObject = Page "Payment Voucher List";
                RunPageView = where(Posted = const(true));
            }
            action("VAT Returns")
            {
                ApplicationArea = VAT;
                Caption = 'VAT Returns';
                RunObject = Page "VAT Report List";
                ToolTip = 'Prepare the VAT Return report so you can submit VAT amounts to a tax authority.';
            }
            action(Budgets)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Budgets';
                RunObject = Page "G/L Budget Names";
                ToolTip = 'View or edit estimated amounts for a range of accounting periods.';
            }
            action("VAT Statements")
            {
                ApplicationArea = VAT;
                Caption = 'VAT Statements';
                Image = VATStatement;
                RunObject = Page "VAT Statement Names";
                ToolTip = 'View a statement of posted VAT amounts, calculate your VAT settlement amount for a certain period, such as a quarter, and prepare to send the settlement to the tax authorities.';
            }
            action("New EFT Entries")
            {
                ApplicationArea = All;
                Caption = 'New EFT Entries';
                RunObject = Page "New EFT Entries";
            }
            action("Bank Reconciliation")
            {
                ApplicationArea = All;
                Caption = 'Bank Reconciliation';
                RunObject = Page "Bank Acc. Reconciliation List";
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
            group("Journals ")
            {
                Caption = 'Journals ';
                Image = Ledger;

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
            group(BudgetPlanning)
            {
                Caption = 'Budget Planning';

                action("Staff Organization Mapping")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Organization Mapping';
                    RunObject = Page "Staff Organization Mappings";
                }
                action("Staff Based Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Based Budget';
                    RunObject = Page "SS Staff Based Budget Headers";
                }
                action("Global Staff Based Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Global Staff Based Budget';
                    RunObject = Page "Staff Based Budget Headers";
                }
                action("Budget Distribution")
                {
                    ApplicationArea = All;
                    Caption = 'Budget Distribution';
                    RunObject = Page "Budget Distribution";
                }
                action("Draft Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Draft Budget';
                    RunObject = Page "Budget Holder Draft Budgets";
                }
                action("Approved Budget")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Approved Budget';
                    RunObject = Page "Budget Holder Approved Budgets";
                    ToolTip = 'Prepare, View and Track your Budget Here';
                }
                action("Budget Categories")
                {
                    ApplicationArea = All;
                    Caption = 'Budget Categories';
                    RunObject = Page "Budget Categories";
                }
                action("Budget Category Distribution")
                {
                    ApplicationArea = All;
                    Caption = 'Budget Category Distribution';
                    RunObject = Page "Budget Category Dist. List";
                }
                action("Global Draft Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Global Draft Budget';
                    RunObject = Page "Global Draft Budgets";
                }
                action("Global Approved Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Global Approved Budget';
                    RunObject = Page "G/L Budget Names";
                }
                action("Open Supplimentary Budget Requests")
                {
                    ApplicationArea = All;
                    Caption = 'New Supplementary Budget Requests';
                    RunObject = Page "Supplementary Budget Requests";
                    RunPageView = where(Status = const(Open));
                }
                action("Supplimentary Budget Requests Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Supplementary Budget Requests Approval';
                    RunObject = Page "Supplementary Budget Requests";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Supplimentary Budget Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Supplementary Budget Requests';
                    RunObject = Page "Supplementary Budget Requests";
                    RunPageView = where(Status = const(Released), Effected = const(false));
                }
                action("Effected Supplimentary Budget Requests")
                {
                    ApplicationArea = All;
                    Caption = ' Effected Supplementary Budget Requests';
                    RunObject = Page "Supplementary Budget Requests";
                    RunPageView = where(Status = const(Released), Effected = const(true));
                }
                action("Budget Planning")
                {
                    ApplicationArea = All;
                    Caption = 'Budget Planning';
                    Image = LedgerBudget;
                    RunObject = Page "G/L Budget Names";
                }
            }
            group("Petty Cash")
            {
                Caption = 'Petty Cash';
                Image = CostAccounting;

                action("New Expense Claim Request")
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
                action("Approved PettyCash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Requests';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const(Released), Posted = const(false));
                }
                action("Posted Petty Cash")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Petty Cash';
                    RunObject = Page "Petty Cash";
                    RunPageView = where(Status = const(Released), Posted = const(true));
                }
            }
            group(CashAdvances)
            {
                Caption = 'Imprests';
                Image = Travel;

                action("Imprest Memo")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Memo';
                    RunObject = Page "Imprest Memo List";
                }
                action("Imprest Memo Open")
                {
                    ApplicationArea = All;
                    Caption = 'Open';
                    RunObject = Page "Imprest Memo List";
                    RunPageView = where(Status = const(Open));
                }
                action("Imprest Memo Pending")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval';
                    RunObject = Page "Imprest Memo List";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Imprest Memo Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Approved';
                    RunObject = Page "Imprest Memo List";
                    RunPageView = where(Status = const(Released));
                }
                action("New Imprests")
                {
                    ApplicationArea = All;
                    Caption = 'New Imprests';
                    RunObject = Page "Imprests";
                    RunPageView = where(Status = const(Open));
                }
                action("Pending Approval Imprests")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval Imprests';
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
                action("UnSurrendered Expenses")
                {
                    ApplicationArea = All;
                    Caption = 'UnSurrendered Cash';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = filter(Open | Rejected), "Surrender Posted" = const(false));
                }
            }
            group(CashRetirement)
            {
                Caption = 'Imprest Surrender';
                Image = Travel;

                action("Imprest Surrender Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrender Approval';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = const("Pending Approval"), "Surrender Posted" = const(false));
                }
                action("Unposted Imprest Surrender")
                {
                    ApplicationArea = All;
                    Caption = 'Unposted Imprest Surrender';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(false));
                }
                action("Posted Imprest Surrenders")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Imprest Surrenders';
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
                    Caption = 'New Staff Claim';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status = const(Open));
                }
                action("Staff Claim Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Claim Approvals';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Staff Claim';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status = const(Released), "Claim Posted" = const(false));
                }
                action("Posted Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Staff Claim';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status = const(Released), "Claim Posted" = const(true));
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
                action(Vendors_bl)
                {
                    ApplicationArea = All;
                    Caption = 'Balance';
                    Image = Balance;
                    RunObject = Page "Vendor List";
                    RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
                }
                action("Purchase Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoice';
                    RunObject = Page "Purchase Invoices";
                }
                action("Posted Purchase Invoice")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoice';
                    RunObject = Page "Posted Purchase Invoices";
                }
                action("Payment Request Review")
                {
                    ApplicationArea = All;
                    RunObject = Page "Payment Request Review";
                }
                action("Purchase Credit Memo")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memo';
                    RunObject = Page "Purchase Credit Memos";
                }
            }
            group("Requests For Payment")
            {
                Caption = 'Payment Requests';
                Image = Bank;

                action(PaymentRequestReview)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Request Review';
                    RunObject = Page "Payment Request Review";
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
                    RunPageView = where(Status = const(Released), Posted = const(false));
                }
                action("Processed Req for Payment")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Payment Requests';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Status = const(Released), Posted = const(true));
                }
            }
            group("Payment Voucher")
            {
                Caption = 'Payment Voucher';

                action("Create Payment Vourcher")
                {
                    ApplicationArea = All;
                    Caption = 'Create Payment Vourcher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status = const(Open));
                }
                action("Pending Approval Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved & Unposted Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Approved & Unposted Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status = const(Released), Posted = const(false));
                }
                action("Posted Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Posted = const(true));
                }
                action("Payment Vouchers sent to EFT")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Vouchers sent to EFT';
                    RunObject = Page "Payment Voucher List";
                    RunPageMode = View;
                    RunPageView = WHERE(EFT_No = FILTER(<> ''));
                }
                action("EFT Payment Integration Awaiting Post")
                {
                    ApplicationArea = All;
                    RunObject = Page "EFT List";
                    RunPageView = WHERE(Status = CONST("Processed by Bank"), "EFT Posted" = CONST(false), "Process Module" = FILTER(<> PVs));
                }
                action("EFT Payment Integration (Staff Claim, Imprest)")
                {
                    ApplicationArea = All;
                    RunObject = Page "EFT List";
                    RunPageView = WHERE(Status = CONST("Processed by Bank"), "EFT Posted" = CONST(false));
                }
                action("EFT Payment Integration List")
                {
                    ApplicationArea = All;
                    RunObject = Page "EFT List";
                    RunPageView = WHERE(Status = FILTER(<> "Processed by Bank"));
                }
                action("EFT Payment Lines List")
                {
                    ApplicationArea = All;
                    RunObject = Page "EFT Lines View";
                    RunPageMode = View;
                }
                action("EFT Payment Integration Posted")
                {
                    ApplicationArea = All;
                    RunObject = Page "EFT List";
                    RunPageView = WHERE(Status = CONST("Processed by Bank"), "EFT Posted" = CONST(true));
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
                action(CustomerBalance)
                {
                    ApplicationArea = All;
                    Caption = 'Balance';
                    Image = Balance;
                    RunObject = Page "Customer List";
                    RunPageView = WHERE("Balance (LCY)" = FILTER(<> 0));
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
            group(Receipts)
            {
                Caption = 'Receipts';

                action("Create Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Create Receipt';
                    RunObject = Page "Receipts";
                    RunPageView = where(Posted = const(false));
                }
                action("Posted Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Receipts';
                    RunObject = Page "Receipts";
                    RunPageView = where(Posted = const(true));
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
                action("Analysis Views")
                {
                    ApplicationArea = All;
                    Caption = 'Analysis Views';
                    RunObject = Page "Analysis View List";
                }
                action("Cost Types")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Types';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Cost Types";
                    ToolTip = 'View the chart of cost types with a structure and functionality that resembles the general ledger chart of accounts. You can transfer the general ledger income statement accounts or create your own chart of cost types.';
                }
                action("Cost Centers")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Centers';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Cost Centers";
                    ToolTip = 'Manage cost centers, which are departments and profit centers that are responsible for costs and income. Often, there are more cost centers set up in cost accounting than in any dimension that is set up in the general ledger. In the general ledger, usually only the first level cost centers for direct costs and the initial costs are used. In cost accounting, additional cost centers are created for additional allocation levels.';
                }
                action("Cost Objects")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Objects';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Chart of Cost Objects";
                    ToolTip = 'Set up cost objects, which are products, product groups, or services of a company. These are the finished goods of a company that carry the costs. You can link cost centers to departments and cost objects to projects in your company.';
                }
                action("Cost Allocations")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Allocations';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cost Allocation Sources";
                    ToolTip = 'Manage allocation rules to allocate costs and revenues between cost types, cost centers, and cost objects. Each allocation consists of an allocation source and one or more allocation targets. For example, all costs for the cost type Electricity and Heating are an allocation source. You want to allocate the costs to the cost centers Workshop, Production, and Sales, which are three allocation targets.';
                }
                action("Cost Budgets")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Budgets';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Cost Budget Names";
                    ToolTip = 'Set up cost accounting budgets that are created based on cost types just as a budget for the general ledger is created based on general ledger accounts. A cost budget is created for a certain period of time, for example, a fiscal year. You can create as many cost budgets as needed. You can create a new cost budget manually, or by importing a cost budget, or by copying an existing cost budget as the budget base.';
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
                    Caption = 'Processed Payment Requests';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Posted = const(true));
                }
                action("Contractual Commitments")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'Contractual Commitments';
                    RunObject = Page "Contract Commitments";
                    RunPageView = where(Commited = const(true));
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
                    Visible = false;
                    Caption = 'Cost Accounting Registers';
                    RunObject = Page "Cost Registers";
                }
                action("Cost Accounting Budget Registers")
                {
                    ApplicationArea = All;
                    Visible = false;
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
                action(Action85)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Banks';
                    RunObject = Page "Employee Bank List";

                    ;
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
                    RunObject = Page "Advanced Finance Setup";
                }
                action("Budget User Roles")
                {
                    ApplicationArea = All;
                    Caption = 'User Budget Roles';
                    Image = Setup;
                    RunObject = Page "Budget Users";
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
                action("Travel Locations")
                {
                    ApplicationArea = All;
                    Caption = 'Travel Locations';
                    RunObject = Page "Travel Locations";
                }
                action("DSA Rates")
                {
                    ApplicationArea = All;
                    Caption = 'DSA Rates';
                    RunObject = Page "TDY Locations";
                }
            }
        }
        area(creation)
        {
            action("Sales &Credit Memo")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Sales &Credit Memo';
                RunObject = Page "Sales Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new sales credit memo to revert a posted sales invoice.';
            }
            action("P&urchase Credit Memo")
            {
                AccessByPermission = TableData "Purchase Header" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'P&urchase Credit Memo';
                RunObject = Page "Purchase Credit Memo";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase credit memo so you can manage returned items to a vendor.';
            }
            action("G/L Journal Entry")
            {
                AccessByPermission = TableData "G/L Entry" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'G/L Journal Entry';
                RunObject = Page "General Journal";
                ToolTip = 'Prepare to post any transaction to the company books.';
            }
            action("Payment Journal Entry")
            {
                AccessByPermission = TableData "Gen. Journal Batch" = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Payment Journal Entry';
                RunObject = Page "Payment Journal";
                ToolTip = 'Pay your vendors by filling the payment journal automatically according to payments due, and potentially export all payment to your bank for automatic processing.';
            }
        }
        area(processing)
        {
            group(Payments)
            {
                Caption = 'Payments';

                action("Cas&h Receipt Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cas&h Receipt Journal';
                    Image = CashReceiptJournal;
                    RunObject = Page "Cash Receipt Journal";
                    ToolTip = 'Apply received payments to the related non-posted sales documents.';
                }
                action("Pa&yment Journal")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Pa&yment Journal';
                    Image = PaymentJournal;
                    RunObject = Page "Payment Journal";
                    ToolTip = 'Make payments to vendors.';
                }
            }
            group(Analysis)
            {
                Caption = 'Analysis';

                action("Analysis &Views")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis &Views';
                    Image = AnalysisView;
                    RunObject = Page "Analysis View List";
                    ToolTip = 'Analyze amounts in your general ledger by their dimensions using analysis views that you have set up.';
                }
                action("Analysis by &Dimensions")
                {
                    ApplicationArea = Dimensions;
                    Caption = 'Analysis by &Dimensions';
                    Image = AnalysisViewDimension;
                    RunObject = Page "Analysis by Dimensions";
                    ToolTip = 'Analyze activities using dimensions information.';
                }
            }
            group(Tasks)
            {
                Caption = 'Tasks';

                action("Calculate Deprec&iation")
                {
                    ApplicationArea = FixedAssets;
                    Caption = 'Calculate Deprec&iation';
                    Ellipsis = true;
                    Image = CalculateDepreciation;
                    RunObject = Report "Calculate Depreciation";
                    ToolTip = 'Calculate depreciation according to the conditions that you define. If the fixed assets that are included in the batch job are integrated with the general ledger (defined in the depreciation book that is used in the batch job), the resulting entries are transferred to the fixed assets general ledger journal. Otherwise, the batch job transfers the entries to the fixed asset journal. You can then post the journal or adjust the entries before posting, if necessary.';
                }
                action("Import Co&nsolidation from Database")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Import Co&nsolidation from Database';
                    Ellipsis = true;
                    Image = ImportDatabase;
                    RunObject = Report "Import Consolidation from DB";
                    ToolTip = 'Import entries from the business units that will be included in a consolidation. You can use the batch job if the business unit comes from the same database in Business Central as the consolidated company.';
                }
                action("Bank Account R&econciliation")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Account R&econciliation';
                    Image = BankAccountRec;
                    RunObject = Page "Bank Acc. Reconciliation";
                    ToolTip = 'View the entries and the balance on your bank accounts against a statement from the bank.';
                }
                action("Payment Reconciliation Journals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Reconciliation Journals';
                    Image = ApplyEntries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Pmt. Reconciliation Journals";
                    RunPageMode = View;
                    ToolTip = 'Reconcile unpaid documents automatically with their related bank transactions by importing a bank statement feed or file. In the payment reconciliation journal, incoming or outgoing payments on your bank are automatically, or semi-automatically, applied to their related open customer or vendor ledger entries. Any open bank account ledger entries related to the applied customer or vendor ledger entries will be closed when you choose the Post Payments and Reconcile Bank Account action. This means that the bank account is automatically reconciled for payments that you post with the journal.';
                }
                action("Adjust E&xchange Rates")
                {
                    ApplicationArea = Suite;
                    Caption = 'Adjust E&xchange Rates';
                    Ellipsis = true;
                    Image = AdjustExchangeRates;
                    // RunObject = Report "Adjust Exchange Rates";
                    ToolTip = 'Adjust general ledger, customer, vendor, and bank account entries to reflect a more updated balance if the exchange rate has changed since the entries were posted.';
                }
                action("P&ost Inventory Cost to G/L")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'P&ost Inventory Cost to G/L';
                    Image = PostInventoryToGL;
                    RunObject = Report "Post Inventory Cost to G/L";
                    ToolTip = 'Record the quantity and value changes to the inventory in the item ledger entries and the value entries when you post inventory transactions, such as sales shipments or purchase receipts.';
                }
                action("Calc. and Pos&t VAT Settlement")
                {
                    ApplicationArea = VAT;
                    Caption = 'Calc. and Pos&t VAT Settlement';
                    Image = SettleOpenTransactions;
                    RunObject = Report "Calc. and Post VAT Settlement";
                    ToolTip = 'Close open VAT entries and transfers purchase and sales VAT amounts to the VAT settlement account. For every VAT posting group, the batch job finds all the VAT entries in the VAT Entry table that are included in the filters in the definition window.';
                }
            }
            group(Create)
            {
                Caption = 'Create';

                action("C&reate Reminders")
                {
                    ApplicationArea = Suite;
                    Caption = 'C&reate Reminders';
                    Ellipsis = true;
                    Image = CreateReminders;
                    RunObject = Report "Create Reminders";
                    ToolTip = 'Create reminders for one or more customers with overdue payments.';
                }
                action("Create Finance Charge &Memos")
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Finance Charge &Memos';
                    Ellipsis = true;
                    Image = CreateFinanceChargememo;
                    RunObject = Report "Create Finance Charge Memos";
                    ToolTip = 'Create finance charge memos for one or more customers with overdue payments.';
                }
            }
            group(Setup)
            {
                Caption = 'Setup';

                action(Action112)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Assisted Setup';
                    Image = QuestionaireSetup;
                    RunObject = Page "Assisted Setup";
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                }
                action("General &Ledger Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'General &Ledger Setup';
                    Image = Setup;
                    RunObject = Page "General Ledger Setup";
                    ToolTip = 'Define your general accounting policies, such as the allowed posting period and how payments are processed. Set up your default dimensions for financial analysis.';
                }
                action("Advance Finance Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Advance Finance Setup';
                    Image = Setup;
                    RunObject = Page "Advanced Finance Setup";
                }
                action("User Budget Roles")
                {
                    ApplicationArea = All;
                    Caption = 'User Budget Roles';
                    Image = Setup;
                    RunObject = Page "Budget Users";
                }
                action("&Sales && Receivables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Sales && Receivables Setup';
                    Image = Setup;
                    RunObject = Page "Sales & Receivables Setup";
                    ToolTip = 'Define your general policies for sales invoicing and returns, such as when to show credit and stockout warnings and how to post sales discounts. Set up your number series for creating customers and different sales documents.';
                }
                action("&Purchases && Payables Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = '&Purchases && Payables Setup';
                    Image = Setup;
                    RunObject = Page "Purchases & Payables Setup";
                    ToolTip = 'Define your general policies for purchase invoicing and returns, such as whether to require vendor invoice numbers and how to post purchase discounts. Set up your number series for creating vendors and different purchase documents.';
                }
                action("&Fixed Asset Setup")
                {
                    ApplicationArea = FixedAssets;
                    Caption = '&Fixed Asset Setup';
                    Image = Setup;
                    RunObject = Page "Fixed Asset Setup";
                    ToolTip = 'Define your accounting policies for fixed assets, such as the allowed posting period and whether to allow posting to main assets. Set up your number series for creating new fixed assets.';
                }
                action("Cash Flow Setup")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Cash Flow Setup';
                    Image = CashFlowSetup;
                    RunObject = Page "Cash Flow Setup";
                    ToolTip = 'Set up the accounts where cash flow figures for sales, purchase, and fixed-asset transactions are stored.';
                }
                action("Cost Accounting Setup")
                {
                    ApplicationArea = CostAccounting;
                    Caption = 'Cost Accounting Setup';
                    Image = CostAccountingSetup;
                    RunObject = Page "Cost Accounting Setup";
                    ToolTip = 'Specify how you transfer general ledger entries to cost accounting, how you link dimensions to cost centers and cost objects, and how you handle the allocation ID and allocation document number.';
                }
            }
            group(History)
            {
                Caption = 'History';

                action("Navi&gate")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Navi&gate';
                    Image = Navigate;
                    RunObject = Page Navigate;
                    ToolTip = 'Find all entries and documents that exist for the document number and posting date on the selected entry or document.';
                }
            }
        }
    }
}
