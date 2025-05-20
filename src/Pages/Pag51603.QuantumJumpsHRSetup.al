page 51603 "QuantumJumps HR Setup"
{
    // version THL- HRM 1.0
    PageType = Card;
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = false;
    UsageCategory = Administration;
    ApplicationArea = All;
    SourceTable = "QuantumJumps HR Setup";

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'General';

                field("Primary Key"; Rec."Primary Key")
                {
                    //Visible = false;
                    ApplicationArea = All;
                }
                field("No Of Chart Entries"; Rec."No Of Chart Entries")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Applicant Nos."; Rec."Applicant Nos.")
                {
                    ApplicationArea = All;
                }
                field("Base Calendar Code"; Rec."Base Calendar Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("CC Base Calendar Code"; Rec."CC Base Calendar Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Qualification Days (Leave)"; Rec."Qualification Days (Leave)")
                {
                    ApplicationArea = All;
                }
                field("Probation Period"; Rec."Probation Period")
                {
                    ApplicationArea = All;
                }
                field("Probation Termination Notice"; Rec."Probation Termination Notice")
                {
                    ApplicationArea = All;
                }
                field("Contract Termination Notice"; Rec."Contract Termination Notice")
                {
                    ApplicationArea = All;
                }
                field("Offers Signed By"; Rec."Offers Signed By")
                {
                    ApplicationArea = All;
                }
                field("User Incidence Nos."; Rec."User Incidence Nos.")
                {
                    ApplicationArea = All;
                }
                field("Payroll Rounding Precision"; Rec."Payroll Rounding Precision")
                {
                    ApplicationArea = All;
                }
                field("Payroll Rounding Type"; Rec."Payroll Rounding Type")
                {
                    ApplicationArea = All;
                }
                field("HR Manager"; Rec."HR Manager")
                {
                    ApplicationArea = All;
                }
                field("Recruitment Needs Nos."; Rec."Recruitment Needs Nos.")
                {
                    ApplicationArea = All;
                }
                field("Recruitment Request"; Rec."Recruitment Request")
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
            group("Leave Setup")
            {
                Caption = 'Leave Setup';

                field("Leave Plan Nos"; Rec."Leave Plan Nos")
                {
                    ApplicationArea = All;
                }
                field("Leave Application Nos"; Rec."Leave Application Nos")
                {
                    ApplicationArea = All;
                }
                field("Leave Recall Nos"; Rec."Leave Recall Nos")
                {
                    ApplicationArea = All;
                }
                field("Leave Allowance Code"; Rec."Leave Allowance Code")
                {
                    ApplicationArea = All;
                }
                field("Annual Leave Days"; Rec."Annual Leave Days")
                {
                    ApplicationArea = All;
                }
                field("Leave Notice Period"; Rec."Leave Notice Period")
                {
                    ApplicationArea = All;
                }
                field("Threshold Addit. Entitilement"; Rec."Threshold Addit. Entitilement")
                {
                    ApplicationArea = All;
                }
                field("Threshold Age For Leave Enti"; Rec."Threshold Age For Leave Enti")
                {
                    ApplicationArea = All;
                }
                field("Leave Adjustment Nos"; "Leave Adjustment Nos") { ApplicationArea = All; }

            }
            group("Training Setup")
            {
                Caption = 'Training Setup';

                field("Training Nos."; Rec."Training Nos.")
                {
                    ApplicationArea = All;
                }
                field("Training Hours per Year"; Rec."Training Hours per Year")
                {
                    ApplicationArea = All;
                }
            }
            group("CSR Setup")
            {
                Caption = 'CSR Setup';

                field("CSR Hours per Year"; Rec."CSR Hours per Year")
                {
                    ApplicationArea = All;
                }
                field("CSR Nos."; Rec."CSR Nos.")
                {
                    ApplicationArea = All;
                }
            }
            group(Appraisal)
            {
                field("Appraisal Nos"; Rec."Appraisal Nos")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Objective Nos"; Rec."Appraisal Objective Nos")
                {
                    ApplicationArea = All;
                }
                field("Bal Planning Score Card Nos"; Rec."Bal Planning Score Card Nos")
                {
                    ApplicationArea = All;
                }
                field("Bal Appraisal Score Card Nos"; Rec."Bal Appraisal Score Card Nos")
                {
                    ApplicationArea = All;
                }
            }
            group(Job)
            {
                Caption = 'Jobs Setup';

                field("Job Nos"; Rec."Job Nos")
                {
                    ApplicationArea = All;
                }
                field("Job Templ Nos"; Rec."Job Templ Nos")
                {
                    ApplicationArea = All;
                }
            }
            group("Staff Disciplinary")
            {
                Caption = 'Staff Disciplinary';

                field("Staff Displinary Nos"; Rec."Staff Displinary Nos")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
