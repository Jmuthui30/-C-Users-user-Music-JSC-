table 51605 "QuantumJumps HR Setup"
{
    // version THL- HRM 1.0
    DrillDownPageID = "QuantumJumps HR Setup";
    LookupPageID = "QuantumJumps HR Setup";

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Leave Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Base Calendar Code"; Code[10])
        {
            TableRelation = "Base Calendar";
        }
        field(4; "Leave Allowance Code"; Code[10])
        {
            TableRelation = Earnings;
        }
        field(5; "Qualification Days (Leave)"; Integer)
        {
        }
        field(6; "Applicant Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(7; "Probation Period"; Text[30])
        {
        }
        field(8; "Probation Termination Notice"; Text[30])
        {
        }
        field(9; "Annual Leave Days"; Integer)
        {
        }
        field(10; "Leave Notice Period"; Integer)
        {
        }
        field(11; "Contract Termination Notice"; Text[30])
        {
        }
        field(12; "Hours Worked Per Week"; Decimal)
        {
        }
        field(13; "Days Worked Per Week"; Decimal)
        {
        }
        field(14; "Reporting Time"; Time)
        {
        }
        field(15; "Closing Time"; Time)
        {
        }
        field(16; "Lunch Break Duration"; Text[30])
        {
        }
        field(17; "Lunch Start Time"; Time)
        {
        }
        field(18; "Lunch End Time"; Time)
        {
        }
        field(19; "Week Start Day"; Text[30])
        {
        }
        field(20; "Week End Day"; Text[30])
        {
        }
        field(21; "Offers Signed By"; Text[50])
        {
        }
        field(22; "CSR Hours per Year"; Integer)
        {
        }
        field(23; "CSR Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(24; "Training Hours per Year"; Integer)
        {
        }
        field(25; "Training Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(26; "User Incidence Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(27; "Payroll Rounding Precision"; Decimal)
        {
        }
        field(28; "Payroll Rounding Type"; Option)
        {
            OptionMembers = Nearest,Up,Down;
        }
        field(29; "HR Manager"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(30; "Leave Plan Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(31; "Leave Recall Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(32; "Recruitment Needs Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(33; "Appraisal Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(34; "Job Templ Nos"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(35; "Appraisal Objective Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(36; "Job Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(38; "Recruitment Request"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(39; "Bal Planning Score Card Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(40; "Bal Appraisal Score Card Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(41; "No Of Chart Entries"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "CC Base Calendar Code"; Code[10])
        {
            TableRelation = "Base Calendar";
        }
        field(43; "Staff Displinary Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50; "Threshold Age For Leave Enti"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Threshold Age For Additional Leave Entitlement';
        }
        field(51; "Threshold Addit. Entitilement"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Additional Entitlement Above Threshhold';
        }
        field(52; "Leave Adjustment Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }
    fieldgroups
    {
    }
}
