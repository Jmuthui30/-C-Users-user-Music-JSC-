page 52145 "General User"
{
    // version THL- PRM 1.0
    Caption = 'General User';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
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
        area(Reporting)
        {
            action("R_SS Payslip")
            {
                ApplicationArea = All;
                Caption = 'Payslip';
                ToolTip = 'Your Payslip';
                RunObject = Report Payslip;
            }
        }
        area(Embedding)
        {
            action("E_SS My Staff Profile")
            {
                ApplicationArea = All;
                Caption = 'My Staff Profile';
                ToolTip = 'Your Staff Profile';
                RunObject = Page "SS Staff Profile";
            }
        }
        area(Sections)
        {
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
                action("Processed Petty Cash Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Processed Petty Cash Requests';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status=const(Released), Posted=const(true));
                }
            }
            group("HR Self Service")
            {
                Caption = 'HR Self Service';
                Visible = false;

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
                    RunObject = Page "SS Employee Leave Plan";
                }
                action("SS New Leave Application")
                {
                    ApplicationArea = All;
                    Caption = 'New Leave Application';
                    RunObject = Page "SS Leave Application - Open";
                }
                action("SS Appraisal Objectives")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Objectives';
                    RunObject = Page "SS Appraisal Objectives";
                }
                action("SS Appraisal Form")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Form';
                    RunObject = Page "SS Employee Appraisals";
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
                group("SS Administration")
                {
                    Caption = 'Administration';

                    action("SS My Staff Profile")
                    {
                        ApplicationArea = All;
                        Caption = 'My Staff Profile';
                        ToolTip = 'Your Staff Profile';
                        RunObject = Page "SS Staff Profile";
                    }
                    action("SS Company Documents")
                    {
                        ApplicationArea = All;
                        Caption = 'Company Documents';
                        RunObject = Page "SS Company Documents";
                    }
                }
            }
        }
        area(Creation)
        {
            action("C_SS New Leave Application")
            {
                ApplicationArea = All;
                Caption = 'New Leave Application';
                RunObject = Page "SS Leave Application - Open";
            }
            action("C_New Store Requisition")
            {
                ApplicationArea = All;
                Caption = 'New Store Requisition';
                RunObject = Page "SS Store Requisitions - Open";
            }
            action("C_New Purchase Requisition")
            {
                ApplicationArea = All;
                Caption = 'New Purchase Requisition';
                RunObject = Page "SS Purch Requisitions - Open";
            }
            action("C_SS New Petty Cash Request")
            {
                ApplicationArea = All;
                Caption = 'New Petty Cash Request';
                RunObject = Page "SS Petty Cash";
                RunPageView = where(Status=const(Open));
            }
        }
    }
}
