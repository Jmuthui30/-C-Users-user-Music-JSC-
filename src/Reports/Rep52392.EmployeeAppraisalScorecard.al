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
            CalcFields = "Current Review Score", "Total Review Score", "Total Weighting", "Review Start Date", "Review End Date";
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
            column(DirectorateCode_Appraisal; AppraisalReportingMgt.GetDirectorateCodeForAppraisal(EmployeeAppraisal)) { }
            column(DirectorateName_Appraisal; AppraisalReportingMgt.GetDirectorateNameForAppraisal(EmployeeAppraisal)) { }
            column(JobGroup_Appraisal; "Job Group") { }
            column(PeriodStart_Appraisal; "Period Start") { }
            column(PeriodEnd_Appraisal; "Period End") { }
            column(CurrentReviewPeriod; "Current Review Period Code") { }
            column(ReviewStartDate_Appraisal; "Review Start Date") { }
            column(ReviewEndDate_Appraisal; "Review End Date") { }
            column(CurrentReviewScore; "Current Review Score") { }
            column(TotalReviewScore; "Total Review Score") { }
            column(TotalWeighting; "Total Weighting") { }
            column(CurrentReviewWeighting; GetCurrentReviewWeighting("Appraisal No", "Current Review Period Code")) { }
            column(AppraiseeReviewComments; GetReviewComments("Appraisal No", "Current Review Period Code", false)) { }
            column(AppraiserReviewComments; GetReviewComments("Appraisal No", "Current Review Period Code", true)) { }
            column(StatusText; Format(Status)) { }
            column(AppraisalStatusText; Format("Appraisal Status")) { }

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
                column(WorkplanCodeValue; "Workplan Code") { }
                column(WorkplanDescription; "Workplan Description") { }
                column(PerformanceMeasure; "Performance Measure") { }
                column(Actualtargets; "Actual targets") { }
                column(Initiativecode; "Initiative code") { }
                column(InitiativeDescription; Description) { }
                column(ActualValue; Actual) { }
                column(Achieved; "Achieved (%)") { }
                column(Rating; Rating) { }
                column(WeightedRating; "Weighted Rating") { }
                column(ReviewPeriodCode_Goals; "Review Period Code") { }
                column(SelfRating_Goals; "Self Rating") { }
                column(AppraiserRating_Goals; "Appraiser Rating") { }
                column(AppraiserComments_Goals; "Results Achieved Comments") { }
                column(QuarterScore_Goals; "Quarter Score") { }
                column(AppraiseeComments_Goals; "Appraisee's comments") { }
                column(AchievementNotes_Goals; "Achievement Notes") { }
                column(CorrectiveAction_Goals; "Corrective Action") { }

                trigger OnPreDataItem()
                begin
                    SetRange("Appraisal Line Type", "Appraisal Line Type"::Objective);
                    if EmployeeAppraisal."Current Review Period Code" <> '' then
                        SetRange("Review Period Code", EmployeeAppraisal."Current Review Period Code");
                end;
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
                column(ReviewPeriodCode_Comments; "Review Period Code") { }

                trigger OnPreDataItem()
                begin
                    if EmployeeAppraisal."Current Review Period Code" <> '' then
                        SetFilter("Review Period Code", '%1|%2', '', EmployeeAppraisal."Current Review Period Code");
                end;
            }

            dataitem("Appraiser Comments"; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");
                DataItemTableView = where(Person = const(Appraiser));

                column(Comments_on_Performance_Appraiser; "Comments on Performance") { }
                column(ReviewPeriodCode_AppraiserComments; "Review Period Code") { }

                trigger OnPreDataItem()
                begin
                    if EmployeeAppraisal."Current Review Period Code" <> '' then
                        SetFilter("Review Period Code", '%1|%2', '', EmployeeAppraisal."Current Review Period Code");
                end;
            }
        }
    }

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(Picture);
    end;

    var
        AppraisalReportingMgt: Codeunit "Appraisal Reporting Mgt.";
        Workplans: Record "Appraisal Workplan Code";
        CompanyInfo: Record "Company Information";

    local procedure GetWorkplanName(WorkplanCode: Code[50]): Text
    begin
        if Workplans.Get(WorkplanCode) then
            exit(Workplans.Description)
        else
            exit(WorkplanCode);
    end;

    local procedure GetCurrentReviewWeighting(AppraisalNo: Code[20]; ReviewPeriodCode: Code[20]): Decimal
    var
        AppraisalLine: Record "Appraisal Lines";
    begin
        AppraisalLine.SetRange("Appraisal No", AppraisalNo);
        AppraisalLine.SetRange("Appraisal Line Type", AppraisalLine."Appraisal Line Type"::Objective);
        if ReviewPeriodCode <> '' then
            AppraisalLine.SetRange("Review Period Code", ReviewPeriodCode);
        AppraisalLine.CalcSums(Weighting);
        exit(AppraisalLine.Weighting);
    end;

    local procedure GetReviewComments(AppraisalNo: Code[20]; ReviewPeriodCode: Code[20]; AppraiserSide: Boolean): Text
    var
        AppraisalComment: Record "Appraisal Comments";
        CommentBuilder: TextBuilder;
        HasComment: Boolean;
    begin
        AppraisalComment.SetRange("Appraisal No.", AppraisalNo);
        if AppraiserSide then
            AppraisalComment.SetRange(Person, AppraisalComment.Person::Appraiser)
        else
            AppraisalComment.SetRange(Person, AppraisalComment.Person::Appraisee);
        AppraisalComment.SetRange("Review Period Code", ReviewPeriodCode);

        if AppraisalComment.FindSet() then
            repeat
                AppendComment(CommentBuilder, AppraisalComment."Comments on Performance", HasComment);
                if AppraiserSide then begin
                    AppendComment(CommentBuilder, AppraisalComment."Comments by Second Suprvisor", HasComment);
                    AppendComment(CommentBuilder, AppraisalComment."Developmental Action", HasComment);
                end else
                    AppendComment(CommentBuilder, AppraisalComment."Comments On Supervisor", HasComment);
            until AppraisalComment.Next() = 0;

        if not HasComment then
            exit('No comments captured for this review period.');

        exit(CommentBuilder.ToText());
    end;

    local procedure AppendComment(var CommentBuilder: TextBuilder; CommentText: Text; var HasComment: Boolean)
    begin
        if CommentText = '' then
            exit;

        HasComment := true;
        CommentBuilder.AppendLine(CommentText);
    end;
}
