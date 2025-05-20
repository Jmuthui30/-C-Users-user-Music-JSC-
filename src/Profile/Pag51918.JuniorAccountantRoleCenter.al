page 51918 "Junior Accountant Role Center"
{
    Caption = 'Accountant Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            systempart(Control1901377608; MyNotes)
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
    actions
    {
        area(embedding)
        {
            action(ChartofAccounts)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Chart of Accounts';
                RunObject = Page "Chart of Accounts";
                ToolTip = 'Open the chart of accounts.';
            }
            action("Bank Accounts")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bank Accounts';
                Image = BankAccount;
                RunObject = Page "Bank Account List";
                ToolTip = 'View or set up detailed information about your bank account, such as which currency to use, the format of bank files that you import and export as electronic payments, and the numbering of checks.';
            }
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
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
                RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Purchase Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
                ToolTip = 'Create purchase orders to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase orders dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase orders allow partial receipts, unlike with purchase invoices, and enable drop shipment directly from your vendor to your customer. Purchase orders can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
            }
            action(CustomersBalance)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Balance';
                Image = Balance;
                RunObject = Page "Customer List";
                RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action("Incoming Documents")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Incoming Documents';
                Image = Documents;
                RunObject = Page "Incoming Documents";
                ToolTip = 'Handle incoming documents, such as vendor invoices in PDF or as image files, that you can manually or automatically convert to document records, such as purchase invoices. The external files that represent incoming documents can be attached at any process stage, including to posted documents and to the resulting vendor, customer, and general ledger entries.';
            }
            action("Purchase Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Purchase Invoices';
                Image = Invoice;
                RunObject = Page "Purchase Invoices";
                ToolTip = 'Create purchase invoices to mirror sales documents that vendors send to you. This enables you to record the cost of purchases and to track accounts payable. Posting purchase invoices dynamically updates inventory levels so that you can minimize inventory costs and provide better customer service. Purchase invoices can be created automatically from PDF or image files from your vendors by using the Incoming Documents feature.';
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
                    RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
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
                action(Vendors_bl)
                {
                    ApplicationArea = All;
                    Caption = 'Balance';
                    Image = Balance;
                    RunObject = Page "Vendor List";
                    RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
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
            group("Payment Request")
            {
                Caption = 'Payment Requests';

                action("New Requests for Payment")
                {
                    ApplicationArea = All;
                    Caption = 'New Payment Requests';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Status=const(Open));
                }
                action("Requests for Payment Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Payment Requests Pending Approval';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Requests for Payment")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Payment Requests';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Status=const(Released));
                }
            }
            group("Payment Voucher")
            {
                Caption = 'Payment Voucher';

                action("Create New Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status=const(Open));
                }
                action("Pending Approval Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Posted Payment Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Payment Voucher';
                    RunObject = Page "Payment Voucher List";
                    RunPageView = where(Status=const(Released));
                }
            }
            group(Imprest)
            {
                Caption = 'Imprest Surrender';
                Image = Travel;

                action("Posted Imprest Surrenders")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Imprest Surrenders';
                    RunObject = Page "Imprest Surrenders";
                    RunPageView = where("Surrender Posted"=const(true));
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
                    RunPageView = where(Posted=const(false));
                }
                action("Posted Receipt")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Receipts';
                    RunObject = Page "Receipts";
                    RunPageView = where(Posted=const(true));
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
                    RunPageView = where(Status=const(Open));
                }
                action("Staff Claim Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Staff ClaimPending Approval';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Staff Claim';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status=const(Released));
                }
                action("Posted Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Staff Claim';
                    RunObject = Page "Staff Claims";
                    RunPageView = where(Status=const(Released), "Claim Posted"=const(true));
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
                    RunPageView = WHERE("Template Type"=CONST(Purchases), Recurring=CONST(false));
                }
                action(SalesJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Sales Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type"=CONST(Sales), Recurring=CONST(false));
                }
                action(CashReceiptJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Cash Receipt Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type"=CONST("Cash Receipts"), Recurring=CONST(false));
                }
                action(PaymentJournals)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Journals';
                    Image = Journals;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type"=CONST(Payments), Recurring=CONST(false));
                }
                action(ICGeneralJournals)
                {
                    ApplicationArea = All;
                    Caption = 'IC General Journals';
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type"=CONST(Intercompany), Recurring=CONST(false));
                }
                action(GeneralJournals)
                {
                    ApplicationArea = All;
                    Caption = 'General Journals';
                    Image = Journal;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type"=CONST(General), Recurring=CONST(false));
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
                    RunPageView = where(posted=const(true));
                }
                action("Posted Cash Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Cash Receipts';
                    RunObject = Page "Receipts";
                    RunPageView = where(Posted=const(true));
                }
                action("Processed Requests for Payment")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Payment Requests';
                    RunObject = Page "Payment Requests";
                    RunPageView = where(Posted=const(true));
                }
                action("Contractual Commitments")
                {
                    ApplicationArea = All;
                    Visible = false;
                    Caption = 'Contractual Commitments';
                    RunObject = Page "Contract Commitments";
                    RunPageView = where(Commited=const(true));
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
            group("Strore Self Service")
            {
                Caption = 'Store Self Service';

                action("New Store Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'New Store Requisition';
                    RunObject = Page "SS Store Requisitions - Open";
                }
                action("Store Requisition Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Store Requisition Pending Approval';
                    RunObject = Page "SS Store Requisitions - Pendin";
                }
                action("Received Store Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Received Store Requisition';
                    RunObject = Page "SS Store Requisitions - Receiv";
                }
            }
            group("Purchase Self Service")
            {
                Caption = 'Purchase Self Service';

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
                action("Approved Purchase Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Purchase Requisition';
                    RunObject = Page "SS Purch Requisitions - Approv";
                }
                action("Close Purchase Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'My Fullfilled Purchase Requisitions';
                    RunObject = Page "SS Purch Requisitions - Closed";
                }
            }
            group("Finance Self Service")
            {
                Caption = 'Finance Self Service';

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
                action("Approved Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status=const(Released));
                }
                group("SS Archives")
                {
                    Caption = 'Archives';

                    action("Processed Petty Cash Requests")
                    {
                        ApplicationArea = All;
                        Caption = 'Processed Petty Cash Requests';
                        RunObject = Page "SS Petty Cash";
                        RunPageView = where(Status=const(Released), Posted=const(true));
                    }
                }
            }
        }
    }
}
