page 51842 "Procurement Role Center"
{
    // version THL- PRM 1.0
    Caption = 'Procument Officer Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control1907662708; "Purchase Agent Activities")
                {
                    ApplicationArea = All;
                }
                part(Control1902476008; "My Vendors")
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
            action("Vendor - T&op 10 List")
            {
                ApplicationArea = All;
                Caption = 'Vendor - T&op 10 List';
                Image = "Report";
                RunObject = Report "Vendor - Top 10 List";
                ToolTip = 'View a list of the vendors from whom you purchase the most or to whom you owe the most.';
            }
            action("Vendor/&Item Purchases")
            {
                ApplicationArea = All;
                Caption = 'Vendor/&Item Purchases';
                Image = "Report";
                RunObject = Report "Vendor/Item Purchases";
                ToolTip = 'View a list of item entries for each vendor in a selected period.';
            }
            separator(Separator28)
            {
            }
            action("Inventory - &Availability Plan")
            {
                ApplicationArea = All;
                Caption = 'Inventory - &Availability Plan';
                Image = ItemAvailability;
                RunObject = Report "Inventory - Availability Plan";
                ToolTip = 'View a list of the quantity of each item in customer, purchase, and transfer orders and the quantity available in inventory. The list is divided into columns that cover six periods with starting and ending dates as well as the periods before and after those periods. The list is useful when you are planning your inventory purchases.';
            }
            action("Inventory &Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Inventory &Purchase Orders';
                Image = "Report";
                RunObject = Report "Inventory Purchase Orders";
                ToolTip = 'View a list of items on order from vendors. The report also shows the expected receipt date and the quantity and amount on back orders. The report can be used, for example, to see when items should be received and whether a reminder of a back order should be issued.';
            }
            action("Inventory - &Vendor Purchases")
            {
                ApplicationArea = All;
                Caption = 'Inventory - &Vendor Purchases';
                Image = "Report";
                RunObject = Report "Inventory - Vendor Purchases";
                ToolTip = 'View a list of the vendors that your company has purchased items from within a selected period. It shows invoiced quantity, amount and discount. The report can be used to analyze a company''s item purchases.';
            }
            action("Inventory &Cost and Price List")
            {
                ApplicationArea = All;
                Caption = 'Inventory &Cost and Price List';
                Image = "Report";
                RunObject = Report "Inventory Cost and Price List";
                ToolTip = 'View price information for your items or stockkeeping units, such as direct unit cost, last direct cost, unit price, profit percentage, and profit.';
            }
        }
        area(embedding)
        {
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
                RunPageView = WHERE("Balance (LCY)"=FILTER(<>0));
                ToolTip = 'View a summary of the bank account balance in different periods.';
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Store Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'Open the list of Inventory items that you trade in.';
            }
            action(Locations)
            {
                ApplicationArea = All;
                Caption = 'Locations';
                RunObject = Page "Location List";
                ToolTip = 'Open the list of Locations';
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
                Caption = 'New/Recalled/Rejected';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Open));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPendingApproval)
            {
                ApplicationArea = All;
                Caption = 'Pending Approval';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER("Pending Approval"));
                ToolTip = 'View the list of purchase orders that await approval';
            }
            action(PurchaseOrdersCommitted)
            {
                ApplicationArea = All;
                Caption = 'Committed';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Released), "Last Receiving No."=FILTER(''));
                ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = All;
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Released), Receive=FILTER(true), "Completely Received"=FILTER(false));
                ToolTip = 'View the list of purchases that are partially received.';
                Visible = false;
            }
            action(PurchaseOrdersReceived)
            {
                ApplicationArea = All;
                Caption = 'Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Released), Receive=FILTER(true), "Last Receiving No."=FILTER(<>''));
                ToolTip = 'View the list of purchases that are partially received.';
            }
            action("Purchase Quotes")
            {
                ApplicationArea = All;
                Caption = 'Purchase Quotes';
                RunObject = Page "Purchase Quotes";
                ToolTip = 'Open the list of ongoing purchase quotes.';
            }
            action("Blanket Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Blanket Purchase Orders';
                RunObject = Page "Blanket Purchase Orders";
                ToolTip = 'View ongoing blanket purchase orders for agreements to buy items from a vendor on several orders over time.';
            }
            action("Purchase Invoices")
            {
                ApplicationArea = All;
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
                ToolTip = 'Open the list of ongoing purchase invoices.';
            }
            action("Purchase Return Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Return Orders';
                RunObject = Page "Purchase Return Order List";
                ToolTip = 'Open the list of ongoing purchase return orders.';
            }
            action("Purchase Credit Memos")
            {
                ApplicationArea = All;
                Caption = 'Purchase Credit Memos';
                RunObject = Page "Purchase Credit Memos";
                ToolTip = 'Open the list of ongoing purchase credit memos.';
            }
            action("Procurement Terms & Conditions")
            {
                ApplicationArea = All;
                Caption = 'Procurement Terms & Conditions';
                RunObject = Page "Procurement Terms & Conditions";
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
            group(Budget)
            {
                Caption = 'Budget';
                ToolTip = 'Procurement Budget';

                action("Procurement Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Plan';
                    ToolTip = 'Procurement Plan based on Financial Year';
                    RunObject = Page "Procurement Budget Plans";
                }
                action("Purchase Budget")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Budget';
                    ToolTip = 'Inventory Purchase Budget';
                    RunObject = Page "Budget Names Purchase";
                }
                action("Purchase Analysis Report")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Analysis Report';
                    ToolTip = 'Run Purchase Analysis Report';
                    RunObject = Page "Analysis Report Purchase";
                }
                //Ibrahim Wasiu
                action("Create Procurement Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Create Procurement Plan';
                    ToolTip = 'Create a new Procurement Plan';
                    RunObject = Page "Procurement Plans";
                    RunPageView = where(Status=const(Open));
                }
                action("Procurement Plan Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Plan Approval';
                    ToolTip = 'View and approve Procurement Plan';
                    RunObject = Page "Procurement Plans";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Procurement Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Procurement Plan';
                    ToolTip = 'View approved Procurement Plan';
                    RunObject = Page "Procurement Plans";
                    RunPageView = where(Status=const(Released));
                }
                action("Procurement Plan Review")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Plans Review';
                    RunObject = page "Procurement Plan Review";
                }
            }
            group(Tendering)
            {
                Caption = 'Tendering';
                ToolTip = 'Tendering Process';

                action(Tenders)
                {
                    ApplicationArea = All;
                    Caption = 'Tenders';
                    ToolTip = 'Create Tender from Approved Purchase Requisitions';
                    RunObject = Page "Tender List";
                }
                action("Tenders Committees")
                {
                    ApplicationArea = All;
                    Caption = 'Tenders Committees';
                    ToolTip = 'Create Tender Committees';
                    RunObject = Page "Appointment List";
                }
                action("Prequalified Suppliers")
                {
                    ApplicationArea = All;
                    Caption = 'Prequalified Suppliers';
                    ToolTip = 'List of Prequalified Suppliers';
                    RunObject = Page "List of Pre-Qualified Supplier";
                }
            }
            group("Vendor Onboarding")
            {
                action(NewVendRegRequest)
                {
                    ApplicationArea = All;
                    Caption = 'New Vendor Registration Request';
                    RunObject = page "Vendor Reg Requests";
                    RunPageView = where(Status=const(Open));
                }
                action(PendingApprovalVendRegRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Registration Request Approval';
                    RunObject = page "Vendor Reg Requests";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action(ReleasedVendRegRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Vendor Registration Request';
                    RunObject = page "Vendor Reg Requests";
                    RunPageView = where(Status=const(Released), "Vendor Created"=const(false));
                }
                action(EffectedVendRegRequest)
                {
                    ApplicationArea = All;
                    Caption = 'Effected Vendor Registration Request';
                    RunObject = page "Vendor Reg Requests";
                    RunPageView = where(Status=const(Released), "Vendor Created"=const(true));
                }
                action(RegisteredVendor)
                {
                    ApplicationArea = All;
                    Caption = 'Registered Suppliers';
                    RunObject = page "Vendor List";
                }
            }
            group("Procurement Operations")
            {
                Caption = 'Procurement Operations';
                Image = LotInfo;
                ToolTip = 'Management of Procurement Tasks';

                action(Action60)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    RunObject = Page "Item List";
                }
                action("Fixed Asset")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Assets';
                    RunObject = Page "Fixed Asset List";
                }
                action("Create Purchase Requisition For Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Create Purchase Requisition For Employees';
                    RunObject = Page "PR Purch Requisitions - Open";
                }
                action("Purchase Requisition Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisition Pending Approval';
                    RunObject = Page "Purch Requisitions - Pendin";
                }
                action("Purchase Requisition Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisition Approved';
                    RunObject = Page "Purch Requisitions - Approv";
                }
                action("Purchase Requisitions Ordered")
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Requisitions Ordered';
                    RunObject = Page "Purch Requisitions - Closed";
                }
                action("Requisitions Review")
                {
                    ApplicationArea = All;
                    Caption = 'Requisitions Review';
                    RunObject = Page "Requisitions Review";
                }
                action("Create New RFQ")
                {
                    ApplicationArea = All;
                    Caption = 'Create New RFQ/RFP';
                    RunObject = Page "RFQ List";
                    RunPageView = where(Status=const(Open));
                }
                action("Pending Approval RFQ")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval RFQ/RFP';
                    RunObject = page "RFQ List";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved RFQ")
                {
                    ApplicationArea = All;
                    Caption = 'Approved RFQ/RFP';
                    RunObject = page "RFQ List";
                    RunPageView = where(Status=const(Released));
                }
                action("New Inspection of Goods/Services")
                {
                    ApplicationArea = All;
                    Caption = 'New Inspection of Goods/Services';
                    RunObject = Page "Inspections - Open";
                }
                action("Create Repair Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Create Repair Requisition';
                    ToolTip = 'Create a new Repair Requisition';
                    RunObject = Page "Repair Requisition List";
                    RunPageView = where(Status=const(Open));
                }
                action("Repair Requisition Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Repair Requisition Approval';
                    ToolTip = 'View and approve Repair Requisition';
                    RunObject = Page "Repair Requisition List";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Repair Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Repair Requisition';
                    ToolTip = 'View Approved Repair Requisition';
                    RunObject = Page "Repair Requisition List";
                    RunPageView = where(Status=const(Released), "RR Closed"=const(false));
                }
                action("Repair Requisition Ordered")
                {
                    ApplicationArea = All;
                    Caption = 'Repair Requisition Ordered';
                    ToolTip = 'View Closed Repair Requisition';
                    RunObject = Page "Repair Requisition List";
                    RunPageView = where(Status=const(Released), "RR Closed"=const(true));
                }
            }
            group("Order Processing")
            {
                Caption = 'Order Processing';

                action("Vendors/Suppliers")
                {
                    ApplicationArea = All;
                    Caption = 'Vendors/Suppliers';
                    RunObject = Page "Vendor List";
                }
                action(Action52)
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
                action(OP_PurchaseOrdersPendConf)
                {
                    ApplicationArea = All;
                    Caption = 'Pending Confirmation';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status=FILTER(Open));
                    ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
                }
                action(OP_PurchaseOrdersCommitted)
                {
                    ApplicationArea = All;
                    Caption = 'Committed';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status=FILTER(Released), "Last Receiving No."=FILTER(''));
                    ToolTip = 'View the list of purchase orders that await the vendor''s confirmation. ';
                }
                action(OP_PurchaseOrdersPartDeliv)
                {
                    ApplicationArea = All;
                    Caption = 'Partially Delivered';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status=FILTER(Released), Receive=FILTER(true), "Completely Received"=FILTER(false));
                    ToolTip = 'View the list of purchases that are partially received.';
                }
                action(OP_PurchaseOrdersReceived)
                {
                    ApplicationArea = All;
                    Caption = 'Fully Delivered';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status=FILTER(Released), "Last Receiving No."=FILTER(<>''), Invoice=CONST(false));
                    ToolTip = 'View the list of purchases that are partially received.';
                }
                action(PurchaseOrdersInvoiced)
                {
                    ApplicationArea = All;
                    Caption = 'Invoiced';
                    RunObject = Page "Purchase Order List";
                    RunPageView = WHERE(Status=FILTER(Released), Invoice=CONST(true));
                    ToolTip = 'View the list of purchases that are partially received.';
                }
                action(Action50)
                {
                    ApplicationArea = All;
                    Caption = 'Purchase Invoices';
                    RunObject = Page "Purchase Invoices";
                }
                action(Action49)
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Purchase Credit Memos';
                    RunObject = Page "Purchase Credit Memos";
                }
                action("Purchase Return")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Purchase Return';
                    RunObject = Page "Purchase Return Order List";
                }
                action("Transfer Order")
                {
                    ApplicationArea = All;
                    Caption = 'Transfer Order';
                    RunObject = Page "Transfer Orders";
                }
                action("Create New Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Work Orders';
                    RunObject = Page "Work Orders";
                    RunPageView = where(Status=const(Open));
                }
                action("Pending Approval Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval Work Orders';
                    RunObject = Page "Work Orders";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Work Order")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Work Orders';
                    RunObject = Page "Work Orders";
                    RunPageView = where(Status=const(Released), Posted=const(false));
                }
            }
            group("Store Management")
            {
                Caption = 'Store Management';

                action("Create Store Requisition for Employees")
                {
                    ApplicationArea = All;
                    Caption = 'Create Store Requisition for Employees';
                    RunObject = Page "PR Store Requisitions - Open";
                }
                action("Store Requisition Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Store Requisition Pending Approval';
                    RunObject = Page "Store Requisitions - Pendin";
                }
                action("Approved Store Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Store Requisition';
                    RunObject = Page "Store Requisitions - Approv";
                }
                action("Issued Store Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Store Requisition';
                    RunObject = Page "Store Requisitions - Issued";
                }
                action("New Store Transactions")
                {
                    ApplicationArea = All;
                    Caption = 'New Store Transactions';
                    RunObject = Page "Store Transactions-Open";
                    Visible = false;
                }
                action("Out of Store Review")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Out of Store Requisition Reviews';
                //RunObject = page "Out of Store Review";
                }
            }
            group("Fleet Operations")
            {
                Caption = 'Fleet Operations';

                action(Driver)
                {
                    ApplicationArea = All;
                    Caption = 'Drivers';
                    RunObject = page "Driver List";
                }
                action(Vehicle)
                {
                    ApplicationArea = All;
                    Caption = 'Vehicles';
                    RunObject = page "Vehicle List";
                }
                action("Work Tickets-Open")
                {
                    ApplicationArea = All;
                    Caption = 'Create Work Tickets';
                    RunObject = page "Work Tickets-Open";
                    RunPageView = where(Status=const(Open));
                }
                action("Work Tickets Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Work Ticket Pending Approval';
                    RunObject = page "Work Tickets-Open";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Work Tickets Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Work Ticket Approved';
                    RunObject = page "Work Tickets-Open";
                    RunPageView = where(Status=const(Released));
                }
                action("Work Tickets-Issed")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Work Tickets';
                    RunObject = page "Work Tickets-Issued";
                    RunPageView = where(Status=const(Committed));
                }
                action("Work Tickets Canceled")
                {
                    ApplicationArea = All;
                    Caption = 'Canceled Work Tickets';
                    RunObject = page "Work Tickets-Canceled";
                }
                action("Fuel Consumption Open")
                {
                    ApplicationArea = All;
                    Caption = 'New Fuel Consumption';
                    RunObject = page "Fuel Consumption-Open";
                }
                action("Fuel Consumption History")
                {
                    ApplicationArea = All;
                    Caption = 'Fuel Consumption History';
                    RunObject = page "Fuel Consumption-closed";
                }
                action("New Fuel Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'New Fuel Voucher';
                    RunObject = page "Fuel Vouchers-Open";
                }
                action("Fuel Card")
                {
                    ApplicationArea = All;
                    Caption = 'New Fuel Card';
                    RunObject = page "Fuel Cards";
                }
                action("New Vehicle Service")
                {
                    ApplicationArea = All;
                    Caption = 'New Vehice Service';
                    RunObject = page "Vehicle Service-Open";
                }
                action("Vehicle Service History")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle Service History';
                    RunObject = page "Vehicle Service-Closed";
                }
            }
            group("Mail Administration")
            {
                action("Create New Incoming Mails")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Incoming Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status=const(Open), "Mail Type"=const("Incoming Mail"), Posted=const(false));
                }
                action("Create New Outgoing Mails")
                {
                    ApplicationArea = All;
                    Caption = 'Create New outgoing Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status=const(Open), "Mail Type"=const("Outgoing Mail"), Posted=const(false));
                }
                action("Closed Incoming Mails")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Incoming Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status=const(Fulfilled), "Mail Type"=const("Incoming Mail"), Posted=const(true));
                }
                action("Closed Outgoing Mails")
                {
                    ApplicationArea = All;
                    Caption = 'Closed outgoing Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status=const(Fulfilled), "Mail Type"=const("Outgoing Mail"), Posted=const(true));
                }
            }
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

                action(Action40)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Receipts';
                    RunObject = Page "Posted Purchase Receipts";
                    ToolTip = 'Open the list of posted purchase receipts.';
                }
                action(Action42)
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Invoices';
                    RunObject = Page "Posted Purchase Invoices";
                    ToolTip = 'Open the list of posted purchase invoices.';
                }
                action("Posted Return Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                    ToolTip = 'Open the list of posted return shipments.';
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ToolTip = 'Open the list of posted purchase credit memos.';
                }
                action("Closed Purchase Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Purchase Requisitions';
                    RunObject = Page "Purch Requisitions - Closed";
                }
                action("Posted Store Transactions")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Store Transactions';
                    RunObject = Page "Store Transactions-Posted";
                }
                action("Work Tickets Closed")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Work Tickets';
                    RunObject = page "Work Tickets-Closed";
                }
                action("Fuel Voucher Posted")
                {
                    ApplicationArea = All;
                    Caption = 'Fuel Voucher Posted';
                    RunObject = Page "Fuel Vouchers-Posted";
                }
                action("Repair Requisition Closed")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Repair Requisition';
                    ToolTip = 'View Closed Repair Requisition';
                    RunObject = Page "Repair Requisition Header";
                    RunPageView = where(Status=const(Released), "RR Closed"=const(true));
                }
            }
        }
        area(creation)
        {
            action("Purchase &Quote")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Quote';
                Image = Quote;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Quote";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase quote, for example to reflect a request for quote.';
            }
            action("Purchase &Invoice")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Invoice';
                Image = NewPurchaseInvoice;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Invoice";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase invoice.';
            }
            action("Purchase &Order")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Order';
                Image = Document;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase order.';
            }
            action("Purchase &Return Order")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Return Order';
                Image = ReturnOrder;
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = Process;
                RunObject = Page "Purchase Return Order";
                RunPageMode = Create;
                ToolTip = 'Create a new purchase return order to return received items.';
            }
        }
        area(processing)
        {
            action(ProcurementSetup)
            {
                ApplicationArea = All;
                Caption = 'Setup';
                RunObject = Page "Procurement Setup";
            }
            separator(Separator1)
            {
            Caption = 'Tasks';
            IsHeader = true;
            }
            action("ProcurementTerms&Conditions")
            {
                ApplicationArea = All;
                Caption = 'Procurement Terms & Conditions';
                RunObject = Page "Procurement Terms & Conditions";
            }
            action("Procurement Methods")
            {
                ApplicationArea = All;
                Caption = 'Procurement Methods';
                RunObject = Page "Procurement Method";
            }
            action("Procurement Committees")
            {
                ApplicationArea = All;
                Caption = 'Procurement Committees';
                RunObject = Page "Procurement Committee";
            }
            separator(Tasks)
            {
            Caption = 'Tasks';
            IsHeader = true;
            }
            action("&Purchase Journal")
            {
                ApplicationArea = All;
                Caption = '&Purchase Journal';
                Image = Journals;
                RunObject = Page "Purchase Journal";
                ToolTip = 'Post purchase transactions directly to the general ledger. The purchase journal may already contain journal lines that are created as a result of related functions.';
            }
            action("Item &Journal")
            {
                ApplicationArea = All;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page "Item Journal";
                ToolTip = 'Adjust the physical quantity of items on inventory.';
            }
            action("Order Plan&ning")
            {
                ApplicationArea = All;
                Caption = 'Order Plan&ning';
                Image = Planning;
                RunObject = Page "Order Planning";
                ToolTip = 'Plan supply orders order by order to fulfill new demand.';
            }
            separator(Separator38)
            {
            }
            action("Requisition &Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Requisition &Worksheet';
                Image = Worksheet;
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type"=CONST("Req."), Recurring=CONST(false));
                ToolTip = 'Calculate a supply plan to fulfill item demand with purchases or transfers.';
            }
            action("Pur&chase Prices")
            {
                ApplicationArea = All;
                Caption = 'Pur&chase Prices';
                Image = Price;
                RunObject = Page "Purchase Prices";
                ToolTip = 'View or set up different prices for items that you buy from the vendor. An item price is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
            }
            action("Purchase &Line Discounts")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Line Discounts';
                Image = LineDiscount;
                RunObject = Page "Purchase Line Discounts";
                ToolTip = 'View or set up different discounts for items that you buy from the vendor. An item discount is automatically granted on invoice lines when the specified criteria are met, such as vendor, quantity, or ending date.';
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
