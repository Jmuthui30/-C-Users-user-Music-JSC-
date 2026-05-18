codeunit 52100 "Imprest Management"
{

    // version THL- ADV.FIN 1.0
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

    var
        ImprestDetails: Record "Imprest Details";
        Text000: Label 'Are you sure you want to post the document?';
        Text001: Label 'The Document No %1 has not been fully approved.';
        EmployeeCustomerMapping: Record "Employee Customer Mapping";
        Text002: Label 'The customer account number for %1 has not been created.';
        Text003: Label 'The request amount cannot be zero.';
        Text004: Label 'The document %1 has been posted.';
        AdvancedFinanceSetup: Record "Advanced Finance Setup";
        CMSetup: Record "Cash Management Setup";
        GenJnLine: Record "Gen. Journal Line";
        Batch: Record "Gen. Journal Batch";
        LineNo: Integer;
        GLEntry: Record "G/L Entry";
        GLSetup: Record "General Ledger Setup";
        Text005: Label 'Kindly capture the actual amount spent on this document';
        Text006: Label 'Surrender Submitted.';
        Text007: Label 'This surrender has been posted.';
        Text008: Label 'Are you sure you want to post the Surrender?';
        Text009: Label 'The Surrender No %1 has not been submitted.';
        Text010: Label 'The surrender amount cannot be zero.';
        Text011: Label 'The surrender %1 has been posted.';
        RefundSelectionString: Label 'Receive Now,Deduct from Payroll';
        ClaimSelectionString: Label 'Pay Now,Pay from Payroll';
        Text012: Label 'You should receive a refund of %1 from %2. Kindly choose the desired option.';
        Selection: Integer;
        Text013: Label 'You should pay a claim of %1 to %2. Kindly choose the desired option.';
        PayrollCalc: Codeunit "Payroll Calculator";
        Text014: Label 'Are you sure you want to create a Payment Voucher?';
        PV: Record "PV Header";
        PVLines: Record "PV Lines";
        Text015: Label 'Are you sure you want to create a Purchase Orders?';
        Request: Record "Request for Payment";
        RequestLines: Record "Request for Payment Lines";
        Text016: Label 'Are you sure you want to create a Request for Payment?';
        Text017: Label 'This Staff Claim has been posted.';
        ReceiptsHeader: Record "Receipts Header";
        ReceiptLines: Record "Receipt Lines";
        FinMgt: Codeunit "Finance Management";
        Emp: Record "Employee Master";
        BankAccount: Record "Bank Account";
    // procedure PostImprestRequest(var ImprestHeader: Record "Imprest Header")
    // begin
    //     if Confirm(Text000, false) = true then begin
    //         if((ImprestHeader.Type <> ImprestHeader.Type::Request) AND (ImprestHeader.Status <> ImprestHeader.Status::Released))then Error(Text001, ImprestHeader."No.");
    //         ImprestHeader.TestField("Employee No.");
    //         ImprestHeader.TestField("Employee Name");
    //         //Check For Cash Availability
    //         //CheckForCashAvailability(ImprestHeader);
    //         if ImprestHeader."Staff Claim" then if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Advances, ImprestHeader."Employee No.")then begin
    //                 if EmployeeCustomerMapping."Customer AC" = '' then Error(Text002, ImprestHeader."Employee Name")end
    //             else
    //                 Error(Text002, ImprestHeader."Employee Name");
    //         if not ImprestHeader."Staff Claim" then if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Travels, ImprestHeader."Employee No.")then begin
    //                 if EmployeeCustomerMapping."Customer AC" = '' then Error(Text002, ImprestHeader."Employee Name")end
    //             else
    //                 Error(Text002, ImprestHeader."Employee Name");
    //         ImprestHeader.TestField("Paying Bank Code");
    //         ImprestHeader.TestField(Date);
    //         ImprestHeader.TestField("Pay Mode");
    //         if ImprestHeader."Pay Mode" <> 'CASH' then ImprestHeader.TestField("Payment Tx No.(Cheque No.)");
    //         if ImprestHeader."Pay Mode" = 'CHEQUE' then ImprestHeader.TestField("Cheque Date");
    //         //Check if the  Lines have been populated
    //         ImprestHeader.CalcFields("Total Request Amount");
    //         if ImprestHeader."Total Request Amount" = 0 then Error(Text003);
    //         if ImprestHeader."Request Posted" then Error(Text004, ImprestHeader."No.");
    //         GLSetup.Get;
    //         CMSetup.Get;
    //         AdvancedFinanceSetup.Get;
    //         // Delete Lines Present on the General Journal Line
    //         GenJnLine.Reset;
    //         GenJnLine.SetRange(GenJnLine."Journal Template Name", AdvancedFinanceSetup."Imprest Template");
    //         GenJnLine.SetRange(GenJnLine."Journal Batch Name", ImprestHeader."No.");
    //         GenJnLine.DeleteAll;
    //         Batch.Init;
    //         Batch."Journal Template Name":=AdvancedFinanceSetup."Imprest Template";
    //         Batch.Name:=ImprestHeader."No.";
    //         if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
    //         LineNo:=1000;
    //         GenJnLine.Init;
    //         GenJnLine."Journal Template Name":=AdvancedFinanceSetup."Imprest Template";
    //         GenJnLine."Journal Batch Name":=ImprestHeader."No.";
    //         GenJnLine."Line No.":=LineNo;
    //         GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account";
    //         GenJnLine."Account No.":=ImprestHeader."Paying Bank Code";
    //         GenJnLine."Posting Date":=ImprestHeader.Date;
    //         GenJnLine."Document No.":=ImprestHeader."No.";
    //         GenJnLine."External Document No.":=ImprestHeader."Payment Tx No.(Cheque No.)";
    //         GenJnLine.Description:=ImprestHeader."Employee Name";
    //         if(ImprestHeader."Currency Code" <> '') and (ImprestHeader."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", ImprestHeader."Currency Code");
    //         GenJnLine.Amount:=-ImprestHeader."Total Request Amount";
    //         GenJnLine.Validate(Amount);
    //         GenJnLine."Shortcut Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //         GenJnLine.Validate("Shortcut Dimension 1 Code");
    //         GenJnLine."Shortcut Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //         GenJnLine.Validate("Shortcut Dimension 2 Code");
    //         GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::Customer;
    //         if ImprestHeader."Staff Claim" then begin
    //             if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Advances, ImprestHeader."Employee No.")then GenJnLine."Bal. Account No.":=EmployeeCustomerMapping."Customer AC";
    //         end
    //         else
    //         begin
    //             if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Travels, ImprestHeader."Employee No.")then GenJnLine."Bal. Account No.":=EmployeeCustomerMapping."Customer AC";
    //         end;
    //         GenJnLine.Validate("Bal. Account No.");
    //         if GenJnLine.Amount <> 0 then GenJnLine.Insert;
    //         CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
    //         GLEntry.Reset;
    //         GLEntry.SetRange(GLEntry."Document No.", ImprestHeader."No.");
    //         GLEntry.SetRange(GLEntry.Reversed, false);
    //         GLEntry.SetRange("Posting Date", ImprestHeader.Date);
    //         if GLEntry.FindFirst then begin
    //             ImprestHeader."Request Posted":=true;
    //             ImprestHeader."Request Posted By":=UserId;
    //             ImprestHeader.Validate("Request Posted Date", WorkDate);
    //             ImprestHeader.Type:=ImprestHeader.Type::Surrender;
    //             ImprestHeader.Status:=ImprestHeader.Status::Open;
    //             ImprestHeader.Modify;
    //         end;
    //     end;
    // end;
    // procedure SubmitImprestSurrender(var ImprestHeader: Record "Imprest Header")
    // begin
    //     ImprestHeader.CalcFields("Total Surrender Amount");
    //     if ImprestHeader."Total Surrender Amount" = 0 then Error(Text005);
    //     ImprestHeader.Status:=ImprestHeader.Status::"Pending Approval";
    //     ImprestHeader."Surrender Date":=Today;
    //     ImprestHeader.Modify;
    //     Message(Text006);
    // end;
    // procedure PostImprestSurrender(var ImprestHeader: Record "Imprest Header")
    // begin
    //     if ImprestHeader."Surrender Posted" then Error(Text007);
    //     //Post Imprest Expenses
    //     PostImprestExpenses(ImprestHeader);
    //     //
    //     ImprestHeader.CALCFIELDS("Net Refund (Net Claim)");
    //     IF ImprestHeader."Net Refund (Net Claim)" > 0 THEN PostImprestRefund(ImprestHeader) //PostRefund
    //     ELSE IF ImprestHeader."Net Refund (Net Claim)" < 0 THEN PostImprestClaim(ImprestHeader); //Post Claim
    //     //Close Imprest
    //     //
    //     CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
    //     GLEntry.Reset;
    //     GLEntry.SetRange(GLEntry."Document No.", ImprestHeader."No.");
    //     GLEntry.SetRange(GLEntry.Reversed, false);
    //     GLEntry.SetRange("Posting Date", ImprestHeader."Surrender Date");
    //     if GLEntry.FindFirst then begin
    //         ImprestHeader."Surrender Posted":=true;
    //         ImprestHeader."Surrender Posted By":=UserId;
    //         ImprestHeader."Surrender Posted Date":=WorkDate;
    //         ImprestHeader.Modify;
    //         //Surrender The PV Lines
    //         PVLines.Reset;
    //         PVLines.SetRange(No, ImprestHeader."Imprest Request Code");
    //         PVLines.SetRange("Account No", ImprestHeader."Payroll No.");
    //         PVLines.SetRange(Posted, true);
    //         PVLines.SetRange(Surrendered, false);
    //         if PVLines.FindFirst then begin
    //             PVLines.Surrendered:=true;
    //             PVLines.Modify(true);
    //         end;
    //     end;
    // end;
    // procedure PostImprestExpenses(var ImprestHeader: Record "Imprest Header")
    // begin
    //     //***********************
    //     if Confirm(Text008, false) = true then begin
    //         if((ImprestHeader.Type <> ImprestHeader.Type::Surrender) AND (ImprestHeader.Status = ImprestHeader.Status::Open))then Error(Text009, ImprestHeader."No.");
    //         ImprestHeader.TestField("Employee No.");
    //         ImprestHeader.TestField("Employee Name");
    //         if ImprestHeader."Staff Claim" then if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Advances, ImprestHeader."Employee No.")then begin
    //                 if EmployeeCustomerMapping."Customer AC" = '' then Error(Text002, ImprestHeader."Employee Name")end
    //             else
    //                 Error(Text002, ImprestHeader."Employee Name");
    //         if not ImprestHeader."Staff Claim" then if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Travels, ImprestHeader."Employee No.")then begin
    //                 if EmployeeCustomerMapping."Customer AC" = '' then Error(Text002, ImprestHeader."Employee Name")end
    //             else
    //                 Error(Text002, ImprestHeader."Employee Name");
    //         ImprestHeader.TestField("Surrender Date");
    //         //TESTFIELD("Pay Mode");
    //         //Check if the  Lines have been populated
    //         ImprestHeader.CalcFields("Total Surrender Amount");
    //         if ImprestHeader."Total Surrender Amount" = 0 then Error(Text010);
    //         if ImprestHeader."Surrender Posted" then Error(Text011, ImprestHeader."No.");
    //         GLSetup.Get;
    //         CMSetup.Get;
    //         AdvancedFinanceSetup.Get;
    //         // Delete Lines Present on the General Journal Line
    //         GenJnLine.Reset;
    //         GenJnLine.SetRange(GenJnLine."Journal Template Name", AdvancedFinanceSetup."Imprest Template");
    //         GenJnLine.SetRange(GenJnLine."Journal Batch Name", ImprestHeader."No.");
    //         GenJnLine.DeleteAll;
    //         Batch.Init;
    //         Batch."Journal Template Name":=AdvancedFinanceSetup."Imprest Template";
    //         Batch.Name:=ImprestHeader."No.";
    //         if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
    //         //***********************
    //         ImprestDetails.Reset;
    //         ImprestDetails.SetRange("No.", ImprestHeader."No.");
    //         if ImprestDetails.Find('-')then begin
    //             repeat GenJnLine.Init;
    //                 GenJnLine."Journal Template Name":=AdvancedFinanceSetup."Imprest Template";
    //                 GenJnLine."Journal Batch Name":=ImprestHeader."No.";
    //                 GenJnLine."Line No.":=ImprestDetails."Line No" + 1000;
    //                 if ImprestDetails.Type = ImprestDetails.Type::Customer then GenJnLine."Account Type":=GenJnLine."Account Type"::Customer
    //                 else if ImprestDetails.Type = ImprestDetails.Type::"Fixed Asset" then GenJnLine."Account Type":=GenJnLine."Account Type"::"Fixed Asset"
    //                     else if ImprestDetails.Type = ImprestDetails.Type::"G/L Account" then GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account"
    //                         else if ImprestDetails.Type = ImprestDetails.Type::Vendor then GenJnLine."Account Type":=GenJnLine."Account Type"::Vendor;
    //                 GenJnLine."Account No.":=ImprestDetails."Account No";
    //                 GenJnLine."Posting Date":=ImprestHeader."Surrender Date";
    //                 GenJnLine."Document No.":=ImprestHeader."No.";
    //                 GenJnLine.Description:=ImprestDetails.Narration;
    //                 if(ImprestHeader."Currency Code" <> '') and (ImprestHeader."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", ImprestHeader."Currency Code");
    //                 GenJnLine.Amount:=ImprestDetails."Actual Spent";
    //                 GenJnLine.Validate(Amount);
    //                 GenJnLine."Shortcut Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //                 GenJnLine.Validate("Shortcut Dimension 1 Code");
    //                 GenJnLine."Shortcut Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //                 GenJnLine.Validate("Shortcut Dimension 2 Code");
    //                 GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::Customer;
    //                 if ImprestHeader."Staff Claim" then begin
    //                     if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Advances, ImprestHeader."Employee No.")then GenJnLine."Bal. Account No.":=EmployeeCustomerMapping."Customer AC";
    //                     GenJnLine.Validate("Bal. Account No.");
    //                 end
    //                 else
    //                 begin
    //                     if ImprestHeader."Payroll No." <> '' then GenJnLine."Bal. Account No.":=ImprestHeader."Payroll No."
    //                     else if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Travels, ImprestHeader."Employee No.")then GenJnLine."Bal. Account No.":=EmployeeCustomerMapping."Customer AC";
    //                 end;
    //                 GenJnLine.Validate("Bal. Account No.");
    //                 if GenJnLine.Amount <> 0 then GenJnLine.Insert;
    //             until ImprestDetails.Next = 0;
    //         end;
    //     end;
    // end;
    // procedure PostImprestRefund(var ImprestHeader: Record "Imprest Header")
    // var
    //     ClaimAmount: Decimal;
    // begin
    //     //CALCFIELDS("Net Refund (Net Claim)");
    //     Message(Text012, ImprestHeader."Net Refund (Net Claim)", ImprestHeader."Employee Name");
    //     Selection:=StrMenu(RefundSelectionString, 1);
    //     if Selection = 1 then begin //Receive Now
    //         Commit;
    //         if PAGE.RunModal(PAGE::"Receive Imprest Refund", ImprestHeader) = ACTION::LookupOK then begin
    //         end;
    //         Commit;
    //         AdvancedFinanceSetup.Get;
    //         GLSetup.Get;
    //         // Generate a Receipt
    //         //Receipt Header
    //         ReceiptsHeader.Init;
    //         ReceiptsHeader.Date:=ImprestHeader."Surrender Date";
    //         ReceiptsHeader."Pay Mode":=ImprestHeader."Receipt Mode";
    //         ReceiptsHeader."Receipt Type":=ReceiptsHeader."Receipt Type"::Normal;
    //         ReceiptsHeader."Cheque Date":=ImprestHeader."Surrender Date";
    //         ReceiptsHeader."Cheque No":=ImprestHeader."Receipt Tx No.(Cheque No.)";
    //         ReceiptsHeader."Bank Code":=ImprestHeader."Receiving Account";
    //         ReceiptsHeader."Received From":=ImprestHeader."Employee Name";
    //         ReceiptsHeader."On Behalf Of":=ImprestHeader."Payroll No.";
    //         ReceiptsHeader.Cashier:=UserId;
    //         ReceiptsHeader.Status:=ReceiptsHeader.Status::Closed;
    //         ReceiptsHeader.Posted:=true;
    //         ReceiptsHeader."Posted Date":=ImprestHeader."Surrender Date";
    //         ReceiptsHeader."Posted Time":=Time;
    //         ReceiptsHeader."Posted By":=UserId;
    //         ReceiptsHeader.Insert(true);
    //         //Receipt Lines
    //         ReceiptLines.Init;
    //         ReceiptLines."Receipt No.":=ReceiptsHeader."No.";
    //         ReceiptLines."Line No":=333333;
    //         ReceiptLines."Receipt Type":=ReceiptLines."Receipt Type"::Normal;
    //         ReceiptLines."Account Type":=ReceiptLines."Account Type"::Customer;
    //         ReceiptLines."Account No.":=ImprestHeader."Payroll No.";
    //         ReceiptLines.Validate("Account No.");
    //         ReceiptLines.Description:=CopyStr('Imprest Refund-' + ImprestHeader."Employee Name", 1, 50);
    //         ReceiptLines.Amount:=ImprestHeader."Net Refund (Net Claim)";
    //         ReceiptLines.Validate(Amount);
    //         ReceiptLines."Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //         ReceiptLines.Validate("Global Dimension 1 Code");
    //         ReceiptLines."Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //         ReceiptLines.Validate("Global Dimension 2 Code");
    //         ReceiptLines.Insert(true);
    //         GenJnLine.Init;
    //         GenJnLine."Journal Template Name":=AdvancedFinanceSetup."Imprest Template";
    //         GenJnLine."Journal Batch Name":=ImprestHeader."No.";
    //         GenJnLine."Line No.":=222222;
    //         GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account";
    //         GenJnLine."Account No.":=ImprestHeader."Receiving Account";
    //         GenJnLine."Posting Date":=ImprestHeader."Surrender Date";
    //         GenJnLine."Document No.":=ReceiptsHeader."No.";
    //         GenJnLine."External Document No.":=ImprestHeader."Receipt Tx No.(Cheque No.)";
    //         GenJnLine.Description:=CopyStr('Imprest Refund-' + ImprestHeader."Employee Name", 1, 50);
    //         if(ImprestHeader."Currency Code" <> '') and (ImprestHeader."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", ImprestHeader."Currency Code");
    //         GenJnLine.Amount:=ImprestHeader."Net Refund (Net Claim)";
    //         GenJnLine.Validate(Amount);
    //         GenJnLine."Shortcut Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //         GenJnLine.Validate("Shortcut Dimension 1 Code");
    //         GenJnLine."Shortcut Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //         GenJnLine.Validate("Shortcut Dimension 2 Code");
    //         GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::Customer;
    //         if ImprestHeader."Staff Claim" then begin
    //             if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Advances, ImprestHeader."Employee No.")then GenJnLine."Bal. Account No.":=EmployeeCustomerMapping."Customer AC";
    //         end
    //         else
    //         begin
    //             if ImprestHeader."Payroll No." <> '' then GenJnLine."Bal. Account No.":=ImprestHeader."Payroll No."
    //             else if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Travels, ImprestHeader."Employee No.")then GenJnLine."Bal. Account No.":=EmployeeCustomerMapping."Customer AC";
    //         end;
    //         GenJnLine.Validate("Bal. Account No.");
    //         if GenJnLine.Amount <> 0 then GenJnLine.Insert;
    //     end
    //     else
    //     begin //Deduct from Payroll
    //         ClaimAmount:=Abs(ImprestHeader."Net Refund (Net Claim)");
    //         PayrollCalc.InsertDeductionPayrollEntry(ImprestHeader."Employee No.", AdvancedFinanceSetup."Imprest Payroll Deduction Code", ClaimAmount);
    //     end;
    // end;
    // procedure PostImprestClaim(var ImprestHeader: Record "Imprest Header")
    // var
    //     Type: Option Payment, Deduction, "Saving Scheme", Loan, Informational;
    //     ClaimAmount: Decimal;
    // begin
    //     //CALCFIELDS("Net Refund (Net Claim)");
    //     Message(Text013, ImprestHeader."Net Refund (Net Claim)", ImprestHeader."Employee Name");
    //     Selection:=StrMenu(ClaimSelectionString, 1);
    //     if Selection = 1 then begin //Pay Now
    //         Commit;
    //         if PAGE.RunModal(PAGE::"Pay Imprest Claim", ImprestHeader) = ACTION::LookupOK then begin
    //         end;
    //         Commit;
    //         AdvancedFinanceSetup.Get;
    //         GLSetup.Get;
    //         GenJnLine.Init;
    //         GenJnLine."Journal Template Name":=AdvancedFinanceSetup."Imprest Template";
    //         GenJnLine."Journal Batch Name":=ImprestHeader."No.";
    //         GenJnLine."Line No.":=333333;
    //         GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
    //         if ImprestHeader."Staff Claim" then begin
    //             if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Advances, ImprestHeader."Employee No.")then GenJnLine."Account No.":=EmployeeCustomerMapping."Customer AC";
    //         end
    //         else
    //         begin
    //             if ImprestHeader."Payroll No." <> '' then GenJnLine."Account No.":=ImprestHeader."Payroll No."
    //             else if EmployeeCustomerMapping.Get(EmployeeCustomerMapping."Account Type"::Travels, ImprestHeader."Employee No.")then GenJnLine."Account No.":=EmployeeCustomerMapping."Customer AC";
    //         end;
    //         GenJnLine."Posting Date":=ImprestHeader."Surrender Date";
    //         GenJnLine."Document No.":=ImprestHeader."No.";
    //         GenJnLine."External Document No.":=ImprestHeader."Claim Payment Tx No";
    //         GenJnLine.Description:=CopyStr('Imprest Claim-' + ImprestHeader."Employee Name", 1, 50);
    //         if(ImprestHeader."Currency Code" <> '') and (ImprestHeader."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", ImprestHeader."Currency Code");
    //         GenJnLine.Amount:=Abs(ImprestHeader."Net Refund (Net Claim)");
    //         GenJnLine.Validate(Amount);
    //         GenJnLine."Shortcut Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //         GenJnLine.Validate("Shortcut Dimension 1 Code");
    //         GenJnLine."Shortcut Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //         GenJnLine.Validate("Shortcut Dimension 2 Code");
    //         GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::"Bank Account";
    //         GenJnLine."Bal. Account No.":=ImprestHeader."Claim Paying Account";
    //         GenJnLine.Validate("Bal. Account No.");
    //         if GenJnLine.Amount <> 0 then GenJnLine.Insert;
    //     end
    //     else
    //     begin //Pay from Payroll
    //         ClaimAmount:=Abs(ImprestHeader."Net Refund (Net Claim)");
    //         PayrollCalc.InsertEarningPayrollEntry(ImprestHeader."Employee No.", AdvancedFinanceSetup."Imprest Payroll Earning Code", ClaimAmount);
    //     end;
    // end;
    // procedure PostStaffClaim(var ImprestHeader: Record "Imprest Header")
    // var
    //     Type: Option Payment, Deduction, "Saving Scheme", Loan, Informational;
    //     ClaimAmount: Decimal;
    //     BankLedger: Record "Bank Account Ledger Entry";
    //     LineNo: Integer;
    // begin
    //     if ImprestHeader."Claim Posted" then Error(Text017);
    //     if ImprestHeader."Pay Mode" <> 'EFT' then begin
    //         ImprestHeader.TestField("Claim Pay Mode");
    //         ImprestHeader.TestField("Claim Paying Account");
    //         if ImprestHeader."Claim Pay Mode" <> 'CASH' then ImprestHeader.TestField("Claim Payment Tx No");
    //     end;
    //     //Check For Cash Availability
    //     //CheckForCashAvailability(ImprestHeader);
    //     ImprestHeader.CalcFields("Total Surrender Amount");
    //     AdvancedFinanceSetup.Get;
    //     GLSetup.Get;
    //     CMSetup.Get();
    //     // Delete Lines Present on the General Journal Line
    //     GenJnLine.Reset;
    //     GenJnLine.SetRange(GenJnLine."Journal Template Name", CMSetup."Cash/Claim  Template");
    //     GenJnLine.SetRange(GenJnLine."Journal Batch Name", ImprestHeader."No.");
    //     GenJnLine.DeleteAll;
    //     Batch.Init;
    //     Batch."Journal Template Name":=CMSetup."Cash/Claim  Template";
    //     Batch.Name:=ImprestHeader."No.";
    //     if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
    //     LineNo:=10000;
    //     //Debit Advance Customer & Credit Bank
    //     GenJnLine.Init;
    //     GenJnLine."Journal Template Name":=CMSetup."Cash/Claim  Template";
    //     GenJnLine."Journal Batch Name":=ImprestHeader."No.";
    //     GenJnLine."Line No.":=333333;
    //     GenJnLine."Account Type":=GenJnLine."Account Type"::Customer;
    //     if Emp.Get(ImprestHeader."Employee No.")then GenJnLine."Account No.":=Emp."Advancess Customer Account";
    //     GenJnLine."Posting Date":=ImprestHeader.Date;
    //     GenJnLine."Document No.":=ImprestHeader."No.";
    //     GenJnLine."External Document No.":=ImprestHeader."Claim Payment Tx No";
    //     GenJnLine.Description:=CopyStr('Staff Claim-' + ImprestHeader."Employee Name", 1, 50);
    //     if(ImprestHeader."Currency Code" <> '') and (ImprestHeader."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", ImprestHeader."Currency Code");
    //     GenJnLine.Amount:=ImprestHeader."Total Surrender Amount";
    //     GenJnLine.Validate(Amount);
    //     GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::"Bank Account";
    //     GenJnLine."Bal. Account No.":=ImprestHeader."Claim Paying Account";
    //     GenJnLine.Validate("Bal. Account No.");
    //     GenJnLine."Shortcut Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //     GenJnLine.Validate("Shortcut Dimension 1 Code");
    //     GenJnLine."Shortcut Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //     GenJnLine.Validate("Shortcut Dimension 2 Code");
    //     // GenJnLine."Shortcut Dimension 3 Code" := "Global Dimension 3 Code";
    //     // GenJnLine.Validate("Shortcut Dimension 3 Code");
    //     if GenJnLine.Amount <> 0 then GenJnLine.Insert;
    //     ImprestDetails.Reset();
    //     ImprestDetails.SetRange("No.", ImprestHeader."No.");
    //     If ImprestDetails.FindSet()then begin
    //         repeat //Debit expense And Credit Customer
    //             GenJnLine.Init;
    //             GenJnLine."Journal Template Name":=CMSetup."Cash/Claim  Template";
    //             GenJnLine."Journal Batch Name":=ImprestHeader."No.";
    //             GenJnLine."Line No.":=LineNo;
    //             GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
    //             GenJnLine."Account No.":=ImprestDetails."Account No";
    //             GenJnLine."Posting Date":=ImprestHeader.Date;
    //             GenJnLine."Document No.":=ImprestHeader."No.";
    //             GenJnLine."External Document No.":=ImprestHeader."Claim Payment Tx No";
    //             GenJnLine.Description:=CopyStr('Staff Claim-' + ImprestHeader."Employee Name", 1, 50);
    //             if(ImprestHeader."Currency Code" <> '') and (ImprestHeader."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", ImprestHeader."Currency Code");
    //             GenJnLine.Amount:=ImprestDetails."Actual Spent";
    //             GenJnLine.Validate(Amount);
    //             GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::Customer;
    //             if Emp.Get(ImprestHeader."Employee No.")then GenJnLine."Bal. Account No.":=Emp."Advancess Customer Account";
    //             GenJnLine.Validate("Bal. Account No.");
    //             GenJnLine."Shortcut Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //             GenJnLine.Validate("Shortcut Dimension 1 Code");
    //             GenJnLine."Shortcut Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //             GenJnLine.Validate("Shortcut Dimension 2 Code");
    //             // GenJnLine."Shortcut Dimension 3 Code" := "Global Dimension 3 Code";
    //             // GenJnLine.Validate("Shortcut Dimension 3 Code");
    //             if GenJnLine.Amount <> 0 then GenJnLine.Insert;
    //             LineNo:=LineNo + 1000;
    //         Until ImprestDetails.Next() = 0;
    //     end;
    //     CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
    //     BankLedger.Reset;
    //     BankLedger.SetCurrentKey(BankLedger."Document No.", BankLedger."Posting Date");
    //     BankLedger.SetRange(BankLedger."Document No.", ImprestHeader."No.");
    //     if BankLedger.Find('-')then begin
    //         ImprestHeader."Claim Posted":=true;
    //         ImprestHeader."Claim Posted By":=UserId;
    //         ImprestHeader."Claim Posted Date":=Today;
    //         ImprestHeader.Modify;
    //     end;
    // end;
    // procedure CreateImprestRequestPV(var ImprestHeader: Record "Imprest Header")
    // begin
    //     ImprestHeader.CalcFields("Total Request Amount");
    //     if ImprestHeader."Total Request Amount" = 0 then Error('There is no amount payable to the traveller on this ITO!');
    //     if Confirm(Text014, false) = true then begin
    //         if((ImprestHeader.Type <> ImprestHeader.Type::Request) AND (ImprestHeader.Status <> ImprestHeader.Status::Released))then Error(Text001, ImprestHeader."No.");
    //         ImprestHeader.TestField("Employee No.");
    //         ImprestHeader.TestField("Employee Name");
    //         if ImprestHeader."Request Posted" then Error(Text004, ImprestHeader."No.");
    //         GLSetup.Get;
    //         CMSetup.Get;
    //         AdvancedFinanceSetup.Get;
    //         //PV Header
    //         PV.Init;
    //         //PV."No." := '';
    //         PV."Payment Type":=PV."Payment Type"::"Payment Voucher";
    //         PV.Date:=Today;
    //         PV."Pay Mode":='RTGS/EFT';
    //         PV.Payee:=ImprestHeader."Employee Name" + '(' + ImprestHeader."No." + ')';
    //         PV."Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //         PV."Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //         PV.Insert(true);
    //         //Lines
    //         ImprestDetails.Reset;
    //         ImprestDetails.SetRange("No.", ImprestHeader."No.");
    //         ImprestDetails.SetRange(Decision, ImprestDetails.Decision::"Pay Cash to Traveller");
    //         if ImprestDetails.FindSet then begin
    //             repeat PVLines.Init;
    //                 PVLines.No:=PV."No.";
    //                 PVLines."Line No":=ImprestDetails."Line No";
    //                 PVLines."Account Type":=ImprestDetails.Type;
    //                 PVLines.Validate("Account No", ImprestDetails."Account No");
    //                 PVLines."Account Name":=ImprestDetails."Account Name";
    //                 PVLines.Description:=ImprestDetails.Narration;
    //                 PVLines.Validate("Currency Code", ImprestDetails."Currency Code");
    //                 PVLines.Validate(Amount, ImprestDetails."Request Amount");
    //                 PVLines."Global Dimension 1 Code":=ImprestDetails."Global Dimension 1 Code";
    //                 PVLines."Global Dimension 2 Code":=ImprestDetails."Global Dimension 2 Code";
    //                 PVLines.Insert;
    //                 ImprestDetails."PV No":=PV."No.";
    //                 ImprestDetails.Modify;
    //             until ImprestDetails.Next = 0;
    //         end;
    //         Message('Payment Voucher Number %1 has been created for this ITO.', PV."No.");
    //         PAGE.Run(50001, PV);
    //     /*
    //          "Request Posted":=TRUE;
    //          "Request Posted By":=USERID;
    //          "Request Posted Date":=TODAY;
    //          Type:=Type::Surrender;
    //          MODIFY;*/
    //     end;
    // end;
    // procedure ViewImprestRequestPVs(var ImprestHeader: Record "Imprest Header")
    // var
    //     FormerPVNo: Code[20];
    //     LatterPVNo: Code[20];
    // begin
    //     ImprestDetails.Reset;
    //     ImprestDetails.SetRange("No.", ImprestHeader."No.");
    //     ImprestDetails.SetFilter("PV No", '<>%1', '');
    //     if ImprestDetails.FindFirst then begin
    //         PV.Reset;
    //         PV.SetRange("No.", ImprestDetails."PV No");
    //         if PV.FindFirst then begin
    //             PAGE.RunModal(50028, PV, PV."No.");
    //         end;
    //     end;
    // end;
    // procedure CreateImprestRequestPO(var ImprestHeader: Record "Imprest Header")
    // var
    //     TempPO: Record "Requisition Review Temp PO" temporary;
    //     PurchOrderHeader: Record "Purchase Header";
    //     PurchOrderLine: Record "Purchase Line";
    //     Counter: Integer;
    // begin
    //     ImprestHeader.CalcFields("Total Request Amount", "Total ITO Cost");
    //     if ImprestHeader."Total Request Amount" = ImprestHeader."Total ITO Cost" then Error('There are no items to be ordered from services providers on this ITO!');
    //     if Confirm(Text015, false) = true then begin
    //         if((ImprestHeader.Type <> ImprestHeader.Type::Request) AND (ImprestHeader.Status <> ImprestHeader.Status::Released))then Error(Text001, ImprestHeader."No.");
    //         ImprestHeader.TestField("Employee No.");
    //         ImprestHeader.TestField("Employee Name");
    //         if ImprestHeader."Request Posted" then Error(Text004, ImprestHeader."No.");
    //         //***************************************************
    //         ImprestDetails.Reset;
    //         ImprestDetails.SetRange("No.", ImprestHeader."No.");
    //         ImprestDetails.SetRange(Decision, ImprestDetails.Decision::"Order from Service Provider");
    //         ImprestDetails.SetFilter(Supplier, '<>%1', '');
    //         if ImprestDetails.FindSet then begin
    //             repeat Counter:=Counter + 1;
    //                 //Keep PO Number
    //                 if not TempPO.Get(ImprestDetails.Supplier)then begin
    //                     //Create Header
    //                     PurchOrderHeader.Init;
    //                     PurchOrderHeader."Document Type":=PurchOrderHeader."Document Type"::Order;
    //                     PurchOrderHeader."No. Printed":=0;
    //                     PurchOrderHeader.Status:=PurchOrderHeader.Status::Open;
    //                     PurchOrderHeader."No.":='';
    //                     PurchOrderHeader."Requisition No":=ImprestHeader."No.";
    //                     PurchOrderHeader."Order Date":=Today;
    //                     PurchOrderHeader."Document Date":=Today;
    //                     PurchOrderHeader."Expected Receipt Date":=Today;
    //                     PurchOrderHeader."Shortcut Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //                     PurchOrderHeader."Shortcut Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //                     PurchOrderHeader."Posting Date":=WorkDate;
    //                     PurchOrderHeader.Insert(true);
    //                     PurchOrderHeader.Validate("Buy-from Vendor No.", ImprestDetails.Supplier);
    //                     PurchOrderHeader.Validate("Shortcut Dimension 1 Code", ImprestHeader."Global Dimension 1 Code");
    //                     PurchOrderHeader.Validate("Shortcut Dimension 2 Code", ImprestHeader."Global Dimension 2 Code");
    //                     PurchOrderHeader.Modify(true);
    //                     //Create Lines
    //                     PurchOrderLine.Init;
    //                     PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::Order;
    //                     PurchOrderLine."Document No.":=PurchOrderHeader."No.";
    //                     PurchOrderLine."Line No.":=Counter;
    //                     if ImprestDetails.Type = ImprestDetails.Type::"G/L Account" then begin
    //                         PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
    //                         PurchOrderLine.Validate("No.", ImprestDetails."Account No");
    //                     end
    //                     else if ImprestDetails.Type = ImprestDetails.Type::Item then begin
    //                             PurchOrderLine.Type:=PurchOrderLine.Type::Item;
    //                             PurchOrderLine.Validate("No.", ImprestDetails."Account No");
    //                         end
    //                         else if ImprestDetails.Type = ImprestDetails.Type::"Fixed Asset" then begin
    //                                 PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
    //                                 PurchOrderLine.Validate("No.", ImprestDetails."Account No");
    //                             end;
    //                     PurchOrderLine.Description:=CopyStr(ImprestDetails.Narration, 1, 250);
    //                     PurchOrderLine."Currency Code":=ImprestDetails."Currency Code";
    //                     PurchOrderLine.Validate(Quantity, ImprestDetails.Quantity);
    //                     PurchOrderLine.Validate("Unit of Measure Code", ImprestDetails.UoM);
    //                     PurchOrderLine.Validate("Direct Unit Cost", ImprestDetails."Unit Cost");
    //                     PurchOrderLine.Validate("Unit Cost", ImprestDetails."Request Amount");
    //                     PurchOrderLine.Validate("Shortcut Dimension 1 Code", ImprestDetails."Global Dimension 1 Code");
    //                     PurchOrderLine.Validate("Shortcut Dimension 2 Code", ImprestDetails."Global Dimension 2 Code");
    //                     PurchOrderLine.Insert;
    //                     ImprestDetails."PO No.":=PurchOrderHeader."No.";
    //                     ImprestDetails.Modify;
    //                     TempPO.Init;
    //                     TempPO."Vendor No.":=ImprestDetails.Supplier;
    //                     TempPO."PO No.":=PurchOrderHeader."No.";
    //                     TempPO.Insert;
    //                 end
    //                 else
    //                 begin
    //                     //Create Lines
    //                     PurchOrderLine.Init;
    //                     PurchOrderLine."Document Type":=PurchOrderLine."Document Type"::Order;
    //                     PurchOrderLine."Document No.":=TempPO."PO No.";
    //                     PurchOrderLine."Line No.":=Counter;
    //                     if ImprestDetails.Type = ImprestDetails.Type::"G/L Account" then begin
    //                         PurchOrderLine.Type:=PurchOrderLine.Type::"G/L Account";
    //                         PurchOrderLine.Validate("No.", ImprestDetails."Account No");
    //                     end
    //                     else if ImprestDetails.Type = ImprestDetails.Type::Item then begin
    //                             PurchOrderLine.Type:=PurchOrderLine.Type::Item;
    //                             PurchOrderLine.Validate("No.", ImprestDetails."Account No");
    //                         end
    //                         else if ImprestDetails.Type = ImprestDetails.Type::"Fixed Asset" then begin
    //                                 PurchOrderLine.Type:=PurchOrderLine.Type::"Fixed Asset";
    //                                 PurchOrderLine.Validate("No.", ImprestDetails."Account No");
    //                             end;
    //                     PurchOrderLine.Description:=CopyStr(ImprestDetails.Narration, 1, 250);
    //                     PurchOrderLine."Currency Code":=ImprestDetails."Currency Code";
    //                     PurchOrderLine.Validate(Quantity, ImprestDetails.Quantity);
    //                     PurchOrderLine.Validate("Unit of Measure Code", ImprestDetails.UoM);
    //                     PurchOrderLine.Validate("Direct Unit Cost", ImprestDetails."Unit Cost");
    //                     PurchOrderLine.Validate("Unit Cost", ImprestDetails."Request Amount");
    //                     PurchOrderLine.Validate("Shortcut Dimension 1 Code", ImprestDetails."Global Dimension 1 Code");
    //                     PurchOrderLine.Validate("Shortcut Dimension 2 Code", ImprestDetails."Global Dimension 2 Code");
    //                     PurchOrderLine.Insert;
    //                     ImprestDetails."PO No.":=PurchOrderHeader."No.";
    //                     ImprestDetails.Modify;
    //                 end;
    //             //******************************************************
    //             until ImprestDetails.Next = 0;
    //         end;
    //     end;
    // end;
    // procedure CreateRequestForPayment(var ImprestHeader: Record "Imprest Header")
    // begin
    //     ImprestHeader.CalcFields("Total Request Amount", "Total ITO Cost");
    //     if ImprestHeader."Staff Claim" then begin
    //         if ImprestHeader."Total ITO Cost" = 0 then Error('There is no amount payable to the staff on this Petty Cash Request!');
    //     end
    //     else if ImprestHeader."Total Request Amount" = 0 then Error('There is no amount payable to the traveller on this ITO!');
    //     if Confirm(Text016, false) = true then begin
    //         if((ImprestHeader.Type <> ImprestHeader.Type::Request) AND (ImprestHeader.Status <> ImprestHeader.Status::Released))then Error(Text001, ImprestHeader."No.");
    //         ImprestHeader.TestField("Employee No.");
    //         ImprestHeader.TestField("Employee Name");
    //         if ImprestHeader."Request Posted" then Error(Text004, ImprestHeader."No.");
    //         GLSetup.Get;
    //         CMSetup.Get;
    //         AdvancedFinanceSetup.Get;
    //         //Request For Payment
    //         Request.Init;
    //         Request.Date:=Today;
    //         Request."Created By":=UserId;
    //         Request."Source Document":=Request."Source Document"::"Travel Order";
    //         Request.Validate("Creditor No.", ImprestHeader."Payroll No.");
    //         Request.Insert(true);
    //         RequestLines.Init();
    //         RequestLines."No.":=Request."No.";
    //         RequestLines."Line No.":=10000;
    //         RequestLines."Source Document":=RequestLines."Source Document"::"Travel Order";
    //         RequestLines.Validate("Source Document No.", ImprestHeader."No.");
    //         RequestLines.Validate("Creditor No.", ImprestHeader."Payroll No.");
    //         RequestLines."Invoice No.":=ImprestHeader."No.";
    //         RequestLines."Currency Code":=ImprestHeader."Currency Code";
    //         RequestLines."Global Dimension 1 Code":=ImprestHeader."Global Dimension 1 Code";
    //         RequestLines."Global Dimension 2 Code":=ImprestHeader."Global Dimension 2 Code";
    //         RequestLines."Global Dimension 3 Code":=ImprestHeader."Global Dimension 3 Code";
    //         RequestLines."Being Payment for":=ImprestHeader.Justification;
    //         if ImprestHeader."Staff Claim" then RequestLines.Amount:=ImprestHeader."Total Surrender Amount"
    //         else
    //             RequestLines.Amount:=ImprestHeader."Total Request Amount";
    //         RequestLines.Insert(true);
    //         ImprestHeader."Request Posted":=true;
    //         ImprestHeader."Request Posted By":=UserId;
    //         ImprestHeader."Request Posted Date":=Today;
    //         ImprestHeader."Request Posted":=true;
    //         ImprestHeader.Modify;
    //         Message('Request for Payment Number %1 has been created for this ITO.', Request."No.");
    //     // PAGE.Run(Page::"Request for Payment", Request);
    //     end;
    // end;
    // procedure CheckForCashAvailability(var Header: Record "Imprest Header")
    // begin
    //     if((Header.Type = Header.Type::Request) and (Header."Staff Claim" = false))then begin
    //         if Header."Paying Bank Code" = '' then Error('The Paying Bank Code has not been specified!');
    //         if BankAccount.Get(Header."Paying Bank Code")then begin
    //             BankAccount.CalcFields(Balance);
    //             Header.CalcFields("Total Request Amount");
    //             if(BankAccount.Balance - Header."Total Request Amount") < BankAccount."Minimum Float" then Error('There is no sufficient cash for your request of %1 Shillings, you can only request for the %2 Shillings available.', Header."Total Request Amount", BankAccount.Balance - BankAccount."Minimum Float");
    //         end;
    //     end
    //     else if((Header.Type = Header.Type::Surrender) and (Header."Staff Claim" = true))then begin
    //             if Header."Paying Bank Code" = '' then Error('The Paying Bank Code has not been specified!');
    //             if BankAccount.Get(Header."Paying Bank Code")then begin
    //                 BankAccount.CalcFields(Balance);
    //                 Header.CalcFields("Total Surrender Amount");
    //                 if(BankAccount.Balance - Header."Total Request Amount") < BankAccount."Minimum Float" then Error('There is no sufficient cash for your request of %1 Shillings, you can only request for the %2 Shillings available.', Header."Total Surrender Amount", BankAccount.Balance - BankAccount."Minimum Float");
    //             end;
    //         end;
    // end;
    // procedure SubmitCashRetirement(var Retirement: Record "Imprest Header")
    // begin
    //     Retirement.Validate(Status, Retirement.Status::Released);
    //     Retirement."Surrender Date":=WorkDate;
    //     Retirement.Modify(true);
    // end;
    // procedure RejectCashRetirement(var Retirement: Record "Imprest Header")
    // begin
    //     Retirement.Validate(Status, Retirement.Status::Rejected);
    //     Retirement.Modify(true);
    // end;
    procedure CreateImprestMemoPR(var Memo: Record "Imprest Memo Header")
    var
        Lines: Record "Imprest Procurement Decision";
        PRHeader: Record "Requisition Header";
        PRLines: Record "Requisition Lines";
        UserSetup: Record "User Setup";
        Counter: Integer;
    begin
        if Memo."PR No." <> '' then if Confirm('A Purchase Requisition ' + Memo."PR No." + 'was already created for this Memo. Do you still wish to create another Requisition?', true) = false then exit;
        UserSetup.Get(UserId);
        UserSetup.TestField("Employee No.");
        Counter := 0;
        PRHeader.Init();
        PRHeader."Document Type" := PRHeader."Document Type"::"Purchase Requisition";
        PRHeader."Requisition Type" := PRHeader."Requisition Type"::"Purchase Requisition";
        PRHeader."Raised by" := UserId;
        PRHeader.Insert(true);
        PRHeader."PR Created" := false;
        PRHeader.Status := PRHeader.Status::Open;
        PRHeader."Employee Code" := UserSetup."Employee No.";
        PRHeader.Validate("Employee Code");
        PRHeader.Reason := CopyStr(Memo.Purpose, 1, 100);
        PRHeader.Modify();
        Lines.Reset();
        Lines.SetRange("Memo No.", Memo."No.");
        Lines.SetRange(Decision, Lines.Decision::"Order from Service Provider");
        if Lines.FindFirst() then begin
            repeat
                if Lines.Amount <> 0 then begin
                    Counter := Counter + 1;
                    PRLines.Init();
                    PRLines.Status := PRLines.Status::Open;
                    PRLines.Type := PRLines.Type::Expense;
                    PRLines."Requisition No" := PRHeader."No.";
                    PRLines."Requisition Type" := PRLines."Requisition Type"::"Purchase Requisition";
                    PRLines."Line No" := Counter;
                    PRLines.No := Lines."Expense Code";
                    PRLines.Validate(No);
                    PRLines."Unit of Measure" := 'EACH';
                    PRLines.Quantity := 1;
                    PRLines."Unit Price" := Lines.Amount;
                    PRLines.Validate("Unit Price");
                    PRLines.Amount := Lines.Amount;
                    PRLines."Global Dimension 1 Code" := Lines."Global Dimension 1 Code";
                    PRLines."Global Dimension 2 Code" := Lines."Global Dimension 2 Code";
                    PRLines.Insert();
                end;
            until Lines.Next() = 0;
        end;
        Memo."PR No." := PRHeader."No.";
        Memo.Modify();
        if PRHeader."No." <> '' then begin
            Message('Purchase Requisition ' + PRHeader."No." + ' has been created');
            Page.Run(Page::"SS Purch Requisition Header-Op", PRHeader);
        end;
    end;

    // procedure CreateImprestMemoPay(var Memo: Record "Imprest Memo Header")
    // var
    //     Lines: Record "Imprest Memo Lines";
    //     PRHeader: Record Payments;
    //     PRLines: Record "Payment Lines";
    //     Counter: Integer;
    //     LineNo: Code[20];
    //     NoSeries: Codeunit "No. Series";
    //     CashMgt: Record "Cash Management Setups";
    //     // Expense Codes (52103)
    //     ExpenseCodes: Record "Expense Codes";
    //     // Advanced Finance Setup (52102)
    //     AdvancedFinanceSetup: Record "Advanced Finance Setup";
    //     ReceiptsandPaymentTypes: Record "Receipts and Payment Types";
    // begin
    //     if not Confirm('An Imprest Requisition %1 was already created for this Memo. Do you still wish to create another?', true, Memo."PR No.") then
    //         exit;

    //     // Fetch setup record first
    //     CashMgt.Get();
    //     CashMgt.TestField("Imprest Nos");

    //     Counter := 0;

    //     Lines.Reset();
    //     Lines.SetRange("No.", Memo."No.");
    //     if Lines.FindSet() then begin
    //         repeat
    //             if Lines.Amount <> 0 then begin
    //                 Counter := Counter + 1;
    //                 LineNo := NoSeries.GetNextNo(CashMgt."Imprest Nos");
    //                 Message('Generated Line No: %1', LineNo);
    //                 PRHeader.Init();
    //                 PRHeader."No." := LineNo;
    //                 PRHeader."Payment Type" := PRHeader."Payment Type"::Imprest;
    //                 PRHeader.Date := Today;
    //                 PRHeader."Time Inserted" := Time;
    //                 PRHeader."Apply on behalf" := false;
    //                 if Lines.Type = Lines.Type::Expert then begin
    //                     PRHeader."On behalf of" := Lines.Name;
    //                     PRHeader."Account No." := UserId;
    //                     PRHeader."Account Name" := UserId;
    //                     PRHeader."Staff No." := Lines."Account No.";
    //                     PRHeader."Payment Narration" := CopyStr(Memo.Purpose + Lines.Name, 1, 100);
    //                 end else
    //                     PRHeader."Account No." := Lines."Account No.";
    //                 PRHeader."Account Name" := Lines.Name;
    //                 PRHeader."Staff No." := Lines."Account No.";
    //                 PRHeader."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
    //                 PRHeader."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
    //                 PRHeader."Payment Narration" := CopyStr(Memo.Purpose, 1, 100);
    //                 PRHeader.Status := PRHeader.Status::Open;
    //                 PRHeader."Date of Project" := Memo."Departure Date";
    //                 PRHeader."Travel Date" := Memo."Departure Date";
    //                 PRHeader."Due Date" := Today;
    //                 PRHeader."Salary Scale" := Lines."Job Group";
    //                 PRHeader."Date of Completion" := Memo."Return Date";
    //                 PRHeader."Created By" := UserId;
    //                 PRHeader.Destination := Memo."Activity Location";
    //                 PRHeader."No of Days" := Memo."Total Days in the Field";
    //                 PRHeader."Total Amount" := Lines.Amount;
    //                 PRHeader.Insert();
    //                 Counter := Counter + 1;


    //                 if Lines.DSA > 0 then begin
    //                     AdvancedFinanceSetup.Get();
    //                     AdvancedFinanceSetup.TestField("DSA Expense Code");
    //                     if ExpenseCodes.Get(AdvancedFinanceSetup."DSA Expense Code") then
    //                         ExpenseCodes.TestField("Account No");
    //                     Message('DSA Expense Code is: %1', ExpenseCodes."Account No");
    //                     ReceiptsandPaymentTypes.Get();
    //                     ReceiptsandPaymentTypes.SetCurrentKey("Account No.");
    //                     ReceiptsandPaymentTypes.SetRange("Account No.", ExpenseCodes."Account No");
    //                     if ReceiptsandPaymentTypes.FindFirst() then
    //                         Message('Receipt and Payment Type for DSA is: %1', ReceiptsandPaymentTypes.Code);
    //                     PRLines.Init();
    //                     PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
    //                     PRLines.Validate("Expenditure Type");
    //                     PRLines.No := PRHeader."No.";
    //                     PRLines."Line No" := 1;
    //                     PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
    //                     PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
    //                     PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
    //                     PRLines.Amount := Lines.DSA;
    //                     PRLines."Posted Date" := Today;
    //                     PRLines.Insert();
    //                 end;
    //                 if Lines.Conference > 0 then begin
    //                     AdvancedFinanceSetup.Get();
    //                     AdvancedFinanceSetup.TestField("Conference Expense Code");
    //                     if ExpenseCodes.Get(AdvancedFinanceSetup."Conference Expense Code") then
    //                         ExpenseCodes.TestField("Account No");
    //                     Message('Conference Expense Code is: %1', ExpenseCodes."Account No");
    //                     ReceiptsandPaymentTypes.Get();
    //                     ReceiptsandPaymentTypes.SetRange("Account No.", ExpenseCodes."Account No");
    //                     if ReceiptsandPaymentTypes.FindFirst() then
    //                         Message('Receipt and Payment Type for Conference is: %1', ReceiptsandPaymentTypes.Code);
    //                     PRLines.Init();
    //                     PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
    //                     PRLines.Validate("Expenditure Type");
    //                     PRLines.No := PRHeader."No.";
    //                     PRLines."Line No" := 2;
    //                     PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
    //                     PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
    //                     PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
    //                     PRLines.Amount := Lines.Conference;
    //                     PRLines."Posted Date" := Today;
    //                     PRLines.Insert();
    //                 end;





    //             end;
    //         until Lines.Next() = 0;
    //     end;

    //     if Counter > 0 then
    //         Message('%1 Imprest Payment line(s) created successfully.', Counter);
    // end;
    procedure CreateImprestMemoPay(var Memo: Record "Imprest Memo Header")
    var
        Lines: Record "Imprest Memo Lines";
        PRHeader: Record Payments;
        PRLines: Record "Payment Lines";
        Counter: Integer;
        LineCounter: Integer;
        LineNo: Code[20];
        NoSeries: Codeunit "No. Series";
        CashMgt: Record "Cash Management Setups";
        ExpenseCodes: Record "Expense Codes";
        AdvancedFinanceSetup: Record "Advanced Finance Setup";
        ReceiptsandPaymentTypes: Record "Receipts and Payment Types";
        DSAExpenseAcc: Code[20];
        AirTicketExpenseAcc: Code[20];
        ConferenceExpenseAcc: Code[20];
        GTransportExpenseAcc: Code[20];
        CordAllowExpenseAcc: Code[20];
        FacilitatorAllowExpenseAcc: Code[20];
        SecretariatAllowExpenseAcc: Code[20];
        OutOfPocketExpenseAcc: Code[20];
        RapporteurAllowExpenseAcc: Code[20];
        DriverAllowExpenseAcc: Code[20];
        RetreatAllowExpenseAcc: Code[20];
        ExpertAllowExpenseAcc: Code[20];
        AccommodationExpenseAcc: Code[20];
        TuitionExpenseAcc: Code[20];
        MileageExpenseAcc: Code[20];
        QtrPerDiemExpenseAcc: Code[20];
        othersExpenseAcc: Code[20];

    begin
        if not Confirm(
            'An Imprest Requisition %1 was already created for this Memo. Do you still wish to create another?',
            true, Memo."PR No.") then
            exit;

        // Fetch all setup records once before the loop
        CashMgt.Get();
        CashMgt.TestField("Imprest Nos");

        AdvancedFinanceSetup.Get();
        AdvancedFinanceSetup.TestField("DSA Expense Code");
        AdvancedFinanceSetup.TestField("Air Ticket Expense Code");
        AdvancedFinanceSetup.TestField("Conference Expense Code");
        AdvancedFinanceSetup.TestField("G.Transport Expense Code");
        AdvancedFinanceSetup.TestField("Cord. Allow Expense Code");
        AdvancedFinanceSetup.TestField("Facilitator Allow Expense Code");
        AdvancedFinanceSetup.TestField("Secretariat Allow Expense Code");
        AdvancedFinanceSetup.TestField("Out of Pocket Expense Code");
        AdvancedFinanceSetup.TestField("Rapporteur Allow Expense Code");
        AdvancedFinanceSetup.TestField("Driver Allow Expense Code");
        AdvancedFinanceSetup.TestField("Retreat Allow Expense Code");
        AdvancedFinanceSetup.TestField("Expert Allow Expense Code");
        AdvancedFinanceSetup.TestField("Accomodation Expense Code");
        AdvancedFinanceSetup.TestField("Tuition Expense Code");
        AdvancedFinanceSetup.TestField("Mileage Expense Code");
        AdvancedFinanceSetup.TestField("Qtr. Per Diem Expense Code");

        // Resolve DSA GL Account
        ExpenseCodes.Get(AdvancedFinanceSetup."DSA Expense Code");
        ExpenseCodes.TestField("Account No");
        DSAExpenseAcc := ExpenseCodes."Account No";
        //  Message('DSA Expense Account resolved to: %1', DSAExpenseAcc);

        // Resolve Conference GL Account
        ExpenseCodes.Get(AdvancedFinanceSetup."Conference Expense Code");
        ExpenseCodes.TestField("Account No");
        ConferenceExpenseAcc := ExpenseCodes."Account No";
        //  Message('Conference Expense Account resolved to: %1', ConferenceExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Air Ticket Expense Code");
        ExpenseCodes.TestField("Account No");
        AirTicketExpenseAcc := ExpenseCodes."Account No";
        //  Message('Air Ticket Expense Account resolved to: %1', AirTicketExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."G.Transport Expense Code");
        ExpenseCodes.TestField("Account No");
        GTransportExpenseAcc := ExpenseCodes."Account No";
        //  Message('G. Transport Expense Account resolved to: %1', GTransportExpenseAcc);  
        ExpenseCodes.Get(AdvancedFinanceSetup."Cord. Allow Expense Code");
        ExpenseCodes.TestField("Account No");
        CordAllowExpenseAcc := ExpenseCodes."Account No";
        //  Message('Cord. Allow Expense Account resolved to: %1', CordAllowExpenseAcc);    
        ExpenseCodes.Get(AdvancedFinanceSetup."Facilitator Allow Expense Code");
        ExpenseCodes.TestField("Account No");
        FacilitatorAllowExpenseAcc := ExpenseCodes."Account No";
        //  Message('Facilitator Allow Expense Account resolved to: %1', FacilitatoratorAllowExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Secretariat Allow Expense Code");
        ExpenseCodes.TestField("Account No");
        SecretariatAllowExpenseAcc := ExpenseCodes."Account No";
        //  Message('Secretariat Allow Expense Account resolved to: %1', SecretariatAllowExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Out of Pocket Expense Code");
        ExpenseCodes.TestField("Account No");
        OutOfPocketExpenseAcc := ExpenseCodes."Account No";
        //  Message('Out of Pocket Expense Account resolved to: %1', OutOfPocketExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Rapporteur Allow Expense Code");
        ExpenseCodes.TestField("Account No");
        RapporteurAllowExpenseAcc := ExpenseCodes."Account No";
        //  Message('Rapporteur Allow Expense Account resolved to: %1', RapporteurAllowExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Driver Allow Expense Code");
        ExpenseCodes.TestField("Account No");
        DriverAllowExpenseAcc := ExpenseCodes."Account No";
        //  Message('Driver Allow Expense Account resolved to: %1', DriverAllowExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Retreat Allow Expense Code");
        ExpenseCodes.TestField("Account No");
        RetreatAllowExpenseAcc := ExpenseCodes."Account No";
        //  Message('Retreat Allow Expense Account resolved to: %1', RetreatAllowExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Expert Allow Expense Code");
        ExpenseCodes.TestField("Account No");
        ExpertAllowExpenseAcc := ExpenseCodes."Account No";
        //  Message('Expert Allow Expense Account resolved to: %1', ExpertAllowExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Accomodation Expense Code");
        ExpenseCodes.TestField("Account No");
        AccommodationExpenseAcc := ExpenseCodes."Account No";
        //  Message('Accommodation Expense Account resolved to: %1', AccommodationExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Tuition Expense Code");
        ExpenseCodes.TestField("Account No");
        TuitionExpenseAcc := ExpenseCodes."Account No";
        //  Message('Tuition Expense Account resolved to: %1', TuitionExpenseAcc);  
        ExpenseCodes.Get(AdvancedFinanceSetup."Mileage Expense Code");
        ExpenseCodes.TestField("Account No");
        MileageExpenseAcc := ExpenseCodes."Account No";
        //  Message('Mileage Expense Account resolved to: %1', MileageExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Qtr. Per Diem Expense Code");
        ExpenseCodes.TestField("Account No");
        QtrPerDiemExpenseAcc := ExpenseCodes."Account No";
        //  Message('Qtr. Per Diem Expense Account resolved to: %1', QtrPerDiemExpenseAcc);
        ExpenseCodes.Get(AdvancedFinanceSetup."Others Expense Code");
        ExpenseCodes.TestField("Account No");
        OthersExpenseAcc := ExpenseCodes."Account No";


        Counter := 0;

        Lines.Reset();
        Lines.SetRange("No.", Memo."No.");
        if Lines.FindSet() then begin
            repeat
                if Lines.Amount <> 0 then begin
                    Counter += 1;
                    LineNo := NoSeries.GetNextNo(CashMgt."Imprest Nos");

                    PRHeader.Init();
                    PRHeader."No." := LineNo;
                    PRHeader."Payment Type" := PRHeader."Payment Type"::Imprest;
                    PRHeader."Account Type" := PRHeader."Account Type"::Customer;
                    PRHeader.Date := Today;
                    PRHeader."Time Inserted" := Time;
                    PRHeader."Apply on behalf" := false;
                    PRHeader."Account Name" := Lines.Name;
                    PRHeader."Staff No." := Lines."Account No.";
                    PRHeader."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                    PRHeader."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                    PRHeader."Payment Narration" := CopyStr(Memo.Purpose, 1, 100);
                    PRHeader.Status := PRHeader.Status::Open;
                    PRHeader."Date of Project" := Memo."Departure Date";
                    PRHeader."Travel Date" := Memo."Departure Date";
                    PRHeader."Due Date" := Today;
                    PRHeader."Salary Scale" := Lines."Job Group";
                    PRHeader."Date of Completion" := Memo."Return Date";
                    PRHeader."Created By" := UserId;
                    PRHeader.Destination := Memo."Activity Location";
                    PRHeader."No of Days" := Memo."Total Days in the Field";
                    PRHeader."Total Amount" := Lines.Amount;
                    PRHeader.Payee := Lines.Name;
                    if Lines.Type = Lines.Type::Expert then begin
                        PRHeader."Apply on behalf" := true;
                        PRHeader."On behalf of" := Lines.Name;
                        PRHeader."Account No." := UserId;
                        PRHeader."Account Name" := UserId;
                        PRHeader.Payee := Lines.Name;
                        PRHeader."Staff No." := Lines."Account No.";
                        PRHeader."Payment Narration" := CopyStr(Memo.Purpose, 1, 100);
                    end else
                        PRHeader."Account No." := Lines."Account No.";

                    PRHeader.Insert();

                    LineCounter := 0;

                    // DSA Line
                    if Lines.DSA > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", DSAExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for DSA Account %1', DSAExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := DSAExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines."Daily Rate" := Lines.DSA;
                        PRLines.Amount := Lines.DSA * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines.Insert();
                    end;
                    //air ticket line
                    if Lines."Air Ticket" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", AirTicketExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Air Ticket Account %1', AirTicketExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := AirTicketExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Air Ticket";
                        PRLines."Daily Rate" := Lines."Air Ticket";
                        PRLines."Posted Date" := Today;
                        PRLines.Insert();
                    end;
                    // // Conference Line
                    // if Lines.Conference > 0 then begin
                    //     ReceiptsandPaymentTypes.Reset();
                    //     ReceiptsandPaymentTypes.SetRange("Account No.", ConferenceExpenseAcc);
                    //     if not ReceiptsandPaymentTypes.FindFirst() then
                    //         Error('No Receipt and Payment Type found for Conference Account %1', ConferenceExpenseAcc);

                    //     LineCounter += 1;
                    //     PRLines.Init();
                    //     PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                    //     PRLines.Validate("Expenditure Type");
                    //     PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                    //     PRLines."Account No" := ConferenceExpenseAcc;
                    //     PRLines.Validate("Account No");
                    //     PRLines."No of Days" := Memo."Total Days in the Field";
                    //     PRLines.No := PRHeader."No.";

                    //     PRLines."Line No" := LineCounter;
                    //     PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                    //     PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                    //     PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                    //     PRLines.Amount := Lines.Conference * Memo."Total Days in the Field";
                    //     PRLines."Daily Rate" := Lines.Conference;
                    //     PRLines."Posted Date" := Today;
                    //     PRLines.Insert();
                    // end;
                    //G.Transport Expense Code"
                    if Lines."Ground Transport" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", GTransportExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for G. Transport Account %1', GTransportExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := GTransportExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Ground Transport";
                        PRLines."Daily Rate" := Lines."Ground Transport";
                        PRLines."Posted Date" := Today;
                        PRLines.Insert();
                    end;
                    // Cord. Allow Expense Code
                    if Lines."Cordination Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", CordAllowExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Cord. Allow Account %1', CordAllowExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := CordAllowExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Cordination Allowance" * Memo."Total Days in the Field";
                        PRLines."Daily Rate" := Lines."Cordination Allowance";
                        PRLines."Posted Date" := Today;
                        PRLines.Insert();
                    end;
                    // Facilitator Allow Expense Code
                    if Lines."Facilitator Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", FacilitatorAllowExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Facilitator Allow Account %1', FacilitatorAllowExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := FacilitatorAllowExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Facilitator Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Facilitator Allowance";
                        PRLines.Insert();
                    end;
                    // Secretariat Allow Expense Code
                    if Lines."Secretariat Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", SecretariatAllowExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Secretariat Allow Account %1', SecretariatAllowExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := SecretariatAllowExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Secretariat Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Secretariat Allowance";
                        PRLines.Insert();
                    end;
                    // Out of Pocket Expense Code
                    if Lines."Out of Pocket Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", OutOfPocketExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Out of Pocket Allow Account %1', OutOfPocketExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := OutOfPocketExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Out of Pocket Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Out of Pocket Allowance";
                        PRLines.Insert();
                    end;
                    // Rapporteur Allow Expense Code
                    if Lines."Rapporteur Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", RapporteurAllowExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Rapporteur Allow Account %1', RapporteurAllowExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := RapporteurAllowExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Rapporteur Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Rapporteur Allowance";
                        PRLines.Insert();
                    end;
                    // Driver Allow Expense Code
                    if Lines."Driver Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", DriverAllowExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Driver Allow Account %1', DriverAllowExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := DriverAllowExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Driver Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Driver Allowance";
                        PRLines.Insert();
                    end;
                    // Retreat Allow Expense Code
                    if Lines."Retreat Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", RetreatAllowExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Retreat Allow Account %1', RetreatAllowExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := RetreatAllowExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Retreat Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Retreat Allowance";
                        PRLines.Insert();
                    end;
                    // Expert Allow Expense Code
                    if Lines."Expert Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", ExpertAllowExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Expert Allow Account %1', ExpertAllowExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := ExpertAllowExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Expert Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Expert Allowance";
                        PRLines.Insert();
                    end;
                    // Accommodation Expense Code
                    if Lines.Accomodation > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", AccommodationExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Accommodation Account %1', AccommodationExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := AccommodationExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines.Accomodation * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines.Accomodation;
                        PRLines.Insert();
                    end;
                    // Tuition Expense Code
                    if Lines."Tuition Fee" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", TuitionExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Tuition Account %1', TuitionExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := TuitionExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Tuition Fee" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Tuition Fee";
                        PRLines.Insert();
                    end;
                    // Mileage Expense Code
                    if Lines."Mileage Allowance" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", MileageExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Mileage Account %1', MileageExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := MileageExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Mileage Allowance" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Mileage Allowance";
                        PRLines.Insert();
                    end;
                    // Qtr. Per Diem Expense Code
                    if Lines."Quarter Per Diem" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", QtrPerDiemExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Qtr. Per Diem Account %1', QtrPerDiemExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := QtrPerDiemExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := CopyStr(Memo.Purpose, 1, 100);
                        PRLines.Amount := Lines."Quarter Per Diem" * Memo."Total Days in the Field";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Quarter Per Diem";
                        PRLines.Insert();
                    end;
                    if Lines."Other Costs" > 0 then begin
                        ReceiptsandPaymentTypes.Reset();
                        ReceiptsandPaymentTypes.SetRange("Account No.", OthersExpenseAcc);
                        if not ReceiptsandPaymentTypes.FindFirst() then
                            Error('No Receipt and Payment Type found for Others Expense Account %1', OthersExpenseAcc);

                        LineCounter += 1;
                        PRLines.Init();
                        PRLines."Expenditure Type" := ReceiptsandPaymentTypes.Code;
                        PRLines.Validate("Expenditure Type");
                        PRLines."Account Name" := ReceiptsandPaymentTypes.Description;
                        PRLines."Account No" := OthersExpenseAcc;
                        PRLines.Validate("Account No");
                        PRLines."No of Days" := Memo."Total Days in the Field";
                        PRLines.No := PRHeader."No.";
                        PRLines."Line No" := LineCounter;
                        PRLines."Shortcut Dimension 1 Code" := Lines."Global Dimension 1 Code";
                        PRLines."Shortcut Dimension 2 Code" := Lines."Global Dimension 2 Code";
                        PRLines.Description := Memo.Purpose + ' - ' + Lines.Description;
                        PRLines.Amount := Lines."Other Costs";
                        PRLines."Posted Date" := Today;
                        PRLines."Daily Rate" := Lines."Other Costs";
                        PRLines.Insert();
                    end;

                end;
            until Lines.Next() = 0;
        end;

        if Counter > 0 then
            Message('%1 Imprest Payment header(s) created successfully.', Counter);
    end;

    procedure CreateImprestPayrollClaims(var Memo: Record "Imprest Memo Header")
    var
        ClaimHeader: Record "Imprest Payroll Claims Header";
    begin
        if Memo."Payroll Claim No." <> '' then if Confirm('A Payroll Claim ' + Memo."Payroll Claim No." + 'was already created for this Memo. Do you still wish to create another Imprest Payroll Claim?', true) = false then exit;
        ClaimHeader.Init();
        ClaimHeader.TransferFields(Memo);
        ClaimHeader."No." := '';
        ClaimHeader.Date := Today;
        ClaimHeader."Imprest Memo" := Memo."No.";
        ClaimHeader.Status := ClaimHeader.Status::Open;
        ClaimHeader.Insert(true);
        ClaimHeader.Validate("Imprest Memo", Memo."No.");
        Memo."Payroll Claim No." := ClaimHeader."No.";
        Memo.Modify();
        if ClaimHeader."No." <> '' then begin
            Message('Imprest Payroll Claim ' + ClaimHeader."No." + ' has been created');
            Page.Run(Page::"Imprest Payroll Claim Header", ClaimHeader);
        end;
    end;

    procedure ProcessImprestClaimsToPayroll(var PayrollClaim: Record "Imprest Payroll Claims Header")
    var
        PayrollMgt: Codeunit "Client Payroll Calculator";
        Lines: Record "Imprest Payroll Claim Lines";
    begin
        if PayrollClaim.Status <> PayrollClaim.Status::Released then Error('The payroll claims are not yet approved');
        Lines.Reset();
        Lines.SetRange("No.", PayrollClaim."No.");
        if Lines.FindFirst() then begin
            repeat
                Lines.TestField("Payroll Code");
                Lines.TestField("Employee No");
                Lines.TestField("Payroll Earning Code");
                if Lines.Amount > 0 then PayrollMgt.InsertEarningPayrollEntry(Lines."Payroll Code", Lines."Employee No", Lines."Payroll Earning Code", Lines.Amount);
            until Lines.Next() = 0;
        end;
        Message('Completed');
    end;
}
