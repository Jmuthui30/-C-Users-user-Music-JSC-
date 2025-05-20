codeunit 52101 "Petty Cash Management"
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
    // ********************************************
    trigger OnRun()
    begin
    end;
    var Text000: Label 'Are you sure you want to post the Petty Cash?';
    Text001: Label 'The Petty Cash No %1 has not been fully approved.';
    Text002: Label 'The customer account number for %1 has not been created.';
    Text003: Label 'The petty cash amount cannot be zero.';
    Text004: Label 'The petty cash %1 has been posted.';
    GLSetup: Record "General Ledger Setup";
    CMSetup: Record "Cash Management Setup";
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    GenJnLine: Record "Gen. Journal Line";
    Batch: Record "Gen. Journal Batch";
    LineNo: Integer;
    GLEntry: Record "G/L Entry";
    PettyCashDetails: Record "Expense Claim Details";
    BankAccount: Record "Bank Account";
    procedure PostPettyCash(var PettyCash: Record "Expense Claim Header")
    begin
        if Confirm(Text000, false) = true then begin
            if PettyCash.Status <> PettyCash.Status::Released then Error(Text001, PettyCash."No.");
            PettyCash.TestField("Employee No.");
            PettyCash.TestField("Employee Name");
            PettyCash.TestField("Paying Account Code");
            PettyCash.TestField(Date);
            PettyCash.TestField("Pay Mode");
            if PettyCash."Pay Mode" <> 'CASH' then PettyCash.TestField("Payment Tx No.(Cheque No.)");
            if PettyCash."Pay Mode" = 'CHEQUE' then PettyCash.TestField("Cheque Date");
            //Check if the  Lines have been populated
            PettyCash.CalcFields("Total Amount");
            if PettyCash."Total Amount" = 0 then Error(Text003);
            if PettyCash.Posted then Error(Text004, PettyCash."No.");
            GLSetup.Get;
            CMSetup.Get;
            AdvancedFinanceSetup.Get;
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", AdvancedFinanceSetup."Petty Cash Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", PettyCash."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            Batch."Journal Template Name":=AdvancedFinanceSetup."Petty Cash Template";
            Batch.Name:=PettyCash."No.";
            if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
            //Bank
            LineNo:=10000;
            GenJnLine.Init;
            GenJnLine."Journal Template Name":=AdvancedFinanceSetup."Petty Cash Template";
            GenJnLine."Journal Batch Name":=PettyCash."No.";
            GenJnLine."Line No.":=LineNo;
            GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No.":=PettyCash."Paying Account Code";
            GenJnLine."Posting Date":=PettyCash.Date;
            GenJnLine."Document No.":=PettyCash."No.";
            GenJnLine."External Document No.":=PettyCash."Payment Tx No.(Cheque No.)";
            GenJnLine.Description:=PettyCash."Employee Name";
            if(PettyCash."Currency Code" <> '') and (PettyCash."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", PettyCash."Currency Code");
            GenJnLine.Amount:=-PettyCash."Total Amount";
            GenJnLine.Validate(Amount);
            GenJnLine."Shortcut Dimension 1 Code":=PettyCash."Global Dimension 1 Code";
            GenJnLine.Validate("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code":=PettyCash."Global Dimension 2 Code";
            GenJnLine.Validate("Shortcut Dimension 2 Code");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Expenses
            PettyCashDetails.Reset;
            PettyCashDetails.SetRange(No, PettyCash."No.");
            if PettyCashDetails.Find('-')then begin
                repeat LineNo:=LineNo + 1000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name":=AdvancedFinanceSetup."Petty Cash Template";
                    GenJnLine."Journal Batch Name":=PettyCash."No.";
                    GenJnLine."Line No.":=LineNo;
                    if PettyCashDetails.Type = PettyCashDetails.Type::Customer then GenJnLine."Account Type":=GenJnLine."Account Type"::Customer
                    else if PettyCashDetails.Type = PettyCashDetails.Type::"Fixed Asset" then GenJnLine."Account Type":=GenJnLine."Account Type"::"Fixed Asset"
                        else if PettyCashDetails.Type = PettyCashDetails.Type::"G/L Account" then GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account"
                            else if PettyCashDetails.Type = PettyCashDetails.Type::Vendor then GenJnLine."Account Type":=GenJnLine."Account Type"::Vendor;
                    GenJnLine."Account No.":=PettyCashDetails."Account No";
                    GenJnLine."Posting Date":=PettyCash.Date;
                    GenJnLine."Document No.":=PettyCash."No.";
                    GenJnLine.Description:=PettyCashDetails.Description;
                    if(PettyCash."Currency Code" <> '') and (PettyCash."Currency Code" <> GLSetup."LCY Code")then GenJnLine.Validate("Currency Code", PettyCash."Currency Code");
                    GenJnLine.Amount:=PettyCashDetails.Amount;
                    GenJnLine.Validate(Amount);
                    GenJnLine."Shortcut Dimension 1 Code":=PettyCashDetails."Global Dimension 1 Code";
                    GenJnLine.Validate("Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PettyCashDetails."Global Dimension 2 Code";
                    GenJnLine.Validate("Shortcut Dimension 2 Code");
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                until PettyCashDetails.Next = 0;
            end;
            //
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", PettyCash."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            GLEntry.SetRange("Posting Date", PettyCash.Date);
            if GLEntry.FindFirst then begin
                PettyCash.Posted:=true;
                PettyCash."Posted By":=UserId;
                PettyCash."Posted Date":=Today;
                PettyCash.Modify;
            end;
        end;
    end;
    procedure CheckForCashAvailability(var PettyCashHeader: Record "Expense Claim Header")
    begin
        if PettyCashHeader."Paying Account Code" = '' then Error('The Paying Bank Code has not been specified!');
        if BankAccount.Get(PettyCashHeader."Paying Account Code")then begin
            BankAccount.CalcFields(Balance);
            PettyCashHeader.CalcFields("Total Amount");
            if(BankAccount.Balance - PettyCashHeader."Total Amount") < BankAccount."Minimum Float" then Error('There is no sufficient cash for your request of %1 Shillings, you can only request for the %2 Shillings available.', PettyCashHeader."Total Amount", BankAccount.Balance - BankAccount."Minimum Float");
        end;
    end;
}
