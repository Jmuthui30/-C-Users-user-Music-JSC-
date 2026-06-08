report 52932 "Training Requirements"
{
    ApplicationArea = All;
    Caption = 'Training Requirements';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrainingRequirements.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TrainingNeedsHeader; "Training Needs Header")
        {
            RequestFilterFields = "No.", "Employee No", Date, Status, "Need Source", "Source Document No";

            column(No; "No.") { }
            column(Date; Date) { }
            column(EmployeeNo; "Employee No") { }
            column(EmployeeName; "Employee Name") { }
            column(JobTitle; "Job Title") { }
            column(Status; Status) { }
            column(NeedSource; "Need Source") { }
            column(SourceDocumentNo; "Source Document No") { }
            column(CurrentEmployeeSkills; "Current Employee Skills") { }
            column(MissingCompetencies; "Missing Competencies") { }
            column(RequiredSkills; "Required Skills") { }
            column(CommentsByDepartmentalHead; Comments1) { }
            column(CommentsByHRManager; Comments2) { }

            dataitem(EmployeeTrainingNeeds; "Employee Training Needs")
            {
                DataItemLink = "Document No." = field("No."), "Employee No." = field("Employee No");

                column(NeedCode; Code) { }
                column(NeedDescription; Description) { }
                column(LineStatus; Status) { }
                column(LineNo; "Line No.") { }
            }
        }
    }
}
