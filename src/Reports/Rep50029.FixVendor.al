report 50029 "Fix Vendor"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix Vendor.rdlc';

    dataset
    {
        dataitem(Vendor; Vendor)
        {
            trigger OnAfterGetRecord()
            begin
                Vendor."Payment Method Code":='';
                if Vendor."Currency Code" = 'KES' then Vendor."Currency Code":='';
                Vendor.Modify;
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
    labels
    {
    }
}
