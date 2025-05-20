report 51827 "Vendor Evaluation"
{
    //Ibrahim Wasiu
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Vendor Evaluation.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = all;

    dataset
    {
        dataitem(Payments; "Vendor Evaluation")
        {
            RequestFilterFields = "Date Filter";

            column(ReportPeriod; Payments.GetFilters)
            {
            }
            column(Logo; CompInfo.Picture)
            {
            }
            column(Watermark; AdvancedFinanceSetup."Watermark Portrait")
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompAddress2; CompInfo."Address 2")
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(CompCountry; CompInfo."Country/Region Code")
            {
            }
            column(VendNo; Payments."Vendor No.")
            {
            }
            column(VendName; Payments."Vendor Name")
            {
            }
            column(VendDate; Payments.Date)
            {
            }
            column(VendCompetency; Payments.Competency)
            {
            }
            column(VendCapacity; Payments.Capacity)
            {
            }
            column(VendCommitment; Payments.Commitment)
            {
            }
            column(VendControl; Payments.Control)
            {
            }
            column(VendCashResources; Payments."Cash Resources")
            {
            }
            column(VendCost; Payments.Cost)
            {
            }
            column(VendConsistency; Payments.Consistency)
            {
            }
            column(ReportToDate; ReportToDate)
            {
            }
            trigger OnPreDataItem()
            begin
                Payments.SetFilter(Date, DateFilter);
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
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture);
        /*AdvancedFinanceSetup.Get;
        AdvancedFinanceSetup.CALCFIELDS("Watermark Portrait");*/
        if Payments.GetFilter("Date Filter") = '' then begin
            Payments.SetRange("Date Filter", 0D, Today)end
        else
            DateFilter:=Payments.GetFilter("Date Filter");
        ReportToDate:=Payments.GetRangeMax("Date Filter");
    end;
    var CompInfo: Record "Company Information";
    CompName: Text[100];
    UserSetup: Record "User Setup";
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    DateFilter: Text;
    ReportToDate: date;
}
