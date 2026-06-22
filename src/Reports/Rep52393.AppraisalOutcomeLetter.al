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
            RequestFilterFields = "Appraisal No.", "Outcome Type", "Employee No.", "Appraisal Period", "Review Period Code";

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
            column(ReviewPeriodCode; "Review Period Code") { }
            column(Rating; Rating) { }
            column(Grade; Grade) { }
            column(Subject; Subject) { }
            column(LetterBody; "Letter Body") { }
            column(IssueDate; GetIssueDate()) { }
            column(IssuedBy; GetIssuedBy()) { }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
    end;

    var
        CompanyInfo: Record "Company Information";

    local procedure GetIssueDate(): Date
    begin
        if AppraisalOutcome."Issue Date" <> 0D then
            exit(AppraisalOutcome."Issue Date");

        exit(WorkDate());
    end;

    local procedure GetIssuedBy(): Code[50]
    begin
        if AppraisalOutcome."Issued By" <> '' then
            exit(AppraisalOutcome."Issued By");

        exit(CopyStr(UserId, 1, MaxStrLen(AppraisalOutcome."Issued By")));
    end;
}
