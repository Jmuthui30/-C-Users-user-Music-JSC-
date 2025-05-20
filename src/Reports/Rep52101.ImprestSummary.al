report 52101 "Imprest Summary"
{
    // version THL- ADV.FIN 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Imprest Summary.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Imprest Header"; "Imprest Header")
        {
            RequestFilterFields = "No.", "Employee No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Global Dimension 3 Code", Date, Status, "Surrender Date", "Due Date";

            column(Logo; CompInfo.Picture)
            {
            }
            column(USER; UserId)
            {
            }
            column(DT; CurrentDateTime)
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(ImprestNo; "Imprest Header"."No.")
            {
            }
            column(EmpNo; "Imprest Header"."Employee No.")
            {
            }
            column(EmpName; "Imprest Header"."Employee Name")
            {
            }
            column(JobTitle; "Imprest Header"."Job Title")
            {
            }
            column(DimOne; "Imprest Header"."Global Dimension 1 Code")
            {
            }
            column(DimTwo; "Imprest Header"."Global Dimension 2 Code")
            {
            }
            column(DimThree; "Imprest Header"."Global Dimension 3 Code")
            {
            }
            column(Date; "Imprest Header".Date)
            {
            }
            column(RequestType; "Imprest Header".Type)
            {
            }
            column(TotalDaysInTheField; "Imprest Header"."Total Days in the Field")
            {
            }
            column(TotalRequestAmount; "Imprest Header"."Total Request Amount")
            {
            }
            column(Status; "Imprest Header".Status)
            {
            }
            column(SurrenderDate; "Imprest Header"."Surrender Date")
            {
            }
            column(DueDate; "Imprest Header".Date)
            {
            }
            column(TotalSurrenderAmount; "Imprest Header"."Total Surrender Amount")
            {
            }
            column(TotalClaim; "Imprest Header"."Total Claim")
            {
            }
            column(TotalRefund; "Imprest Header"."Total Refund")
            {
            }
            column(NetRefundClaim; "Imprest Header"."Net Refund (Net Claim)")
            {
            }
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
        ReportFilters:="Imprest Header".GetFilters;
    end;
    var CompInfo: Record "Company Information";
    ReportFilters: Text;
}
