report 52931 "Courses Offered"
{
    ApplicationArea = All;
    Caption = 'Courses Offered';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/CoursesOffered.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TrainingNeed; "Training Need")
        {
            RequestFilterFields = Code, Description, Status, "Start Date", "End Date", Provider, Location;

            column(Code; Code) { }
            column(Description; Description) { }
            column(TrainingObjectives; "Training Objectives") { }
            column(StartDate; "Start Date") { }
            column(EndDate; "End Date") { }
            column(Location; Location) { }
            column(Provider; Provider) { }
            column(ProviderName; "Provider Name") { }
            column(Status; Status) { }
            column(NeedSource; "Need Source") { }
            column(SourceAssessmentNo; "Source Assessment No.") { }
        }
    }
}
