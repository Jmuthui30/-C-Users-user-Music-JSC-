page 52144 "Stores Agent Role Center"
{
    // version THL- ADV.FIN 1.0
    Caption = 'Store Keeper';
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
            group(Control1900724708)
            {
                ShowCaption = false;

                part(Control25; "Purchase Performance")
                {
                    ApplicationArea = All;
                }
                part(Control37; "Purchase Performance")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control21; "Inventory Performance")
                {
                    ApplicationArea = All;
                }
                part(Control44; "Inventory Performance")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control45; "Report Inbox Part")
                {
                    ApplicationArea = All;
                }
                part(Control35; "My Job Queue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = All;
                }
                systempart(Control43; MyNotes)
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
            }
            action("Vendor/&Item Purchases")
            {
                ApplicationArea = All;
                Caption = 'Vendor/&Item Purchases';
                Image = "Report";
                RunObject = Report "Vendor/Item Purchases";
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
            }
            action("Inventory &Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Inventory &Purchase Orders';
                Image = "Report";
                RunObject = Report "Inventory Purchase Orders";
            }
            action("Inventory - &Vendor Purchases")
            {
                ApplicationArea = All;
                Caption = 'Inventory - &Vendor Purchases';
                Image = "Report";
                RunObject = Report "Inventory - Vendor Purchases";
            }
            action("Inventory &Cost and Price List")
            {
                ApplicationArea = All;
                Caption = 'Inventory &Cost and Price List';
                Image = "Report";
                RunObject = Report "Inventory Cost and Price List";
            }
        }
        area(embedding)
        {
            action(PurchaseOrders)
            {
                ApplicationArea = All;
                Caption = 'Purchase Orders';
                RunObject = Page "Purchase Order List";
            }
            action(PurchaseOrdersPendConf)
            {
                ApplicationArea = All;
                Caption = 'Pending Confirmation';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Open));
            }
            action(PurchaseOrdersPartDeliv)
            {
                ApplicationArea = All;
                Caption = 'Partially Delivered';
                RunObject = Page "Purchase Order List";
                RunPageView = WHERE(Status=FILTER(Released), Receive=FILTER(true), "Completely Received"=FILTER(false));
            }
            action("Purchase Quotes")
            {
                ApplicationArea = All;
                Caption = 'Purchase Quotes';
                RunObject = Page "Purchase Quotes";
            }
            action("Blanket Purchase Orders")
            {
                ApplicationArea = All;
                Caption = 'Blanket Purchase Orders';
                RunObject = Page "Blanket Purchase Orders";
            }
            action("Purchase Invoices")
            {
                ApplicationArea = All;
                Caption = 'Purchase Invoices';
                RunObject = Page "Purchase Invoices";
            }
            action("Purchase Return Orders")
            {
                ApplicationArea = All;
                Caption = 'Purchase Return Orders';
                RunObject = Page "Purchase Return Order List";
            }
            action("Purchase Credit Memos")
            {
                ApplicationArea = All;
                Caption = 'Purchase Credit Memos';
                RunObject = Page "Purchase Credit Memos";
            }
            action("Assembly Orders")
            {
                ApplicationArea = All;
                Caption = 'Assembly Orders';
                RunObject = Page "Assembly Orders";
            }
            action("Sales Orders")
            {
                ApplicationArea = All;
                Caption = 'Sales Orders';
                Image = "Order";
                RunObject = Page "Sales Order List";
            }
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
            }
            action("Nonstock Items")
            {
                ApplicationArea = All;
                Caption = 'Nonstock Items';
                Image = NonStockItem;
                RunObject = Page "Catalog Item List";
            }
            action("Stockkeeping Units")
            {
                ApplicationArea = All;
                Caption = 'Stockkeeping Units';
                Image = SKU;
                RunObject = Page "Stockkeeping Unit List";
            }
            action("Purchase Analysis Reports")
            {
                ApplicationArea = All;
                Caption = 'Purchase Analysis Reports';
                RunObject = Page "Analysis Report Purchase";
                RunPageView = WHERE("Analysis Area"=FILTER(Purchase));
            }
            action("Inventory Analysis Reports")
            {
                ApplicationArea = All;
                Caption = 'Inventory Analysis Reports';
                RunObject = Page "Analysis Report Inventory";
                RunPageView = WHERE("Analysis Area"=FILTER(Inventory));
            }
            action("Item Journals")
            {
                ApplicationArea = All;
                Caption = 'Item Journals';
                RunObject = Page "Item Journal Batches";
                RunPageView = WHERE("Template Type"=CONST(Item), Recurring=CONST(false));
            }
            action("Purchase Journals")
            {
                ApplicationArea = All;
                Caption = 'Purchase Journals';
                RunObject = Page "General Journal Batches";
                RunPageView = WHERE("Template Type"=CONST(Purchases), Recurring=CONST(false));
            }
            action(RequisitionWorksheets)
            {
                ApplicationArea = All;
                Caption = 'Requisition Worksheets';
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type"=CONST("Req."), Recurring=CONST(false));
            }
            action(SubcontractingWorksheets)
            {
                ApplicationArea = All;
                Caption = 'Subcontracting Worksheets';
                RunObject = Page "Req. Wksh. Names";
                RunPageView = WHERE("Template Type"=CONST("For. Labor"), Recurring=CONST(false));
            }
            action("Standard Cost Worksheets")
            {
                ApplicationArea = All;
                Caption = 'Standard Cost Worksheets';
                RunObject = Page "Standard Cost Worksheet Names";
            }
        }
        area(sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;

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
                action("Posted Return Shipments")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Return Shipments';
                    RunObject = Page "Posted Return Shipments";
                }
                action("Posted Purchase Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Purchase Credit Memos';
                    RunObject = Page "Posted Purchase Credit Memos";
                }
                action("Posted Assembly Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Assembly Orders';
                    RunObject = Page "Posted Assembly Orders";
                }
            }
            group("Cash Management ")
            {
                Description = 'Cash Management ';
                Image = HumanResources;

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
                }
            }
            group("Store Transactions ")
            {
                Caption = 'Store Transactions ';
                Description = 'Store Transactions ';
                Image = Payables;

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
                action("Item Journal Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Item Journal Templates';
                    RunObject = Page "Item Journal Templates";
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
            }
        }
        area(processing)
        {
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
            }
            action("Item &Journal")
            {
                ApplicationArea = All;
                Caption = 'Item &Journal';
                Image = Journals;
                RunObject = Page "Item Journal";
            }
            action("Order Plan&ning")
            {
                ApplicationArea = All;
                Caption = 'Order Plan&ning';
                Image = Planning;
                RunObject = Page "Order Planning";
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
            }
            action("Pur&chase Prices")
            {
                ApplicationArea = All;
                Caption = 'Pur&chase Prices';
                Image = Price;
                RunObject = Page "Purchase Prices";
            }
            action("Purchase &Line Discounts")
            {
                ApplicationArea = All;
                Caption = 'Purchase &Line Discounts';
                Image = LineDiscount;
                RunObject = Page "Purchase Line Discounts";
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
            }
        }
    }
}
