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
            part(ApprovalActivities; "Approvals Activities")
            {
                Caption = 'Approval Activities';
            }
            //"Employee Management Cues"
            part("Employee Management Cues"; "Employee Management Cues")
            {
                ApplicationArea = All;
                caption = 'Employee Management';
            }
            Part(Control15; "HR Management Cues")
            {
                ApplicationArea = All;
                caption = 'Recruitment Management';
            }
            // "HR Leave Management"
            Part("HR Leave Management"; "HR Leave Management")
            {
                ApplicationArea = All;
                caption = 'Leave Management';
            }
            // "Performance Management Cues"
            Part("Performance Management Cues"; "Performance Management Cues")
            {
                ApplicationArea = All;
                caption = 'Performance Management';
            }
            // "Training Management Cues"
            Part("Training Management Cues"; "Training Management Cues")
            {
                ApplicationArea = All;
                caption = 'Training Management';
            }

            part("Payroll Cues"; "Employee Payroll Cue")
            {
                ApplicationArea = All;
                Caption = 'Payroll Management';
            }
            part(Headline; "Headline RC Payroll Manager")
            {
                ApplicationArea = Basic, Suite;
                Visible = false;
            }
            part(Control96; "Report Inbox Part")
            {
                ApplicationArea = All;
                Visible = false;
            }

        }
    }
    actions
    {

        area(processing)
        {
        }


        area(embedding)
        {


            group(employeeManagement)
            {
                Caption = 'Employee Management';
                Image = Employee;
                ToolTip = 'All staff records';
                action(Action34)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Master';
                    Image = PersonInCharge;
                    RunObject = Page "Employee List";
                    ToolTip = 'View the employee details';
                }

                //"Employee Change List"
                action(Action37)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Change Request';
                    Image = PersonInCharge;
                    RunObject = Page "Employee Change List";
                    ToolTip = 'View the employee details';
                }
                //"Employee JSC List"
                action(Action38)
                {
                    ApplicationArea = All;
                    Caption = 'Employee JSC List';
                    Image = PersonInCharge;
                    RunObject = Page "Employee JSC List";
                    ToolTip = 'View the employee details';
                }
                //"Employee KJC List"
                action(Action39)
                {
                    ApplicationArea = All;
                    Caption = 'Employee KJC List';
                    Image = PersonInCharge;
                    RunObject = Page "Employee KJC List";
                    ToolTip = 'View the employee details';
                }
                // "Employee Judiciary List"
                action(Action40)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Judiciary List';
                    Image = PersonInCharge;
                    RunObject = Page "Employee Judiciary List";
                    ToolTip = 'View the employee details';
                }
                //"Employee Board List"
                action(Action41)
                {
                    ApplicationArea = All;
                    Caption = 'Employee Board List';
                    Image = PersonInCharge;
                    RunObject = Page "Employee Board List";
                    ToolTip = 'View the employee details';
                }


            }
            group("Leave Management")
            {
                Caption = 'Leave Management';
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

                    action("Leave Planner Requests")
                    {
                        RunObject = page "Leave Planner app List";
                        ApplicationArea = All;
                        ToolTip = 'Executes the Assign Leave Days action';
                        Caption = 'Leave Planner Requests';
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
                        Caption = 'Leave Applied';
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
                        Visible = false;
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




            }

            group(Recruitment)
            {
                Caption = 'Recruitment Management';
                ToolTip = 'Recruitment Process';


                action("Approved Company Establishments")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Establishments';
                    RunPageView = where(Status = const(Released));
                    RunObject = Page "Company Job List";
                    ToolTip = 'Approved staff Establishment Verified by Director HR';
                }
                action("Vacant Positions1")
                {
                    ApplicationArea = All;
                    Caption = 'Vacant Positions';
                    ToolTip = 'Open Vacant Positions';
                    RunObject = Page "Vacant Positions";
                    RunPageLink = Status = const(Released);
                    Image = VendorContact;

                }


                group("Recruitment Request")
                {
                    Caption = 'Recruitment Process';
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
                        Caption = 'Ongoing Recruitment';
                    }
                    action("Archived Recruitment Requests")
                    {
                        ApplicationArea = All;
                        RunObject = page "Archived Recruitment Requests";

                        ToolTip = 'Executes the Archived Recruitment Requests action';
                        Caption = 'Archived Recruitment ';
                    }
                }


                group(RecruitmentSubmitted)
                {
                    Caption = 'Recruitment Submition.';
                    Image = Registered;

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

                    action(List_submitted)
                    {
                        ApplicationArea = All;
                        Caption = 'List of Submitted Job ';
                        RunObject = page "Applicant Submitted Job";
                    }





                }


                group("Job Applications")
                {
                    Caption = 'Job Application';
                    action("Job Applications ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Job Appl. List";
                        RunPageLink = "Application Status" = const(Application);
                        ToolTip = 'Executes the Submitted Applications action';
                        Caption = 'Job Applications - New';
                    }

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
                        Caption = 'Applicants Submited List';
                        RunObject = report "Appl. Submit J list";
                    }


                }




            }

            group("Performance Appraisal Management")
            {
                Caption = 'Performance Management';
                group("Quarterly Scorecard")
                {
                    Caption = 'Appraisal Cycle';
                    Visible = false;
                    // Legacy planning-cycle group hidden. Appraisals are generated from Appraisal Periods.
                    action("Perf BSC Plan Review Periods")
                    {
                        ApplicationArea = All;
                        Caption = '1. Create Appraisal Planning';
                        RunObject = Page "Bal Score Plan Review Period";
                        Visible = false;
                        // Legacy planning-cycle page hidden from the unified appraisal process.
                        ToolTip = 'Open appraisal planning periods used to create employee appraisal records.';
                    }
                    action("Perf BSC Planning Documents")
                    {
                        ApplicationArea = All;
                        Caption = '2. BSC Planning Documents';
                        RunObject = Page "Bal Planning Score Card List";
                        Visible = false;
                        // Legacy BSC planning list hidden from the unified appraisal process.
                        ToolTip = 'Open employee BSC planning documents.';
                    }
                    action("Perf BSC Quarterly Reviews")
                    {
                        ApplicationArea = All;
                        Caption = '3. Quarterly BSC Reviews';
                        RunObject = Page "Bal Appraisal Score Card List";
                        Visible = false;
                        ToolTip = 'Open quarterly BSC appraisal review documents.';
                    }
                    action("Perf BSC HR Admin Reviews")
                    {
                        ApplicationArea = All;
                        Caption = '4. HR Admin BSC Reviews';
                        RunObject = Page "Bal Admin App. Score Card List";
                        Visible = false;
                        ToolTip = 'Open BSC appraisal documents for HR administration review.';
                    }
                }
                group("Appraisal Planning")
                {
                    Caption = 'Appraisal Planning';
                    action("Perf Appraisal Planning All")
                    {
                        ApplicationArea = All;
                        Caption = 'All Appraisal Planning';
                        RunObject = Page "Appraisal Planning List";
                        ToolTip = 'Open appraisal planning documents.';
                    }
                    action("Perf Appraisal Planning Draft")
                    {
                        ApplicationArea = All;
                        Caption = 'Draft Planning';
                        RunObject = Page "Draft Appraisal Planning";
                        ToolTip = 'Open draft appraisal planning documents.';
                    }
                    action("Perf Appraisal Planning Pending Appraiser")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending Appraiser Review';
                        RunObject = Page "Appr Planning Pending App.";
                        ToolTip = 'Open appraisal planning documents pending appraiser review.';
                    }
                    action("Perf Appraisal Planning Returned")
                    {
                        ApplicationArea = All;
                        Caption = 'Returned Planning';
                        RunObject = Page "Returned Appraisal Planning";
                        ToolTip = 'Open appraisal planning documents returned for changes.';
                    }
                    action("Perf Appraisal Planning Pending HR")
                    {
                        ApplicationArea = All;
                        Caption = 'Pending HR Approval';
                        RunObject = Page "Appraisal Planning Pending HR";
                        ToolTip = 'Open appraisal planning documents ready for HR to create actual appraisals.';
                    }
                    action("Perf Appraisal Planning Created")
                    {
                        ApplicationArea = All;
                        Caption = 'Planning With Appraisals Created';
                        RunObject = Page "Created Appraisal Planning";
                        ToolTip = 'Open appraisal planning documents that have created actual appraisals.';
                    }
                }
                action("Appraisal List")
                {
                    RunObject = page "Appraisal List";
                    ToolTip = 'Executes the Appraisal List - Objectives action';
                    Caption = 'Appraisal List';
                }

                action("Appraisal List - Pending Approval")
                {
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = Status = const("Pending Approval");
                    ToolTip = 'Executes the Appraisal List - Objectives Pending Approval action';
                    Caption = 'Appraisal List - Pending Approval';
                    // Visible = false;
                }
                action("Appraisal List - Under Review")
                {
                    ApplicationArea = All;
                    RunObject = page "Appraisal List - UnderReview-F";
                    ToolTip = 'Open appraisals that have been approved and are ready for quarterly assessment.';
                    Caption = 'Appraisals Under Review';
                }
                action("Appraisal List - Further review")
                {
                    RunObject = page "Appraisal List - Pending";
                    RunPageLink = "Appraisal Status" = filter("Further review");
                    ToolTip = 'Executes the Appraisal List - Further review action';
                    Caption = 'Appraisal List - Further review';
                    Visible = false;
                }
                group("Appraisals List Under Review")
                {
                    Caption = 'Appraisals List Under Review';
                    action("Appraisal List Under Review - MidYear")
                    {
                        RunObject = page "Appraisals UnderReview MidYear";
                        ToolTip = 'Executes the Appraisal List Under Review - MidYear action';
                        Caption = 'Appraisal List Under Review - MidYear';
                        Visible = false;
                    }
                    action("Appraisal List Under Review - FinalYear")
                    {
                        RunObject = page "Appraisals UnderReview FY";
                        ToolTip = 'Executes the Appraisal List Under Review - FinalYear action';
                        Caption = 'Appraisal List Under Review - FinalYear';
                        Visible = false;
                    }

                }
                action("Appraisal List - Completed")
                {
                    RunObject = page "Appraisal List - Completed";
                    ToolTip = 'Executes the Appraisal List - Completed action';
                    Caption = 'Appraisal List - Completed';
                }
                action("Appraisal Outcomes")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisal Outcomes';
                    RunObject = page "Appraisal Outcome List";
                    ToolTip = 'Open appraisal commendation letters, warning letters, and outcome memos.';
                }
                group("Appriasal Reports")
                {
                    Caption = 'Reports';
                    action("Employee Appraisal Evaluation")
                    {
                        RunObject = report "Employee Appraisal Evaluation";
                        Caption = 'Employee Appraisal Evaluation';
                    }
                }
                group("Appraisal Setup")
                {
                    Caption = 'Appraisal Setup';
                    action("Perf HR Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'HR Setup';
                        RunObject = Page "QuantumJumps HR Setup";
                        ToolTip = 'Open HR setup, including directorate dimension and appraisal numbering setup.';
                    }
                    action("Appraisal Periods")
                    {
                        RunObject = page "Appraisal Periods";
                        ToolTip = 'Executes the Appraisal Periods action';
                        Caption = 'Appraisal Periods';
                    }
                    action("Appraisal Rating Scale")
                    {
                        ApplicationArea = All;
                        Caption = 'Appraisal Rating Scale';
                        RunObject = Page "Bal Score Card Rating";
                        ToolTip = 'Set up the 1-5 rating scale used for appraisee and appraiser ratings.';
                    }
                    action("Perf BSC Preview Periods")
                    {
                        ApplicationArea = All;
                        Caption = 'Quarterly Review Periods';
                        RunObject = Page "Bal Score Preview Periods";
                        ToolTip = 'Set up appraisal review sequence, final review period, and suggested review dates.';
                    }
                    action("Perf BSC Employee Categories")
                    {
                        ApplicationArea = All;
                        Caption = 'BSC Employee Categories';
                        RunObject = Page "Bal Score Emp Categories";
                        Visible = false;
                        // Legacy BSC scoring setup hidden; unified appraisals use workplan objective lines.
                        ToolTip = 'Set up BSC employee categories used when creating scorecard lines.';
                    }
                    action("Perf BSC Scoring Setup")
                    {
                        ApplicationArea = All;
                        Caption = 'BSC Scoring Setup';
                        RunObject = Page "Bal Scoring Setup";
                        Visible = false;
                        // Legacy BSC scoring setup hidden; unified appraisals use objective weighting.
                        ToolTip = 'Set up BSC perspectives and weighting by employee category.';
                    }
                    action("Perf BSC Perspectives")
                    {
                        ApplicationArea = All;
                        Caption = 'BSC Perspectives';
                        RunObject = Page "Bal Score Percipectives";
                        Visible = false;
                        // Legacy BSC perspective setup hidden from the unified appraisal process.
                        ToolTip = 'Set up BSC perspectives used by scorecard scoring setup.';
                    }
                    action("Perf BSC Ratings")
                    {
                        ApplicationArea = All;
                        Caption = 'BSC Ratings';
                        RunObject = Page "Bal Score Card Rating";
                        Visible = false;
                        // Legacy BSC rating setup hidden from the unified appraisal process.
                        ToolTip = 'Set up BSC rating values.';
                    }
                    action("Workplan Codes")
                    {
                        RunObject = page "Appraisal Workplan Codes";
                        Caption = 'Workplan Codes';
                    }
                    action("Strategic Implementation Frequency")
                    {
                        RunObject = page "Strategic Impl Frequency";
                        ToolTip = 'Executes the Strategic Implementation Frequency action';
                        Visible = false;
                        Caption = 'Strategic Implementation Frequency';
                    }
                    action("Strategic Implementation Objectives")
                    {
                        RunObject = page "Strategic Impl Objectives";
                        ToolTip = 'Executes the Strategic Implementation Objectives action';
                        Visible = false;
                        Caption = 'Strategic Implementation Objectives';
                    }
                    action("Perfomance rating matrix")
                    {
                        RunObject = page "Perfomance rating matrix";
                        ToolTip = 'Executes the Perfomance rating matrix action';
                        Visible = false;
                        Caption = 'Perfomance rating matrix';
                    }
                    action("Work related attributes")
                    {
                        RunObject = page "Work related attributes";
                        ToolTip = 'Executes the Work related attributes action';
                        Caption = 'Work related attributes';
                    }
                    action("Training Area")
                    {
                        RunObject = page "Training Areas";
                        ToolTip = 'Executes the Training Area action';
                        Caption = 'Training Area';
                    }
                    action("Skill Codes")
                    {
                        RunObject = page "Skill Codes";
                        ToolTip = 'Executes the Skill Codes action';
                        Visible = false;
                        Caption = 'Skill Codes';
                    }
                    action("Developmental Actions Setup")
                    {
                        RunObject = page "Appraisal Dev Needs Setup";
                        ToolTip = 'Executes the Developmental Actions Setup action';
                        Caption = 'Developmental Actions Setup';
                    }
                }
            }

            group("Training and Development")
            {
                Caption = 'Training and Development';
                Image = Capacities;
                ToolTip = 'Track Employee Training and Development';
                group("Training Budget Group")
                {
                    Caption = 'Training Budget';
                    action("Training Budget Action")
                    {
                        ApplicationArea = All;
                        RunObject = page "Training Plan Budget";
                        Caption = 'Training Budget';
                        ToolTip = 'Open the approved training budget and budget lines.';
                    }
                }

                group("Training Needs Intake")
                {
                    Caption = 'Needs Intake';
                    action("Training Needs Assesment")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Needs Assesment';
                        RunObject = Page "New Training Needs Assesment";
                        ToolTip = 'Capture new staff or department training needs.';
                    }
                    action("Training Needs Under Review")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Needs Under Review';
                        RunObject = Page "Training Needs List-Approval";
                        ToolTip = 'Review and approve submitted training needs assessments.';
                    }
                    action("Reviewed Training Needs")
                    {
                        ApplicationArea = All;
                        Caption = 'Reviewed Training Needs';
                        RunObject = Page "Training Needs List-Approved";
                        ToolTip = 'Open approved training needs assessments and create planning training needs.';
                    }
                    action("New Training Needs")
                    {
                        ApplicationArea = All;
                        RunObject = page "Training Needs Open";
                        ToolTip = 'Open training needs created for application.';
                        Caption = 'New Training Needs';
                    }
                }

                group("Training Planning")
                {
                    Caption = 'Planning';
                    action("Consolidated Training Plan")
                    {
                        ApplicationArea = All;
                        RunObject = page "Consolidated Training Plan";
                        ToolTip = 'Open consolidated planned training needs for scheduling and approval readiness.';
                        Caption = 'Consolidated Training Plan';
                    }

                    action("On-Going Training Needs")
                    {
                        ApplicationArea = All;
                        RunObject = page "Training Needs Application";
                        RunPageLink = Status = filter(Application);
                        ToolTip = 'Open training needs that are ready for application.';
                        Caption = 'On-Going Training Needs';
                    }
                }

                group("Training Applications")
                {
                    Caption = 'Training Applications';
                    action("Training Request List ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Training Request List";
                        ToolTip = 'Open staff training applications.';
                        Caption = 'Training Request List ';
                    }
                    action("Approved Training Request List ")
                    {
                        ApplicationArea = All;
                        RunObject = page "Approved Training Request List";
                        ToolTip = 'Open approved staff training applications.';
                        Caption = 'Approved Training Request List ';
                    }
                }

                group("Training Evaluation")
                {
                    Caption = 'Training Evaluation';
                    action("Training Evaluations")
                    {
                        ApplicationArea = All;
                        RunObject = page "Training Evaluation List";
                        ToolTip = 'Open training feedback, back-to-office reports, and supervisor evaluations.';
                        Caption = 'Training Evaluations';
                    }
                }

                group("Training Reports")
                {
                    Caption = 'Training Reports';
                    action("Training Needs ")
                    {
                        ApplicationArea = All;
                        RunObject = report "Training Need";
                        Caption = 'Training Needs ';
                    }
                    action("Approved Training Requests")
                    {
                        ApplicationArea = All;
                        RunObject = report "Approved Training Requests";
                        Caption = 'Approved Training Requests';
                    }
                    action("Training Plan Summary")
                    {
                        ApplicationArea = All;
                        RunObject = report "Training Plan Summary";
                        Caption = 'Training Plan Summary';
                    }
                    action("Training Requirements")
                    {
                        ApplicationArea = All;
                        RunObject = report "Training Requirements";
                        Caption = 'Training Requirements';
                    }
                    action("Training Attendees")
                    {
                        ApplicationArea = All;
                        RunObject = report "Training Attendees";
                        Caption = 'Training Attendees';
                    }
                    action("Training History")
                    {
                        ApplicationArea = All;
                        RunObject = report "Training History";
                        Caption = 'Training History';
                    }
                    action("Courses Offered")
                    {
                        ApplicationArea = All;
                        RunObject = report "Courses Offered";
                        Caption = 'Courses Offered';
                    }
                    action("Training Feedback Summary")
                    {
                        ApplicationArea = All;
                        RunObject = report "Training Feedback Summary";
                        Caption = 'Training Feedback Summary';
                    }
                    action("Competencies and Skills")
                    {
                        ApplicationArea = All;
                        RunObject = report "Competencies and Skills";
                        Caption = 'Competencies and Skills';
                    }
                }

                group("Training Administration")
                {
                    Caption = 'Administration';
                    action("Competency and Qualifications Catalogue")
                    {
                        ApplicationArea = All;
                        Caption = 'Competency and Qualifications Catalogue';
                        RunObject = Page "HR_Qualifications";
                        ToolTip = 'Maintain competencies and qualifications used for development planning.';
                    }
                    action(Coaching)
                    {
                        ApplicationArea = All;
                        Caption = 'Coaching';
                        RunObject = Page "Coaching List";
                        ToolTip = 'Maintain coaching records linked to development needs.';
                    }
                    action("Performance Issues")
                    {
                        ApplicationArea = All;
                        Caption = 'Performance Issues';
                        RunObject = Page "Performance Issues";
                        ToolTip = 'Maintain performance issues used in training needs analysis.';
                    }
                    action("Training Needs2")
                    {
                        ApplicationArea = All;
                        Caption = 'Training Needs';
                        RunObject = Page "Training Needs";
                        ToolTip = 'Maintain training needs setup records.';
                    }
                }


            }

            group(Payroll)
            {
                Caption = 'Payroll Management';
                ToolTip = 'Payroll Management';
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
                    Visible = false;
                }
                action("Imprest Payroll Claims Open")
                {
                    ApplicationArea = All;
                    Caption = 'Open';
                    RunObject = Page "Imprest Payroll Claims List";
                    RunPageView = where(Status = const(Open));
                    Visible = false;
                }
                action("Imprest Payroll Claims Pending")
                {
                    ApplicationArea = All;
                    Caption = 'Pending Approval';
                    RunObject = Page "Imprest Payroll Claims List";
                    RunPageView = where(Status = const("Pending Approval"));
                    Visible = false;
                }
                action("Imprest Payroll Claims Approved")
                {
                    ApplicationArea = All;
                    Caption = 'Approved';
                    RunObject = Page "Imprest Payroll Claims List";
                    RunPageView = where(Status = const(Released));
                    Visible = false;
                }
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

                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    Image = Reconcile;

                    action("Payroll Run")
                    {
                        ApplicationArea = All;
                        Caption = 'Payroll Run';
                        Image = Calculate;
                        //RunObject = Report "Payroll Calculator";
                        RunObject = report "Client Payroll Calculator";
                        ToolTip = 'Calculate Payroll';
                    }
                    action("Email Payslips")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email Payslips';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Client Payslips";
                        //RunObject = codeunit "Email Payslips";
                        ToolTip = 'Email Payslips';
                    }
                    action("Email P9A")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Email P9 Report';
                        Image = SendEmailPDF;
                        RunObject = Report "Email Client P9";
                        ToolTip = 'Email P9A';
                    }
                    action("Generate Payroll Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Payroll Journal';
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Transfer Client Journal to GL";
                    }
                    action("Generate Payroll Journal per Group")
                    {
                        ApplicationArea = All;
                        Caption = 'Generate Payroll Journal Per Group';
                        Image = Suggest;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = Report "Client Journal to GL New";
                    }
                    action("General Journal")
                    {
                        ApplicationArea = All;
                        Caption = 'General Journal';
                        Image = Journals;
                        Promoted = true;
                        PromotedIsBig = true;
                        RunObject = page "General Journal";
                    }
                }

            }


        }


        area(reporting)
        {
        }

        area(sections)
        {
        }

    }
}
