page 59991 "Director Role Center"
{
    Caption = 'Director Role Center';
    PageType = RoleCenter;
    ApplicationArea = All;


    //SourceTable = "";
    layout
    {
        area(rolecenter)
        {
            part(Control16; "Payroll Activities")
            {
                AccessByPermission = TableData "G/L Entry" = R;
                ApplicationArea = All;
                visible = false;
            }


            part("Finance Management Cues"; "Finance Management Cues")
            {
                Caption = 'Finance Management';
                Visible = false;
            }
            Part(Control15; "HR Management Cues")
            {
                ApplicationArea = All;
                caption = 'HR Management';
            }


            part("PR Payroll Activities Cue"; "Payroll Activities")
            {
                Caption = 'PAYROLL ACTIVITIES';
                ApplicationArea = Basic, Suite;
            }
            part(Headline; "Headline RC Payroll Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control96; "Report Inbox Part")
            {
                ApplicationArea = All;
            }

        }
    }
    actions
    {

        area(processing)
        {
            group(Reports)
            {
                Caption = 'Reports';

                group("Management Reports")
                {
                    Caption = 'Management Reports';
                    Image = ReferenceData;

                    action(Payslips)
                    {
                        ApplicationArea = All;
                        Caption = 'Payslips';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Payslip";
                        ToolTip = 'View Employee Payslips';
                    }
                    action("Master Roll")
                    {
                        ApplicationArea = All;
                        Caption = 'Master Roll';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        // RunObject = Report "Client Master Roll Report";
                        RunObject = Report "Client Master Roll Report2";
                        ToolTip = 'View Master Roll Report';
                    }
                    action("Master Roll B")
                    {
                        ApplicationArea = All;
                        Caption = 'Master Roll PAYROLLB';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        // RunObject = Report "Client Master Roll Report";
                        RunObject = Report "Client Master Roll ReportB";
                        ToolTip = 'View Master Roll Report';
                    }
                    action("Monthly PAYE Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Monthly PAYE Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Monthly PAYE Report";
                        ToolTip = 'View the monthly PAYE Report';
                    }
                    action("Earnings Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Earnings Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Earnings";
                        ToolTip = 'View Earnings Report';
                    }
                    action("Deductions Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Deductions Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Deductions";
                    }
                    action("Third Parties Deductions Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Third Parties Deductions Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Deduction-Institution";
                        // RunObject = report "Deduction-Institution";
                    }
                    action("Total Deductions Only Per Employee")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Deductions Only Per Employee';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Total Deductions/Employee";
                        // RunObject = report "Total Deductions for Employee";
                    }
                    action("Total Earnings Only Per Employee")
                    {
                        ApplicationArea = All;
                        Caption = 'Total Earnings Only Per Employee';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Total Earnings/Employee";
                        // RunObject=report "Total Earnings Only Per Employee";
                    }
                    action("Bank List")
                    {
                        ApplicationArea = All;
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
                        ApplicationArea = All;
                        Caption = 'Bank Instruction';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Bank Instruction";
                        ToolTip = 'Generate Instruction to the Bank';
                    }
                    action("Client Wage Bill")
                    {
                        ApplicationArea = All;
                        Caption = 'Client Wage Bill';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Wage Bill";
                        ToolTip = 'View the Company Totals Report';
                    }
                    action("Client Total Payroll Cost")
                    {
                        ApplicationArea = All;
                        Caption = 'Client Wagebill Per Employee Group';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Total Payroll Cost";
                        ToolTip = 'Client Total Payroll Cost';
                    }
                    action("Client A Third Rule Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Client A Third Rule Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "A Third Rule Report";
                        ToolTip = 'View Client A Third Rule Report';
                    }
                    action(PRMS)
                    {
                        ApplicationArea = All;
                        Caption = 'PRMS Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        // RunObject = Report "PRMS Report";
                        RunObject = report "Client Provident Fund";
                        ToolTip = 'View PRMS Report';
                    }
                    action("Company Totals")
                    {
                        ApplicationArea = All;
                        Caption = 'Company Totals';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Company Totals";
                        ToolTip = 'View the Company Totals Report';
                    }
                    action("Variance(Net Pay)")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Variance(Net Pay)';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Recon Combined";
                    }
                    action("Variance(Detail)")
                    {
                        ApplicationArea = All;
                        Caption = 'Detailed Variance Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Reconciliation";
                    }
                    action("Earnings Variance Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Earnings Variance Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Earn.Variance Recon.";
                    }
                    action("12 Month Report")
                    {
                        ApplicationArea = All;
                        Caption = '12 Month Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Salary 12 Month Report";
                    }


                    //   Payroll Reconciliation new

                }
                group("Statutory Reports")
                {
                    Caption = 'Statutory Reports';
                    Image = ReferenceData;

                    action(P9A)
                    {
                        ApplicationArea = All;
                        Caption = 'P9A';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client P9A";
                        ToolTip = 'View Employee P9A Report';
                    }
                    action("P10 B")
                    {
                        ApplicationArea = All;
                        Caption = 'KRA ITAX P10 Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "KRA ITAX P10 Report";
                        ToolTip = 'View Employee P10 B Report';
                    }
                    action("Housing Levy")
                    {
                        ApplicationArea = All;
                        Caption = 'Housing Levy';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Housing Levy";
                        ToolTip = 'View Employee Housing Levy Report';
                    }
                    action("P10 A")
                    {
                        ApplicationArea = All;
                        Caption = 'P10 A';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "P10 A";
                        ToolTip = 'View Employee P10 A Report';
                    }
                    action("SHIF Report")
                    {
                        ApplicationArea = All;
                        Caption = 'SHIF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client SHIF";
                        ToolTip = 'View SHIF Report';
                    }
                    action("PROVIDENT")
                    {
                        ApplicationArea = All;
                        Caption = 'PROVIDENT Fund Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Provident Fund";
                        ToolTip = 'View PROVIDENT Fund Report';
                    }
                    action("PROVIDENT Arrears")
                    {
                        ApplicationArea = All;
                        Caption = 'PROVIDENT Fund Arrears Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client Provident Fund Arrears";
                        ToolTip = 'View PROVIDENT Fund Arrears Report';
                    }
                    action("NSSF Report")
                    {
                        ApplicationArea = All;
                        Caption = 'NSSF Report';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Client NSSF";
                        ToolTip = 'View NSSF Report';
                    }
                    action("NSSF Report New")
                    {
                        ApplicationArea = All;
                        Caption = 'NSSF Report new';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report NSSF;
                        ToolTip = 'View NSSF Report';
                    }
                    action("NSSF Report New1")
                    {
                        ApplicationArea = All;
                        Caption = 'NSSF Report new1';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "NSSF New";
                        ToolTip = 'View NSSF Report';
                    }
                }
                group("Employee Statistics")
                {
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
                    action("Staff Changes")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Staff Changes';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Staff Changes Report";
                        ToolTip = 'View Staff Changes Report';
                    }
                    action("Payroll Reconciliation new")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Reconciliation new';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Reconciliation new";
                    }
                    action("Payroll Reconciliationtest")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Payroll Reconciliation test';
                        Image = "Report";
                        Promoted = true;
                        PromotedCategory = "Report";
                        PromotedIsBig = true;
                        RunObject = Report "Payroll Reconciliation test";
                    }
                }
            }
        }


        area(embedding)
        {
            ToolTip = 'Manage your business. See KPIs, trial balance, and favorite customers.';

            action("Employee Master A")
            {
                ApplicationArea = All;
                Caption = 'Employee Master A';
                RunObject = Page "Client Payroll List A";
                ToolTip = 'Open the list of employees in Payroll A.';
            }
            action("Employee Master B")
            {
                ApplicationArea = All;
                Caption = 'Employee Master B';
                RunObject = Page "Client Payroll List B";
                ToolTip = 'Open the list of employees in Payroll B.';
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
        }


        area(reporting)
        {
            // Leave Applications 

            action(LeaveApplications)
            {
                Caption = 'Leave Applications';
                Image = Leave;
                ApplicationArea = Basic, Suite;
                RunObject = report "Leave Applications";
                ToolTip = 'Run the Leave Applications report';

            }
            // Job Applications (58110, Report Request)
            action(JobApplications)
            {
                Caption = 'Job Applications';
                Image = Job;
                ApplicationArea = Basic, Suite;
                RunObject = report "Job Applications";
                ToolTip = 'Run the Job Applications report';

            }
            // Applicant job Submitted (52970, Report Request)
            action(ApplicantJobSubmitted)
            {
                Caption = 'Applicant Job Submitted';
                Image = Job;
                ApplicationArea = Basic, Suite;
                RunObject = report "Applicant Job Submitted";
                ToolTip = 'Run the Applicant Job Submitted report';

            }
            action(EmployeeAppraisals)
            {
                Caption = 'Employee Appraisals';
                Image = Performance;
                ApplicationArea = Basic, Suite;
                RunObject = report "Employee Appraisals";
                ToolTip = 'Run the Employee Appraisals report';

            }

            group(Payroll)
            {
                Caption = 'Payroll';
                Image = Payroll;
                // Client Payroll List A (56098, List)
                action(ClientPayrollListA)
                {
                    Caption = 'Client Payroll List A';
                    Image = Payroll;
                    ApplicationArea = Basic, Suite;
                    RunObject = page "Client Payroll List A";
                    ToolTip = 'Run the Client Payroll List A report';

                }

                //    Client Master Roll Report2 (59019, Report Request)
                action(ClientMasterRollReport)
                {
                    Caption = 'Client Master Roll Report';
                    Image = Payroll;
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Client Master Roll Report";
                    ToolTip = 'Run the Client Master Roll Report';

                }
                //Client Earnings (51460, Report Request)
                action(ClientEarnings)
                {
                    Caption = 'Client Earnings';
                    Image = Payroll;
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Client Earnings";
                    ToolTip = 'Run the Client Earnings report';

                }
                // Client Deductions (51471, Report Request)
                action(ClientDeductions)
                {
                    Caption = 'Client Deductions';
                    Image = Payroll;
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Client Deductions";
                    ToolTip = 'Run the Client Deductions report';

                }
                // Client Wage Bill (52206, Report Request)
                action(ClientWageBill)
                {
                    Caption = 'Client Wage Bill';
                    Image = Payroll;
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Client Wage Bill";
                    ToolTip = 'Run the Client Wage Bill report';

                }
                // Payroll Reconciliation new (52039, Report Request)
                action(PayrollReconciliation)
                {
                    Caption = 'Payroll Reconciliation';
                    Image = Payroll;
                    ApplicationArea = Basic, Suite;
                    RunObject = report "Payroll Reconciliation";
                    ToolTip = 'Run the Payroll Reconciliation report';
                }
            }



        }

        area(sections)
        {
        }




    }
}
