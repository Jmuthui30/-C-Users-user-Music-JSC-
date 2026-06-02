report 52023 "Employee Appraisal - New"
{
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/EmployeeAppraisalNew.rdl';
    Caption = 'Employee Appraisal - New';
    dataset
    {
        dataitem(Appraisal; "Employee Appraisal")
        {
            CalcFields = "Responsibilty Center", "Current Review Score", "Total Review Score";

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
            column(PeriodStart_Appraisal; Appraisal."Period Start")
            {
            }
            column(PeriodEnd_Appraisal; Appraisal."Period End")
            {
            }
            column(UserDept; Appraisal."Responsibilty Center")
            {
            }
            column(Type_Appraisal; Appraisal.Type)
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
            column(MidYear; MidYear)
            {
            }
            column(FinalYear; FinalYear)
            {
            }
            column(CurrentReviewPeriod; Appraisal."Current Review Period Code")
            {
            }
            column(CurrentReviewScore; Appraisal."Current Review Score")
            {
            }
            column(TotalReviewScore; Appraisal."Total Review Score")
            {
            }
            dataitem(BSCAppraisal; "Bal Score Card Header")
            {
                CalcFields = Score, "Global Score", "Expected Score";
                DataItemLink = "Employee Appraisal No." = field("Appraisal No");
                DataItemTableView = where("Document Type" = const(Appraisal));

                column(BSCNo; "No.")
                {
                }
                column(BSCProgressReviewPeriod; "Progress Review Period")
                {
                }
                column(BSCScore; Score)
                {
                }
                column(BSCGlobalScore; "Global Score")
                {
                }
                column(BSCExpectedScore; "Expected Score")
                {
                }
                column(BSCCombinedScore; "Combined Score")
                {
                }
                column(BSCPerformanceRating; "Performance Rating")
                {
                }
                column(BSCAppraiseeComment; "Appraisee Comment")
                {
                }
                column(BSCAppraiserRecommendations; "Appraiser Recommendations")
                {
                }
                column(BSCHRReview; "HR's Review")
                {
                }
                dataitem(BSCLine; "Bal Score Card Lines")
                {
                    DataItemLink = DocNo = field("No.");

                    column(BSCLinePerspective; Percepective)
                    {
                    }
                    column(BSCLineReviewPeriod; "Progress Review Period")
                    {
                    }
                    column(BSCLineExpectedMaxScore; "Expected Max Score")
                    {
                    }
                    column(BSCLineSelfRating; "Self Rating")
                    {
                    }
                    column(BSCLineJointRating; "Joint Rating")
                    {
                    }
                    column(BSCLineScore; Score)
                    {
                    }
                    column(BSCLineAchievementsToDate; "Achievements ToDate")
                    {
                    }
                    column(BSCLineEmphasis; Emphasis)
                    {
                    }
                    column(BSCLineReviewed; Reviewed)
                    {
                    }
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
                column(No_Goals; Goals."No.")
                {
                }
                column(Description_Goals; Goals.Description)
                {
                }
                column(KPI_Goals; Goals.KPI)
                {
                }
                column(KeyIndicators_Goals; Goals."Key Indicators")
                {
                }
                column(FY_Target; "FY Target")
                {
                }
                column(Variance; Variance)
                {
                }
                column(Weighting_Goals; Goals.Weighting)
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
                end;
            }
            dataitem(GoalsJD; "Appraisal Lines-JD")
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
                column(ResultsAchievedComments_GoalsJD; GoalsJD."Results Achieved Comments")
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

                //if Appraisal.Type = Appraisal.Type::"Mid-Year" then
                //MidYear := true
                //else
                //MidYear := false;

                //if Appraisal.Type = Appraisal.Type::"Final Year" then
                //FinalYear := true
                //else
                //FinalYear := false;
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

    trigger OnInitReport()
    begin
        MidYear := false;
        FinalYear := false;
    end;

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
        Employee: Record Employee;
        Qualification: Record Qualification;
        FinalYear: Boolean;
        MidYear: Boolean;

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
}





