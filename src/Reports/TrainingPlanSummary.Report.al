report 52926 "Training Plan Summary"
{
    ApplicationArea = All;
    Caption = 'Training Plan Summary';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/TrainingPlanSummary.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(TrainingNeed; "Training Need")
        {
            RequestFilterFields = "Start Date", "End Date", Status, Location, Provider, "Need Source";

            column(Code; Code) { }
            column(Description; Description) { }
            column(NeedSource; "Need Source") { }
            column(SourceAssessmentNo; "Source Assessment No.") { }
            column(StartDate; "Start Date") { }
            column(EndDate; "End Date") { }
            column(Location; Location) { }
            column(Provider; Provider) { }
            column(ProviderName; "Provider Name") { }
            column(Status; Status) { }
            column(CostOfTraining; "Cost Of Training") { }
            column(CostOfTrainingLCY; "Cost Of Training (LCY)") { }
            column(NoOfParticipants; "No. of Participants") { }

            dataitem(TrainingNeedsLine; "Training Needs Lines")
            {
                DataItemLink = "Document No." = field(Code);

                column(ExpenseCode; "Expense Code") { }
                column(ExpenseName; "Expense name") { }
                column(ApprovedBudget; "Approved Budget") { }
                column(ApprovalAmount; "Approval Amount") { }
                column(ApprovalAmountLCY; "Approval Amount (LCY)") { }
                column(GLAccount; "G/L Account") { }
                column(TrainingYear; "Training Year") { }
            }
        }
    }
}
