codeunit 51830 "Work Order Management"
{
    //Ibrahim Wasiu
    trigger OnRun()
    begin
    end;
    var myInt: Integer;
    Procedure GenerateOrderFormRepairRequest(var RepairH: Record "Repair Header")
    var
        WorkOrderHeader: Record "Work Order Header";
        WorkOrderLine: Record "Work Order Lines";
        RepairLines: Record "Repair Lines";
    begin
        if RepairH.Status <> RepairH.Status::Released then Error('This Repair Request has not been fully approved.');
        if RepairH."WO Generated Directly" then Error('A Work Order No. %1 has already been generated for this Repair Request.', RepairH."WO Number");
        //Creat Header
        WorkOrderHeader.Init();
        WorkOrderHeader."Document Type":=WorkOrderHeader."Document Type"::Order;
        WorkOrderHeader.Status:=WorkOrderHeader.Status::Open;
        WorkOrderHeader."No.":='';
        WorkOrderHeader."Repair Request No.":=RepairH."No.";
        WorkOrderHeader."Work Date":=Today;
        WorkOrderHeader."Work Order Type":=RepairH."Repair Type";
        WorkOrderHeader."Service Level":=RepairH."Repair Service Level";
        WorkOrderHeader."Fault Area":=RepairH."Fault Area";
        WorkOrderHeader."Fault Date":=RepairH."Fault Date";
        WorkOrderHeader."Fault Code":=RepairH."Fault Type";
        WorkOrderHeader."Fault Symptom":=RepairH."Fault Symptom";
        WorkOrderHeader."Global Dimension 1 Code":=RepairH."Global Dimension 1 Code";
        WorkOrderHeader."Global Dimension 2 Code":=RepairH."Global Dimension 2 Code";
        WorkOrderHeader."Global Dimension 3 Code":=RepairH."Global Dimension 3 Code";
        WorkOrderHeader."Asset Location":=RepairH."Asset Location";
        WorkOrderHeader."Location Code":=RepairH."Location Code";
        WorkOrderHeader."Currency Code":=RepairH."Currency Code";
        WorkOrderHeader."Posting Date":=WorkDate();
        WorkOrderHeader.Insert(true);
        //Fetch Supplier Details
        RepairH.Reset();
        RepairH.SetRange("No.", RepairH."No.");
        Commit();
        if page.RunModal(page::"Supplier Selection for PO", RepairH) = Action::LookupOK then begin
            RepairH.TestField("Supplier No");
            WorkOrderHeader.Validate("Buy-from Vendor No.", RepairH."Supplier No");
            WorkOrderHeader.Validate("Global Dimension 1 Code", RepairH."Global Dimension 1 Code");
            WorkOrderHeader.Validate("Global Dimension 2 Code", RepairH."Global Dimension 2 Code");
            WorkOrderHeader.Validate("Global Dimension 3 Code", RepairH."Global Dimension 3 Code");
        end;
        Commit();
        WorkOrderHeader.Modify(true);
        //Create Line
        RepairLines.Reset();
        RepairLines.SetRange("Repair No", RepairH."No.");
        if RepairLines.Find('-')then begin
            repeat WorkOrderLine.Init();
                WorkOrderLine."Document Type":=WorkOrderLine."Document Type"::Order;
                WorkOrderLine."Work No":=WorkOrderHeader."No.";
                WorkOrderLine."Line No":=RepairLines."Line No";
                WorkOrderLine."Catalog No.":=RepairLines."Catalog No.";
                WorkOrderLine.MFR:=RepairLines.MFR;
                if RepairLines.Type = RepairLines.Type::Item then begin
                    WorkOrderLine.Type:=WorkOrderLine.Type::Item;
                    WorkOrderLine.Validate(No, RepairLines.No);
                end
                else if RepairLines.Type = RepairLines.Type::"Fixed Asset" then begin
                        WorkOrderLine.Type:=WorkOrderLine.Type::"Fixed Asset";
                        WorkOrderLine.Validate(No, RepairLines.No);
                    end;
                WorkOrderLine.Description:=CopyStr(RepairLines.Description, 1, 250);
                WorkOrderLine."Location Code":=RepairLines."Location Code";
                WorkOrderLine."Asset Location":=RepairLines."Asset Location";
                WorkOrderLine."Fault Code":=RepairH."Fault Type";
                WorkOrderLine."Fault Area Code":=RepairH."Fault Area";
                WorkOrderLine."Symptom Code":=RepairH."Fault Symptom";
                WorkOrderLine."FA Posting Type":=WorkOrderLine."FA Posting Type"::Maintenance;
                WorkOrderLine."Currency Code":=RepairLines."Currency Code";
                WorkOrderLine.Validate(Quantity, RepairLines.Quantity);
                WorkOrderLine.Validate("Unit of Measure", RepairLines."Unit of Measure");
                WorkOrderLine.Validate("Unit Price", RepairLines."Unit Price");
                WorkOrderLine."Global Dimension 1 Code":=RepairLines."Global Dimension 1 Code";
                WorkOrderLine."Global Dimension 2 Code":=RepairLines."Global Dimension 2 Code";
                WorkOrderLine."Global Dimension 3 Code":=RepairLines."Global Dimension 3 Code";
                WorkOrderLine.Insert();
            /*RequisitionLines.Decision := RequisitionLines.Decision::Order;
            RequisitionLines."Target No." := PurchOrderHeader."Buy-from Vendor No.";
            RequisitionLines."Order No" := PurchOrderHeader."No.";
            RequisitionLines.Processed := true;
            RequisitionLines.Modify;*/
            until RepairLines.Next() = 0;
        end;
        //Update Repair Requisition
        RepairH."WO Generated Directly":=true;
        RepairH."WO Generated Date":=Today;
        RepairH."WO Generated By":=UserId;
        RepairH."WO Number":=WorkOrderHeader."No.";
        RepairH."RR Closed":=true;
        RepairH."RR Closed By":=RepairH."RR Closed By"::"Work Order";
        RepairH.Modify();
        Message('Work Order No. %1 has been created for this Repair Requisition.', WorkOrderHeader."No.");
        Page.Run(52001, WorkOrderHeader);
    end;
    procedure AppendRequisitionToOrder(var RepairH: Record "Repair Header")
    var
        WorkOrderHeader: Record "Work Order Header";
        WorkOrderLine: Record "Work Order Lines";
        RepairLines: Record "Repair Lines";
        LineNo: Integer;
        PurchOrderHeader: Record "Purchase Header";
        PurchOrderLine: Record "Purchase Line";
        RequisitionLines: Record "Requisition Lines";
    begin
        if RepairH.Status <> RepairH.Status::Released then Error('This Repair Request has not been fully approved.');
        if RepairH."WO Generated Directly" then Error('A Work Order No. %1 has already been generated for this Repair Request.', RepairH."WO Number");
        //Create Header
        WorkOrderHeader.Reset();
        WorkOrderHeader.SetRange("Document Type", WorkOrderHeader."Document Type"::Order);
        WorkOrderHeader.SetRange(Status, WorkOrderHeader.Status::Open);
        if page.RunModal(page::"Work Orders", WorkOrderHeader) = Action::LookupOK then begin
            WorkOrderHeader."Repair Request No.":=RepairH."No.";
            WorkOrderHeader."Work Date":=Today;
            WorkOrderHeader."Work Order Type":=RepairH."Repair Type";
            WorkOrderHeader."Service Level":=RepairH."Repair Service Level";
            WorkOrderHeader."Fault Area":=RepairH."Fault Area";
            WorkOrderHeader."Fault Date":=RepairH."Fault Date";
            WorkOrderHeader."Fault Code":=RepairH."Fault Type";
            WorkOrderHeader."Fault Symptom":=RepairH."Fault Symptom";
            WorkOrderHeader."Global Dimension 1 Code":=RepairH."Global Dimension 1 Code";
            WorkOrderHeader."Global Dimension 2 Code":=RepairH."Global Dimension 2 Code";
            WorkOrderHeader."Global Dimension 3 Code":=RepairH."Global Dimension 3 Code";
            WorkOrderHeader."Asset Location":=RepairH."Asset Location";
            WorkOrderHeader."Location Code":=RepairH."Location Code";
            WorkOrderHeader."Currency Code":=RepairH."Currency Code";
            WorkOrderHeader."Posting Date":=WorkDate();
            WorkOrderHeader.Modify();
            //Append Lines
            RepairLines.Reset();
            RepairLines.SetRange("Repair No", RepairH."No.");
            if RepairLines.FindLast()then LineNo:=RepairLines."Line No";
            RepairLines.Reset();
            RepairLines.SetRange("Repair No", RepairH."No.");
            if RepairLines.Find('-')then begin
                repeat LineNo:=LineNo + 1000;
                    WorkOrderLine.Init();
                    WorkOrderLine."Document Type":=WorkOrderLine."Document Type"::Order;
                    WorkOrderLine."Work No":=WorkOrderHeader."No.";
                    WorkOrderLine."Line No":=LineNo;
                    WorkOrderLine."Catalog No.":=RepairLines."Catalog No.";
                    WorkOrderLine.MFR:=RepairLines.MFR;
                    if RepairLines.Type = RepairLines.Type::Item then begin
                        WorkOrderLine.Type:=WorkOrderLine.Type::Item;
                        WorkOrderLine.Validate(No, RepairLines.No);
                    end
                    else if RepairLines.Type = RepairLines.Type::"Fixed Asset" then begin
                            WorkOrderLine.Type:=WorkOrderLine.Type::"Fixed Asset";
                            WorkOrderLine.Validate(No, RepairLines.No);
                        end;
                    WorkOrderLine.Description:=CopyStr(RepairLines.Description, 1, 250);
                    WorkOrderLine."Location Code":=RepairLines."Location Code";
                    WorkOrderLine."Asset Location":=RepairLines."Asset Location";
                    WorkOrderLine."Fault Code":=RepairH."Fault Type";
                    WorkOrderLine."Fault Area Code":=RepairH."Fault Area";
                    WorkOrderLine."Symptom Code":=RepairH."Fault Symptom";
                    WorkOrderLine."FA Posting Type":=WorkOrderLine."FA Posting Type"::Maintenance;
                    WorkOrderLine."Currency Code":=RepairLines."Currency Code";
                    WorkOrderLine.Validate(Quantity, RepairLines.Quantity);
                    WorkOrderLine.Validate("Unit of Measure", RepairLines."Unit of Measure");
                    WorkOrderLine.Validate("Unit Price", RepairLines."Unit Price");
                    WorkOrderLine."Global Dimension 1 Code":=RepairLines."Global Dimension 1 Code";
                    WorkOrderLine."Global Dimension 2 Code":=RepairLines."Global Dimension 2 Code";
                    WorkOrderLine."Global Dimension 3 Code":=RepairLines."Global Dimension 3 Code";
                    WorkOrderLine.Insert();
                /*RequisitionLines.Decision := RequisitionLines.Decision::Order;
                RequisitionLines."Target No." := PurchOrderHeader."Buy-from Vendor No.";
                RequisitionLines."Order No" := PurchOrderHeader."No.";
                RequisitionLines.Processed := true;
                RequisitionLines.Modify;*/
                until RepairLines.Next() = 0;
            end;
            //Update Repair Requisition
            RepairH."WO Generated Directly":=true;
            RepairH."WO Generated Date":=Today;
            RepairH."WO Generated By":=UserId;
            RepairH."WO Number":=WorkOrderHeader."No.";
            RepairH."RR Closed":=true;
            RepairH."RR Closed By":=RepairH."RR Closed By"::"Work Order";
            RepairH.Modify();
            Message('Work Order No. %1 has been updated with this Repair Requisition.', WorkOrderHeader."No.");
            Page.Run(52001, WorkOrderHeader);
        end;
    end;
}
