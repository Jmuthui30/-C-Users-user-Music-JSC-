report 52106 "M&A Sales Invoice"
{
    // version THL- ADV.FIN 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/M&A Sales Invoice.rdlc';

    dataset
    {
        dataitem(Header; "Sales Invoice Header")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(CustName; Header."Bill-to Name")
            {
            }
            column(CustAddress; Header."Bill-to Address")
            {
            }
            column(CustCity; Header."Bill-to City")
            {
            }
            column(InvoiceNo; Header."No.")
            {
            }
            dataitem(Lines; "Sales Invoice Line")
            {
                column(Description; Lines.Description)
                {
                }
                column(Amount; Lines.Amount)
                {
                }
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
    end;
    var CompInfo: Record "Company Information";
    TotalVAT: Decimal;
    GrossTotal: Decimal;
}
