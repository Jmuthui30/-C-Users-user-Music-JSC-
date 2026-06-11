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

            part(Control46; "Team Member Activities")
            {
                ApplicationArea = All;
            }
            part("Finance Management Cues"; "Finance Management Cues")
            {
                Caption = 'Finance Management';
            }
            Part(Control15; "HR Management Cues")
            {
                ApplicationArea = All;
                caption = 'HR Management';
            }

            part(Headline; "Headline RC Payroll Manager")
            {
                ApplicationArea = Basic, Suite;
            }
            part("PR Payroll Activities Cue"; "Payroll Activities")
            {
                Caption = 'PAYROLL ACTIVITIES';
                ApplicationArea = Basic, Suite;
            }


        }
    }
    actions
    {
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
