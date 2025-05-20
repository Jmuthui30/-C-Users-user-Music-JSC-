page 51876 "Motorpool Role Center"
{
    // version THL- PRM 1.0
    Caption = 'Purchasing Agent', Comment = '{Dependency=Match,"ProfileDescription_PURCHASINGAGENT"}';
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
            action(Drivers)
            {
                ApplicationArea = All;
                Caption = 'Drivers';
                RunObject = Page "Driver List";
            }
            action(Vehicles)
            {
                ApplicationArea = All;
                Caption = 'Vehicles';
                RunObject = Page "Vehicle List";
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
            group("Work Tickets")
            {
                Caption = 'Work Tickets';
                Image = Job;

                action("New Work Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'New Work Tickets';
                    RunObject = Page "Work Tickets-Open";
                }
                action("Issued Work Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'Issued Work Tickets';
                    RunObject = Page "Work Tickets-Issued";
                }
                action("Closed Work Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'Closed Work Tickets';
                    RunObject = Page "Work Tickets-Closed";
                }
                action("Canceled Work Tickets")
                {
                    ApplicationArea = All;
                    Caption = 'Canceled Work Tickets';
                    RunObject = Page "Work Tickets-Canceled";
                }
            }
            group("Fuel Consumption")
            {
                Caption = 'Fuel Consumption';
                Image = Statistics;

                action("New Fuel Consumption")
                {
                    ApplicationArea = All;
                    Caption = 'New Fuel Consumption';
                    RunObject = Page "Fuel Consumption-Open";
                }
                action("Fuel Consumption History")
                {
                    ApplicationArea = All;
                    Caption = 'Fuel Consumption History';
                    RunObject = Page "Fuel Consumption-Closed";
                }
                action("New Fuel Voucher")
                {
                    ApplicationArea = All;
                    Caption = 'New Fuel Voucher';
                    RunObject = Page "Fuel Vouchers-Open";
                }
                action("Printed Fuel Vouchers")
                {
                    ApplicationArea = All;
                    Caption = 'Printed Fuel Vouchers';
                    RunObject = Page "Fuel Vouchers-Posted";
                }
                action("Fuel Cards")
                {
                    ApplicationArea = All;
                    Caption = 'Fuel Cards';
                    RunObject = Page "Fuel Cards";
                }
            }
            group("Vehicle Service & Maintenance")
            {
                Caption = 'Vehicle Service & Maintenance';
                Image = CostAccounting;

                action("New Vehicle Service")
                {
                    ApplicationArea = All;
                    Caption = 'New Vehicle Service';
                    RunObject = Page "Vehicle Service-Open";
                }
                action("Vehicle Service History")
                {
                    ApplicationArea = All;
                    Caption = 'Vehicle Service History';
                    RunObject = Page "Vehicle Service-Closed";
                }
            }
            group("Cost Analysis")
            {
                Caption = 'Cost Analysis';
                Image = Payables;

                action("Monthly Cost Analysis")
                {
                    ApplicationArea = All;
                    Caption = 'Monthly Cost Analysis';
                    RunObject = Page "Monthly Cost Analyses - Open";
                }
                action("My Site Cost Centers")
                {
                    ApplicationArea = All;
                    Caption = 'My Site Cost Centers';
                    RunObject = Page "My Site Cost Centers";
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
                    Caption = 'New Imprest';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status=const(Open));
                }
                action("Imprest Requests Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprests Pending Approval';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status=const("Pending Approval"));
                }
                action("Approved Imprest Requests")
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
            }
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                ToolTip = 'Approve requests made by other users.';

                action("Motorpool Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Motorpool Setup';
                    RunObject = Page "Motorpool Setup";
                }
                action("Motorpool Costs")
                {
                    ApplicationArea = All;
                    Caption = 'Motorpool Costs';
                    RunObject = Page "Motorpool Costs";
                }
                action("Cost Periods")
                {
                    ApplicationArea = All;
                    Caption = 'Cost Periods';
                    RunObject = Page "Cost Periods";
                }
                action("Motorpool Cost Centers")
                {
                    ApplicationArea = All;
                    Caption = 'Motorpool Cost Centers';
                    RunObject = Page "Motorpool Cost Centers";
                }
                action("Service & Check Codes")
                {
                    ApplicationArea = All;
                    Caption = 'Service & Check Codes';
                    RunObject = Page "Service & Check Codes";
                }
                action("Fuel Voucher Stations")
                {
                    ApplicationArea = All;
                    Caption = 'Fuel Voucher Stations';
                    RunObject = Page "Fuel Voucher Stations";
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
    }
}
