page 51488 "HR Officer Role Center"
{
    Caption = 'HR Officer Role Center';
    PageType = RoleCenter;

    //SourceTable = "";
    layout
    {
        area(rolecenter)
        {
            part(Control16; "Payroll Activities")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = All;
            }
            part(Control55; "Help And Chart Wrapper")
            {
                //Commented by Henry//AccessByPermission = TableData "Assisted Setup" = R;
                ApplicationArea = All;
                Caption = '';
                ToolTip = 'Specifies the view of your business assistance';
            }
            part(Control46; "Team Member Activities")
            {
                ApplicationArea = All;
            }
            part("Favorite Accounts"; "My Accounts")
            {
                ApplicationArea = All;
                Caption = 'Favorite Accounts';
            }
            part(Control96; "Report Inbox Part")
            {
                ApplicationArea = All;
            }
            // part(Control98; "Power BI Report Spinner Part")
            // {
            //     ApplicationArea = Basic, Suite;
            // }
        }
    }
    actions
    {
        area(reporting)
        {
            action("Reported Incidents")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Reported Incidents';
                RunObject = Page "Incidences/Grievances";
                RunPageView = where(Status = filter(<> New));
                ToolTip = 'Open Reported User Grievances';
            }
            group("Management Reports")
            {
                Caption = 'Management Reports';
                Image = ReferenceData;

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
                action("Master Roll")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Master Roll';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Master Roll Report";
                    ToolTip = 'View Master Roll Report';
                }
                action("Monthly PAYE Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Monthly PAYE Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Monthly PAYE Report";
                    ToolTip = 'View the monthly PAYE Report';
                }
                action("Earnings Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Earnings Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report Earnings;
                    ToolTip = 'View Earnings Report';
                }
                action("Deductions Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Deductions Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report Deductions;
                }
                action("SHIF Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'SHIF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report SHIF;
                    ToolTip = 'View SHIF Report';
                }
                action("NSSF Report")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'NSSF Report';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report NSSF;
                    ToolTip = 'View NSSF Report';
                }
                action("Bank List")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank List';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Bank List";
                    ToolTip = 'View Bank List Report';
                }
                action("Bank Instruction")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Bank Instruction';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Bank Instruction Format 2";
                    ToolTip = 'Generate Instruction to the Bank';
                }
                action("Company Totals")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Totals';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Company Totals";
                    ToolTip = 'View the Company Totals Report';
                }
                action("Accounted Time")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounted Time';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Time Sheet Entries";
                }
            }
            group("Statutory Reports")
            {
                Caption = 'Statutory Reports';
                Image = ReferenceData;

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
            }
            group("HR & Admin Reports")
            {
                Caption = 'HR & Admin Reports';
                Image = ReferenceData;

                action("Employee Details")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Employee Details';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Employee Details";
                    ToolTip = 'View Employee Details';
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
                action("Outstanding Leave Days")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Outstanding Leave Days';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Outstanding Leave Days";
                    ToolTip = 'View Outstanding Leave Days for all staff';
                }
                action("Staff On Leave")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff On Leave';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Staff On Leave";
                    ToolTip = 'View Staff On Leave';
                }
                action("Leave Grant Paid")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Leave Grant Paid';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Leave Grant Paid";
                    ToolTip = 'View Staff whose Leave grant has been paid';
                }
                action("Staff on Excuse Duty")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Staff on Excuse Duty';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Excuse Duty";
                    ToolTip = 'View Staff on excuse duty';
                }
                action("Imprest Summary")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Imprest Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Imprest Summary";
                }
                action("Petty Cash Summary")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Petty Cash Summary';
                    Image = "Report";
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;
                    RunObject = Report "Petty Cash Summary";
                }
            }
        }
        area(embedding)
        {
            ToolTip = 'Manage your Human Resource Management and Payroll Management';

            action("Employee Master")
            {
                ApplicationArea = All;
                Caption = 'Employee Master';
                Image = PersonInCharge;
                RunObject = Page "HR Employee List";
                ToolTip = 'View the employee details';
            }
            action("HRSetup")
            {
                ApplicationArea = All;
                Image = HRSetup;
                Caption = 'HR Setup';
                RunObject = Page "QuantumJumps HR Setup";
                ToolTip = 'Perform Human Resource Setup';
            }
        }
        area(sections)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                ToolTip = 'Approve requests made by other users.';

                action(Action77)
                {
                    ApplicationArea = Suite;
                    Caption = 'Requests to Approve';
                    Image = Approvals;
                    RunObject = Page "Requests to Approve";
                    ToolTip = 'View the number of approval requests that require your approval.';
                }
            }
            group(CompanyInformation)
            {
                Caption = 'Company Information';
                ToolTip = 'Company Information List';

                action("Board Of Directors")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Board Of Directors';
                    RunObject = Page "Board Of Directors";
                    ToolTip = 'Open Board Of Directors';
                }
                action("Dimensions")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                    RunObject = Page Dimensions;
                    ToolTip = 'Open Dimensions';
                }
                action("Company Establishments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Company Establishments';
                    RunObject = Page "Company Job List";
                    ToolTip = 'Open Company Establishments';
                }
                group(Task)
                {
                    Caption = 'Task';
                    ToolTip = 'Company Information Tasks';

                    action("Base Calendar")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Base Calendar';
                        RunObject = Page "Base Calendar List";
                        ToolTip = 'Open Base Calendar';
                    }
                    action("Committees")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Committees';
                        RunObject = Page Committees;
                        ToolTip = 'Open Committees';
                    }
                }
                group(Administration)
                {
                    Caption = 'Administration';
                    ToolTip = 'Company Information Administration';

                    action("Company Information")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Company Information';
                        RunObject = Page "Company Information";
                        ToolTip = 'Open Company Information';
                    }
                    action("CompanyDocuments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Company Documents';
                        RunObject = Page "Company Documents";
                        ToolTip = 'Open Company Documents';
                    }
                }
            }
            group(Recruitment)
            {
                Caption = 'Recruitment';
                ToolTip = 'Recruitment Process';

                group("Recruitment Plan")
                {
                    Caption = 'Recruitment Plan';
                    ToolTip = 'Recruitment Plan';

                    action("Open Recruitment Plan")
                    {
                        ApplicationArea = All;
                        Caption = 'Open Recruitment Plan';
                        RunObject = Page "Recruitment Plans";
                        RunPageView = where(Status = const(Open));
                    }
                    action("Pending Recruitment Plan")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Recruitment Plan';
                        RunObject = Page "Recruitment Plans";
                        RunPageView = where(Status = const("Pending Approval"));
                    }
                    action("Approved Recruitment Plan")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Recruitment Plan';
                        RunObject = Page "Recruitment Plans";
                        RunPageView = where(Status = const(Released));
                    }
                }
                group("Consolidated Recruitment Plans")
                {
                    action("Open Consolidated Recruitment Plan")
                    {
                        ApplicationArea = All;
                        Caption = 'Open';
                        RunObject = Page "Consolidated Recruitment Plans";
                        RunPageView = where(Status = const(Open));
                    }
                    action("Pending Consolidated Recruitment Plan")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Approval';
                        RunObject = Page "Consolidated Recruitment Plans";
                        RunPageView = where(Status = const("Pending Approval"));
                    }
                    action("Approved Consolidated Recruitment Plan")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved';
                        RunObject = Page "Consolidated Recruitment Plans";
                        RunPageView = where(Status = const(Released));
                    }
                }
                action("Vacant Positions")
                {
                    ApplicationArea = All;
                    Caption = 'Vacant Positions';
                    ToolTip = 'Open Vacant Positions';
                    RunObject = Page "Vacant Positions";
                }
                action("New Req. Request Header")
                {
                    ApplicationArea = All;
                    Caption = 'New Recruitment Requests';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = where(Status = const(Open));
                    Visible = false;
                }
                group("Recruitement Request")
                {
                    action("Create New Recruitment Request")
                    {
                        ApplicationArea = All;
                        Caption = 'Create New Recruitment Request';
                        ToolTip = 'Open Create New Recruitment Request';
                        RunObject = Page "Create New Recruitment Req.";
                    }
                    action("Approved Recruitment Requests")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Recruitment Requests';
                        ToolTip = 'Open Approved Recruitment Requests';
                        RunObject = Page "Approved Recruitment Request";
                    }
                    action("Pending Request Header")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Recruitment Requests';
                        RunObject = Page "Recruitment Requests";
                        RunPageView = where(Status = const("Pending Approval"));
                    }
                    action("Closed Recruitment Requests")
                    {
                        ApplicationArea = All;
                        Caption = 'Closed Recruitment Requests';
                        ToolTip = 'Open Recruitment Criteria';
                        RunObject = Page "Closed Recruitment Needs";
                    }
                }
                action("Advertised Recruitment Requests")
                {
                    ApplicationArea = All;
                    Caption = 'Advertised Recruitment Requests';
                    RunObject = Page "Advertised Recruitment Needs";
                    RunPageView = where(Status = filter(Released), Advertised = const(true));
                    Visible = true;
                }
                action("Approved Request Header")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Recruitment Requests';
                    RunObject = Page "Recruitment Requests";
                    RunPageView = where(Status = const(Released), Advertised = const(false));
                    Visible = false;
                }
                // action("recruitmentn plan")
                // {
                //     ApplicationArea=All;
                //     Caption='Recruitment Plan';
                //     ToolTip='Open Recruitment Plan';
                //     RunObject=page "recruitment plan";
                // }
                action("Recruitment Criteria")
                {
                    ApplicationArea = All;
                    Caption = 'Recruitment Criteria';
                    ToolTip = 'Open Recruitment Criteria';
                    RunObject = Page "Shortlisting Criteria List";
                }
                action("All Applicants")
                {
                    ApplicationArea = All;
                    Caption = 'Applicants';
                    RunObject = Page "Applicant List-All";
                }
                group(Tasks)
                {
                    Caption = 'Tasks';
                    ToolTip = 'Task Processes';

                    action("Long List")
                    {
                        ApplicationArea = All;
                        Caption = 'Long List';
                        RunObject = page "Long listings";
                    }
                    action("Shortlist")
                    {
                        ApplicationArea = All;
                        Caption = 'Shortlist';
                        RunObject = Page Shortlistings;
                    }
                    action(Interview)
                    {
                        ApplicationArea = All;
                        Caption = 'Interview';
                        ToolTip = 'Perform Interview';
                        RunObject = Page "Interview Criteria List";
                    }
                    action("Medical Examination")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Perform Mediacal Examination';
                        RunObject = Page "Medical Examination List";
                    }
                }
                group("Recruitment Administration")
                {
                    Caption = 'Administration';
                    ToolTip = 'Recuitment Setups';

                    action("Recruitment Stage")
                    {
                        ApplicationArea = All;
                        Caption = 'Recruitment Stage';
                        ToolTip = 'Recruitment Stage List';
                        RunObject = Page "Recruitment Stages";
                    }
                }
            }
            group("Employee Onboarding")
            {
                Caption = 'Employee Onboarding';
                Image = HumanResources;
                ToolTip = 'Handling of new staff joining the organization';

                action("Applicant Master")
                {
                    ApplicationArea = Suite;
                    Caption = 'Applicant Master';
                    Image = PersonInCharge;
                    RunObject = Page "Applicant List";
                    ToolTip = 'View the applicants details';
                }
                action("Offers Made")
                {
                    ApplicationArea = Suite;
                    Caption = 'Offers Made';
                    RunObject = Page "Applicant List-Offer Made";
                }
                action("Offers Accepted")
                {
                    ApplicationArea = Suite;
                    Caption = 'Offers Accepted';
                    RunObject = Page "Applicant List-Offer Accepted";
                }
                action("Create Orientation Checklist")
                {
                    ApplicationArea = Suite;
                    Caption = 'Create Orientation Checklist';
                    ToolTip = 'Create Orientation Checklist For Employees';
                    RunObject = Page "Orientation List-Open";
                }
                action("Staff Orientation Checklist Awaiting Approval")
                {
                    ApplicationArea = Suite;
                    Caption = 'Staff Orientation Checklist Awaiting Approval';
                    RunObject = Page "Orientation List-Approval";
                }
                group("Onboarding History")
                {
                    Caption = 'History';
                    ToolTip = 'Open Archive/History';

                    action("Reported to Work")
                    {
                        ApplicationArea = All;
                        Caption = 'Reported to Work';
                        RunObject = Page "Applicant List-Reported";
                    }
                    action("Offers Rejected")
                    {
                        ApplicationArea = All;
                        Caption = 'Offers Rejected';
                        RunObject = Page "Applicant List-Offer Rejected";
                    }
                    action("Approved Staff Orientation Checklist")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Staff Orientation Checklist';
                        RunObject = Page "Orientation List-Approved";
                    }
                }
                group("Onboarding Administration")
                {
                    Caption = 'Administration';
                    ToolTip = 'Employee Onboarding Setup';

                    action("Orientation Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'Orientation Checklist Setup';
                        ToolTip = 'Setup Orientation Checklist';
                        RunObject = Page "Orientation Checklist Setup";
                    }
                }
            }
            group("Staff Records")
            {
                Caption = 'Staff Records';
                Image = HRSetup;
                ToolTip = 'All staff electronic records';

                action(Action34)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Master';
                    Image = PersonInCharge;
                    RunObject = Page "HR Employee List";
                    ToolTip = 'View the employee details';
                }
                action("Staff User Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Staff User Setup';
                    RunObject = Page "QuantumJumps User Setup";
                    ToolTip = 'Map Employee with their User Accounts';
                }
            }
            group("Payroll")
            {
                Caption = 'Payroll';
                ToolTip = 'Payroll Process';

                action("Payroll List")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll List';
                    RunObject = Page "Client Payroll List";
                    ToolTip = 'Open Payroll List and Perform Payroll Operations';
                }
                action("PayrollSetup")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Setup';
                    RunObject = Page "Client Payroll Setup";
                    ToolTip = 'Perform Payroll Setup';
                }
            }
            group("Loan Management")
            {
                Caption = 'Loan Management';

                action("Loan Products")
                {
                    ApplicationArea = All;
                    Caption = 'Loan Products';
                    RunObject = Page "Loan Product Type list";
                }
                action("Loan Application")
                {
                    ApplicationArea = All;
                    Caption = 'Loan Application';
                    RunObject = Page "Loan Application List";
                }
            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
                Image = Capacities;
                ToolTip = 'All staff leave records';

                action("Create Leave Plan for Employee")
                {
                    ApplicationArea = All;
                    Caption = 'Create Leave Plan for Employee';
                    Image = PersonInCharge;
                    RunObject = Page "Department Leave Plans List";
                }
                action("Approved Leave Plans")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Leave Plans';
                    Image = PersonInCharge;
                    RunObject = Page "Emp Leave Plan List-Approved";
                }
                action("Create Leave Application for Employee")
                {
                    ApplicationArea = All;
                    Caption = 'Create Leave Application for Employee';
                    Image = PersonInCharge;
                    RunObject = Page "Leave Applications - Open";
                }
                action("Leave Applications Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Applications Pending Approval';
                    RunObject = Page "Leave Applications-Approval";
                }
                action("Leave Recalls")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Recall';
                    Image = PersonInCharge;
                    RunObject = Page "Leave Recalls List";
                }
                action("Excuse Duty Registration")
                {
                    ApplicationArea = All;
                    Caption = 'Excuse Duty Registration';
                    RunObject = Page "Excuse Duty Registration";
                }
                group("Leave Management Task")
                {
                    Caption = 'Task';
                    ToolTip = 'Leave Management Tasks';

                    action("Create Leave Entitlement")
                    {
                        ApplicationArea = All;
                        Caption = 'Create Leave Entitlement';
                        ToolTip = 'Assign Users Leave Balances';
                        RunObject = Report "Create Leave Entitlement";
                    }
                }
                group("Leave Management Reports")
                {
                    Caption = 'Report & Analysis';
                    ToolTip = 'Open Leave Management Reports and Analysis';

                    action("Leave Balance")
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Balance';
                        Image = Report2;
                        RunObject = Report "Leave Balance";
                    }
                    action(OutstandingLeaveDays)
                    {
                        ApplicationArea = All;
                        Caption = 'Outstanding Leave Days';
                        Image = Report2;
                        RunObject = Report "Outstanding Leave Days";
                    }
                    action(StaffOnLeave)
                    {
                        ApplicationArea = All;
                        Caption = 'Staff who have Proceeded on Leave';
                        ToolTip = 'Open Staff who have Proceeded on Leave';
                        Image = Report2;
                        RunObject = Report "Staff On Leave";
                    }
                    action(StaffOnExcuseDuty)
                    {
                        ApplicationArea = All;
                        Caption = 'Staff On ExcuseDuty';
                        ToolTip = 'Open Staff On Excuse Duty';
                        Image = Report2;
                        RunObject = Report "Excuse Duty";
                    }
                }
                group("Leave Management Archive")
                {
                    Caption = 'Archive';

                    action("Approved Leave Applications")
                    {
                        ApplicationArea = All;
                        Caption = 'Approved Leave Applications';
                        RunObject = Page "Leave Applications-Approved";
                    }
                    action("Employee Excuse Duty")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee Excuse Duty';
                        RunObject = Page "Employee Absences";
                    }
                    action("Leave Recalls Approved")
                    {
                        ApplicationArea = All;
                        Caption = 'Archived Leave Recalls';
                        RunObject = Page "Leave Recalls_Approved";
                    }
                }
                group("Leave Management Administration")
                {
                    Caption = 'Administration';
                    ToolTip = 'Leave Management Setups';

                    action("Quantumjump HR Setups")
                    {
                        ApplicationArea = All;
                        Caption = 'HR Setup';
                        RunObject = Page "QuantumJumps HR Setup";
                    }
                    action(LeaveSetup)
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Setup';
                        RunObject = Page "Leave Setup";
                    }
                }
            }
            group("Performance Management")
            {
                Caption = 'Performance Management';

                action("Appraisal Objectives")
                {
                    ApplicationArea = All;
                    Caption = 'Create Employee Appraisal Objectives';
                    ToolTip = 'Open Create Employee Appraisal Objectives';
                    RunObject = Page "Create Appraisal Objectives";
                }
                action("Approved Appraisal Objectives")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Appraisal Objectives';
                    ToolTip = 'Open Approved Appraisal Objectives';
                    RunObject = Page "Approved Appraisal Objectives";
                }
                action("Employee Appraisal")
                {
                    ApplicationArea = All;
                    Caption = 'Create Employee Appraisal';
                    ToolTip = 'Open Create Employee Appraisal';
                    RunObject = Page "Create Employee Appraisal";
                }
                action("Approved Appraisal")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Employee Appraisal';
                    ToolTip = 'Open Approved Employee Appraisal';
                    RunObject = Page "Employee Appraisals";
                }
                group("Performance Management Reports")
                {
                    Caption = 'Reports & Analysis';
                    ToolTip = 'Performance Management Reports & Analysis';

                    action("Rtp. Employee Appraisal")
                    {
                        ApplicationArea = All;
                        Caption = 'Employee Appraisal';
                        ToolTip = 'Run Employee Appraisal';
                        RunObject = Report "Employee Appraisals";
                    }
                    action("Rtp. Performance Appraisal")
                    {
                        ApplicationArea = All;
                        Caption = 'Performance Appraisal';
                        ToolTip = 'Run Performance Appraisal';
                        RunObject = Report "Performance Appraisal";
                    }
                }
                group("Performance Management Administration")
                {
                    Caption = 'Administration';
                    ToolTip = 'Performance Management Setups';

                    action("Adm. Appraisal Category")
                    {
                        ApplicationArea = All;
                        Caption = 'Appraisal Category';
                        ToolTip = 'Open Appraisal Category';
                        RunObject = Page "Appraisal Category";
                    }
                    action("Adm. Appraisal Types")
                    {
                        ApplicationArea = All;
                        Caption = 'Appraisal Types';
                        ToolTip = 'Open Appraisal Types';
                        RunObject = Page "Appraisal Types";
                    }
                    action("Adm. Appraisal Periods")
                    {
                        ApplicationArea = All;
                        Caption = 'Appraisal Periods';
                        ToolTip = 'Open Appraisal Periods';
                        RunObject = Page "Appraisal Periods";
                    }
                    action("Adm. Appraisal Ranking")
                    {
                        ApplicationArea = All;
                        Caption = 'Appraisal Ranking';
                        ToolTip = 'Open Appraisal Ranking';
                        RunObject = Page "Grade Matrix";
                    }
                }
            }
            group("Internal Memo")
            {
                action("New Interal Memos")
                {
                    ApplicationArea = All;
                    Caption = 'New Internal Memos';
                    ToolTip = 'Create New Internal Memo';
                    RunObject = Page "Internal Memo - Open";
                }
                action("Posted Internal Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Internal Memos';
                    ToolTip = 'Posted Internal Memo';
                    RunObject = Page "Internal Memo - Posted";
                }
                group("Internal Memo Archive")
                {
                    Caption = 'Archive';

                    action("Archive Internal Memos")
                    {
                        ApplicationArea = All;
                        Caption = 'Posted Internal Memos';
                        ToolTip = 'Posted Internal Memo';
                        RunObject = Page "Internal Memos - Archived";
                    }
                }
                group("Internal Memo Administration")
                {
                    Caption = 'Administration';

                    action(InternalMemoSetup)
                    {
                        ApplicationArea = All;
                        Caption = 'Internal Memo Setup';
                        ToolTip = 'Internal Memo Setup';
                        RunObject = Page "Internal Memo Setup";
                    }
                    action("Mails Distribution List")
                    {
                        ApplicationArea = All;
                        Caption = 'Mails Distribution List';
                        ToolTip = 'Mails Distribution List';
                        RunObject = Page "Mail Distribution Lists";
                    }
                }
            }
            group("Training & Development")
            {
                Caption = 'Training & Development';
                Image = Marketing;
                ToolTip = 'Track Employee Training & Development';

                action(Coaching)
                {
                    ApplicationArea = All;
                    Caption = 'Coaching';
                    RunObject = Page "Coaching List";
                }
                action("Training Needs Assesment")
                {
                    ApplicationArea = All;
                    Caption = 'Training Needs Assesment';
                    RunObject = Page "New Training Needs Assesment";
                }
                action("Training Needs Under Review")
                {
                    ApplicationArea = All;
                    Caption = 'Training Needs Under Review';
                    RunObject = Page "Training Needs List-Approval";
                }
                action("Training Nomination")
                {
                    ApplicationArea = All;
                    Caption = 'Training Nomination';
                    RunObject = Page "Training Nomination List";
                }
                action("Training Pending Approval")
                {
                    ApplicationArea = All;
                    Caption = 'Training Pending Approval';
                    Image = PersonInCharge;
                    RunObject = Page "Training List - Approval";
                }
                action("Approved Training")
                {
                    ApplicationArea = Suite;
                    Caption = 'Approved Training';
                    RunObject = Page "Training List - Approved";
                }
                action("Training Evaluation")
                {
                    ApplicationArea = All;
                    Caption = 'Training Evaluation';
                    RunObject = Page "Training Evaluation List";
                }
                group("Training Administration")
                {
                    Caption = 'Administration';

                    action("Performance Issues")
                    {
                        ApplicationArea = All;
                        Caption = 'Performance Issues';
                        RunObject = Page "Performance Issues";
                    }
                    action("Training Needs")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Needs';
                        RunObject = Page "Training Needs";
                    }
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
            group(Setup)
            {
                Caption = 'Setup';
                Image = Setup;
                ToolTip = 'All hr module setups';

                action("Orientation Checklist Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Orientation Checklist Setup';
                    Image = PersonInCharge;
                    RunObject = Page "Orientation Checklist Setup";
                }
                action(Action26)
                {
                    ApplicationArea = All;
                    Caption = 'Staff User Setup';
                    RunObject = Page "QuantumJumps User Setup";
                }
                action("HR Setup")
                {
                    ApplicationArea = All;
                    Caption = 'HR Setup';
                    RunObject = Page "QuantumJumps HR Setup";
                }
                action("Leave Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Leave Setup';
                    RunObject = Page "Leave Setup";
                }
                action("Bal Score Card Rating")
                {
                    ApplicationArea = All;
                    Caption = 'Bal Score Card Rating';
                    RunObject = Page "Bal Score Card Rating";
                }
                action("Bal  Emp Categories")
                {
                    ApplicationArea = All;
                    Caption = 'Bal Score Emp Categories';
                    RunObject = Page "Bal Score Emp Categories";
                }
                action("Bal Scoring Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Bal Scoring Setup';
                    RunObject = Page "Bal Scoring Setup";
                }
                action("Appraisal Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Setup';
                    RunObject = Page "Appraisal Setup";
                }
                action("Appraisal Questions")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Questions';
                    RunObject = Page "Appraisal Questions";
                }
                action("Appraisal Rating")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Rating';
                    RunObject = Page "Appraisal Rating";
                }
                action("Appraisal General Instructions")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal General Instructions';
                    RunObject = Page "Appraisal General Instructions";
                }
                action("Internal Memo Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Internal Memo Setup';
                    RunObject = Page "Internal Memo Setup";
                }
                action("Mail Distribution Lists")
                {
                    ApplicationArea = All;
                    Caption = 'Mail Distribution Lists';
                    RunObject = Page "Mail Distribution Lists";
                }
                action("Medical Schemes")
                {
                    Caption = 'Medical Schemes';
                    RunObject = Page "Medical Schemes";
                    ApplicationArea = All;
                }
                action("Medical Cover Limits")
                {
                    Caption = 'Medical Cover Limits';
                    RunObject = Page "Medical Cover Limits";
                    ApplicationArea = All;
                }
                action("Medical Covers Setup")
                {
                    Caption = 'Medical Covers Setup';
                    RunObject = Page "Medical Covers Setup";
                    ApplicationArea = All;
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

                action("SS New Petty Cash Request")
                {
                    ApplicationArea = All;
                    Caption = 'New Petty Cash Request';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const(Open));
                }
                action("SS Pending Approval Petty Cash Request")
                {
                    ApplicationArea = All;
                    Caption = 'Petty Cash Request Pending Approval';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const("Pending Approval"));
                }
                action("SS Approved Petty Cash Request")
                {
                    ApplicationArea = All;
                    Caption = 'Approved Petty Cash Request';
                    RunObject = Page "SS Petty Cash";
                    RunPageView = where(Status = const(Released));
                }
                group("SS Archived")
                {
                    Caption = 'Archive';

                    action("SS Posted Petty Cash Request")
                    {
                        ApplicationArea = All;
                        Caption = 'Processed Petty Cash Request';
                        RunObject = Page "SS Petty Cash";
                        RunPageView = where(Posted = const(true));
                    }
                }
            }
        }
        area(processing)
        {
            action("QuantumJumps HR SetUp")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'HR SetUp';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Setup;
                RunObject = Page "QuantumJumps HR Setup";
                RunPageMode = Edit;
                ToolTip = 'Modify a value in the HR Setup';
            }
            action("Payroll Setup")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payroll Setup';
                Image = PayrollStatistics;
                RunObject = Page "QuantumJumps Payroll Setup";
                RunPageMode = Edit;
                ToolTip = 'Modify a value in the Payroll Setup';
            }
            action("Employee Groups")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Employee Groups';
                Image = EmployeeAgreement;
                RunObject = Page "Employee Groups";
                RunPageMode = Edit;
                ToolTip = 'Edit or Add new Emloyee Groups';
            }
            action("Payroll Periods")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Payroll Periods';
                Image = PaymentPeriod;
                RunObject = Page "Payroll Periods";
                RunPageMode = Edit;
                ToolTip = 'Manage or Create new Payroll Periods';
            }
            action(Earnings)
            {
                ApplicationArea = Suite;
                Caption = 'Earnings';
                Image = PaymentJournal;
                RunObject = Page Earnings;
                RunPageMode = Edit;
                ToolTip = 'Manage or Create new Employee Earnings';
            }
            action(Deductions)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Deductions';
                Image = Receipt;
                RunObject = Page Deductions;
                RunPageMode = Edit;
                ToolTip = 'Manage or create new earnings';
            }
            action("Bracket Tables")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Bracket Tables';
                Image = Database;
                RunObject = Page "Bracket Tables";
                RunPageMode = Edit;
                ToolTip = 'Manage or Create new Bracket Tables';
            }
            group(Payments)
            {
                Caption = 'Payments';

                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    Image = Reconcile;

                    action("Payroll Run")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Run';
                        Image = Calculate;
                        RunObject = Report "Payroll Calculator";
                        ToolTip = 'Calculate Payroll';
                    }
                    action("Email Payslips")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email Payslips';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Payslips";
                        ToolTip = 'Email Payslips';
                    }
                    action("Generate Payroll Journal")
                    {
                        Caption = 'Generate Payroll Journal';
                        ApplicationArea = All;
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Transfer Journal to GL";
                    }
                    action("Create Employee Imprest Accounts")
                    {
                        Caption = 'Create Employee Imprest Accounts';
                        RunObject = Report "Create Employee Customer AC";
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}
