report 52933 "Competencies and Skills"
{
    ApplicationArea = All;
    Caption = 'Competencies and Skills';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/CompetenciesAndSkills.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(HRQualifications; "HR_Qualifications")
        {
            RequestFilterFields = Code, Type, "Qualification Type";

            column(QualificationCode; Code) { }
            column(QualificationDescription; Description) { }
            column(Type; Type) { }
            column(QualificationType; "Qualification Type") { }
            column(QualifiedEmployees; "Qualified Employees") { }
        }

        dataitem(JobSkills; "Job Skills")
        {
            RequestFilterFields = Code, Level;

            column(SkillCode; Code) { }
            column(SkillDescription; Description) { }
            column(SkillLevel; Level) { }
        }
    }
}
