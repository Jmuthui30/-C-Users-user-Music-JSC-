page 51742 "HR & Admin Manager Role Center"
{
    // version THL- HRM 1.0 51742
    // CurrPage."Help And Setup List".ShowFeatured;
    Caption = 'HR & Payroll Manager Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control76; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }
            part(Control55; "Balance Score Card Chart")
            {
                ApplicationArea = All;
                Caption = '';
                ToolTip = 'Specifies the view of your business assistance';
            }
            part(Control47; "Distribution by Location")
            {
                ApplicationArea = All;
            }
            part(Control48; "Distribution by Department")
            {
                ApplicationArea = All;
            }
            part(Control54; "Distribution by cadre")
            {
                ApplicationArea = All;
            }
            part(Control49; "Head Count Distribution")
            {
                ApplicationArea = All;
            }
            part(Control50; "Distribution by Gender")
            {
                ApplicationArea = All;
            }
            part(Control51; "Distribution by Job Type")
            {
                ApplicationArea = All;
            }
            part(Control52; "Distribution by Age")
            {
                ApplicationArea = All;
            }
            part(Control53; "Distribution by Tenure")
            {
                ApplicationArea = All;
            }
            part(Control0055; "Exit by Department")
            {
                ApplicationArea = All;
            }
            part(Control56; "Exit Mode")
            {
                ApplicationArea = All;
            }
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
                RunPageView = where(Status = const(Closed));
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
                action("Leave Balances new")
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
            group(ManpowerPlanning)
            {
                Caption = 'Manpower, Career & Succession Planning';
                ToolTip = 'Company Information List';

                group("Company Establishments")
                {
                    action("Open Company Establishments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Open Company Establishments';
                        RunObject = Page "Company Job List";
                        RunPageView = where(Status = const(Open));
                        ToolTip = 'Newly loaded staff establishment by HR Officer which is not editable ';
                    }
                    action("Pending Company Establishments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Pending Company Establishments';
                        RunObject = Page "Company Job List";
                        RunPageView = where(Status = const("Pending Approval"));
                        ToolTip = 'Company Establishments Awaiting Director HR approval';
                    }
                    action("Approved Company Establishments")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Approved Company Establishments';
                        RunPageView = where(Status = const(Released));
                        RunObject = Page "Company Job List";
                        ToolTip = 'Approved staff Establishment Verified by Director HR';
                    }
                }
                action("Company Jobs Templates")
                {
                    ApplicationArea = All;
                    Caption = 'Job Templates';
                    RunObject = Page "Job Template List";
                    ToolTip = 'Job Template List';
                }
                action("Professions")
                {
                    ApplicationArea = All;
                    Caption = 'Job Profession';
                    RunObject = Page "Job Professions";
                    ToolTip = 'Professions';
                }
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
                group(Task)
                {
                    Caption = 'Task';
                    ToolTip = 'Company Information Tasks';

                    action("Base Calendar new")
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

            group("Recruitment ")
            {
                Image = HRSetup;
                Caption = 'Recruitment ';
                action("Vacant Positions1")
                {
                    ApplicationArea = All;
                    Caption = 'Vacant Positions';
                    ToolTip = 'Open Vacant Positions';
                    RunObject = Page "Vacant Positions";
                    RunPageLink = Status = const(Released);

                }
                group("Recruitment Request")
                {
                    action("Recruitment Request List")
                    {
                        ApplicationArea = All;
                        RunObject = page "Recruitment Request List";
                        RunPageLink = Status = const(Open);
                        ToolTip = 'Executes the Recruitment Request List action';
                        Caption = 'Recruitment Requests';
                    }
                    action("Approved Recruitment Requests1")
                    {
                        ApplicationArea = All;
                        RunObject = page "Approved Recruitment Requests";
                        RunPageLink = Status = const(Released);
                        ToolTip = 'Executes the Approved Recruitment Requests action';
                        Caption = 'Approved Recruitment Requests';
                    }
                    action("Archived Recruitment Requests")
                    {
                        ApplicationArea = All;
                        RunObject = page "Archived Recruitment Requests";

                        ToolTip = 'Executes the Archived Recruitment Requests action';
                        Caption = 'Archived Recruitment Requests';
                    }
                }



                action("All Applicants")
                {
                    ApplicationArea = All;
                    Caption = 'Profile Applicants';
                    RunObject = Page "Applicant List-All";
                    //RunPageLink = "Application Status" = const("Qualified for Interview");
                    RunPageLink = Submitted = const(false);

                }
                action("All ApplicantsSubmited")
                {
                    ApplicationArea = All;
                    Caption = 'Applicants Submited';
                    RunObject = Page "Applicant Submit-All";
                    RunPageLink = Submitted = const(true);
                }
                action("Job Application-Submitted")
                {
                    ApplicationArea = All;

                    RunObject = page "Job Applications - Submitted'";
                    RunPageLink = "Application Status" = const(Submited);
                    ToolTip = 'Executes the Submitted Applications action';
                    Caption = 'Job Applications - Submitted';
                }



                group("Job Applications")
                {
                    action("Job Applications ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job Appl. List";
                        RunPageLink = "Application Status" = const(Application);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications - New';
                    }

                    //8*************************************************
                    action("Job Applications-Submitted")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job Applications - Submitted'";
                        RunPageLink = "Application Status" = const(Submited);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications - Submitted';
                    }
                    action("Job Applications- Under Shortlisting")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job Under Shortlisting List";
                        RunPageLink = "Application Status" = const(Shortlisted);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications - Under Shortlisting';
                    }
                    action("Job Applications- Qualified Interview")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job Application List";
                        RunPageLink = "Application Status" = const("Qualified for Interview");
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications - Qualified Interview';
                    }
                    action("Job Applications- Non-Qualified Interview")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job Application List";
                        RunPageLink = "Application Status" = const("Non-Qualified for Interview");
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications - Non-Qualified Interview';
                    }
                    action("Job Applications- Interviewed")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job Interview List";
                        RunPageLink = "Application Status" = const(Interview);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications -Interviewed';
                    }
                    action("Job Applications- Hired")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job hire List";
                        RunPageLink = "Application Status" = const(Employed);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications -Hired';
                    }
                }



                group("Shortlisting")
                {
                    // action("Shortlist")
                    // {
                    //     ApplicationArea = All;
                    //     Caption = 'Shortlist';
                    //     RunObject = Page Shortlistings;
                    // }
                    action("Recruitment Criteria")
                    {
                        ApplicationArea = All;
                        Caption = 'Recruitment Criteria';
                        ToolTip = 'Open Recruitment Criteria';
                        RunObject = Page "Recruitment Shortlist";
                    }
                    action("Closed Recruitment Shortlist ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Recruitment Shortlist";
                        RunPageLink = "Shortlisting Closed" = const(true);
                        ToolTip = 'Executes the Closed Recruitment Shortlist  action';
                        Caption = 'Closed Recruitment Shortlist';
                    }
                }
                group("Interview1")
                {
                    action("Interview List ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Interview List";
                        ToolTip = 'Executes the Interview List  action';
                        Caption = 'Interview List';
                    }
                    action("Completed Interviews")
                    {
                        ApplicationArea = All;
                        RunObject = page "Completed Interviews";
                        ToolTip = 'Executes the Completed Interviews action';
                        Caption = 'Completed Interviews';
                    }
                }
                group("Hiring Process")
                {
                    action("Hire Qualified Interviewees")
                    {
                        ApplicationArea = All;
                        RunObject = page "Qualified Interviewees";
                        ToolTip = 'Executes the Completed Interviews action';
                        Caption = 'Hiring Process - Qualified Interviewees';
                    }
                    action("Hired Qualified Interviewees")
                    {
                        ApplicationArea = All;
                        RunObject = page "Qualified Interviewees Archive";
                        ToolTip = 'Executes the Completed Interviews action';
                        Caption = 'Hiring Process - Archive';
                    }
                }

                group("Recruitment Setups")
                {
                    Caption = 'Recruitment Setups';
                    action("Education Institutions")
                    {
                        ApplicationArea = All;
                        RunObject = page "Education Intitutions";
                        ToolTip = 'Executes the Education Institutions action';
                        Caption = 'Education Institutions';
                    }
                    action("Qualification Setup")
                    {
                        ApplicationArea = All;
                        RunObject = page "Qualifications Setup";
                        ToolTip = 'Executes the Qualification Setup action';
                        Caption = 'Qualification Setup';
                    }
                    action("Recruitment Stages ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Recruitment Stages";
                        ToolTip = 'Executes the Recruitment Stages  action';
                        Caption = 'Recruitment Stages ';
                    }
                    action("Interview Panel Members")
                    {
                        ApplicationArea = All;
                        RunObject = page "Interview Panel Members";
                        ToolTip = 'Executes the Interview Panel Members action';
                        Caption = 'Interview Panel Members';
                    }
                    action("Test Parameters ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Test Parameters";
                        ToolTip = 'Executes the Test Parameters  action';
                        Caption = 'Test Parameters ';
                    }
                    action("Score Setup ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Score Setup";
                        ToolTip = 'Executes the Score Setup  action';
                        Caption = 'Score Setup ';
                        Visible = false;
                    }
                    action("Interview Setup")
                    {
                        ApplicationArea = All;
                        RunObject = page "Interview Setup";
                        ToolTip = 'Executes the Interview Setup action';
                        Caption = 'Interview Setup';
                    }
                    action("Induction Checklist Setup ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Appointment Checklist Setup";
                        ToolTip = 'Executes the Imprest Deduction action';
                        Caption = 'Induction Checklist Setup';
                    }
                    action("Job Attachments Setup")
                    {
                        ApplicationArea = All;
                        RunObject = page "Attachments Setup";
                        ToolTip = 'Executes the Attachments Setup action';
                        Caption = 'Attachments Setup';
                    }
                }
                group("Recruitment Reports")
                {
                    Caption = 'Recruitment Reports';

                    action("Job Applications Report")
                    {
                        ApplicationArea = All;
                        RunObject = report "Job Applications";
                        Caption = 'Job Applications Report';
                    }
                    action("Applicant Applications Report")
                    {
                        ApplicationArea = All;
                        Caption = 'Applicant Applications Report';
                        RunObject = report "Applicant Applications Report";
                    }

                    action("All ApplicantsSubmited report1")
                    {
                        ApplicationArea = All;
                        Caption = 'Applicants Submited Profile ';
                        RunObject = report "Appl. Submit Job list";
                    }
                    action("All ApplicantsSubmited report22")
                    {
                        ApplicationArea = All;
                        Caption = 'Applicants Submited List new';
                        RunObject = report "Appl. Submit J list";
                    }
                    //update quo cod
                    action("All ApplicantsSubmited report222")
                    {
                        ApplicationArea = All;
                        Caption = 'Applicants Submited job List';
                        RunObject = report "Applicant job Submitted";
                    }

                }
                action(List_submitted)
                {
                    ApplicationArea = All;
                    Caption = 'List of Submitted Job ';
                    RunObject = page "Applicant Submitted Job";
                }


            }
            /*
                        group(Recruitment)
                        {
                            Caption = 'Recruitment';
                            ToolTip = 'Recruitment Process';

                            action("Vacant Positions")
                            {
                                ApplicationArea = All;
                                Caption = 'Vacant Positions';
                                ToolTip = 'Open Vacant Positions';
                                RunObject = Page "Vacant Positions";
                            }
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
                            group("Recruitement Request")
                            {
                                action("Create New Recruitment Request")
                                {
                                    ApplicationArea = All;
                                    Caption = 'Create New Recruitment Request';
                                    ToolTip = 'Open Create New Recruitment Request';
                                    RunObject = Page "Create New Recruitment Req.";
                                }
                                action("New Req. Request Header")
                                {
                                    ApplicationArea = All;
                                    Caption = 'New Recruitment Requests';
                                    RunObject = Page "Recruitment Requests";
                                    RunPageView = where(Status = const(Open));
                                    Visible = false;
                                }
                                action("Pending Request Header")
                                {
                                    ApplicationArea = All;
                                    Caption = 'Pending Recruitment Requests';
                                    RunObject = Page "Recruitment Requests";
                                    RunPageView = where(Status = const("Pending Approval"));
                                }
                                action("Approved Recruitment Requests")
                                {
                                    ApplicationArea = All;
                                    Caption = 'Approved Recruitment Requests';
                                    ToolTip = 'Open Approved Recruitment Requests';
                                    RunObject = Page "Approved Recruitment Request";
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

            */

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
                action(RedeploymentAction)
                {
                    ApplicationArea = All;
                    Caption = 'Staff Redeployment';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    ToolTip = 'Staff Redeployment';
                }
                action(RedeploymentOpen)
                {
                    ApplicationArea = All;
                    Caption = 'New';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    RunPageView = WHERE(Status = FILTER(New));
                    ToolTip = 'New Staff Redeployments';
                }
                action(RedeploymentApproved)
                {
                    ApplicationArea = All;
                    Caption = 'Approved';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    RunPageView = WHERE(Status = FILTER(Approved));
                    ToolTip = 'Approved Staff Redeployments';
                }
                action(RedeploymentOMNotified)
                {
                    ApplicationArea = All;
                    Caption = 'Old Line Manager Notified';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    RunPageView = WHERE(Status = FILTER("Old Line Manager Notified"));
                    ToolTip = 'Staff Redeployments where the Old Line Manager has been notified';
                }
                action(RedeploymentNMNotified)
                {
                    ApplicationArea = All;
                    Caption = 'New Line Manager Notified';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    RunPageView = WHERE(Status = FILTER("New Line Manager Notified"));
                    ToolTip = 'Staff Redeployments where the New Line Manager has been notified';
                }
                action(RedeploymentLetterSent)
                {
                    ApplicationArea = All;
                    Caption = 'Redeployment Letter Sent';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    RunPageView = WHERE(Status = FILTER("Redeployment Letter Sent"));
                    ToolTip = 'Staff Redeployments where the Redeployment Letter has been sent';
                }
                action(RedeploymentComplete)
                {
                    ApplicationArea = All;
                    Caption = 'Completed';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    RunPageView = WHERE(Status = FILTER("Redeployment Completed"));
                    ToolTip = 'Completed Staff Redeployments';
                }
                action(SteppedDown)
                {
                    ApplicationArea = All;
                    Caption = 'Stepped Down';
                    Image = PersonInCharge;
                    RunObject = Page Redeployments;
                    RunPageView = WHERE(Status = FILTER("Stepped Down"));
                    ToolTip = 'Abandoned Staff Redeployments';
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
                    RunObject = Page "Payroll Employee List";
                    ToolTip = 'Open Payroll List and Perform Payroll Operations';
                }
                action("PayrollSetup")
                {
                    ApplicationArea = All;
                    Caption = 'Payroll Setup';
                    RunObject = Page "QuantumJumps Payroll Setup";
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
            group(new) { Caption = 'test leav'; }
            group("Leave Management new")
            {
                //Image = Administration;
                Caption = 'Leave Management ';
                Image = Capacities;
                ToolTip = 'All staff leave records';


                group("Leave")
                {
                    Caption = 'Leave Applications';

                    action("Leave Applications-Open")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const(Open);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Open';
                    }
                    action("Leave Applications-Pending Approval")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const("Pending Approval");
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Pending';
                    }
                    action("Leave Applications-Approved")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const(Released);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Approved';
                    }
                    action("Leave Applications-Rejected")
                    {
                        RunObject = page "Leave Application List";
                        RunPageLink = Status = const(Rejected);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Applications action';
                        Caption = 'Leave Applications-Rejected';
                    }
                }
                group("Leave Adjustments ")
                {
                    action("Leave Adjustments")
                    {
                        RunObject = page "Leave Adjustment List";
                        RunPageLink = Posted = filter(false);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Adjustments action';
                        Caption = 'Leave Adjustments';
                    }
                    action("Posted Leave Adjustments")
                    {
                        RunObject = page "Leave Adjustment List";
                        RunPageLink = Posted = filter(true);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Posted Leave Adjustments action';
                        Caption = 'Posted Leave Adjustments';
                    }
                }
                group("Leave Recalls new")
                {
                    Caption = 'Leave Recalls';
                    action("Leave Recall")
                    {
                        RunObject = page "Leave Recall List";
                        RunPageLink = Completed = filter(false);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Recall action';
                        Caption = 'Leave Recall';
                    }
                    action("Completed Leave Recalls")
                    {
                        RunObject = page "Leave Recall List";
                        RunPageLink = Completed = filter(true);
                        ApplicationArea = All;
                        ToolTip = 'Executes the Completed Leave Recalls action';
                        Caption = 'Completed Leave Recalls';
                    }
                }
                group("Leave Planner ")
                {
                    Caption = 'Leave Planner ';
                    action("Leave Planner")
                    {
                        RunObject = page "Leave Planner List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Assign Leave Days action';
                        Caption = 'Leave Planner';
                    }
                }
                group("Leave Reports")
                {
                    Caption = 'Leave Reports';
                    action("Leave Applications Report")
                    {
                        RunObject = report "Leave Applications";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Balances action';
                        Caption = 'Leave Applications';
                    }
                    action("Leave Balances")
                    {
                        RunObject = report "Leave Balance";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Balances action';
                        Caption = 'Leave Balances';
                    }
                    action("Leave Balancesnew")
                    {
                        RunObject = report "Leave Balance new";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Balances action';
                        Caption = 'Leave Balances New';
                    }

                    action("Leave Statement")
                    {
                        RunObject = report "HR Staff Leave Statement";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Statement action';
                        Caption = 'Leave Statement';
                    }
                }
                group("Leave Setups")
                {
                    Caption = 'Leave Setups';
                    action("Leave Types")
                    {
                        RunObject = page "Leave Types Setup";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Types action';
                        Caption = 'Leave Types';
                    }
                    action("Leave Period")
                    {
                        RunObject = page "Leave Periods";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Leave Period action';
                        Caption = 'Leave Period';
                    }
                    action("Base Calendar")
                    {
                        RunObject = page "Base Calendar List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Base Calendar List action';
                        Caption = 'Base Calendar';
                    }
                }
                group("Leave Archive")
                {
                    action("Leave Ledger")
                    {
                        RunObject = page "HR Leave Ledger Entries";
                        Caption = 'Leave Ledger Entries';
                        ApplicationArea = All;
                    }
                }


            }

            /*

             group("Leave Management")
             {
                 Caption = 'Leave Management';
                 Image = Capacities;
                 ToolTip = 'All staff leave records';
                 action("Leave Applications-Open1")
                 {
                     RunObject = page "Leave Application List";
                     RunPageLink = Status = const(Open);
                     ToolTip = 'Executes the Leave Applications action';
                     Caption = 'Leave Applications-Open';
                 }
                 action("Leave Applications-Pending Approval1")
                 {
                     RunObject = page "Leave Application List";
                     RunPageLink = Status = const("Pending Approval");
                     ToolTip = 'Executes the Leave Applications action';
                     Caption = 'Leave Applications-Pending';
                 }
                 action("Create Leave Plan for Employee")
                 {
                     ApplicationArea = All;
                     Caption = 'Create Leave Plan for Employee';
                     Image = PersonInCharge;
                     RunObject = Page "Department Leave Plans List";
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
                 action("Leave Adjustment")
                 {
                     ApplicationArea = All;
                     Caption = 'Leave Adjustment';
                     RunObject = Page "Leave Adjustment List";
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
                     action("Approved Leave Plans")
                     {
                         ApplicationArea = All;
                         Caption = 'Approved Leave Plans';
                         Image = PersonInCharge;
                         RunObject = Page "Emp Leave Plan List-Approved";
                     }
                 }
                 group("Leave Management Administration")
                 {
                     Caption = 'Administration';
                     ToolTip = 'Leave Management Setups';
                     //"Employee Leave Assignment"

                     action("Employee Leave Assignment")
                     {
                         ApplicationArea = All;
                         Caption = 'Employee Leave Assignment';
                         RunObject = Page "Employee Leave Assignment";
                     }
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
                     action(BaseCalender)
                     {
                         ApplicationArea = All;
                         Caption = 'Base Calender';
                         RunObject = Page "Base Calendar List";
                     }
                 }
             }

 */
            group("Balanced Score Card")
            {
                action("Plan Review Period")
                {
                    ApplicationArea = All;
                    RunObject = Page "Bal Score Plan Review Period";
                }
                action("Preview Periods")
                {
                    ApplicationArea = All;
                    RunObject = Page "Bal Score Preview Periods";
                }
                action(Planning)
                {
                    ApplicationArea = All;
                    RunObject = Page "Bal Planning Score Card List";
                }
                action(Appraisal)
                {
                    ApplicationArea = All;
                    RunObject = Page "Bal Appraisal Score Card List";
                }
                action("Admin Appraisal")
                {
                    ApplicationArea = All;
                    RunObject = Page "Bal Admin App. Score Card List";
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

                action("Competency and Qualifications Catalogue")
                {
                    ApplicationArea = All;
                    Caption = 'Competency and Qualifications Catalogue';
                    RunObject = Page "HR_Qualifications";
                }
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
            group(Disciplinary)
            {
                Caption = 'Staff Disciplinary & Misconduct';

                action("Offence Types Ratings")
                {
                    ApplicationArea = All;
                    Caption = 'Offence Ratings';
                    RunObject = page "Disciplinary Case Ratings";
                }
                action("Offence Types")
                {
                    ApplicationArea = All;
                    Caption = 'Offence Types';
                    RunObject = page "Disciplinary Cases";
                }
                action("Disciplinary Actions")
                {
                    ApplicationArea = All;
                    Caption = 'Disciplinary Actions';
                    RunObject = page "Disciplinary Actions";
                }
                action("Disciplinary Remarks")
                {
                    ApplicationArea = All;
                    Caption = 'Disciplinary Remarks';
                    RunObject = page "Disciplinary Remarks";
                }
                action("New Accusations")
                {
                    ApplicationArea = All;
                    Caption = 'New Accusations';
                    RunObject = page "Staff Displinary Cases";
                    RunPageView = where(Status = const(New));
                }
                action("Pending Accusations")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Accusations';
                    RunObject = page "Staff Displinary Cases";
                    RunPageView = where(Status = const(Accusations));
                }
                action("Accusations Rejected")
                {
                    ApplicationArea = All;
                    Caption = 'Accusations Rejected';
                    RunObject = page "Staff Displinary Cases";
                    RunPageView = where(Status = const(Rejected));
                }
                action("Open Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Open Cases';
                    RunObject = page "Staff Displinary Cases";
                    RunPageView = where(Status = const(Accepted));
                }
                action("Filed Cases")
                {
                    ApplicationArea = All;
                    Caption = 'Filed Cases';
                    RunObject = page "Staff Displinary Cases";
                    RunPageView = where(Status = filter("Action Taken" | Closed));
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
                action("Bal Score Percipectives")
                {
                    ApplicationArea = All;
                    Caption = 'Bal Score Percipectives';
                    RunObject = Page "Bal Score Percipectives";
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
                    ApplicationArea = All;
                    RunObject = Page "Medical Cover Limits";
                }
                action("Medical Covers Setup")
                {
                    Caption = 'Medical Covers Setup';
                    RunObject = Page "Medical Covers Setup";
                    ApplicationArea = All;
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
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Transfer Journal to GL";
                        ApplicationArea = All;
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
