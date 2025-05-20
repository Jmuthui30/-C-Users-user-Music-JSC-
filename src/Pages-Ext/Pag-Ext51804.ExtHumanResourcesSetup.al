pageextension 51804 "ExtHuman Resources Setup" extends "Human Resources Setup"
{
    layout
    {
        addafter("Base Unit of Measure")
        {
            field("Normal Retirement Age"; Rec."Normal Retirement Age")
            {
                ApplicationArea = all;
            }
            field("Retirement Age"; "Retirement Age") { ApplicationArea = all; }
            field("Minimum Employee Age"; "Minimum Employee Age") { ApplicationArea = All; }
            field("PLWD Retirement Age"; Rec."PLWD Retirement Age")
            {
                ApplicationArea = All;
            }
            field("Probation Period"; "Probation Period") { ApplicationArea = all; }
            field("Probation Period(Months)"; "Probation Period(Months)") { ApplicationArea = all; }
            field("Probation Termination Notice"; "Probation Termination Notice") { ApplicationArea = all; }
            field("Maximum No. of Trainings"; Rec."Maximum No. of Trainings")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Training Expense Code"; Rec."Training Expense Code")
            {
                ApplicationArea = Basic, Suite;
                ShowMandatory = true;
            }
            field("Training Notification"; Rec."Training Notification")
            {
                ApplicationArea = Basic, Suite;
            }
            field("KRA Percentage"; Rec."KRA Percentage")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Competencies Percentage"; Rec."Competencies Percentage")
            {
                ApplicationArea = Basic, Suite;
            }
            field("One Point Eligibility"; Rec."One Point Eligibility")
            {
                ApplicationArea = Basic, Suite;
            }
            field("Leave Allowance Min. Days"; Rec."Leave Allowance Min. Days")
            {
                ApplicationArea = all;
            }
            field("Leave Allowance Code"; Rec."Leave Allowance Code")
            {
                ApplicationArea = all;
            }
            field("Leave Adjustment Nos"; "Leave Adjustment Nos") { ApplicationArea = all; }
            field("Leave Plan Nos"; Rec."Leave Plan Nos")
            {
                ApplicationArea = all;
            }
            field("Leave Application Nos."; Rec."Leave Application Nos.")
            {
                ApplicationArea = all;
            }
            field("Leave Recall Nos"; Rec."Leave Recall Nos")
            {
                ApplicationArea = all;
            }
            field("Transport Request Nos"; Rec."Transport Request Nos")
            {
                ApplicationArea = All;
            }
            field("Disciplinary Cases Nos."; Rec."Disciplinary Cases Nos.")
            {
                ApplicationArea = All;
            }
            field("Pay Change Nos."; Rec."Pay Change Nos.")
            {
                ApplicationArea = All;
            }
            field("Appraisal Objective Nos"; Rec."Appraisal Objective Nos")
            {
                ApplicationArea = All;
            }
            field("Appraisal Nos"; Rec."Appraisal Nos")
            {
                ApplicationArea = All;
            }
            field("Training Need Nos"; Rec."Training Need Nos")
            {
                ApplicationArea = All;
            }
            field("Training Application Nos"; Rec."Training Application Nos")
            {
                ApplicationArea = All;
            }
            field("Exit Nos"; Rec."Exit Nos")
            {
                ApplicationArea = All;
            }
            field("Exit Form Nos."; Rec."Exit Form Nos.")
            {
                ApplicationArea = All;
            }
        }
        addafter(Numbering)
        {
            group(Recruitment)
            {
                field("Recruitment Plan Nos"; Rec."Recruitment Plan Nos")
                {
                    ApplicationArea = All;
                }
                field("Applicants Nos."; Rec."Applicants Nos.")
                {
                    ApplicationArea = All;
                }
                field("Job Requisition Nos"; Rec."Job Requisition Nos")
                {
                    ApplicationArea = All;
                }
                field("Job Application Nos"; Rec."Job Application Nos")
                {
                    ApplicationArea = All;
                }
                field("Job Shortlisting Nos"; Rec."Job Shortlisting Nos")
                {
                    ApplicationArea = All;
                }
                field("Job Interview Nos"; Rec."Job Interview Nos")
                {
                    ApplicationArea = All;
                }
                field("Consol. Recruitment Plan Nos"; "Consol. Recruitment Plan Nos") { ApplicationArea = All; }
                field("Cons. Recruitment Plan Nos"; "Cons. Recruitment Plan Nos") { ApplicationArea = All; }
            }
            group(Orientation)
            {
                field("Orientation No."; Rec."Orientation No.")
                {
                    ApplicationArea = All;
                }
                field("HR Email"; Rec."HR Email")
                {
                    ApplicationArea = All;
                }
                field("Finance Email"; Rec."Finance Email")
                {
                    ApplicationArea = All;
                }
                field("IT Email"; Rec."IT Email")
                {
                    ApplicationArea = All;
                }
            }
            group("Time Setup")
            {
                field("Hours Worked Per Week"; Rec."Hours Worked Per Week")
                {
                    ApplicationArea = All;
                }
                field("Days Worked Per Week"; Rec."Days Worked Per Week")
                {
                    ApplicationArea = All;
                }
                field("Reporting Time"; Rec."Reporting Time")
                {
                    ApplicationArea = All;
                }
                field("Closing Time"; Rec."Closing Time")
                {
                    ApplicationArea = All;
                }
                field("Lunch Break Duration"; Rec."Lunch Break Duration")
                {
                    ApplicationArea = All;
                }
                field("Lunch Start Time"; Rec."Lunch Start Time")
                {
                    ApplicationArea = All;
                }
                field("Lunch End Time"; Rec."Lunch End Time")
                {
                    ApplicationArea = All;
                }
                field("Week Start Day"; Rec."Week Start Day")
                {
                    ApplicationArea = All;
                }
                field("Week End Day"; Rec."Week End Day")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
