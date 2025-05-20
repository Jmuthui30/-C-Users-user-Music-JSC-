page 51776 "Employee Self Service"
{
    // version THL- HRM 1.0
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'Employee Self Service Role Center';
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
            action("SS My Staff Profile")
            {
                ApplicationArea = All;
                Caption = 'My Staff Profile';
                ToolTip = 'Your Staff Profile';
                RunObject = Page "SS Employee Card";
            }
            action("Update Status")
            {
                ApplicationArea = All;
                Caption = 'Update My Status';
                RunObject = Page "Update My Status";
            }
            action("SS Company Documents")
            {
                ApplicationArea = All;
                Caption = 'Company Documents';
                RunObject = Page "SS Company Documents";
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
            group("Strore")
            {
                Caption = 'Stores';

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
            group("Purchase")
            {
                Caption = 'Purchases';

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
                //ProcurementPlan
                action("Create Procurement Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Procurement Plan';
                    ToolTip = 'Create a new Procurement Plan';
                    RunObject = Page "Procurement Plans";
                    RunPageView = where(Status = const(Open));
                }
                action("Procurement Plan Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Procurement Plan Approval';
                    ToolTip = 'View and approve Procurement Plan';
                    RunObject = Page "Procurement Plans";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Procurement Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Procurement Plan';
                    ToolTip = 'View approved Procurement Plan';
                    RunObject = Page "Procurement Plans";
                    RunPageView = where(Status = const(Released));
                }
            }
            group("Finance")
            {
                Caption = 'Finance';

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
                    RunPageView = where(Status = const(Released), Posted = const(false));
                }
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
                action("Imprest Payroll Claims")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Payroll Claims';
                    RunObject = Page "Imprest Payroll Claims List";
                }
                action("Imprest Payroll Claims Open")
                {
                    ApplicationArea = All;
                    Caption = 'Open';
                    RunObject = Page "Imprest Payroll Claims List";
                    RunPageView = where(Status = const(Open));
                }
                action("Imprest Payroll Claims Pending")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval';
                    RunObject = Page "Imprest Payroll Claims List";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Imprest Payroll Claims Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Approved';
                    RunObject = Page "Imprest Payroll Claims List";
                    RunPageView = where(Status = const(Released));
                }
                action("New Imprests")
                {
                    ApplicationArea = All;
                    Caption = 'New Imprests';
                    RunObject = Page "SS Imprests";
                    RunPageView = where(Status = const(Open));
                }
                action("Pending Approval Imprests")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval Imprests';
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
                action("UnSurrendered Expenses")
                {
                    ApplicationArea = All;
                    Caption = 'UnSurrendered Cash';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = filter(Open | Rejected), "Surrender Posted" = const(false));
                }
                action("Imprest Surrender Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Imprest Surrender Approval';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const("Pending Approval"), "Surrender Posted" = const(false));
                }
                action("Unposted Imprest Surrender")
                {
                    ApplicationArea = All;
                    Caption = 'Unposted Imprest Surrender';
                    RunObject = Page "SS Imprest Surrenders";
                    RunPageView = where(Status = const(Released), "Surrender Posted" = const(false));
                }
                action("Create New Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'New Staff Claim';
                    RunObject = Page "SS Staff Claims";
                    RunPageView = where(Status = const(Open));
                }
                action("Staff Claim Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Staff Claim Approvals';
                    RunObject = Page "SS Staff Claims";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Staff Claim")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Staff Claim';
                    RunObject = Page "SS Staff Claims";
                    RunPageView = where(Status = const(Released), "Claim Posted" = const(false));
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
                    action("Posted Imprest Surrenders")
                    {
                        ApplicationArea = All;
                        Caption = 'Posted Imprest Surrenders';
                        RunObject = Page "SS Imprest Surrenders";
                        RunPageView = where(Status = const(Released), "Surrender Posted" = const(true));
                    }
                    action("Posted Staff Claim")
                    {
                        ApplicationArea = All;
                        Caption = 'Posted Staff Claim';
                        RunObject = Page "SS Staff Claims";
                        RunPageView = where(Status = const(Released), "Claim Posted" = const(true));
                    }
                }
            }
            group("HR")
            {
                Caption = 'HR';

                // action("New Req. Request Header")
                // {
                //     ApplicationArea = All;
                //     Caption = 'New Recruitment Requests';
                //     RunObject = Page "SS Recruitment Requests";
                //     RunPageView = where(Status = const(Open));
                // }
                // action("Pending Request Header")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Pending Recruitment Requests';
                //     RunObject = Page "SS Recruitment Requests";
                //     RunPageView = where(Status = const("Pending Approval"));
                // }
                // action("Approved Request Header")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Approved Recruitment Requests';
                //     RunObject = Page "SS Recruitment Requests";
                //     RunPageView = where(Status = const(Released), Advertised = const(false));
                // }
                // action("Processed Request Header")
                // {
                //     ApplicationArea = All;
                //     Caption = 'Processed Recruitment Requests';
                //     RunObject = Page "SS Recruitment Requests";
                //     RunPageView = where(Status = const(Released), Advertised = const(true));
                // }
                action("Jobs_To_Apply")
                {
                    ApplicationArea = All;
                    Caption = 'Jobs To Apply';
                    RunObject = Page "Approved Recruitment Request";
                    RunPageView = WHERE(Status = CONST(Released), "Advertisement Status" = const(Open), "Advertisement Type" = filter(Internal | Both));
                }
                action("SS New Orientation Checklist")
                {
                    ApplicationArea = All;
                    Caption = 'New Orientation Checklist';
                    RunObject = Page "SS Orientation List-Open";
                }
                action("SS New Leave Plan")
                {
                    ApplicationArea = All;
                    Caption = 'New Leave Plan';
                    RunObject = Page "SS Employee Leave Plans";
                    RunPageView = where(Status = const(open));
                }
                action("SS Leave Plan Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Plan Approval';
                    RunObject = Page "SS Employee Leave Plans";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("SS Approved Leave Plan")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Plan';
                    RunObject = Page "SS Employee Leave Plans";
                    RunPageView = where(Status = const(Released));
                }
                action("SS New Leave Application")
                {
                    ApplicationArea = All;
                    Caption = 'New Leave Application';
                    RunObject = Page "SS Leave Applications - Open";
                }
                action("SS Approval Leave Application")
                {
                    ApplicationArea = All;
                    Caption = 'Approval Leave Application';
                    RunObject = Page "SS Leave Applications-Approval";
                }
                action("SS Leave App Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Application Approved';
                    RunObject = Page "SS Leave Applications-Approved";
                }
                action("SS Appraisal")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal';
                    RunObject = Page "SS Bal App Score Card List";
                }
                action("SS Internal Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Form';
                    RunObject = Page "Internal Memo - Self Service";
                }
                action("SS New Training")
                {
                    ApplicationArea = All;
                    Caption = 'New Training';
                    RunObject = Page "SS Training List - Open";
                }
                action("New Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'New Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "SS Incidences/Grievances";
                    RunPageView = where(Status = const(New));
                }
                action("Reported Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'Reported Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "SS Incidences/Grievances";
                    RunPageView = where(Status = const(Reported));
                }
                action("Closed Incidences Grievances")
                {
                    ApplicationArea = All;
                    Caption = 'Closed/Resolved Grievances';
                    Image = PersonInCharge;
                    RunObject = Page "SS Closed User Grievances";
                    RunPageView = where(Status = const(Closed));
                }
                group("SS Report & Analysis")
                {
                    Caption = 'Reports & Analysis';

                    action("SS Payslip")
                    {
                        ApplicationArea = All;
                        Caption = 'Payslip';
                        ToolTip = 'Your Payslip';
                        RunObject = Report Payslip;
                    }
                }
                group("SS Documents")
                {
                    Caption = 'Documents';

                    action("SS Leave Application Pending Approval")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Application Pending Approval';
                        RunObject = Page "SS Leave Applications-Approval";
                    }
                    action("SS Training Pending Approval")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Pending Approval';
                        RunObject = Page "SS Training List - Approval";
                    }
                }
                group("SS Archive")
                {
                    Caption = 'Archive';

                    action("SS Leave Application Approved")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Leave Application';
                        RunObject = Page "SS Leave Applications-Approved";
                    }
                    action("SS Training Approved")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Training ';
                        RunObject = Page "SS Training List - Approved";
                    }
                }
            }
            group(Disciplinary)
            {
                Caption = 'Disciplinary & Misconduct';

                action("Accusations")
                {
                    ApplicationArea = All;
                    Caption = 'Accused Cases';
                    RunObject = page "SS Staff Displinary Cases";
                    RunPageView = where(Status = const(Accusations));
                }
                action("Filed Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Filed Cases';
                    RunObject = page "SS Staff Displinary Cases";
                    RunPageView = where(Status = filter("Action Taken" | Closed));
                }
            }
            group("Fleet Service")
            {
                action("Work Tickets-Open")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Work Tickets';
                    RunObject = page "Work Tickets-Open";
                    RunPageView = where(Status = const(Open));
                }
                action("Work Tickets Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Work Ticket Pending Approval';
                    RunObject = page "Work Tickets-Open";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Work Tickets Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Work Ticket Approved';
                    RunObject = page "Work Tickets-Open";
                    RunPageView = where(Status = const(Released));
                }
                action("Create Repair Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Repair Requisition';
                    ToolTip = 'Create a new Repair Requisition';
                    RunObject = Page "Repair Requisition List";
                    RunPageView = where(Status = const(Open));
                }
                action("Repair Requisition Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Repair Requisition Approval';
                    ToolTip = 'View and approve Repair Requisition';
                    RunObject = Page "Repair Requisition List";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("Approved Repair Requisition")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Repair Requisition';
                    ToolTip = 'View Approved Repair Requisition';
                    RunObject = Page "Repair Requisition List";
                    RunPageView = where(Status = const(Released), "RR Closed" = const(false));
                }
            }
            group("Mail Service")
            {
                action("Create New Incoming Mails")
                {
                    ApplicationArea = All;
                    Caption = 'Create New Incoming Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status = const(Open), "Mail Type" = const("Incoming Mail"), Posted = const(false));
                }
                action("Create New Outgoing Mails")
                {
                    ApplicationArea = All;
                    Caption = 'Create New outgoing Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status = const(Open), "Mail Type" = const("Outgoing Mail"), Posted = const(false));
                }
                action("Closed Incoming Mails")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Closed Incoming Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status = const(Fulfilled), "Mail Type" = const("Incoming Mail"), Posted = const(true));
                }
                action("Closed Outgoing Mails")
                {
                    Visible = false;
                    ApplicationArea = All;
                    Caption = 'Closed outgoing Mails';
                    RunObject = page "Mail Detail list";
                    RunPageView = where(Status = const(Fulfilled), "Mail Type" = const("Outgoing Mail"), Posted = const(true));
                }
            }
        }
    }
    var
        UserSetup: Record "User Setup";
        NAVEmp: Record Employee;
}
