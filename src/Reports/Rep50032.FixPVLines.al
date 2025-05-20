report 50032 "Fix PV Lines"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix PV Lines.rdlc';

    dataset
    {
        dataitem("PV Lines"; "PV Lines")
        {
            trigger OnAfterGetRecord()
            begin
                if "PV Lines"."Currency Code" = '' then begin
                    "PV Lines"."Amount LCY":="PV Lines".Amount;
                    "PV Lines".Modify;
                end;
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
