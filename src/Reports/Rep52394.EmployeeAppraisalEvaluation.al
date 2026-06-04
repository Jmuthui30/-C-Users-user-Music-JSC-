report 52394 "Employee Appraisal Evaluation"
{
    ApplicationArea = All;
    Caption = 'Employee Appraisal Evaluation';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeAppraisalEvaluation.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(EmployeeAppraisal; "Employee Appraisal")
        {
            CalcFields = "Responsibilty Center", "Total Weighting", "Total FY Rating", "Total FY Attributes", "Current Review Score", "Total Review Score", "Review Start Date", "Review End Date";
            RequestFilterFields = "Appraisal Period", "Appraisal Type", "Department Code", "Current Review Period Code", Status, "Appraisal Status";

            column(CompName; CompanyInfo.Name) { }
            column(CompPic; CompanyInfo.Picture) { }
            column(AppraisalNo; "Appraisal No") { }
            column(EmployeeNo; "Employee No") { }
            column(AppraiseeName; "Appraisee Name") { }
            column(JobTitle; "Appraisee's Job Title") { }
            column(JobGroup; "Job Group") { }
            column(DepartmentCode; "Department Code") { }
            column(ResponsibilityCenter; "Responsibilty Center") { }
            column(DirectorateDimensionCode; DirectorateDimensionCode) { }
            column(DirectorateFilter; DirectorateFilter) { }
            column(DirectorateCode; AppraisalReportingMgt.GetDirectorateCodeForAppraisal(EmployeeAppraisal)) { }
            column(DirectorateName; AppraisalReportingMgt.GetDirectorateNameForAppraisal(EmployeeAppraisal)) { }
            column(AppraisalPeriod; "Appraisal Period") { }
            column(AppraisalTypeCode; "Appraisal Type") { }
            column(AppraisalTypeOption; Format(AppraisalType)) { }
            column(StatusText; Format(Status)) { }
            column(AppraisalStatusText; Format("Appraisal Status")) { }
            column(TotalWeighting; "Total Weighting") { }
            column(TotalFYRating; "Total FY Rating") { }
            column(TotalFYAttributes; "Total FY Attributes") { }
            column(TotalPercentageFYRating; "Total Percentage FY Rating") { }
            column(GradeFinalYearRating; "Grade final year rating") { }
            column(CurrentReviewPeriod; "Current Review Period Code") { }
            column(ReviewStartDate; "Review Start Date") { }
            column(ReviewEndDate; "Review End Date") { }
            column(CurrentReviewScore; "Current Review Score") { }
            column(TotalReviewScore; "Total Review Score") { }
            column(BSCPlanningNo; "BSC Planning No.") { }
            column(BSCAppraisalNo; "BSC Appraisal No.") { }

            dataitem(AppraisalLine; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");

                column(EvalLineWorkplanCode; "Workplan Code") { }
                column(EvalLineWorkplanDescription; "Workplan Description") { }
                column(EvalLineReviewPeriod; "Review Period Code") { }
                column(EvalLineWeighting; Weighting) { }
                column(EvalLineSelfRating; "Self Rating") { }
                column(EvalLineAppraiserRating; "Appraiser Rating") { }
                column(EvalLineQuarterScore; "Quarter Score") { }
                column(EvalLineAppraiseeComments; "Appraisee's comments") { }
                column(EvalLineAppraiserComments; "Results Achieved Comments") { }
            }

            dataitem(BSCAppraisal; "Bal Score Card Header")
            {
                CalcFields = Score, "Expected Score";
                DataItemLink = "Employee Appraisal No." = field("Appraisal No");
                DataItemTableView = where("Document Type" = const(Appraisal));

                column(EvalBSCNo; "No.") { }
                column(EvalBSCProgressReviewPeriod; "Progress Review Period") { }
                column(EvalBSCScore; Score) { }
                column(EvalBSCExpectedScore; "Expected Score") { }
                column(EvalBSCCombinedScore; "Combined Score") { }
                column(EvalBSCPerformanceRating; "Performance Rating") { }
            }

            trigger OnAfterGetRecord()
            begin
                if (DirectorateFilter <> '') and (AppraisalReportingMgt.GetDirectorateCodeForAppraisal(EmployeeAppraisal) <> DirectorateFilter) then
                    CurrReport.Skip();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Filters)
                {
                    Caption = 'Filters';

                    field(DirectorateFilter; DirectorateFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Directorate Filter';
                        TableRelation = "Dimension Value".Code;
                        ToolTip = 'Specifies the directorate dimension value to report. Leave blank to include every directorate. The directorate dimension is controlled from Human Resources Setup.';
                    }
                }
            }
        }
    }

    trigger OnPreReport()
    var
        DimensionValue: Record "Dimension Value";
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
        DirectorateDimensionCode := AppraisalReportingMgt.GetDirectorateDimensionCode();

        if DirectorateFilter <> '' then
            DimensionValue.Get(DirectorateDimensionCode, DirectorateFilter);
    end;

    var
        AppraisalReportingMgt: Codeunit "Appraisal Reporting Mgt.";
        CompanyInfo: Record "Company Information";
        DirectorateDimensionCode: Code[20];
        DirectorateFilter: Code[20];
}
