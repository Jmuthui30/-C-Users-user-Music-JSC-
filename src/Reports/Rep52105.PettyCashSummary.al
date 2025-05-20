report 52105 "Petty Cash Summary"
{
    // version THL- ADV.FIN 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Petty Cash Summary.rdlc';

    dataset
    {
        dataitem("Expense Claim Header"; "Expense Claim Header")
        {
            RequestFilterFields = "No.", "Employee No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Global Dimension 3 Code", Date, Status;

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
            column(ImprestNo; "Expense Claim Header"."No.")
            {
            }
            column(EmpNo; "Expense Claim Header"."Employee No.")
            {
            }
            column(EmpName; "Expense Claim Header"."Payment To")
            {
            }
            column(DimOne; "Expense Claim Header"."Global Dimension 1 Code")
            {
            }
            column(DimTwo; "Expense Claim Header"."Global Dimension 2 Code")
            {
            }
            column(DimThree; "Expense Claim Header"."Global Dimension 3 Code")
            {
            }
            column(Date; "Expense Claim Header".Date)
            {
            }
            column(RequestStatus; "Expense Claim Header".Status)
            {
            }
            column(TotalRequestAmount; "Expense Claim Header"."Total Amount")
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
        ReportFilters:="Expense Claim Header".GetFilters;
    end;
    var CompInfo: Record "Company Information";
    ReportFilters: Text;
}
