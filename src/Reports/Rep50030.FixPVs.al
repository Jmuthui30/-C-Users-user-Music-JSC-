report 50030 "Fix PVs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix PVs.rdlc';

    dataset
    {
        dataitem("PV Header"; "PV Header")
        {
            DataItemTableView = WHERE(Posted=CONST(true));

            trigger OnAfterGetRecord()
            begin
                Lines.Reset;
                Lines.SetRange(No, "PV Header"."No.");
                if Lines.FindSet then begin
                    repeat Lines.Posted:=true;
                        Lines."Posted Date":="PV Header"."Posted Date";
                        Lines.Modify;
                    until Lines.Next = 0;
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
    var Lines: Record "PV Lines";
}
