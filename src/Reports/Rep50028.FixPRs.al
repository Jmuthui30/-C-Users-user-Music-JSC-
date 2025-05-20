report 50028 "Fix PRs"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fix PRs.rdlc';

    dataset
    {
        dataitem("Requisition Header"; "Requisition Header")
        {
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Lines.Reset;
                Lines.SetRange("Requisition No", "Requisition Header"."No.");
                if Lines.Find('-')then begin
                    repeat /*Lines."Order No" := "Requisition Header"."PO Number";
                        Lines.Decision := Lines.Decision::Order;
                        IF PO.GET(PO."Document Type"::Order,"Requisition Header"."PO Number") THEN
                        Lines."Target No." := PO."Buy-from Vendor No.";
                        Lines.Processed := TRUE;

                        Lines."Global Dimension 1 Code" := FORMAT("Requisition Header"."Global Dimension 1 Code");
                        Lines."Global Dimension 2 Code" := FORMAT("Requisition Header"."Global Dimension 2 Code");*/
                        if "Requisition Header".Status = "Requisition Header".Status::Open then Lines.Status:=Lines.Status::Open
                        else if "Requisition Header".Status = "Requisition Header".Status::"Pending Approval" then Lines.Status:=Lines.Status::"Pending Approval"
                            else if "Requisition Header".Status = "Requisition Header".Status::Released then Lines.Status:=Lines.Status::Released;
                        if PO.Get(PO."Document Type"::Order, "Requisition Header"."PO Number")then begin
                            if PO.Status = PO.Status::Released then Lines.Status:=Lines.Status::Committed;
                            if PO.Receive then Lines.Status:=Lines.Status::Fulfilled;
                        end;
                        if(Lines."Order No" <> '') and (Lines.Processed = false)then Lines.Processed:=true;
                        Lines.Modify;
                    until Lines.Next = 0;
                end;
            /*"Requisition Header".VALIDATE("Global Dimension 1 Code");
                "Requisition Header".VALIDATE("Global Dimension 2 Code");*/
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
    var Lines: Record "Requisition Lines";
    PO: Record "Purchase Header";
}
