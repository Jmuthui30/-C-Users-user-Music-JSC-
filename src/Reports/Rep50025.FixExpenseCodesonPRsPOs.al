report 50025 "Fix Expense Codes on PRs & POs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix Expense Codes on PRs & POs.rdlc';

    dataset
    {
        dataitem("Requisition Header"; "Requisition Header")
        {
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
}
