page 51887 "Principal Investigator RC"
{
    // version THL- HRM 1.0
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'Principal Investigator Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control46; "Team Member Activities")
            {
                ApplicationArea = Suite;
            }
            part(Control96; "Report Inbox Part")
            {
                ApplicationArea = Basic, Suite;
            }
            // part(Control98; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
        }
    }
    actions
    {
        area(processing)
        {
            group(Reports)
            {
                Caption = 'Reports';

                group("My Reports")
                {
                    Caption = 'My Reports';
                    Image = ReferenceData;
                    Visible = false;

                    action(Payslips)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payslips';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report Payslip;
                        ToolTip = 'View Employee Payslips';
                    }
                    action(P9A)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'P9A';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report P9A;
                        ToolTip = 'View Employee P9A Report';
                    }
                    action("Leave Balances")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Leave Balances';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Leave Balance";
                        ToolTip = 'View Employee Leave Balances';
                    }
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';

            action("New Imprest")
            {
                ApplicationArea = All;
                Caption = 'New Imprest';
                RunObject = Page "SS Imprests";
                RunPageView = where(Status = const(Open));
            }
            action("Imprest Pending Approval")
            {
                ApplicationArea = All;
                Caption = 'Imprest Pending Approval';
                RunObject = Page "SS Imprests";
                RunPageView = where(Status = const("Pending Approval"));
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
                    ApplicationArea = Suite;
                    Caption = 'Requests to Approve';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'View the number of approval requests that require your approval.';
                }
                action("Time Sheet Approval")
                {
                    ApplicationArea = Suite;
                    Caption = 'Time Sheet Approval';
                    RunObject = Page "Manager Time Sheet List";
                }
            }
            group("My Staff Profile")
            {
                Caption = 'My Staff Profile';
                Image = HRSetup;
                ToolTip = 'All staff electronic records';

                action(Action34)
                {
                    ApplicationArea = Suite;
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
                Visible = false;

                action("New Leave Application")
                {
                    ApplicationArea = Suite;
                    Caption = 'New Leave Application';
                    Image = PersonInCharge;
                    RunObject = Page "SS Leave Applications - Open";
                }
                action("Leave Applications Pending Approval")
                {
                    ApplicationArea = Suite;
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
                Visible = false;

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
                Visible = false;

                action(Action11)
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
                Visible = false;

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
                Visible = false;

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
                Visible = false;

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
                Visible = false;

                action(Action102)
                {
                    ApplicationArea = Suite;
                    Caption = 'Company Documents';
                    Image = PersonInCharge;
                    RunObject = Page "Company Documents";
                }
            }
            group(HSE)
            {
                Caption = 'Incidence & Grievances';
                Image = Travel;
                ToolTip = 'Health, Safety and Environment Issues';

                action("New Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'New Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "Incidences/Grievances";
                    RunPageView = where(Status = const(New));
                }
                action("Reported Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'Reported Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "Incidences/Grievances";
                    RunPageView = where(Status = const(Reported));
                }
                action("Closed Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'Closed/Resolved Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "Incidences/Grievances";
                    RunPageView = where(Status = const(Closed));
                }
            }
            group(Finance)
            {
                Caption = 'Finance';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Acess Services from HR Department';

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
                group("SS Archives")
                {
                    Caption = 'Archives';

                    action("Processed Petty Cash Requests")
                    {
                        ApplicationArea = All;
                        Caption = 'Processed Petty Cash Requests';
                        RunObject = Page "SS Petty Cash";
                        RunPageView = where(Status = const(Released), Posted = const(true));
                    }
                }
            }
        }
    }
    var
        UserSetup: Record "User Setup";
        NAVEmp: Record Employee;
}
