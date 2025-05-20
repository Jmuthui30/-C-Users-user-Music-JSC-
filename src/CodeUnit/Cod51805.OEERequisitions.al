codeunit 51805 "OEERequisitions"
{
    // version THL- PRM 1.0
    trigger OnRun()
    begin
    end;
    var RequisitionHeader: Record "Requisition Header";
    ProcurementSetup: Record "Procurement Setup";
    NoSeries: Record "No. Series";
    RequisitionLines: Record "Requisition Lines";
    QuantumJumpsUserSetup: Record "User Setup";
    Employee: Record Employee;
    JobJnLine: Record "Job Journal Line";
    Batch: Record "Gen. Journal Batch";
    JobJnlPostLine: Codeunit "Job Jnl.-Post Line";
    ServiceLine: Record "Service Line";
    WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines";
    Resource: Record Resource;
    QtyDiff: Decimal;
    Mail: Codeunit "QuantumJumps Mail";
    ItemLedger: Record "Item Ledger Entry";
    Text000: Label 'The Item %1 is Out of Stock';
    Text001: Label 'You are about to post this document, do you wish to continue?';
    Text002: Label 'Your are about to receive Items on this Approved Purchase Requisition. Do you wish to continue?';
    JobTaskDimension: Record "Job Task Dimension";
    procedure "Post Job Resource"(WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    var
        LineNo: Integer;
    begin
        WorksheetRequisitionsLines.TestField("Shortcut Dimension 1 Code");
        WorksheetRequisitionsLines.TestField("Gen. Prod. Posting Group");
        // Delete JobLines Present on the General Journal Line
        JobJnLine.Reset;
        JobJnLine.SetRange(JobJnLine."Journal Template Name", 'JOB');
        JobJnLine.SetRange(JobJnLine."Journal Batch Name", 'DEFAULT');
        JobJnLine.DeleteAll;
        //Create General Journal
        Batch.Init;
        Batch."Journal Template Name":='JOB';
        Batch.Description:='Job Posting Journal';
        Batch.Name:='DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        LineNo:=1000;
        JobJnLine.Init;
        JobJnLine."Journal Template Name":='JOB';
        JobJnLine."Journal Batch Name":='DEFAULT';
        JobJnLine."Line No.":=LineNo;
        JobJnLine."Document No.":=WorksheetRequisitionsLines."Document No.";
        JobJnLine."Line Type":=JobJnLine."Line Type"::Budget;
        JobJnLine.Validate("Line Type", JobJnLine."Line Type"::Budget);
        JobJnLine."Posting Date":=WorkDate;
        JobJnLine."Document Date":=WorkDate;
        JobJnLine."Job No.":=WorksheetRequisitionsLines."Job No.";
        JobJnLine.Validate("Job No.");
        JobJnLine."Job Task No.":=WorksheetRequisitionsLines."Job Task No.";
        JobJnLine.Validate("Job Task No.");
        JobJnLine.Type:=JobJnLine.Type::Resource;
        JobJnLine."No.":=WorksheetRequisitionsLines."No.";
        JobJnLine.Validate("No.");
        JobJnLine."Location Code":=WorksheetRequisitionsLines."Location Code";
        JobJnLine."Unit of Measure Code":=WorksheetRequisitionsLines."Unit of Measure Code";
        JobJnLine."Shortcut Dimension 1 Code":=WorksheetRequisitionsLines."Shortcut Dimension 1 Code";
        JobJnLine.Validate("Shortcut Dimension 1 Code");
        JobJnLine.Quantity:=WorksheetRequisitionsLines.Quantity;
        JobJnLine.Validate(Quantity);
        JobJnLine."Unit Cost":=WorksheetRequisitionsLines."Unit Cost";
        JobJnLine.Validate("Unit Cost");
        if JobJnLine.Quantity <> 0 then JobJnLine.Insert;
        JobJnlPostLine.RunWithCheck(JobJnLine);
        WorksheetRequisitionsLines.Posted:=true;
        WorksheetRequisitionsLines."Quantity Issued":=WorksheetRequisitionsLines.Quantity;
        WorksheetRequisitionsLines.Modify;
    end;
    procedure "Post Job GL"(WorksheetRequisitionsLines: Record "Worksheet Requisitions Lines")
    var
        LineNo: Integer;
    begin
        WorksheetRequisitionsLines.TestField("Shortcut Dimension 1 Code");
        // WorksheetRequisitionsLines.TestField("Gen. Prod. Posting Group");
        // Delete JobLines Present on the General Journal Line
        JobJnLine.Reset;
        JobJnLine.SetRange(JobJnLine."Journal Template Name", 'JOB');
        JobJnLine.SetRange(JobJnLine."Journal Batch Name", 'DEFAULT');
        JobJnLine.DeleteAll;
        //Create General Journal
        Batch.Init;
        Batch."Journal Template Name":='JOB';
        Batch.Description:='Job Posting Journal';
        Batch.Name:='DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        LineNo:=1000;
        JobJnLine.Init;
        JobJnLine."Journal Template Name":='JOB';
        JobJnLine."Journal Batch Name":='DEFAULT';
        JobJnLine."Line No.":=LineNo;
        JobJnLine."Document No.":=WorksheetRequisitionsLines."Document No.";
        JobJnLine."Line Type":=JobJnLine."Line Type"::Budget;
        JobJnLine.Validate("Line Type", JobJnLine."Line Type"::Budget);
        JobJnLine."Posting Date":=WorkDate;
        JobJnLine."Document Date":=WorkDate;
        JobJnLine."Job No.":=WorksheetRequisitionsLines."Job No.";
        JobJnLine.Validate("Job No.");
        JobJnLine."Job Task No.":=WorksheetRequisitionsLines."Job Task No.";
        JobJnLine.Validate("Job Task No.");
        JobJnLine.Type:=JobJnLine.Type::"G/L Account";
        JobJnLine."No.":=WorksheetRequisitionsLines."No.";
        JobJnLine.Validate("No.");
        JobJnLine."Location Code":=WorksheetRequisitionsLines."Location Code";
        JobJnLine."Unit of Measure Code":=WorksheetRequisitionsLines."Unit of Measure Code";
        JobJnLine."Shortcut Dimension 1 Code":=WorksheetRequisitionsLines."Shortcut Dimension 1 Code";
        JobJnLine.Validate("Shortcut Dimension 1 Code");
        JobJnLine.Quantity:=WorksheetRequisitionsLines.Quantity;
        JobJnLine.Validate(Quantity);
        JobJnLine."Unit Cost":=WorksheetRequisitionsLines."Unit Cost";
        JobJnLine.Validate("Unit Cost");
        if JobJnLine.Quantity <> 0 then JobJnLine.Insert;
        JobJnlPostLine.RunWithCheck(JobJnLine);
        WorksheetRequisitionsLines.Posted:=true;
        WorksheetRequisitionsLines."Quantity Issued":=WorksheetRequisitionsLines.Quantity;
        WorksheetRequisitionsLines.Modify;
    end;
    procedure "Post Service Store Requisition"(RequisitionHeader: Record "Requisition Header")
    begin
        RequisitionLines.Reset;
        RequisitionLines.SetRange("Requisition No", RequisitionHeader."No.");
        if RequisitionLines.FindSet then repeat begin
                QtyDiff:=RequisitionLines."Quantity in Store" - RequisitionLines.Quantity;
                if QtyDiff < 0 then begin
                    Message(Text000, RequisitionLines.Description, RequisitionLines."Quantity in Store");
                //Mail.NewIncidentMail(ProcurementSetup."Stores Control Email", STRSUBSTNO(Text001,RequisitionLines.Description),STRSUBSTNO(Text002,RequisitionHeader."Employee Name",FORMAT(RequisitionLines.Quantity),RequisitionLines.Description));
                end;
                ServiceLine.Reset;
                ServiceLine.SetRange("Document Type", ServiceLine."Document Type"::Order);
                ServiceLine.SetRange("Document No.", RequisitionLines."Service Order No");
                ServiceLine.SetRange("Line No.", RequisitionLines."Service Item Line No.");
                ServiceLine.SetRange("No.", RequisitionLines.No);
                if ServiceLine.FindFirst then begin
                    //ServiceLine."Store Issue" := ServiceLine."Store Issue" + RequisitionLines."Quantity To Issue";
                    ServiceLine.Modify;
                end;
                RequisitionHeader."Issued By":=UserId;
                RequisitionHeader."Issued Date":=WorkDate;
                RequisitionHeader.Modify(true);
                RequisitionLines."Quantity Issued":=RequisitionLines."Quantity Issued" + RequisitionLines."Quantity To Issue";
                RequisitionLines."Issued By":=UserId;
                RequisitionLines."Issued Date":=WorkDate;
                if RequisitionLines."Quantity Issued" = RequisitionLines.Quantity then RequisitionLines.Status:=RequisitionLines.Status::Committed;
                RequisitionLines.Modify;
            end;
            until RequisitionLines.Next = 0;
        Message('Service Order Lines have been Updated and Ready to be Posted');
    end;
    procedure "Post Job Store Requisition"(RequisitionHeader: Record "Requisition Header")
    var
        LineNo: Integer;
        "Issued Amount": Decimal;
    begin
        // Delete JobLines Present on the General Journal Line
        JobJnLine.Reset;
        JobJnLine.SetRange(JobJnLine."Journal Template Name", 'JOB');
        JobJnLine.SetRange(JobJnLine."Journal Batch Name", 'DEFAULT');
        JobJnLine.DeleteAll;
        //Create General Journal
        Batch.Init;
        Batch."Journal Template Name":='JOB';
        Batch.Description:='Job Posting Journal';
        Batch.Name:='DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        LineNo:=1000;
        RequisitionLines.Reset;
        RequisitionLines.SetRange("Requisition No", RequisitionHeader."No.");
        if RequisitionLines.FindSet then repeat begin
                RequisitionLines.TestField("Global Dimension 1 Code");
                QtyDiff:=RequisitionLines."Quantity in Store" - RequisitionLines.Quantity;
                if QtyDiff < 0 then begin
                    Message(Text000, RequisitionLines.Description, RequisitionLines."Quantity in Store");
                //Mail.NewIncidentMail(ProcurementSetup."Stores Control Email", STRSUBSTNO(Text001,RequisitionLines.Description),STRSUBSTNO(Text002,RequisitionHeader."Employee Name",FORMAT(RequisitionLines.Quantity),RequisitionLines.Description));
                end;
                JobJnLine.Init;
                JobJnLine."Journal Template Name":='JOB';
                JobJnLine."Journal Batch Name":='DEFAULT';
                JobJnLine."Line No.":=LineNo;
                JobJnLine."Line Type":=JobJnLine."Line Type"::Budget;
                JobJnLine.Validate("Line Type", JobJnLine."Line Type"::Budget);
                JobJnLine."Posting Date":=WorkDate;
                JobJnLine."Document Date":=WorkDate;
                JobJnLine."Document No.":=RequisitionLines."Requisition No";
                JobJnLine."Job No.":=RequisitionLines."Job No";
                JobJnLine.Validate("Job No.");
                JobJnLine."Job Task No.":=RequisitionLines."Job Task No";
                JobJnLine.Validate("Job Task No.");
                JobJnLine.Type:=JobJnLine.Type::Item;
                JobJnLine.Validate(Type);
                JobJnLine."No.":=RequisitionLines.No;
                JobJnLine.Validate("No.");
                JobJnLine."Location Code":=RequisitionLines."Location Code";
                JobJnLine."Unit of Measure Code":=RequisitionLines."Unit of Measure";
                JobJnLine.Validate("Shortcut Dimension 1 Code");
                JobJnLine."Shortcut Dimension 1 Code":=RequisitionLines."Global Dimension 1 Code";
                JobJnLine.Validate("Shortcut Dimension 1 Code");
                JobJnLine.Quantity:=RequisitionLines."Quantity To Issue";
                JobJnLine.Validate(Quantity);
                if JobJnLine.Quantity <> 0 then JobJnlPostLine.RunWithCheck(JobJnLine);
                RequisitionHeader."Issued By":=UserId;
                RequisitionHeader."Issued Date":=WorkDate;
                RequisitionHeader.Modify(true);
                RequisitionLines."Quantity Issued":=RequisitionLines."Quantity Issued" + RequisitionLines."Quantity To Issue";
                "Issued Amount":=RequisitionLines."Quantity Issued";
                RequisitionLines."Issued By":=UserId;
                RequisitionLines."Issued Date":=WorkDate;
                if RequisitionLines."Quantity Issued" = RequisitionLines.Quantity then begin
                    RequisitionLines.Status:=RequisitionLines.Status::Committed;
                    RequisitionLines."Quantity To Issue":=0;
                end;
                RequisitionLines.Modify;
                WorksheetRequisitionsLines.Reset;
                WorksheetRequisitionsLines.SetRange("Job No.", RequisitionLines."Job No");
                WorksheetRequisitionsLines.SetRange("Job Task No.", RequisitionLines."Job Task No");
                WorksheetRequisitionsLines.SetRange("Line No.", RequisitionLines."Job Worksheet LineNo");
                if WorksheetRequisitionsLines.FindFirst then begin
                    WorksheetRequisitionsLines."Quantity Issued":="Issued Amount";
                    if WorksheetRequisitionsLines."Quantity Issued" = WorksheetRequisitionsLines.Quantity then WorksheetRequisitionsLines.Posted:=true;
                    WorksheetRequisitionsLines.Modify;
                end;
            end;
            until RequisitionLines.Next = 0;
        Message('Requisition have been Posted and Item Posted');
    end;
    procedure "Reverse Job Planning Entry"(JobNo: Code[20]; JobTaskNo: Code[20]; JobPlanningLineNo: Code[20])
    var
        JobPlanningLine: Record "Job Planning Line";
        JobPlanningLineNo_int: Integer;
        DimensionCode: Code[20];
    begin
        DimensionCode:='';
        JobPlanningLine.Reset;
        JobPlanningLine.SetRange("Job No.", JobNo);
        JobPlanningLine.SetRange("Job Task No.", JobTaskNo);
        Evaluate(JobPlanningLineNo_int, JobPlanningLineNo);
        JobPlanningLine.SetRange("Line No.", JobPlanningLineNo_int);
        if JobPlanningLine.FindFirst then begin
            JobTaskDimension.Reset;
            JobTaskDimension.SetRange("Job No.", JobPlanningLine."Job No.");
            JobTaskDimension.SetRange("Job Task No.", JobPlanningLine."Job Task No.");
            JobTaskDimension.SetRange("Dimension Code", 'DIVISION');
            if JobTaskDimension.FindFirst then DimensionCode:=JobTaskDimension."Dimension Value Code";
            case JobPlanningLine.Type of JobPlanningLine.Type::"G/L Account": "Reverse Job Planning Line GL"(JobPlanningLine, DimensionCode);
            JobPlanningLine.Type::Item: "Reverse Job Planning Line Item"(JobPlanningLine, DimensionCode);
            JobPlanningLine.Type::Resource: "Reverse Job Planning Line Resourse"(JobPlanningLine, DimensionCode);
            end;
        end;
    end;
    local procedure "Reverse Job Planning Line GL"(JobPlanningLine: Record "Job Planning Line"; Dimension: Code[20])
    var
        LineNo: Integer;
    begin
        // Delete JobLines Present on the General Journal Line
        JobJnLine.Reset;
        JobJnLine.SetRange(JobJnLine."Journal Template Name", 'JOB');
        JobJnLine.SetRange(JobJnLine."Journal Batch Name", 'DEFAULT');
        JobJnLine.DeleteAll;
        //Create General Journal
        Batch.Init;
        Batch."Journal Template Name":='JOB';
        Batch.Description:='Job Posting Journal';
        Batch.Name:='DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        LineNo:=1000;
        JobJnLine.Init;
        JobJnLine."Journal Template Name":='JOB';
        JobJnLine."Journal Batch Name":='DEFAULT';
        JobJnLine."Line No.":=LineNo;
        JobJnLine."Line Type":=JobJnLine."Line Type"::Budget;
        JobJnLine.Validate("Line Type", JobJnLine."Line Type"::Budget);
        JobJnLine."Posting Date":=WorkDate;
        JobJnLine."Document Date":=WorkDate;
        JobJnLine."Document No.":=JobPlanningLine."Document No.";
        JobJnLine."Job No.":=JobPlanningLine."Job No.";
        JobJnLine.Validate("Job No.");
        JobJnLine."Job Task No.":=JobPlanningLine."Job Task No.";
        JobJnLine.Validate("Job Task No.");
        JobJnLine.Type:=JobJnLine.Type::"G/L Account";
        JobJnLine.Validate(Type);
        JobJnLine."No.":=JobPlanningLine."No.";
        JobJnLine.Validate("No.");
        JobJnLine."Location Code":=JobPlanningLine."Location Code";
        JobJnLine."Unit of Measure Code":=JobPlanningLine."Unit of Measure Code";
        JobJnLine.Validate("Unit of Measure Code");
        JobJnLine."Shortcut Dimension 1 Code":=Dimension;
        JobJnLine.Validate("Shortcut Dimension 1 Code");
        JobPlanningLine."Unit Cost":=JobPlanningLine."Unit Cost";
        JobPlanningLine.Validate("Unit Cost");
        JobJnLine.Quantity:=-(JobPlanningLine.Quantity);
        JobJnLine.Validate(Quantity);
        if JobJnLine.Quantity <> 0 then JobJnlPostLine.RunWithCheck(JobJnLine);
        UpdateJobPlanningLine(JobPlanningLine);
        Message('G/L Account Job Planning Line Entry have been Reversed');
    end;
    local procedure "Reverse Job Planning Line Item"(JobPlanningLine: Record "Job Planning Line"; Dimension: Code[20])
    var
        LineNo: Integer;
    begin
        // Delete JobLines Present on the General Journal Line
        JobJnLine.Reset;
        JobJnLine.SetRange(JobJnLine."Journal Template Name", 'JOB');
        JobJnLine.SetRange(JobJnLine."Journal Batch Name", 'DEFAULT');
        JobJnLine.DeleteAll;
        //Create General Journal
        Batch.Init;
        Batch."Journal Template Name":='JOB';
        Batch.Description:='Job Posting Journal';
        Batch.Name:='DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        LineNo:=1000;
        JobJnLine.Init;
        JobJnLine."Journal Template Name":='JOB';
        JobJnLine."Journal Batch Name":='DEFAULT';
        JobJnLine."Line No.":=LineNo;
        JobJnLine."Line Type":=JobJnLine."Line Type"::Budget;
        JobJnLine.Validate("Line Type", JobJnLine."Line Type"::Budget);
        JobJnLine."Posting Date":=WorkDate;
        JobJnLine."Document Date":=WorkDate;
        JobJnLine."Document No.":=JobPlanningLine."Document No.";
        JobJnLine."Job No.":=JobPlanningLine."Job No.";
        JobJnLine.Validate("Job No.");
        JobJnLine."Job Task No.":=JobPlanningLine."Job Task No.";
        JobJnLine.Validate("Job Task No.");
        JobJnLine.Type:=JobJnLine.Type::Item;
        JobJnLine.Validate(Type);
        JobJnLine."No.":=JobPlanningLine."No.";
        JobJnLine.Validate("No.");
        JobJnLine."Location Code":=JobPlanningLine."Location Code";
        JobJnLine."Unit of Measure Code":=JobPlanningLine."Unit of Measure Code";
        JobJnLine.Validate("Unit of Measure Code");
        JobJnLine."Shortcut Dimension 1 Code":=Dimension;
        JobJnLine.Validate("Shortcut Dimension 1 Code");
        JobJnLine.Quantity:=-(JobPlanningLine.Quantity);
        JobJnLine.Validate(Quantity);
        if JobJnLine.Quantity <> 0 then JobJnlPostLine.RunWithCheck(JobJnLine);
        UpdateJobPlanningLine(JobPlanningLine);
        Message('Item Job Planning Line Entry have been Reversed');
    end;
    local procedure "Reverse Job Planning Line Resourse"(JobPlanningLine: Record "Job Planning Line"; Dimension: Code[20])
    var
        LineNo: Integer;
    begin
        // Delete JobLines Present on the General Journal Line
        JobJnLine.Reset;
        JobJnLine.SetRange(JobJnLine."Journal Template Name", 'JOB');
        JobJnLine.SetRange(JobJnLine."Journal Batch Name", 'DEFAULT');
        JobJnLine.DeleteAll;
        //Create General Journal
        Batch.Init;
        Batch."Journal Template Name":='JOB';
        Batch.Description:='Job Posting Journal';
        Batch.Name:='DEFAULT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        LineNo:=1000;
        JobJnLine.Init;
        JobJnLine."Journal Template Name":='JOB';
        JobJnLine."Journal Batch Name":='DEFAULT';
        JobJnLine."Line No.":=LineNo;
        JobJnLine."Line Type":=JobJnLine."Line Type"::Budget;
        JobJnLine.Validate("Line Type", JobJnLine."Line Type"::Budget);
        JobJnLine."Posting Date":=WorkDate;
        JobJnLine."Document Date":=WorkDate;
        JobJnLine."Document No.":=JobPlanningLine."Document No.";
        JobJnLine."Job No.":=JobPlanningLine."Job No.";
        JobJnLine.Validate("Job No.");
        JobJnLine."Job Task No.":=JobPlanningLine."Job Task No.";
        ;
        JobJnLine.Validate("Job Task No.");
        JobJnLine.Type:=JobJnLine.Type::Resource;
        JobJnLine.Validate(Type);
        JobJnLine."No.":=JobPlanningLine."No.";
        JobJnLine.Validate("No.");
        JobJnLine."Location Code":=JobPlanningLine."Location Code";
        JobJnLine."Unit of Measure Code":=JobPlanningLine."Unit of Measure Code";
        JobJnLine.Validate("Unit of Measure Code");
        JobJnLine."Shortcut Dimension 1 Code":=Dimension;
        JobJnLine.Validate("Shortcut Dimension 1 Code");
        JobJnLine.Quantity:=-(JobPlanningLine.Quantity);
        JobJnLine.Validate(Quantity);
        if JobJnLine.Quantity <> 0 then JobJnlPostLine.RunWithCheck(JobJnLine);
        UpdateJobPlanningLine(JobPlanningLine);
        Message('Resourse Job Planning Line Entry have been Reversed');
    end;
    local procedure UpdateJobPlanningLine(NewJobPlanningLine: Record "Job Planning Line")
    var
        JobPlanningLine: Record "Job Planning Line";
    begin
        JobPlanningLine.Reset;
        JobPlanningLine.SetRange("Job No.", NewJobPlanningLine."Job No.");
        JobPlanningLine.SetRange("Job Task No.", NewJobPlanningLine."Job Task No.");
        JobPlanningLine.SetRange("Line No.", NewJobPlanningLine."Line No.");
        if JobPlanningLine.FindFirst then begin
            //JobPlanningLine.Reversed := TRUE;
            JobPlanningLine.Modify(true);
        end;
    end;
}
