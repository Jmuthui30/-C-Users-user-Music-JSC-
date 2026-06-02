report 52392 "Employee Appraisal Scorecard"
{
    ApplicationArea = All;
    Caption = 'Employee Appraisal Scorecard';
    DefaultLayout = RDLC;
    // EmployeeAppraisalScorecard
    // RDLCLayout = './src/report_layout/EmployeeAppraisalNew.rdl';
    RDLCLayout = './src/report_layout/EmployeeAppraisalScorecard.rdl';

    dataset
    {
        dataitem(EmployeeAppraisal; "Employee Appraisal")
        {
            CalcFields = "Current Review Score", "Total Review Score";
            RequestFilterFields = "Appraisal No";
            // Company Info
            column(CompPic; CompanyInfo.Picture) { }
            column(CompName; CompanyInfo.Name) { }

            // Header Fields
            column(AppraisalNo_Appraisal; "Appraisal No") { }
            column(AppraisalPeriod_Appraisal; "Appraisal Period") { }
            column(AppraisalType_Appraisal; "Appraisal Type") { }

            // Appraisee Fields
            column(AppraiseeName_Appraisal; "Appraisee Name") { }
            column(AppraiseesJobTitle_Appraisal; "Appraisee's Job Title") { }
            column(EmployeeNo_Appraisal; "Employee No") { }
            column(AppraiseeID_Appraisal; "Appraisee ID") { }

            // Appraiser Fields
            column(AppraisersName_Appraisal; "Appraisers Name") { }
            column(AppraisersJobTitle_Appraisal; "Appraiser's Job Title") { }
            column(AppraiserNo_Appraisal; "Appraiser No") { }
            column(AppraiserID_Appraisal; "Appraiser ID") { }

            // Other Header Fields
            column(DepartmentCode_Appraisal; "Department Code") { }
            column(JobGroup_Appraisal; "Job Group") { }
            column(PeriodStart_Appraisal; "Period Start") { }
            column(PeriodEnd_Appraisal; "Period End") { }
            column(CurrentReviewPeriod; "Current Review Period Code") { }
            column(CurrentReviewScore; "Current Review Score") { }
            column(TotalReviewScore; "Total Review Score") { }

            // Responsibility Center (FlowField)
            column(UserDept; "Responsibilty Center") { }

            dataitem(BSCAppraisal; "Bal Score Card Header")
            {
                CalcFields = Score, "Global Score", "Expected Score";
                DataItemLink = "Employee Appraisal No." = field("Appraisal No");
                DataItemTableView = where("Document Type" = const(Appraisal));

                column(BSCNo; "No.") { }
                column(BSCProgressReviewPeriod; "Progress Review Period") { }
                column(BSCScore; Score) { }
                column(BSCGlobalScore; "Global Score") { }
                column(BSCExpectedScore; "Expected Score") { }
                column(BSCCombinedScore; "Combined Score") { }
                column(BSCPerformanceRating; "Performance Rating") { }
                column(BSCAppraiseeComment; "Appraisee Comment") { }
                column(BSCAppraiserRecommendations; "Appraiser Recommendations") { }
                column(BSCHRReview; "HR's Review") { }

                dataitem(BSCLine; "Bal Score Card Lines")
                {
                    DataItemLink = DocNo = field("No.");

                    column(BSCLinePerspective; Percepective) { }
                    column(BSCLineReviewPeriod; "Progress Review Period") { }
                    column(BSCLineExpectedMaxScore; "Expected Max Score") { }
                    column(BSCLineSelfRating; "Self Rating") { }
                    column(BSCLineJointRating; "Joint Rating") { }
                    column(BSCLineScore; Score) { }
                    column(BSCLineAchievementsToDate; "Achievements ToDate") { }
                    column(BSCLineEmphasis; Emphasis) { }
                    column(BSCLineReviewed; Reviewed) { }
                }
            }

            dataitem(AppraisalLines; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");

                column(KeyResponsibility_Goals; "Key Responsibility") { }
                column(Description_Goals; Description) { }
                column(KPI_Goals; KPI) { }
                column(FY_Target; "FY Target") { }
                column(Weighting_Goals; Weighting) { }
                column(MidYearAppraisal_Goals; "Mid-Year Appraisal") { }
                column(FinalSelfAppraisal_Goals; "Final Self-Appraisal") { }
                column(ScorePoints_Goals; "Score/Points") { }
                column(Variance; Variance) { }

                // Other existing columns
                column(WorkplanCode; GetWorkplanName("Workplan Code")) { }
                column(PerformanceMeasure; "Performance Measure") { }
                column(Actualtargets; "Actual targets") { }
                column(Initiativecode; "Initiative code") { }
                column(Achieved; "Achieved (%)") { }
                column(Rating; Rating) { }
                column(WeightedRating; "Weighted Rating") { }
                column(ReviewPeriodCode_Goals; "Review Period Code") { }
                column(SelfRating_Goals; "Self Rating") { }
                column(AppraiserRating_Goals; "Appraiser Rating") { }
                column(QuarterScore_Goals; "Quarter Score") { }
                column(AppraiseeComments_Goals; "Appraisee's comments") { }
                column(AchievementNotes_Goals; "Achievement Notes") { }
                column(CorrectiveAction_Goals; "Corrective Action") { }
            }

            dataitem("Appraisee Comments"; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");
                DataItemTableView = where(Person = const(Appraisee));

                column(CommentsonPerformance_Comments; "Comments on Performance") { }
                column(CommentsOnSupervisor_Comments; "Comments On Supervisor") { }
                column(PerformanceRelatedDicussions_Comments; "Performance Related Dicussions") { }
                column(ExtentofDiscussionHelp_Comments; "Extent of Discussion Help") { }
                column(Date_Comments; Date) { }
                column(Person_Comments; Person) { }
            }

            dataitem("Appraiser Comments"; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");
                DataItemTableView = where(Person = const(Appraiser));

                column(Comments_on_Performance_Appraiser; "Comments on Performance") { }
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Workplans: Record "Appraisal Workplan Code";
        CompanyInfo: Record "Company Information";

    local procedure GetWorkplanName(WorkplanCode: Code[50]): Text
    begin
        if Workplans.Get(WorkplanCode) then
            exit(Workplans.Description)
        else
            exit(WorkplanCode);
    end;
}
