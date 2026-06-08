report 52928 "Training Attendees"
{
    ApplicationArea = All;
    Caption = 'Training Attendees';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrainingAttendees.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TrainingRequest; "Training Request")
        {
            DataItemTableView = where(Status = const(Released));
            RequestFilterFields = "Training Need", "Global Dimension 1 Code", "Global Dimension 2 Code", "Planned Start Date", "Planned End Date";

            column(RequestNo; "Request No.") { }
            column(RequestDate; "Request Date") { }
            column(EmployeeNo; "Employee No") { }
            column(EmployeeName; "Employee Name") { }
            column(Designation; Designation) { }
            column(TrainingNeed; "Training Need") { }
            column(Description; Description) { }
            column(PlannedStartDate; "Planned Start Date") { }
            column(PlannedEndDate; "Planned End Date") { }
            column(NoOfDays; "No. Of Days") { }
            column(Destination; Destination) { }
            column(CostOfTraining; "Cost of Training") { }
            column(CostOfTrainingLCY; "Cost of Training (LCY)") { }
            column(DepartmentCode; "Global Dimension 1 Code") { }
            column(CommissionerCode; "Global Dimension 2 Code") { }
        }
    }
}
