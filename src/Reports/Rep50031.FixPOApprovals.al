report 50031 "Fix PO Approvals"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix PO Approvals.rdlc';

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            trigger OnAfterGetRecord()
            begin
                "Purchase Header".CalcFields("Pending Approvals");
                if("Purchase Header"."Pending Approvals" = 0) and ("Purchase Header".Status = "Purchase Header".Status::Released)then begin
                    Commitment.POCommitment("Purchase Header");
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
    trigger OnPostReport()
    begin
        Message('Complete');
    end;
    var Commitment: Codeunit "Commitment Management";
}
