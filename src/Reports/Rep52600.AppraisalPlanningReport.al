report 52600 "Appraisal Planning Report"
{
    ApplicationArea = All;
    Caption = 'Appraisal Planning Report';
    DefaultRenderingLayout = PlanningWord;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Plan; "Appraisal Planning Header")
        {
            RequestFilterFields = "No.", "Employee No.", "Appraisal Period", "Planning Status";

            column(PlanCode; "No.") { }
            column(EmployeeNo; "Employee No.") { }
            column(EmployeeName; "Employee Name") { }
            column(AppraisalPeriod; "Appraisal Period") { }
            column(ResponsibilityCenter; "Responsibility Center") { }
            column(AppraiserNo; "Appraiser No.") { }
            column(AppraiserName; "Appraiser Name") { }
            column(PlanningStatus; "Planning Status") { }
            column(ReviewRound; "Review Round") { }
            column(SubmittedAt; "Submitted At") { }
            column(ReturnedAt; "Returned At") { }
            column(ObjectivesAgreedAt; "Objectives Agreed At") { }
            column(AppraisalCreatedAt; "Appraisal Created At") { }
            column(ActualAppraisalNo; "Actual Appraisal No.") { }
            column(LastReviewReason; "Last Review Reason") { }
            column(JobTitle; "Job Title") { }
            column(DutyStation; "Directorate Name") { }
            column(DepartmentProject; "Responsibility Center") { }
            column(MeetingDate; Today) { }
            column(PersonalDevelopmentObjectives; "Personal Dev. Objectives") { }
            column(CoreValuesMaintained; "Core Values Maintained") { }
            column(CoreValuesMaintenanceActions; "Core Values Maintenance") { }
            column(CoreValuesToDevelop; "Core Values To Develop") { }
            column(CoreValuesDevelopmentActions; "Core Values Development") { }
            column(AdditionalResponsibilities; "Additional Responsibilities") { }
            column(KnowledgeInnovationContribution; "Knowledge Innovation") { }
            column(CVSubmitted; '') { }
            column(CVNotSubmittedReason; '') { }
            column(EmployeeAgreed; "Employee Agreed") { }
            column(AppraiserAgreed; "Appraiser Agreed") { }
            column(EmployeeSignatureName; "Employee Name") { }
            column(AppraiserSignatureName; "Appraiser Name") { }
            column(EmployeeSignedAt; "Submitted At") { }
            column(AppraiserSignedAt; "Objectives Agreed At") { }
            column(HRApprovedBy; "HR Approved By") { }
            column(HRApprovedAt; "HR Approved At") { }
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress; CompanyInfo.Address) { }
            column(CompanyPicture; CompanyInfo.Picture) { }
            column(PlanGuidanceText; PlanGuidanceTxt) { }
            column(ReviewHistorySummary; GetReviewHistorySummary("No.")) { }

            dataitem(Objectives; "Appraisal Planning Line")
            {
                DataItemLink = "Plan No." = field("No.");
                DataItemTableView = sorting("Plan No.", "Line No");

                column(ObjectiveEntryNo; "Line No") { }
                column(ObjectiveCode; "Workplan Code") { }
                column(ObjectiveDescription; "Workplan Description") { }
                column(ObjectiveWeighting; "Weighting (%)") { }
                column(ObjectiveMeasuresSummary; GetObjectiveMeasuresSummary(Objectives)) { }
                column(ObjectiveInitiativesSummary; GetObjectiveInitiativesSummary(Objectives)) { }
                column(ObjectiveResourcesSummary; '') { }
                column(ObjectiveMilestonesSummary; GetObjectiveMilestonesSummary(Objectives)) { }
                column(ObjectiveReviewPeriod; "Review Period Code") { }
                column(ObjectiveTarget; Target) { }
                column(ObjectiveRatingAllocation; "Rating Allocation") { }

                dataitem(PerformanceMeasures; "Appraisal Planning Line")
                {
                    DataItemLink = "Plan No." = field("Plan No."), "Line No" = field("Line No");
                    DataItemTableView = sorting("Plan No.", "Line No");

                    column(MeasureLineNo; "Line No") { }
                    column(MeasureCode; "Performance Measure") { }
                    column(MeasureDescription; "Perf. Measure Description") { }
                }

                dataitem(Initiatives; "Appraisal Planning Line")
                {
                    DataItemLink = "Plan No." = field("Plan No."), "Line No" = field("Line No");
                    DataItemTableView = sorting("Plan No.", "Line No");

                    column(InitiativeLineNo; "Line No") { }
                    column(InitiativeCode; "Initiative Code") { }
                    column(InitiativeText; "Initiative Description") { }
                    column(InitiativeObjective; "Workplan Description") { }
                }

                dataitem(Resources; "Appraisal Planning Line")
                {
                    DataItemLink = "Plan No." = field("Plan No."), "Line No" = field("Line No");
                    DataItemTableView = sorting("Plan No.", "Line No");

                    column(ResourceLineNo; "Line No") { }
                    column(ResourceCode; '') { }
                    column(ResourceText; '') { }
                    column(ResourceObjective; "Workplan Description") { }
                }

                dataitem(Milestones; "Appraisal Planning Line")
                {
                    DataItemLink = "Plan No." = field("Plan No."), "Line No" = field("Line No");
                    DataItemTableView = sorting("Plan No.", "Line No");

                    column(MilestoneEntryNo; "Line No") { }
                    column(MilestoneObjectiveEntryNo; "Line No") { }
                    column(MilestoneQuarter; "Review Period Code") { }
                    column(MilestoneText; GetObjectiveMilestonesSummary(Milestones)) { }
                    column(MilestoneDueDate; GetReviewDueDate("Review Period Code")) { }
                }
            }

            dataitem(ReviewHistory; "Appraisal Planning Review")
            {
                DataItemLink = "Plan No." = field("No.");
                DataItemTableView = sorting("Plan No.", "Entry No.");

                column(HistoryReviewRound; "Entry No.") { }
                column(HistoryAction; Action) { }
                column(HistoryActor; "Action By") { }
                column(HistoryActionAt; "Action At") { }
                column(HistoryReason; Comment) { }
                column(HistoryActualAppraisalNo; Plan."Actual Appraisal No.") { }
                column(HistoryDownstreamError; '') { }
            }
        }
    }

    rendering
    {
        layout(PlanningWord)
        {
            Type = Word;
            LayoutFile = './src/report_layout/AppraisalPlanningReport.docx';
            Caption = 'Appraisal Planning Report';
            Summary = 'Formal Word layout for appraisal planning.';
        }
        layout(PlanningRDLC)
        {
            Type = RDLC;
            LayoutFile = './src/report_layout/AppraisalPlanningReport.rdl';
            Caption = 'Appraisal Planning Report - RDLC';
            Summary = 'Tabular RDLC fallback for appraisal planning.';
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        PlanGuidanceTxt: Label 'Objectives should be selected from the approved JSC workplan code setup and agreed before the actual quarterly appraisal review begins.';

    local procedure GetObjectiveMeasuresSummary(PlanLine: Record "Appraisal Planning Line"): Text
    begin
        exit(StrSubstNo('%1 - %2', PlanLine."Performance Measure", PlanLine."Perf. Measure Description"));
    end;

    local procedure GetObjectiveInitiativesSummary(PlanLine: Record "Appraisal Planning Line"): Text
    begin
        if PlanLine."Initiative Code" = '' then
            exit(PlanLine."Initiative Description");
        exit(StrSubstNo('%1 - %2', PlanLine."Initiative Code", PlanLine."Initiative Description"));
    end;

    local procedure GetObjectiveMilestonesSummary(PlanLine: Record "Appraisal Planning Line"): Text
    begin
        exit(StrSubstNo('%1: target %2, rating allocation %3, weighting %4%.',
            PlanLine."Review Period Code", PlanLine.Target, PlanLine."Rating Allocation", PlanLine."Weighting (%)"));
    end;

    local procedure GetReviewHistorySummary(PlanNo: Code[20]): Text
    var
        Review: Record "Appraisal Planning Review";
        Summary: Text;
        LineCount: Integer;
    begin
        Review.SetRange("Plan No.", PlanNo);
        if Review.FindSet() then
            repeat
                AddSummaryLine(Summary, StrSubstNo('%1 by %2 on %3. %4', Review.Action, Review."Action By", Review."Action At", Review.Comment), LineCount);
            until Review.Next() = 0;

        exit(Summary);
    end;

    local procedure GetReviewDueDate(ReviewPeriodCode: Code[20]): Date
    var
        ReviewPeriod: Record "Bal Score Preview Periods";
    begin
        if ReviewPeriod.Get(ReviewPeriodCode) then
            exit(ReviewPeriod."Due Date");
        exit(0D);
    end;

    local procedure AddSummaryLine(var Summary: Text; Value: Text; var LineCount: Integer)
    begin
        Value := DelChr(Value, '<>', ' ');
        if Value = '' then
            exit;

        LineCount += 1;
        if Summary <> '' then
            Summary += ' ';
        Summary += StrSubstNo('%1. %2', LineCount, Value);
    end;
}
