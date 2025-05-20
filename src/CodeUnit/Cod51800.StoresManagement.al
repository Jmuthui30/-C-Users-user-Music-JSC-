codeunit 51800 "Stores Management"
{
    // version THL- PRM 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
    // Advanced Finance: 52100 - 52199 = 99
    // QuantumJumps HR: 51600 - 51799 = 199
    // QuantumJumps Procumement: 51800 - 51899 = 99
    // ***********************
    // EasyPFA: 51900 - 52099 = 199
    // Investment: 52100 - 52199 = 99
    // DynamicsHMIS: 52200 - 52299 = 99
    // EasyProperty: 52300 - 52399 = 99
    // Insurance: 61423 - 61622 = 199
    // Sacco:   61623 - 62422 = ***
    // ***********************
    trigger OnRun()
    begin
    end;
    var RequsitionLines: Record "Requisition Lines";
    ItemJournaline: Record "Item Journal Line";
    CurrentJnlBatchName: Code[10];
    ItemPostline: Codeunit "Item Jnl.-Post Line";
    UserSetup: Record "User Setup";
    UserSetupRec: Record "User Setup";
    QtyDiff: Decimal;
    Mail: Codeunit "QuantumJumps Mail";
    ItemLedger: Record "Item Ledger Entry";
    ProcurementSetup: Record "Procurement Setup";
    Batch: Record "Item Journal Batch";
    Text000: Label 'The document %1 is already posted';
    Text001: Label 'You are about to post this document, do you wish to continue?';
    ItemJnlLine: Record "Item Journal Line";
    JnlTemplate: Record "Item Journal Template";
    TransactionLines: Record "Store Transaction Lines";
    Text002: Label 'Your are about to receive Items on this Approved Purchase Requisition. Do you wish to continue?';
    Header: Record "Store Transaction Header";
    Lines: Record "Store Transaction Lines";
    procedure IssueStoreItems(var Requisition: Record "Requisition Header")
    var
        Text000: Label 'Procurement Notified! The stock item: %1 is out of stock, The quantity in store is %2';
        Text001: Label '%1 is Out of stock';
        Text002: Label '%1 has Requested %2 %3 but it is out of stock';
        Text003: Label 'Requisition %1 is already posted';
        Text004: Label 'The Requisition cannot be posted before it is fully approved';
        Text005: Label '%1 issued.';
        Text006: Label '%1. You have been issued with %2  of %3.';
        Text007: Label '%1 approved';
        Text008: Label '%1. You have been approved with %2 of %3.';
    begin
        ProcurementSetup.Get;
        ProcurementSetup.TestField("Store Issue Template");
        ProcurementSetup.TestField("Store Issue Batch");
        ProcurementSetup.TestField("Stores Control Email");
        // Delete Lines Present on the General Journal Line
        ItemJournaline.Reset;
        ItemJournaline.SetRange(ItemJournaline."Journal Template Name", ProcurementSetup."Store Issue Template");
        ItemJournaline.SetRange(ItemJournaline."Journal Batch Name", ProcurementSetup."Store Issue Batch");
        ItemJournaline.DeleteAll;
        Batch.Init;
        Batch."Journal Template Name":=ProcurementSetup."Store Issue Template";
        Batch.Name:=ProcurementSetup."Store Issue Batch";
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        RequsitionLines.Reset;
        RequsitionLines.SetRange(RequsitionLines."Requisition No", Requisition."No.");
        if RequsitionLines.Find('-')then begin
            repeat QtyDiff:=RequsitionLines."Quantity in Store" - RequsitionLines.Quantity;
                if(RequsitionLines."Quantity in Store" < 0) or (QtyDiff < 0)then begin
                    Message(Text000, RequsitionLines.Description, RequsitionLines."Quantity in Store");
                    Mail.NewIncidentMail(ProcurementSetup."Stores Control Email", StrSubstNo(Text001, RequsitionLines.Description), StrSubstNo(Text002, Requisition."Employee Name", Format(RequsitionLines.Quantity), RequsitionLines.Description));
                    exit;
                end;
            until RequsitionLines.Next = 0;
        end;
        if Requisition.Posted then Error(Text003, Requisition."No.");
        if Requisition.Status <> Requisition.Status::Released then Error(Text004);
        RequsitionLines.Reset;
        RequsitionLines.SetRange(RequsitionLines."Requisition No", Requisition."No.");
        if RequsitionLines.Find('-')then repeat RequsitionLines.Validate(Quantity);
                ItemJournaline.Init;
                ItemJournaline."Journal Template Name":=ProcurementSetup."Store Issue Template";
                ItemJournaline."Journal Batch Name":=ProcurementSetup."Store Issue Batch";
                ItemJournaline."Line No.":=ItemJournaline."Line No." + 10000;
                ItemJournaline."Posting Date":=Today;
                ItemJournaline."Entry Type":=ItemJournaline."Entry Type"::"Negative Adjmt.";
                ItemJournaline."Document No.":=RequsitionLines."Requisition No";
                ItemJournaline."Item No.":=RequsitionLines.No;
                ItemJournaline.Validate(ItemJournaline."Item No.");
                ItemJournaline."Location Code":=RequsitionLines."Location Code";
                ItemJournaline.Validate("Location Code");
                ItemJournaline."External Document No.":=RequsitionLines."Requisition No";
                ItemJournaline.Quantity:=RequsitionLines."Quantity To Issue";
                ItemJournaline.Validate(ItemJournaline.Quantity);
                ItemJournaline."Shortcut Dimension 1 Code":=RequsitionLines."Global Dimension 1 Code";
                ItemJournaline."Shortcut Dimension 2 Code":=RequsitionLines."Global Dimension 2 Code";
                ItemJournaline.Validate("Shortcut Dimension 1 Code");
                if ItemJournaline.Quantity <> 0 then ItemJournaline.Insert(true);
                RequsitionLines."Quantity Issued":=RequsitionLines."Quantity Issued" + RequsitionLines."Quantity To Issue";
                //RequsitionLines."Quantity Issued" := RequsitionLines."Quantity Issued";
                RequsitionLines."Issued By":=UserId;
                Requisition."Requisition Date":=Today;
                RequsitionLines.Modify;
            until RequsitionLines.Next = 0;
        ItemJournaline.SetRange(ItemJournaline."Journal Template Name", ProcurementSetup."Store Issue Template");
        ItemJournaline.SetRange(ItemJournaline."Journal Batch Name", ProcurementSetup."Store Issue Batch");
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJournaline);
        CurrentJnlBatchName:=ItemJournaline.GetRangeMax("Journal Batch Name");
        ItemLedger.Reset;
        ItemLedger.SetRange(ItemLedger."Entry Type", ItemLedger."Entry Type"::"Negative Adjmt.");
        ItemLedger.SetRange(ItemLedger."Document No.", Requisition."No.");
        if ItemLedger.Find('-')then begin
            Requisition.Posted:=true;
            Requisition.Issued:=true;
            Requisition."Issued By":=UserId;
            Requisition."Issued Date":=Today;
            Requisition.Received:=true;
            if UserSetup.Get(Requisition."Raised by")then Mail.NewIncidentMail(UserSetup."E-Mail", StrSubstNo(Text005, RequsitionLines.Description), StrSubstNo(Text006, Requisition."Employee Name", Format(RequsitionLines.Quantity), RequsitionLines.Description));
            Requisition.Modify;
        end;
    end;
    procedure PostStoreTransaction(var Transactions: Record "Store Transaction Header")
    begin
        if Confirm(Text001, false) = true then begin
            if Transactions.Transaction = Transactions.Transaction::Issue then PostItemIssue(Transactions)
            else if Transactions.Transaction = Transactions.Transaction::Receive then PostItemReceipt(Transactions)
                else if Transactions.Transaction = Transactions.Transaction::Transfer then PostItemTransfer(Transactions);
        end;
    end;
    procedure PostItemIssue(var Transactions: Record "Store Transaction Header")
    begin
        if Transactions.Posted then Error(StrSubstNo(Text000, Transactions."No."));
        //Check if template exists
        JnlTemplate.Init;
        JnlTemplate.Name:='STORE';
        JnlTemplate.Description:='Stores Transactions';
        JnlTemplate.Type:=JnlTemplate.Type::Item;
        if not JnlTemplate.Get(JnlTemplate.Name)then JnlTemplate.Insert;
        //Check if batch exists
        Batch.Init;
        Batch."Journal Template Name":='STORE';
        Batch.Name:='ISSUE';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        // Delete Lines Present on the General Journal Line
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", 'STORE');
        ItemJnlLine.SetRange("Journal Batch Name", 'ISSUE');
        ItemJnlLine.DeleteAll;
        TransactionLines.Reset;
        TransactionLines.SetRange("No.", Transactions."No.");
        if TransactionLines.Find('-')then repeat TransactionLines.Validate(Quantity);
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name":='STORE';
                ItemJnlLine."Journal Batch Name":='ISSUE';
                ItemJnlLine."Line No.":=ItemJnlLine."Line No." + 10000;
                ItemJnlLine."Posting Date":=Transactions.Date;
                ItemJnlLine."Entry Type":=ItemJnlLine."Entry Type"::"Negative Adjmt.";
                ItemJnlLine."Document No.":=TransactionLines."No.";
                ItemJnlLine."External Document No.":=TransactionLines."No.";
                ItemJnlLine.Validate("Item No.", TransactionLines."Item No.");
                ItemJnlLine.Description:=CopyStr('Item Issue to ' + TransactionLines."To Description", 1, 50);
                if TransactionLines.From = TransactionLines.From::Location then ItemJnlLine.Validate("Location Code", TransactionLines."From No.");
                ItemJnlLine.Validate(Quantity, TransactionLines.Quantity);
                if TransactionLines."Unit of Measure" <> '' then ItemJnlLine.Validate("Unit of Measure Code", TransactionLines."Unit of Measure");
                if TransactionLines."Variant Code" <> '' then ItemJnlLine.Validate("Variant Code", TransactionLines."Variant Code");
                if ItemJnlLine.Quantity <> 0 then ItemJnlLine.Insert(true);
            until TransactionLines.Next = 0;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", 'STORE');
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", 'ISSUE');
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
        CurrentJnlBatchName:=ItemJnlLine.GetRangeMax("Journal Batch Name");
        ItemLedger.Reset;
        ItemLedger.SetRange(ItemLedger."Entry Type", ItemLedger."Entry Type"::"Negative Adjmt.");
        ItemLedger.SetRange(ItemLedger."Document No.", Transactions."No.");
        if ItemLedger.Find('-')then begin
            Transactions.Validate(Posted, true);
            Transactions."Posted By":=UserId;
            Transactions."Posted Date":=Today;
            Transactions.Modify;
        end;
    end;
    procedure PostItemReceipt(var Transactions: Record "Store Transaction Header")
    begin
        if Transactions.Posted then Error(StrSubstNo(Text000, Transactions."No."));
        //Check if template exists
        JnlTemplate.Init;
        JnlTemplate.Name:='STORE';
        JnlTemplate.Description:='Stores Transactions';
        JnlTemplate.Type:=JnlTemplate.Type::Item;
        if not JnlTemplate.Get(JnlTemplate.Name)then JnlTemplate.Insert;
        //Check if batch exists
        Batch.Init;
        Batch."Journal Template Name":='STORE';
        Batch.Name:='RECEIPT';
        if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
        // Delete Lines Present on the General Journal Line
        ItemJnlLine.Reset;
        ItemJnlLine.SetRange("Journal Template Name", 'STORE');
        ItemJnlLine.SetRange("Journal Batch Name", 'RECEIPT');
        ItemJnlLine.DeleteAll;
        TransactionLines.Reset;
        TransactionLines.SetRange("No.", Transactions."No.");
        if TransactionLines.Find('-')then repeat TransactionLines.Validate(Quantity);
                ItemJnlLine.Init;
                ItemJnlLine."Journal Template Name":='STORE';
                ItemJnlLine."Journal Batch Name":='RECEIPT';
                ItemJnlLine."Line No.":=ItemJnlLine."Line No." + 10000;
                ItemJnlLine."Posting Date":=Transactions.Date;
                ItemJnlLine."Entry Type":=ItemJnlLine."Entry Type"::"Positive Adjmt.";
                ItemJnlLine."Document No.":=TransactionLines."No.";
                ItemJnlLine."External Document No.":=TransactionLines."No.";
                ItemJnlLine.Validate("Item No.", TransactionLines."Item No.");
                ItemJnlLine.Description:=CopyStr('Item Receipt from ' + TransactionLines."From Description", 1, 50);
                if TransactionLines."To" = TransactionLines."To"::Location then ItemJnlLine.Validate("Location Code", TransactionLines."To No.");
                ItemJnlLine.Validate(Quantity, TransactionLines.Quantity);
                if TransactionLines."Unit of Measure" <> '' then ItemJnlLine.Validate("Unit of Measure Code", TransactionLines."Unit of Measure");
                if TransactionLines."Variant Code" <> '' then ItemJnlLine.Validate("Variant Code", TransactionLines."Variant Code");
                if ItemJnlLine.Quantity <> 0 then ItemJnlLine.Insert(true);
            until TransactionLines.Next = 0;
        ItemJnlLine.SetRange(ItemJnlLine."Journal Template Name", 'STORE');
        ItemJnlLine.SetRange(ItemJnlLine."Journal Batch Name", 'RECEIPT');
        CODEUNIT.Run(CODEUNIT::"Item Jnl.-Post", ItemJnlLine);
        CurrentJnlBatchName:=ItemJnlLine.GetRangeMax("Journal Batch Name");
        ItemLedger.Reset;
        ItemLedger.SetRange(ItemLedger."Entry Type", ItemLedger."Entry Type"::"Positive Adjmt.");
        ItemLedger.SetRange(ItemLedger."Document No.", Transactions."No.");
        if ItemLedger.Find('-')then begin
            Transactions.Validate(Posted, true);
            Transactions."Posted By":=UserId;
            Transactions."Posted Date":=Today;
            Transactions.Modify;
        end;
    end;
    procedure PostItemTransfer(var Transactions: Record "Store Transaction Header")
    begin
    end;
    procedure ReceiveReleasedPR(var Request: Record "Requisition Header")
    var
        RequestLines: Record "Requisition Lines";
    begin
        if Confirm(Text002, false) = true then begin
            //Insert Header
            Header.Init;
            Header.Transaction:=Header.Transaction::Receive;
            Header.Insert(true);
            //Insert Lines
            RequestLines.Reset;
            RequestLines.SetRange("Requisition No", Request."No.");
            if RequestLines.Find('-')then begin
                repeat Lines.Init;
                    Lines."No.":=Header."No.";
                    Lines."Line No.":=RequestLines."Line No";
                    Lines.Transaction:=Lines.Transaction::Receive;
                    Lines.Validate("Item No.", RequestLines.No);
                    Lines.Validate(Quantity, RequestLines.Quantity);
                    if(Lines."Unit Value" = 0) and (RequestLines."Unit Price" <> 0)then Lines.Validate("Unit Value", RequestLines."Unit Price");
                    Lines."Unit of Measure":=RequestLines."Unit of Measure";
                    Lines.Insert(true);
                until RequestLines.Next = 0;
            end;
            PAGE.Run(51819, Header);
        end;
    end;
    procedure EmailStoreRequisition(var Requisition: Record "Requisition Header")
    var
        Text007: Label '%1 approved';
        Text008: Label '%1. You have been approved with %2 of %3.';
    begin
        ProcurementSetup.TestField("Stores Control Email");
        if Requisition.Status <> Requisition.Status::Released then Error('Store requisition has not fully approved.');
        if UserSetup.Get(Requisition."Raised by")then Mail.NewIncidentMail(UserSetup."E-Mail", StrSubstNo(Text007, RequsitionLines.Description), StrSubstNo(Text008, Requisition."Employee Name", Format(RequsitionLines.Quantity), RequsitionLines.Description));
        Requisition.Modify;
    end;
}
