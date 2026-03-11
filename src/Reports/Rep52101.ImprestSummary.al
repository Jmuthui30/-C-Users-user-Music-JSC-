report 52101 "Imprest Summary"
{
    // version THL- ADV.FIN 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Imprest Summary.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Imprest Header"; Payments)
        {
            RequestFilterFields = "No.", "Staff No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Shortcut Dimension 3 Code", Date, Status, "Surrender Date", "Due Date";

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
            column(EmpNo; "Imprest Header"."Staff No.")
            {
            }
            column(EmpName; "Imprest Header".Payee)
            {
            }
            column(JobTitle; "Imprest Header"."Shortcut Dimension 2 Code")
            {
            }
            column(DimOne; "Imprest Header"."Shortcut Dimension 1 Code")
            {
            }
            column(DimTwo; "Imprest Header"."Shortcut Dimension 2 Code")
            {
            }
            column(DimThree; "Imprest Header"."Shortcut Dimension 3 Code")
            {
            }
            column(Date; "Imprest Header".Date)
            {
            }
            column(RequestType; "Imprest Header"."Payment Type")
            {
            }
            column(TotalDaysInTheField; "Imprest Header"."No of Days")
            {
            }
            column(TotalRequestAmount; "Imprest Header"."Imprest Amount")
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
            column(TotalSurrenderAmount; "Imprest Header"."Receipt Amount")
            {
            }
            column(TotalClaim; "Imprest Header"."Actual Amount Spent")
            {
            }
            column(TotalRefund; "Imprest Header"."Total Amount")
            {
            }
            column(NetRefundClaim; "Imprest Header"."Remaining Amount")
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
