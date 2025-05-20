page 51846 "Warehouse Role Center"
{
    // version THL- PRM 1.0
    Caption = 'Warehouse Worker - Warehouse Management System', Comment = '{Dependency=Match,"ProfileDescription_WAREHOUSEWORKER-WMS"}';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(Control1900724808)
            {
                ShowCaption = false;

                part(Control1901138408; "Warehouse Worker Activities")
                {
                    ApplicationArea = All;
                }
                part(Control1905989608; "My Items")
                {
                    ApplicationArea = All;
                }
            }
            group(Control1900724708)
            {
                ShowCaption = false;

                part(Control1006; "My Job Queue")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                part(Control4; "Report Inbox Part")
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
            action("Warehouse &Bin List")
            {
                ApplicationArea = All;
                Caption = 'Warehouse &Bin List';
                Image = "Report";
                RunObject = Report "Warehouse Bin List";
                ToolTip = 'Get an overview of warehouse bins, their setup, and the quantity of items within the bins.';
            }
            action("Warehouse A&djustment Bin")
            {
                ApplicationArea = All;
                Caption = 'Warehouse A&djustment Bin';
                Image = "Report";
                RunObject = Report "Whse. Adjustment Bin";
                ToolTip = 'Get an overview of warehouse bins, their setup, and the quantity of items within the bins.';
            }
            action("Whse. P&hys. Inventory List")
            {
                ApplicationArea = All;
                Caption = 'Whse. P&hys. Inventory List';
                Image = "Report";
                RunObject = Report "Whse. Phys. Inventory List";
                ToolTip = 'View or print the list of the lines that you have calculated in the Whse. Phys. Invt. Journal window. You can use this report during the physical inventory count to mark down actual quantities on hand in the warehouse and compare them to what is recorded in the program.';
            }
            action("Prod. &Order Picking List")
            {
                ApplicationArea = All;
                Caption = 'Prod. &Order Picking List';
                Image = "Report";
                RunObject = Report "Prod. Order - Picking List";
                ToolTip = 'View a detailed list of items that must be picked for a particular production order, from which location (and bin, if the location uses bins) they must be picked, and when the items are due for production.';
            }
            action("Customer &Labels")
            {
                ApplicationArea = All;
                Caption = 'Customer &Labels';
                Image = "Report";
                RunObject = Report "Customer - Labels";
                ToolTip = 'View, save, or print mailing labels with the customers'' names and addresses. The report can be used to send sales letters, for example.';
            }
        }
        area(embedding)
        {
            action(Picks)
            {
                ApplicationArea = All;
                Caption = 'Picks';
                RunObject = Page "Warehouse Picks";
                ToolTip = 'View the list of ongoing warehouse picks. ';
            }
            action("Put-aways")
            {
                ApplicationArea = All;
                Caption = 'Put-aways';
                RunObject = Page "Warehouse Put-aways";
                ToolTip = 'View the list of ongoing put-aways.';
            }
            action(Movements)
            {
                ApplicationArea = All;
                Caption = 'Movements';
                RunObject = Page "Warehouse Movements";
                ToolTip = 'View the list of ongoing movements between bins according to an advanced warehouse configuration.';
            }
            action(WhseShpt)
            {
                ApplicationArea = All;
                Caption = 'Warehouse Shipments';
                RunObject = Page "Warehouse Shipment List";
                ToolTip = 'View the list of ongoing warehouse shipments.';
            }
            action(WhseShptReleased)
            {
                ApplicationArea = All;
                Caption = 'Released';
                RunObject = Page "Warehouse Shipment List";
                RunPageView = SORTING("No.")WHERE(Status=FILTER(Released));
                ToolTip = 'View the list of released source documents that are ready for warehouse activities.';
            }
            action(WhseShptPartPicked)
            {
                ApplicationArea = All;
                Caption = 'Partially Picked';
                RunObject = Page "Warehouse Shipment List";
                RunPageView = WHERE("Document Status"=FILTER("Partially Picked"));
                ToolTip = 'View the list of ongoing warehouse picks that are partially completed.';
            }
            action(WhseShptComplPicked)
            {
                ApplicationArea = All;
                Caption = 'Completely Picked';
                RunObject = Page "Warehouse Shipment List";
                RunPageView = WHERE("Document Status"=FILTER("Completely Picked"));
                ToolTip = 'View the list of completed warehouse picks.';
            }
            action(WhseShptPartShipped)
            {
                ApplicationArea = All;
                Caption = 'Partially Shipped';
                RunObject = Page "Warehouse Shipment List";
                RunPageView = WHERE("Document Status"=FILTER("Partially Shipped"));
                ToolTip = 'View the list of ongoing warehouse shipments that are partially completed.';
            }
            action(WhseReceipts)
            {
                ApplicationArea = All;
                Caption = 'Warehouse Receipts';
                RunObject = Page "Warehouse Receipts";
                ToolTip = 'View the list of ongoing warehouse receipts.';
            }
            action(WhseReceiptsPartReceived)
            {
                ApplicationArea = All;
                Caption = 'Partially Received';
                RunObject = Page "Warehouse Receipts";
                RunPageView = WHERE("Document Status"=FILTER("Partially Received"));
                ToolTip = 'View the list of ongoing warehouse receipts that are partially completed.';
            }
            action("Transfer Orders")
            {
                ApplicationArea = All;
                Caption = 'Transfer Orders';
                Image = Document;
                RunObject = Page "Transfer Orders";
                ToolTip = 'Open the list of transfer orders where you can transfer items between locations.';
            }
            action("Assembly Orders")
            {
                ApplicationArea = All;
                Caption = 'Assembly Orders';
                RunObject = Page "Assembly Orders";
                ToolTip = 'View ongoing assembly orders.';
            }
            action("Bin Contents")
            {
                ApplicationArea = All;
                Caption = 'Bin Contents';
                Image = BinContent;
                RunObject = Page "Bin Contents List";
                ToolTip = 'View items in the bin if the selected line contains a bin code.';
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
            action(Vendors)
            {
                ApplicationArea = All;
                Caption = 'Vendors';
                Image = Vendor;
                RunObject = Page "Vendor List";
                ToolTip = 'View a list of vendors that you can buy items from.';
            }
            action("Shipping Agents")
            {
                ApplicationArea = All;
                Caption = 'Shipping Agents';
                RunObject = Page "Shipping Agents";
                ToolTip = 'View the list of shipping companies that you use to transport goods.';
            }
            action("Warehouse Employees")
            {
                ApplicationArea = All;
                Caption = 'Warehouse Employees';
                RunObject = Page "Warehouse Employee List";
                ToolTip = 'View the warehouse employees that exist in the system.';
            }
            action(WhsePhysInvtJournals)
            {
                ApplicationArea = All;
                Caption = 'Whse. Phys. Invt. Journals';
                RunObject = Page "Whse. Journal Batches List";
                RunPageView = WHERE("Template Type"=CONST("Physical Inventory"));
                ToolTip = 'Prepare to count inventories by preparing the documents that warehouse employees use when they perform a physical inventory of selected items or of all the inventory. When the physical count has been made, you enter the number of items that are in the bins in this window, and then you register the physical inventory.';
            }
            action("WhseItem Journals")
            {
                ApplicationArea = All;
                Caption = 'Whse. Item Journals';
                RunObject = Page "Whse. Journal Batches List";
                RunPageView = WHERE("Template Type"=CONST(Item));
                ToolTip = 'Adjust the quantity of an item in a particular bin or bins. For instance, you might find some items in a bin that are not registered in the system, or you might not be able to pick the quantity needed because there are fewer items in a bin than was calculated by the program. The bin is then updated to correspond to the actual quantity in the bin. In addition, it creates a balancing quantity in the adjustment bin, for synchronization with item ledger entries, which you can then post with an item journal.';
            }
            action(PickWorksheets)
            {
                ApplicationArea = All;
                Caption = 'Pick Worksheets';
                RunObject = Page "Worksheet Names List";
                RunPageView = WHERE("Template Type"=CONST(Pick));
                ToolTip = 'Plan and initialize picks of items. ';
            }
            action(PutawayWorksheets)
            {
                ApplicationArea = All;
                Caption = 'Put-away Worksheets';
                RunObject = Page "Worksheet Names List";
                RunPageView = WHERE("Template Type"=CONST("Put-away"));
                ToolTip = 'Plan and initialize item put-aways.';
            }
            action(MovementWorksheets)
            {
                ApplicationArea = All;
                Caption = 'Movement Worksheets';
                RunObject = Page "Worksheet Names List";
                RunPageView = WHERE("Template Type"=CONST(Movement));
                ToolTip = 'Plan and initiate movements of items between bins according to an advanced warehouse configuration.';
            }
        }
        area(sections)
        {
            group("Warehouse Operations")
            {
                Caption = 'Warehouse Operations';
                Image = LotInfo;
                ToolTip = 'Management of Procurement Tasks';

                action(Action85)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
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
                action(Action75)
                {
                    ApplicationArea = All;
                    Caption = 'New Purchase Requisition';
                    RunObject = Page "SS Purch Requisitions - Open";
                }
                action("Vendors/Suppliers")
                {
                    ApplicationArea = All;
                    Caption = 'Vendors/Suppliers';
                    RunObject = Page "Vendor List";
                }
                action("New Inspection of Goods/Services")
                {
                    ApplicationArea = All;
                    Caption = 'New Inspection of Goods/Services';
                    RunObject = Page "Inspections - Open";
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
            group("Employee Self Service")
            {
                Caption = 'Employee Self Service';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Acess Services from HR Department';

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
                action("My Fullfilled Purchase Requisitions")
                {
                    ApplicationArea = All;
                    Caption = 'My Fullfilled Purchase Requisitions';
                    RunObject = Page "SS Purch Requisitions - Closed";
                }
                action("New Imprest")
                {
                    ApplicationArea = All;
                    Caption = 'New Imprests';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status=const(Open));
                }
                action("Imprest Pending Approval")
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
                action("Imprest Surrender")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrender';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status=const(Released), "Surrender Posted"=const(true));
                }
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
                action("Processed Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status=const(Released), Posted=const(true));
                }
            }
            group("Registered Documents")
            {
                Caption = 'Registered Documents';
                Image = RegisteredDocs;

                action("Registered Picks")
                {
                    ApplicationArea = All;
                    Caption = 'Registered Picks';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Picks";
                    ToolTip = 'View warehouse picks that have been performed.';
                }
                action("Registered Put-aways")
                {
                    ApplicationArea = All;
                    Caption = 'Registered Put-aways';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Put-aways";
                    ToolTip = 'View the list of completed put-away activities.';
                }
                action("Registered Movements")
                {
                    ApplicationArea = All;
                    Caption = 'Registered Movements';
                    Image = RegisteredDocs;
                    RunObject = Page "Registered Whse. Movements";
                    ToolTip = 'View the list of completed warehouse movements.';
                }
                action("Posted Whse. Receipts")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Whse. Receipts';
                    Image = PostedReceipts;
                    RunObject = Page "Posted Whse. Receipt List";
                    ToolTip = 'Open the list of posted warehouse receipts.';
                }
            }
        }
        area(processing)
        {
            action("Whse. P&hysical Invt. Journal")
            {
                ApplicationArea = All;
                Caption = 'Whse. P&hysical Invt. Journal';
                Image = InventoryJournal;
                RunObject = Page "Whse. Phys. Invt. Journal";
                ToolTip = 'Prepare to count inventories by preparing the documents that warehouse employees use when they perform a physical inventory of selected items or of all the inventory. When the physical count has been made, you enter the number of items that are in the bins in this window, and then you register the physical inventory.';
            }
            action("Whse. Item &Journal")
            {
                ApplicationArea = All;
                Caption = 'Whse. Item &Journal';
                Image = BinJournal;
                RunObject = Page "Whse. Item Journal";
                ToolTip = 'Adjust the quantity of an item in a particular bin or bins. For instance, you might find some items in a bin that are not registered in the system, or you might not be able to pick the quantity needed because there are fewer items in a bin than was calculated by the program. The bin is then updated to correspond to the actual quantity in the bin. In addition, it creates a balancing quantity in the adjustment bin, for synchronization with item ledger entries, which you can then post with an item journal.';
            }
            action("Pick &Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Pick &Worksheet';
                Image = PickWorksheet;
                RunObject = Page "Pick Worksheet";
                ToolTip = 'Plan and initialize picks of items. ';
            }
            action("Put-&away Worksheet")
            {
                ApplicationArea = All;
                Caption = 'Put-&away Worksheet';
                Image = PutAwayWorksheet;
                RunObject = Page "Put-away Worksheet";
                ToolTip = 'Plan and initialize item put-aways.';
            }
            action("M&ovement Worksheet")
            {
                ApplicationArea = All;
                Caption = 'M&ovement Worksheet';
                Image = MovementWorksheet;
                RunObject = Page "Movement Worksheet";
                ToolTip = 'Prepare to move items between bins within the warehouse.';
            }
        }
    }
}
