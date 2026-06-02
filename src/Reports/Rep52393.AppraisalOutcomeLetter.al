report 52393 "Appraisal Outcome Letter"
{
    ApplicationArea = All;
    Caption = 'Appraisal Outcome Letter';
    DefaultLayout = Word;
    UsageCategory = ReportsAndAnalysis;
    WordLayout = './src/report_layout/AppraisalOutcomeLetter.docx';

    dataset
    {
        dataitem(AppraisalOutcome; "Appraisal Outcome")
        {
            RequestFilterFields = "Appraisal No.", "Outcome Type", "Employee No.", "Appraisal Period";

            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPhone; CompanyInfo."Phone No.") { }
            column(CompanyPhoneNo; CompanyInfo."Phone No.") { }
            column(CompanyEmail; CompanyInfo."E-Mail") { }
            column(AppraisalNo; "Appraisal No.") { }
            column(OutcomeType; Format("Outcome Type")) { }
            column(EmployeeNo; "Employee No.") { }
            column(EmployeeName; "Employee Name") { }
            column(JobTitle; "Job Title") { }
            column(DepartmentCode; "Department Code") { }
            column(AppraisalPeriod; "Appraisal Period") { }
            column(Rating; Rating) { }
            column(Grade; Grade) { }
            column(Subject; Subject) { }
            column(LetterBody; "Letter Body") { }
            column(IssueDate; "Issue Date") { }
            column(IssuedBy; "Issued By") { }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";
}
