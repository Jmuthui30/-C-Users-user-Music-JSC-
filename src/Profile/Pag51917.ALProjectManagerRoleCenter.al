page 51917 "AL Project Manager Role Center"
{
    // version NAVW113.00
    Caption = 'Project Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control49; "Headline RC Serv. Dispatcher")
                {
                    ApplicationArea = All;
                }
                part(Control48; "Service Dispatcher Activities")
                {
                    ApplicationArea = All;
                }
                part(Control46; "Headline RC Project Manager")
                {
                    ApplicationArea = All;
                }
                part(Control47; "Project Manager Activities")
                {
                    ApplicationArea = All;
                }
                part(Control45; "My Jobs")
                {
                    ApplicationArea = All;
                }
                part("Job Actual Price to Budget Price"; "Job Act to Bud Price Chart")
                {
                    ApplicationArea = All;
                    Caption = 'Job Actual Price to Budget Price';
                    ToolTip = 'Compare the actual price of your jobs to the price that was budgeted. The report shows budget and actual amounts for each phase, task, and steps.';
                }
                part("Job Profitability"; "Job Profitability Chart")
                {
                    ApplicationArea = All;
                    Caption = 'Job Profitability';
                    ToolTip = 'View profit figures for completed jobs.';
                }
                part("Job Actual Cost to Budget Cost"; "Job Act to Bud Cost Chart")
                {
                    ApplicationArea = All;
                    Caption = 'Job Actual Cost to Budget Cost';
                    ToolTip = 'Comparison the actual cost of your jobs to the cost that was budgeted. The report shows budget and actual amounts for each phase, task and steps.';
                }
            }
            group(Control40)
            {
                ShowCaption = false;

                part(Control35; "My Job Queue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control32; "My Customers")
                {
                    ApplicationArea = All;
                }
                part(Control31; "My Items")
                {
                    ApplicationArea = All;
                }
                part(Control27; "Report Inbox Part")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control21; "Report Inbox Part")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                systempart(Control18; MyNotes)
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
            group(Service)
            {
                Caption = 'Service';

                action("Service Ta&sks")
                {
                    ApplicationArea = All;
                    Caption = 'Service Ta&sks';
                    Image = ServiceTasks;
                    RunObject = Report "Service Tasks";
                    ToolTip = 'View or edit service task information, such as service order number, service item description, repair status, and service item. You can print a list of the service tasks that have been entered.';
                }
                action("Service &Load Level")
                {
                    ApplicationArea = All;
                    Caption = 'Service &Load Level';
                    Image = "Report";
                    RunObject = Report "Service Load Level";
                    ToolTip = 'View the capacity, usage, unused, unused percentage, sales, and sales percentage of the resource. You can test what the service load is of your resources.';
                }
                action("Resource &Usage")
                {
                    ApplicationArea = All;
                    Caption = 'Resource &Usage';
                    Image = "Report";
                    RunObject = Report "Service Item - Resource Usage";
                    ToolTip = 'View details about the total use of service items, both cost and amount, profit amount, and profit percentage.';
                }
                action("Service I&tems Out of Warranty")
                {
                    ApplicationArea = All;
                    Caption = 'Service I&tems Out of Warranty';
                    Image = "Report";
                    RunObject = Report "Service Items Out of Warranty";
                    ToolTip = 'View information about warranty end dates, serial numbers, number of active contracts, items description, and names of customers. You can print a list of service items that are out of warranty.';
                }
            }
            group(Profit)
            {
                Caption = 'Profit';

                action("Profit Service &Contracts")
                {
                    ApplicationArea = All;
                    Caption = 'Profit Service &Contracts';
                    Image = "Report";
                    RunObject = Report "Service Profit (Contracts)";
                    ToolTip = 'View details about service amount, contract discount amount, service discount amount, service cost amount, profit amount, and profit. You can print information about service profit for service contracts, based on the difference between the service amount and service cost.';
                }
                action("Profit Service &Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Profit Service &Orders';
                    Image = "Report";
                    RunObject = Report "Service Profit (Serv. Orders)";
                    ToolTip = 'View the customer number, serial number, description, item number, contract number, and contract amount. You can print information about service profit for service orders, based on the difference between service amount and service cost.';
                }
                action("Profit Service &Items")
                {
                    ApplicationArea = All;
                    Caption = 'Profit Service &Items';
                    Image = "Report";
                    RunObject = Report "Service Profit (Service Items)";
                    ToolTip = 'View details about service amount, contract discount amount, service discount amount, service cost amount, profit amount, and profit. You can print information about service profit for service items.';
                }
            }
        }
        area(embedding)
        {
            action("Service Contract Quotes")
            {
                ApplicationArea = All;
                Caption = 'Service Contract Quotes';
                RunObject = Page "Service Contract Quotes";
                ToolTip = 'View the list of ongoing service contract quotes.';
            }
            action("Service Contracts")
            {
                ApplicationArea = All;
                Caption = 'Service Contracts';
                Image = ServiceAgreement;
                RunObject = Page "Service Contracts";
                ToolTip = 'View the list of ongoing service contracts.';
            }
            action("Service Quotes")
            {
                ApplicationArea = All;
                Caption = 'Service Quotes';
                Image = Quote;
                RunObject = Page "Service Quotes";
                ToolTip = 'View the list of ongoing service quotes.';
            }
            action("Service Orders")
            {
                ApplicationArea = All;
                Caption = 'Service Orders';
                Image = Document;
                RunObject = Page "Service Orders";
                ToolTip = 'Open the list of ongoing service orders.';
            }
            action("Standard Service Codes")
            {
                ApplicationArea = All;
                Caption = 'Standard Service Codes';
                Image = ServiceCode;
                RunObject = Page "Standard Service Codes";
                ToolTip = 'View or edit service order lines that you have set up for recurring services. ';
            }
            action(Loaners)
            {
                ApplicationArea = All;
                Caption = 'Loaners';
                Image = Loaners;
                RunObject = Page "Loaner List";
                ToolTip = 'View or select from items that you lend out temporarily to customers to replace items that they have in service.';
            }
            action(Customers)
            {
                ApplicationArea = All;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Service Items")
            {
                ApplicationArea = All;
                Caption = 'Service Items';
                Image = ServiceItem;
                RunObject = Page "Service Item List";
                ToolTip = 'View the list of service items.';
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'View or edit detailed information for the products that you trade in. The item card can be of type Inventory or Service to specify if the item is a physical unit or a labor time unit. Here you also define if items in inventory or on incoming orders are automatically reserved for outbound documents and whether order tracking links are created between demand and supply to reflect planning actions.';
            }
            action("Item Journals")
            {
                ApplicationArea = All;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type"=CONST(Item), Recurring=CONST(false));
                ToolTip = 'Post item transactions directly to the item ledger to adjust inventory in connection with purchases, sales, and positive or negative adjustments without using documents. You can save sets of item journal lines as standard journals so that you can perform recurring postings quickly. A condensed version of the item journal function exists on item cards for quick adjustment of an items inventory quantity.';
            }
            action("Requisition Worksheets")
            {
                ApplicationArea = All;
                Caption = 'Requisition Worksheets';
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type"=CONST("Req."), Recurring=CONST(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
        }
        area(sections)
        {
            group(Jobs)
            {
                Caption = 'Job';

                action("Job List")
                {
                    ApplicationArea = All;
                    Caption = 'Job List';
                    RunObject = Page "Job List";
                }
                action("Job Register")
                {
                    ApplicationArea = All;
                    Caption = 'Job Register';
                    RunObject = Page "Job Registers";
                }
                action("Res. Capacity Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Resources Capacity Entries';
                    RunObject = Page "Res. Capacity Entries";
                }
                action("Job Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Job Ledger Entries';
                    RunObject = Page "Job Ledger Entries";
                }
                action("Job WIP Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Job WIP Entries';
                    RunObject = Page "Job WIP Entries";
                }
                action("Job WIP G/L Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Job WIP G/L Entries';
                    RunObject = Page "Job WIP G/L Entries";
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

                action("Posted Service Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Service Shipments';
                    Image = PostedShipment;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Service Shipments";
                    ToolTip = 'Open the list of posted service shipments.';
                }
                action("Posted Service Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Service Invoices';
                    Image = PostedServiceOrder;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Service Invoices";
                    ToolTip = 'Open the list of posted service invoices.';
                }
                action("Posted Service Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Service Credit Memos';
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Posted Service Credit Memos";
                    ToolTip = 'Open the list of posted service credit memos.';
                }
            }
        }
        area(creation)
        {
            action("Service Contract &Quote")
            {
                ApplicationArea = All;
                Caption = 'Service Contract &Quote';
                Image = AgreementQuote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Service Contract Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new quote to perform service on a customer''s item.';
            }
            action("Service &Contract")
            {
                ApplicationArea = All;
                Caption = 'Service &Contract';
                Image = Agreement;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Service Contract";
                RunPageMode = Create;
                ToolTip = 'Create a new service contract.';
            }
            action("Service Q&uote")
            {
                ApplicationArea = All;
                Caption = 'Service Q&uote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Service Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new service quote.';
            }
            action("Service &Order")
            {
                ApplicationArea = All;
                Caption = 'Service &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Service Order";
                RunPageMode = Create;
                ToolTip = 'Create a new service order to perform service on a customer''s item.';
            }
            action("Sales Or&der")
            {
                ApplicationArea = All;
                Caption = 'Sales Or&der';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Sales Order";
                RunPageMode = Create;
                ToolTip = 'Create a new sales order for items or services that require partial posting or order confirmation.';
            }
            action("Transfer &Order")
            {
                ApplicationArea = All;
                Caption = 'Transfer &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Transfer Order";
                RunPageMode = Create;
                ToolTip = 'Prepare to transfer items to another location.';
            }
        }
        area(processing)
        {
            group(Tasks)
            {
                Caption = 'Tasks';

                action("Service Tas&ks")
                {
                    ApplicationArea = All;
                    Caption = 'Service Tas&ks';
                    Image = ServiceTasks;
                    RunObject = Page "Service Tasks";
                    ToolTip = 'View or edit service task information, such as service order number, service item description, repair status, and service item. You can print a list of the service tasks that have been entered.';
                }
                action("C&reate Contract Service Orders")
                {
                    ApplicationArea = All;
                    Caption = 'C&reate Contract Service Orders';
                    Image = "Report";
                    RunObject = Report "Create Contract Service Orders";
                    ToolTip = 'Copy information from an existing production order record to a new one. This can be done regardless of the status type of the production order. You can, for example, copy from a released production order to a new planned production order. Note that before you start to copy, you have to create the new record.';
                }
                action("Create Contract In&voices")
                {
                    ApplicationArea = All;
                    Caption = 'Create Contract In&voices';
                    Image = "Report";
                    RunObject = Report "Create Contract Invoices";
                    ToolTip = 'Create service invoices for service contracts that are due for invoicing. ';
                }
                action("Post &Prepaid Contract Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Post &Prepaid Contract Entries';
                    Image = "Report";
                    RunObject = Report "Post Prepaid Contract Entries";
                    ToolTip = 'Transfers prepaid service contract ledger entries amounts from prepaid accounts to income accounts.';
                }
                action("Order Pla&nning")
                {
                    ApplicationArea = All;
                    Caption = 'Order Pla&nning';
                    Image = Planning;
                    RunObject = Page "Order Planning";
                    ToolTip = 'Plan supply orders order by order to fulfill new demand.';
                }
            }
            group(Administration)
            {
                Caption = 'Administration';

                action("St&andard Service Codes")
                {
                    ApplicationArea = All;
                    Caption = 'St&andard Service Codes';
                    Image = ServiceCode;
                    RunObject = Page "Standard Service Codes";
                    ToolTip = 'View or edit service order lines that you have set up for recurring services. ';
                }
                action("Dispatch Board")
                {
                    ApplicationArea = All;
                    Caption = 'Dispatch Board';
                    Image = ListPage;
                    RunObject = Page "Dispatch Board";
                    ToolTip = 'Get an overview of your service orders. Set filters, for example, if you only want to view service orders for a particular customer, service zone or you only want to view service orders needing reallocation.';
                }
            }
            group(History)
            {
                Caption = 'History';

                action("Item &Tracing")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracing';
                    Image = ItemTracing;
                    RunObject = Page "Item Tracing";
                    ToolTip = 'Trace where a lot or serial number assigned to the item was used, for example, to find which lot a defective component came from or to find all the customers that have received items containing the defective component.';
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
}
