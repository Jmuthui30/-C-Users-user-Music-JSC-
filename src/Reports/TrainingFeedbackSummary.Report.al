report 52927 "Training Feedback Summary"
{
    ApplicationArea = All;
    Caption = 'Training Feedback Summary';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrainingFeedbackSummary.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TrainingEvaluation; "Training Evaluation")
        {
            RequestFilterFields = "Training Need", "Training Request No.", "Employee No", Date, Status;

            column(No; "No.") { }
            column(Date; Date) { }
            column(EmployeeNo; "Employee No") { }
            column(EmployeeName; "Employee Name") { }
            column(JobTitle; "Job Title") { }
            column(TrainingRequestNo; "Training Request No.") { }
            column(TrainingNeed; "Training Need") { }
            column(CourseTitle; "Course Title") { }
            column(Venue; Venue) { }
            column(StartDate; "Start Date") { }
            column(EndDate; "End Date") { }
            column(RelevanceOfCourse; "Relevance of Course") { }
            column(LearnedSkill1; "Learned Skill 1") { }
            column(LearnedSkill2; "Learned Skill 2") { }
            column(LearnedSkill3; "Learned Skill 3") { }
            column(MaterialCovered; "Material Covered") { }
            column(RateTheTraining; "Rate the Training") { }
            column(Comments; Comments) { }
            column(BackToOfficeReport; "Back To Office Report") { }
            column(Competency; Competency) { }
            column(CommunicationSkills; "Communication Skills") { }
            column(SupervisorComments; "Supervisor Comments") { }
            column(SupervisorEvaluated; "Supervisor Evaluated") { }
        }
    }
}
