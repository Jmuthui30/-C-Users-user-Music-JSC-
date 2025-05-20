tableextension 51802 "ExtHuman Resources Setup" extends "Human Resources Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Tax Table"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bracket Table";
        }
        field(50001; "Corporation Tax"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Housing Earned Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Pension Limit Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Pension Limit Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Round Down"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Working Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Payroll Rounding Precision"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Payroll Rounding Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Nearest,Up,Down;
        }
        field(50010; "Special Duty Table"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "CFW Round Deduction code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions;
        }
        field(50012; "BFW Round Earning code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Earnings;
        }
        field(50013; "Company overtime hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Loan Product Type Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50015; "Tax Relief Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "General Payslip Message"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Incoming Mail Server"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Outgoing Mail Server"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "Email Text"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Sender User ID"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50024; "Sender Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50025; "Email Subject"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Template Location"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(50027; "Applicants Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50028; "Leave Application Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50029; "Recruitment Needs Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50030; "Disciplinary Cases Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series".Code;
        }
        field(50031; "No. Of Days in Month"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50032; "Transport Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50033; "Cover Selection Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50034; "Qualification Days (Leave)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50035; "Leave Allowance Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Earnings;
        }
        field(50036; "Telephone Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50037; "Training Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50038; "Leave Recall Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50039; "Medical Claim Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50040; "Account No (Training)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(50041; "Training Evaluation Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50042; "Off Days Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Setup";
        }
        field(50043; "Appraisal Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50044; "Leave Plan Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50045; "Keys Request Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50046; "Incidences Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50047; "Sick Of Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50048; "Conveyance Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50049; "Base Calender Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar".Code;
        }
        field(50050; "Membership No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50052; "Employee Absentism"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50056; "Conf/Sem/Request"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50057; "Conf/Sem Evaluation"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50058; "Monthly PayDate"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "User Incident"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50060; "DMS LINK"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Vehicle Filling No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50062; "Savings Withdrawal No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50063; "Med Claim DMS LINK"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(50064; "Resource Request Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50065; "Appraisal Objective Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50066; "Probation Period(Months)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50067; "Normal Retirement Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Salary Scale Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Monthly,Annual;
        }
        field(50069; "Job Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50070; "Recruitment Plan Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50071; "Consol. Recruitment Plan Nos"; Code[20])
        {
            TableRelation = "No. Series";
            Caption = 'Consolidated Recruitment Plan Nos';
        }
        field(50072; "Pay Change Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50073; "Job Requisition Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50074; "Job Shortlisting Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50075; "Job Interview Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50076; "Probation Period"; Text[30])
        {
        }
        field(50077; "Probation Termination Notice"; Text[30])
        {
        }
        field(50078; "Annual Leave Days"; Integer)
        {
        }
        field(50079; "Leave Notice Period"; Integer)
        {
        }
        field(50080; "Contract Termination Notice"; Text[30])
        {
        }
        field(50081; "Hours Worked Per Week"; Decimal)
        {
        }
        field(50082; "Days Worked Per Week"; Decimal)
        {
        }
        field(50083; "Reporting Time"; Time)
        {
        }
        field(50084; "Closing Time"; Time)
        {
        }
        field(50085; "Lunch Break Duration"; Text[30])
        {
        }
        field(50086; "Lunch Start Time"; Time)
        {
        }
        field(50087; "Lunch End Time"; Time)
        {
        }
        field(50088; "Week Start Day"; Text[30])
        {
        }
        field(50089; "Week End Day"; Text[30])
        {
        }
        field(50090; "Offers Signed By"; Text[50])
        {
        }
        field(50091; "Leave Allowance Min. Days"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50092; "Training Need Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50093; "Training Plan Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50094; "Maximum No. of Trainings"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50095; "Training Notification"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50096; "KRA Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50097; "Competencies Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50098; "Training Expense Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Expense Codes" where("Account Type" = const("G/L Account"));
        }
        field(50099; "Training Application Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50100; "One Point Eligibility"; Text[70])
        {
            DataClassification = ToBeClassified;
            // trigger OnLookup()
            // begin
            //     AppraisalRatings.Reset;
            //     if PAGE.RunModal(PAGE::"Appraisal Ratings", AppraisalRatings) = ACTION::LookupOK then
            //         "One Point Eligibility" := AppraisalRatings.Code;
            // end;
        }
        field(50101; "Exit Form Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50102; "Exit Nos"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50103; "Orientation No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50104; "IT Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(50105; "HR Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(50106; "Finance Email"; Text[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = EMail;
        }
        field(50107; "PLWD Retirement Age"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(50108; "Cons. Recruitment Plan Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50109; "Leave Adjustment Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50110; "Shortlisting Criteria"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50111; "Education Institution Nos"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50112; "Minimum Employee Age"; Code[50])
        { }
        field(50113; "Retirement Age"; Code[30]) { }
    }
}
