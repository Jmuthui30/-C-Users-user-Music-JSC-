report 52930 "Training History"
{
    ApplicationArea = All;
    Caption = 'Training History';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrainingHistory.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TrainingRequest; "Training Request")
        {
            DataItemTableView = where(Status = const(Released));
            RequestFilterFields = "Employee No", "Training Need", "Planned Start Date", "Planned End Date", Destination;

            column(RequestNo; "Request No.") { }
            column(EmployeeNo; "Employee No") { }
            column(EmployeeName; "Employee Name") { }
            column(TrainingNeed; "Training Need") { }
            column(Description; Description) { }
            column(PlannedStartDate; "Planned Start Date") { }
            column(PlannedEndDate; "Planned End Date") { }
            column(NoOfDays; "No. Of Days") { }
            column(Destination; Destination) { }
            column(Status; Status) { }
            column(CostOfTrainingLCY; "Cost of Training (LCY)") { }
        }
    }
}
