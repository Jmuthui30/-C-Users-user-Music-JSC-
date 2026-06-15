report 52324 "Employee Objectives - New"
{
    ApplicationArea = All;
    DefaultLayout = Word;
    RDLCLayout = './src/report_layout/EmployeeObjectivesNew.rdl';
    WordLayout = './src/report_layout/EmployeeObjectivesNew.docx';
    Caption = 'Employee Objectives - New';
    dataset
    {
        dataitem(Appraisal; "Employee Appraisal")
        {
            CalcFields = "Responsibilty Center", "Current Review Score", "Total Review Score", "Review Start Date", "Review End Date";
            RequestFilterFields = "Appraisal No", "Employee No", "Appraisal Period", "Current Review Period Code";

            column(AppraisalNo_Appraisal; Appraisal."Appraisal No")
            {
            }
            column(EmployeeNo_Appraisal; Appraisal."Employee No")
            {
            }
            column(AppraisalType_Appraisal; Appraisal."Appraisal Type")
            {
            }
            column(AppraisalPeriod_Appraisal; Appraisal."Appraisal Period")
            {
            }
            column(JobID_Appraisal; Appraisal."Job ID")
            {
            }
            column(AppraiserNo_Appraisal; Appraisal."Appraiser No")
            {
            }
            column(AppraisersName_Appraisal; Appraisal."Appraisers Name")
            {
            }
            column(AppraiseeID_Appraisal; Appraisal."Appraisee ID")
            {
            }
            column(AppraiserID_Appraisal; Appraisal."Appraiser ID")
            {
            }
            column(AppraiseeName_Appraisal; Appraisal."Appraisee Name")
            {
            }
            column(JobGroup_Appraisal; Appraisal."Job Group")
            {
            }
            column(AppraisersJobTitle_Appraisal; Appraisal."Appraiser's Job Title")
            {
            }
            column(AppraiseesJobTitle_Appraisal; Appraisal."Appraisee's Job Title")
            {
            }
            column(DepartmentCode_Appraisal; Appraisal."Department Code")
            {
            }
            column(DirectorateCode_Appraisal; AppraisalReportingMgt.GetDirectorateCodeForAppraisal(Appraisal))
            {
            }
            column(DirectorateName_Appraisal; AppraisalReportingMgt.GetDirectorateNameForAppraisal(Appraisal))
            {
            }
            column(PeriodStart_Appraisal; Appraisal."Period Start")
            {
            }
            column(PeriodEnd_Appraisal; Appraisal."Period End")
            {
            }
            column(UserDept; Appraisal."Responsibilty Center")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompPic; CompInfo.Picture)
            {
            }
            column(OtherNames; Employee."First Name" + ' ' + Employee."Middle Name")
            {
            }
            column(Surname; Employee."Last Name")
            {
            }
            column(EmployementDate; Employee."Date Of Join")
            {
            }
            column(JobGroup; Employee."Salary Scale")
            {
            }
            column(AcademicQualificationText; GetQualificationDescription(Appraisal."Employee No", 'Academic'))
            {
            }
            column(ProfessionalQualificationText; GetQualificationDescription(Appraisal."Employee No", 'Professional'))
            {
            }
            column(ObjectivePlanSummaryText; GetObjectivePlanSummary(Appraisal."Appraisal No", Appraisal."Current Review Period Code"))
            {
            }
            column(CurrentReviewPeriod; Appraisal."Current Review Period Code")
            {
            }
            column(ReviewStartDate_Appraisal; Appraisal."Review Start Date")
            {
            }
            column(ReviewEndDate_Appraisal; Appraisal."Review End Date")
            {
            }
            column(CurrentReviewScore; Appraisal."Current Review Score")
            {
            }
            column(TotalReviewScore; Appraisal."Total Review Score")
            {
            }
            dataitem(BSCObjectiveContext; "Bal Score Card Header")
            {
                DataItemLink = "Employee Appraisal No." = field("Appraisal No");
                DataItemTableView = where("Document Type" = const(Appraisal));

                column(ObjectiveBSCNo; "No.")
                {
                }
                column(ObjectiveBSCProgressReviewPeriod; "Progress Review Period")
                {
                }
                column(ObjectiveBSCPlanningNo; "Planning Doc No")
                {
                }
            }
            dataitem(Goals; "Appraisal Lines")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");

                column(EmployeeNo_Goals; Goals."Employee No")
                {
                }
                column(KeyResponsibility_Goals; Goals."Key Responsibility")
                {
                }
                column(Description_Goals; Goals.Description)
                {
                }
                column(WorkplanCode_Goals; Goals."Workplan Code")
                {
                }
                column(WorkplanDescription_Goals; Goals."Workplan Description")
                {
                }
                column(PerformanceMeasure_Goals; Goals."Performance Measure")
                {
                }
                column(InitiativeCode_Goals; Goals."Initiative code")
                {
                }
                column(InitiativeDescription_Goals; Goals.Description)
                {
                }
                column(No_Goals; Goals."No.")
                {
                }
                column(KeyIndicators_Goals; Goals."Key Indicators")
                {
                }
                column(KPI_Goals; Goals.KPI)
                {
                }
                column(Weighting_Goals; Goals.Weighting)
                {
                }
                column(FY_Target; "FY Target")
                {
                }
                column(Variance; Variance)
                {
                }
                column(ResultsAchievedComments_Goals; Goals."Results Achieved Comments")
                {
                }
                column(ScorePoints_Goals; Goals."Score/Points")
                {
                }
                column(MidYearAppraisal_Goals; Goals."Mid-Year Appraisal")
                {
                }
                column(FinalSelfAppraisal_Goals; Goals."Final Self-Appraisal")
                {
                }
                column(AppraisalLineType_Goals; Goals."Appraisal Line Type")
                {
                }
                column(AgreedTargetDate_Goals; Goals."Agreed Target Date")
                {
                }
                column(LineTypeGoals; Goals."Appraisal Line Type")
                {
                }
                column(ReviewPeriodCode_Goals; Goals."Review Period Code")
                {
                }
                column(SelfRating_Goals; Goals."Self Rating")
                {
                }
                column(AppraiserRating_Goals; Goals."Appraiser Rating")
                {
                }
                column(QuarterScore_Goals; Goals."Quarter Score")
                {
                }
                column(AppraiseeComments_Goals; Goals."Appraisee's comments")
                {
                }
                column(AchievementNotes_Goals; Goals."Achievement Notes")
                {
                }
                column(CorrectiveAction_Goals; Goals."Corrective Action")
                {
                }

                trigger OnPreDataItem()
                begin
                    Goals.SetFilter(Goals."Appraisal Line Type", '<>%1&<>%2', Goals."Appraisal Line Type"::"Objective Heading End", Goals."Appraisal Line Type"::"Sub-Heading End");
                    if Appraisal."Current Review Period Code" <> '' then
                        Goals.SetRange("Review Period Code", Appraisal."Current Review Period Code");
                end;
            }
            dataitem("GoalsJD"; "Appraisal Lines-JD")
            {
                DataItemLink = "Appraisal No" = field("Appraisal No");

                column(EmployeeNo_GoalsJD; GoalsJD."Employee No")
                {
                }
                column(KeyResponsibility_GoalsJD; GoalsJD."Key Responsibility")
                {
                }
                column(No_GoalsJD; GoalsJD."No.")
                {
                }
                column(Weighting_GoalsJD; GoalsJD.Weighting)
                {
                }
                column(ScorePoints_GoalsJD; GoalsJD."Score/Points")
                {
                }
                column(FinalSelfAppraisal_GoalsJD; GoalsJD."Final Self-Appraisal")
                {
                }
                column(AppraisalLineType_GoalsJD; GoalsJD."Appraisal Line Type")
                {
                }
                column(AgreedTargetDate_GoalsJD; GoalsJD."Agreed Target Date")
                {
                }
                column(LineTypeGoalsJD; GoalsJD."Appraisal Line Type")
                {
                }

                trigger OnPreDataItem()
                begin
                    GoalsJD.SetFilter(GoalsJD."Appraisal Line Type", '<>%1&<>%2', GoalsJD."Appraisal Line Type"::"Objective Heading End", GoalsJD."Appraisal Line Type"::"Sub-Heading End");
                end;
            }
            dataitem(Comments; "Appraisal Comments")
            {
                DataItemLink = "Appraisal No." = field("Appraisal No");

                column(AppraisalNo_Comments; Comments."Appraisal No.")
                {
                }
                column(Person_Comments; Comments.Person)
                {
                }
                column(ReviewPeriodCode_Comments; Comments."Review Period Code")
                {
                }
                column(PerformanceRelatedDicussions_Comments; Comments."Performance Related Dicussions")
                {
                }
                column(ExtentofDiscussionHelp_Comments; Comments."Extent of Discussion Help")
                {
                }
                column(CommentsonPerformance_Comments; Comments."Comments on Performance")
                {
                }
                column(CommentsOnSupervisor_Comments; Comments."Comments On Supervisor")
                {
                }
                column(CommentsbySecondSuprvisor_Comments; Comments."Comments by Second Suprvisor")
                {
                }
                column(Date_Comments; Comments.Date)
                {
                }

                trigger OnPreDataItem()
                begin
                    if Appraisal."Current Review Period Code" <> '' then
                        SetFilter("Review Period Code", '%1|%2', '', Appraisal."Current Review Period Code");
                end;
            }
            dataitem("Training Request"; "Training Request")
            {
                DataItemLink = "Employee No" = field("Employee No");
                DataItemTableView = where(Status = filter(Released));

                column(EmployeeNo_TrainingRequest; "Training Request"."Employee No")
                {
                }
                column(Description_TrainingRequest; "Training Request".Description)
                {
                }

                trigger OnPreDataItem()
                begin
                    "Training Request".SetFilter("Planned Start Date", '>=%1', Appraisal."Period Start");
                    "Training Request".SetFilter("Planned End Date", '<=%1', Appraisal."Period End");
                end;
            }
            dataitem("Employee Qualification"; "Employee Qualification")
            {
                DataItemLink = "Employee No." = field("Employee No");

                column(EmployeeNo_EmployeeQualification; "Employee Qualification"."Employee No.")
                {
                }
                column(QualificationCode_EmployeeQualification; "Employee Qualification"."Qualification Code")
                {
                }
                column(FromDate_EmployeeQualification; "Employee Qualification"."From Date")
                {
                }
                column(ToDate_EmployeeQualification; "Employee Qualification"."To Date")
                {
                }
                column(Description_EmployeeQualification; "Employee Qualification".Description)
                {
                }
                column(QualificationType_EmployeeQualification; GetQualificationType("Employee Qualification"."Qualification Code"))
                {
                }
            }

            trigger OnAfterGetRecord()
            begin
                if Employee.Get(Appraisal."Employee No") then;
            end;
        }
    }

    requestpage
    {
        layout
        {
        }

        actions
        {
        }
    }
    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        AppraisalReportingMgt: Codeunit "Appraisal Reporting Mgt.";
        CompInfo: Record "Company Information";
        Employee: Record Employee;

        Qualification: Record Qualification;

    local procedure GetQualificationType(QualificationCode: Code[20]): Text
    begin
        if Qualification.Get(QualificationCode) then
            exit(Format(Qualification."Qualification Type"));

        exit('');
    end;

    local procedure GetQualificationDescription(EmployeeNo: Code[20]; QualificationTypeFilter: Text): Text
    var
        EmployeeQualification: Record "Employee Qualification";
        QualificationDate: Date;
        SelectedDate: Date;
        SelectedDescription: Text;
    begin
        EmployeeQualification.Reset();
        EmployeeQualification.SetRange("Employee No.", EmployeeNo);
        if EmployeeQualification.FindSet() then
            repeat
                if GetQualificationType(EmployeeQualification."Qualification Code") = QualificationTypeFilter then begin
                    QualificationDate := EmployeeQualification."To Date";
                    if QualificationDate = 0D then
                        QualificationDate := EmployeeQualification."From Date";

                    if (SelectedDescription = '') or (QualificationDate >= SelectedDate) then begin
                        SelectedDate := QualificationDate;
                        SelectedDescription := EmployeeQualification.Description;
                    end;
                end;
            until EmployeeQualification.Next() = 0;

        exit(SelectedDescription);
    end;

    local procedure GetObjectivePlanSummary(AppraisalNo: Code[20]; ReviewPeriodCode: Code[20]): Text
    var
        AppraisalLine: Record "Appraisal Lines";
        Builder: TextBuilder;
        LineIndex: Integer;
    begin
        AppraisalLine.Reset();
        AppraisalLine.SetRange("Appraisal No", AppraisalNo);
        AppraisalLine.SetFilter("Workplan Code", '<>%1', '');
        if ReviewPeriodCode <> '' then
            AppraisalLine.SetRange("Review Period Code", ReviewPeriodCode);

        if AppraisalLine.FindSet() then
            repeat
                LineIndex += 1;
                Builder.AppendLine(StrSubstNo('%1. %2', LineIndex, AppraisalLine."Workplan Description"));
                Builder.AppendLine(StrSubstNo('   Review Period: %1 | Measure: %2 | Target: %3 | Weighting: %4%',
                    AppraisalLine."Review Period Code",
                    AppraisalLine."Performance Measure",
                    AppraisalLine."FY Target",
                    AppraisalLine.Weighting));
                if AppraisalLine."Appraisee's comments" <> '' then
                    Builder.AppendLine(StrSubstNo('   Appraisee Planning Comments: %1', AppraisalLine."Appraisee's comments"));
                Builder.AppendLine('');
            until AppraisalLine.Next() = 0;

        if LineIndex = 0 then
            exit('No objective lines have been captured for this appraisal.');

        exit(Builder.ToText());
    end;
}





