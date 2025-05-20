codeunit 50000 "Finance Management"
{
    // version THL-Basic Fin 1.0
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
    // Sacco:   61423 - 62422 = ***
    // ***********************
    trigger OnRun()
    begin
    end;
    var CMSetup: Record "Cash Management Setup";
    Batch: Record "Gen. Journal Batch";
    Text000: Label 'There is a remaining amount of %1 are you sure you want to create a receipt for this amount?';
    Text001: Label '&Post and Create &Receipt,&Post';
    UncommittmentDate: Date;
    PayrollSetup: Record "QuantumJumps Payroll Setup";
    PayrollMgt: Codeunit "Payroll Calculator";
    Currencies: Record Currency;
    RegEx: Codeunit Regex;
    Text0001: Label 'The following are the only Spaecial Characters you can use (.,%_-).';
    Text0002: Label 'One or more selected record is not VENDOR (account type), Kindly select only vendor Transactions';
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    EFTLines: Record "EFT Lines";
    PVLine: Record "PV Lines";
    Vendor: Record Vendor;
    EmploeeBankAcc: Record "Employee Bank Account";
    procedure PostReceipt(RptHeader: Record "Receipts Header")
    var
        GenJnLine: Record "Gen. Journal Line";
        RcptLine: Record "Receipt Lines";
        LineNo: Integer;
        Batch: Record "Gen. Journal Batch";
        GLEntry: Record "G/L Entry";
        Text000: Label 'Are you sure you want to post the receipt no ';
        Text001: Label 'The Receipt has been posted';
    begin
        if Confirm(Text000 + ' ' + RptHeader."No." + ' ?') = true then begin
            if RptHeader.Posted then Error(Text001);
            RptHeader.TestField("Bank Code");
            RptHeader.TestField("Pay Mode");
            RptHeader.TestField("Received From");
            RptHeader.TestField(Date);
            if RptHeader."Pay Mode" = 'CHEQUE' then begin
                RptHeader.TestField("Cheque No");
                RptHeader.TestField("Cheque Date");
            end;
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", CMSetup."Receipt Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", RptHeader."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get()then Batch."Journal Template Name":=CMSetup."Receipt Template";
            Batch.Name:=RptHeader."No.";
            if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
            //Post Bank entries
            RptHeader.CalcFields(RptHeader.Amount);
            LineNo:=LineNo + 1000;
            GenJnLine.Init;
            GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
            GenJnLine."Journal Batch Name":=RptHeader."No.";
            GenJnLine."Line No.":=LineNo;
            GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No.":=RptHeader."Bank Code";
            GenJnLine."Posting Date":=RptHeader.Date;
            GenJnLine."Document No.":=RptHeader."No.";
            GenJnLine.Description:=RptHeader.Description;
            GenJnLine.Amount:=RptHeader.Amount;
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."External Document No.":=RptHeader."Cheque No";
            GenJnLine."Currency Code":=RptHeader."Currency Code";
            GenJnLine.Validate(GenJnLine."Currency Code");
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code", RptHeader."Global Dimension 1 Code");
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code", RptHeader."Global Dimension 2 Code");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //Post the receipt lines
            RcptLine.SetRange(RcptLine."Receipt No.", RptHeader."No.");
            if RcptLine.FindFirst then begin
                repeat RcptLine.Validate(Amount);
                    LineNo:=LineNo + 1000;
                    GenJnLine.Init;
                    GenJnLine."Journal Template Name":=CMSetup."Receipt Template";
                    GenJnLine."Journal Batch Name":=RptHeader."No.";
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine.Validate("Account Type", RcptLine."Account Type");
                    GenJnLine."Account No.":=RcptLine."Account No.";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    GenJnLine."Posting Date":=RptHeader.Date;
                    GenJnLine."Document No.":=RptHeader."No.";
                    GenJnLine.Description:=RptHeader.Description;
                    GenJnLine.Amount:=-RcptLine."Net Amount";
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."External Document No.":=RptHeader."Cheque No";
                    GenJnLine."Currency Code":=RptHeader."Currency Code";
                    GenJnLine.Validate(GenJnLine."Currency Code");
                    GenJnLine."Shortcut Dimension 1 Code":=RcptLine."Global Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=RcptLine."Global Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                until RcptLine.Next = 0;
            end;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", RptHeader."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                RptHeader.Posted:=true;
                RptHeader."Posted Date":=Today;
                RptHeader."Posted Time":=Time;
                RptHeader."Posted By":=UserId;
                RptHeader.Modify;
            end;
        end;
    end;
    procedure "Post Payment Voucher"(PV: Record "PV Header")
    var
        PVLines: Record "PV Lines";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TarriffCodes: Record Document;
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
    begin
        if Confirm('Are u sure u want to post the Payment Voucher No. ' + PV."No." + ' ?') = true then begin
            if PV.Status <> PV.Status::Released then Error('The Payment Voucher No %1 has not been fully approved', PV."No.");
            if PV.Posted then Error('Payment Voucher %1 has been posted', PV."No.");
            PV.TestField(Date);
            PV.TestField("Paying Bank Account");
            PV.TestField(PV.Payee);
            PV.TestField(PV."Pay Mode");
            if PV."Pay Mode" = 'CHEQUE' then begin
                PV.TestField(PV."External Document No");
                PV.TestField(PV."External Document Date");
            end;
            //Check Lines
            PV.CalcFields("Total Amount");
            if PV."Total Amount" = 0 then Error('Amount is cannot be zero');
            PVLines.Reset;
            PVLines.SetRange(PVLines.No, PV."No.");
            if not PVLines.FindLast then Error('Payment voucher Lines cannot be empty');
            CMSetup.Get();
            // Delete Lines Present on the General Journal Line
            GenJnLine.Reset;
            GenJnLine.SetRange(GenJnLine."Journal Template Name", CMSetup."Payment Voucher Template");
            GenJnLine.SetRange(GenJnLine."Journal Batch Name", PV."No.");
            GenJnLine.DeleteAll;
            Batch.Init;
            if CMSetup.Get()then Batch."Journal Template Name":=CMSetup."Payment Voucher Template";
            Batch.Name:=PV."No.";
            if not Batch.Get(Batch."Journal Template Name", Batch.Name)then Batch.Insert;
            //Bank Entries
            LineNo:=LineNo + 10000;
            GenJnLine.Init;
            if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
            GenJnLine."Journal Batch Name":=PV."No.";
            GenJnLine."Line No.":=LineNo;
            GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No.":=PV."Paying Bank Account";
            GenJnLine.Validate(GenJnLine."Account No.");
            if PV.Date = 0D then Error('You must specify the PV date');
            GenJnLine."Posting Date":=PV.Date;
            GenJnLine."Document No.":=PV."No.";
            GenJnLine."External Document No.":=PV."External Document No";
            GenJnLine.Description:=PVLines.Description;
            GenJnLine.Validate("Currency Code", PV.Currency);
            GenJnLine.Amount:=-PV."Total Amount";
            GenJnLine.Validate(GenJnLine.Amount);
            GenJnLine."Shortcut Dimension 1 Code":=PV."Global Dimension 1 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code":=PV."Global Dimension 2 Code";
            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            //PV Lines Entries
            PVLines.Reset;
            PVLines.SetRange(PVLines.No, PV."No.");
            if PVLines.FindFirst then begin
                repeat PVLines.Validate(PVLines.Amount);
                    //Debit Payable
                    GenJnLine.Init;
                    LineNo:=LineNo + 10000;
                    if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name":=PV."No.";
                    GenJnLine."Line No.":=LineNo;
                    GenJnLine."Account Type":=PVLines."Account Type";
                    GenJnLine."Account No.":=PVLines."Account No";
                    GenJnLine.Validate(GenJnLine."Account No.");
                    if PV.Date = 0D then Error('You must specify the PV date');
                    GenJnLine."Posting Date":=PV.Date;
                    GenJnLine."Document No.":=PV."No.";
                    GenJnLine."External Document No.":=PV."External Document No";
                    GenJnLine.Description:=PVLines.Description;
                    GenJnLine.Validate("Currency Code", PVLines."Currency Code");
                    GenJnLine.Amount:=PVLines."Net Amount";
                    GenJnLine.Validate(GenJnLine.Amount);
                    GenJnLine."Shortcut Dimension 1 Code":=PVLines."Global Dimension 1 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code":=PVLines."Global Dimension 2 Code";
                    GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                    GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                    GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                    GenJnLine.Validate(GenJnLine."Applies-to Doc. No.");
                    if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    //Post VAT
                    if CMSetup."Post VAT" then begin
                        if PVLines."VAT Code" <> '' then begin
                            PVLines.Validate(PVLines.Amount);
                            LineNo:=LineNo + 10000;
                            GenJnLine.Init;
                            if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                            GenJnLine."Journal Batch Name":=PV."No.";
                            GenJnLine."Line No.":=LineNo;
                            GenJnLine."Account Type":=PVLines."Account Type";
                            GenJnLine."Account No.":=PVLines."Account No";
                            GenJnLine.Validate(GenJnLine."Account No.");
                            if PV.Date = 0D then Error('You must specify the PV date');
                            GenJnLine."Posting Date":=PV.Date;
                            GenJnLine."Document No.":=PV."No.";
                            GenJnLine."External Document No.":=PV."External Document No";
                            GenJnLine.Description:=PVLines.Description;
                            GenJnLine.Validate("Currency Code", PVLines."Currency Code");
                            GenJnLine.Amount:=PVLines."VAT Amount";
                            GenJnLine.Validate(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.Validate("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group":='';
                            GenJnLine.Validate("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group":='';
                            GenJnLine.Validate("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group":='';
                            GenJnLine.Validate("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group":='';
                            GenJnLine.Validate("VAT Prod. Posting Group");
                            //
                            GenJnLine."Shortcut Dimension 1 Code":=PVLines."Global Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code":=PVLines."Global Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                            LineNo:=LineNo + 10000;
                            GenJnLine.Init;
                            if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                            GenJnLine."Journal Batch Name":=PV."No.";
                            GenJnLine."Line No.":=LineNo;
                            GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                            case PVLines."Account Type" of PVLines."Account Type"::"G/L Account": begin
                                GLAccount.Get(PVLines."Account No");
                                GLAccount.TestField("VAT Bus. Posting Group");
                                if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."VAT Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                                GenJnLine.Validate(GenJnLine."Account No.");
                            end;
                            PVLines."Account Type"::Vendor: begin
                                Vendor.Get(PVLines."Account No");
                                Vendor.TestField("VAT Bus. Posting Group");
                                if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."VAT Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                                GenJnLine.Validate(GenJnLine."Account No.");
                            end;
                            PVLines."Account Type"::Customer: begin
                                Customer.Get(PVLines."Account No");
                                Customer.TestField("VAT Bus. Posting Group");
                                if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."VAT Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                                GenJnLine.Validate(GenJnLine."Account No.");
                            end;
                            end;
                            if PV.Date = 0D then Error('You must specify the PV date');
                            GenJnLine."Posting Date":=PV.Date;
                            GenJnLine."Document No.":=PV."No.";
                            GenJnLine."External Document No.":=PV."External Document No";
                            GenJnLine.Description:=PVLines.Description;
                            GenJnLine.Validate("Currency Code", PVLines."Currency Code");
                            GenJnLine.Amount:=-PVLines."VAT Amount";
                            GenJnLine.Validate(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.Validate("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group":='';
                            GenJnLine.Validate("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group":='';
                            GenJnLine.Validate("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group":='';
                            GenJnLine.Validate("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group":='';
                            GenJnLine.Validate("VAT Prod. Posting Group");
                            //
                            GenJnLine."Shortcut Dimension 1 Code":=PVLines."Global Dimension 1 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code":=PVLines."Global Dimension 2 Code";
                            GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        end;
                    //End of Posting VAT
                    end;
                    //Post Withholding Tax
                    if PVLines."W/Tax Code" <> '' then begin
                        PVLines.Validate(PVLines.Amount);
                        //Debit Payable Account Withholding Tax Amount;
                        LineNo:=LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name":=PV."No.";
                        GenJnLine."Line No.":=LineNo;
                        GenJnLine."Account Type":=PVLines."Account Type";
                        GenJnLine."Account No.":=PVLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        if PV.Date = 0D then Error('You must specify the PV date');
                        GenJnLine."Posting Date":=PV.Date;
                        GenJnLine."Document No.":=PV."No.";
                        GenJnLine."External Document No.":=PV."External Document No";
                        GenJnLine.Description:=PVLines.Description;
                        GenJnLine.Validate("Currency Code", PVLines."Currency Code");
                        GenJnLine.Amount:=PVLines."W/Tax Amount";
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group":='';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group":='';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group":='';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group":='';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Global Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code":=PVLines."Global Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        //Credit Withholding Tax Account;
                        LineNo:=LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name":=PV."No.";
                        GenJnLine."Line No.":=LineNo;
                        GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                        case PVLines."Account Type" of PVLines."Account Type"::"G/L Account": begin
                            GLAccount.Get(PVLines."Account No");
                            GLAccount.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."W/Tax Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.Validate(GenJnLine."Account No.");
                        end;
                        PVLines."Account Type"::Vendor: begin
                            Vendor.Get(PVLines."Account No");
                            Vendor.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."W/Tax Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.Validate(GenJnLine."Account No.");
                        end;
                        PVLines."Account Type"::Customer: begin
                            Customer.Get(PVLines."Account No");
                            Customer.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."W/Tax Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.Validate(GenJnLine."Account No.");
                        end;
                        end;
                        if PV.Date = 0D then Error('You must specify the PV date');
                        GenJnLine."Posting Date":=PV.Date;
                        GenJnLine."Document No.":=PV."No.";
                        GenJnLine."External Document No.":=PV."External Document No";
                        GenJnLine.Description:=PVLines.Description;
                        GenJnLine.Validate("Currency Code", PVLines."Currency Code");
                        GenJnLine.Amount:=-PVLines."W/Tax Amount";
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group":='';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group":='';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group":='';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group":='';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Global Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code":=PVLines."Global Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        // GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::Invoice;
                        // GenJnLine."Applies-to Doc. No." := PVLines."Applies to Doc. No";
                        // GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    end;
                    //End of Posting Withholding Tax 
                    //Post Stamp Duty Tax
                    if PVLines."Stamp Duty Code" <> '' then begin
                        PVLines.Validate(PVLines.Amount);
                        //Debit Payable Account Stamp Duty Tax Amount;
                        LineNo:=LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name":=PV."No.";
                        GenJnLine."Line No.":=LineNo;
                        GenJnLine."Account Type":=PVLines."Account Type";
                        GenJnLine."Account No.":=PVLines."Account No";
                        GenJnLine.Validate(GenJnLine."Account No.");
                        if PV.Date = 0D then Error('You must specify the PV date');
                        GenJnLine."Posting Date":=PV.Date;
                        GenJnLine."Document No.":=PV."No.";
                        GenJnLine."External Document No.":=PV."External Document No";
                        GenJnLine.Description:=PVLines.Description;
                        GenJnLine.Validate("Currency Code", PVLines."Currency Code");
                        GenJnLine.Amount:=PVLines."Stamp Duty Amount";
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group":='';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group":='';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group":='';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group":='';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Global Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code":=PVLines."Global Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                        //Credit Stamp Duty Payable Account;
                        LineNo:=LineNo + 10000;
                        GenJnLine.Init;
                        if CMSetup.Get then GenJnLine."Journal Template Name":=CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name":=PV."No.";
                        GenJnLine."Line No.":=LineNo;
                        GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account";
                        case PVLines."Account Type" of PVLines."Account Type"::"G/L Account": begin
                            GLAccount.Get(PVLines."Account No");
                            GLAccount.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(GLAccount."VAT Bus. Posting Group", PVLines."W/Tax Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.Validate(GenJnLine."Account No.");
                        end;
                        PVLines."Account Type"::Vendor: begin
                            Vendor.Get(PVLines."Account No");
                            Vendor.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(Vendor."VAT Bus. Posting Group", PVLines."W/Tax Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.Validate(GenJnLine."Account No.");
                        end;
                        PVLines."Account Type"::Customer: begin
                            Customer.Get(PVLines."Account No");
                            Customer.TestField("VAT Bus. Posting Group");
                            if VATSetup.Get(Customer."VAT Bus. Posting Group", PVLines."W/Tax Code")then GenJnLine."Account No.":=VATSetup."Purchase VAT Account";
                            GenJnLine.Validate(GenJnLine."Account No.");
                        end;
                        end;
                        if PV.Date = 0D then Error('You must specify the PV date');
                        GenJnLine."Posting Date":=PV.Date;
                        GenJnLine."Document No.":=PV."No.";
                        GenJnLine."External Document No.":=PV."External Document No";
                        GenJnLine.Description:=PVLines.Description;
                        GenJnLine.Validate("Currency Code", PVLines."Currency Code");
                        GenJnLine.Amount:=-PVLines."Stamp Duty Amount";
                        GenJnLine.Validate(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type":=GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.Validate("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group":='';
                        GenJnLine.Validate("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group":='';
                        GenJnLine.Validate("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group":='';
                        GenJnLine.Validate("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group":='';
                        GenJnLine.Validate("VAT Prod. Posting Group");
                        //
                        GenJnLine."Shortcut Dimension 1 Code":=PVLines."Global Dimension 1 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code":=PVLines."Global Dimension 2 Code";
                        GenJnLine.Validate(GenJnLine."Shortcut Dimension 2 Code");
                        if GenJnLine.Amount <> 0 then GenJnLine.Insert;
                    end;
                    //End of Posting Stamp Duty Tax
                    PVLines.Posted:=true;
                    PVLines."Posted Date":=Today;
                    PVLines."Posted Time":=Time;
                    PVLines.Modify;
                until PVLines.Next = 0;
            end;
            CODEUNIT.Run(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.Reset;
            GLEntry.SetRange(GLEntry."Document No.", PV."No.");
            GLEntry.SetRange(GLEntry.Reversed, false);
            if GLEntry.FindFirst then begin
                PV.Posted:=true;
                PV."Posted By":=UserId;
                PV."Posted Date":=Today;
                PV."Time Posted":=Time;
                PV.Modify;
                //Create Imprest Surrender in the event the document originated from an imprest.
                if PV."Original Document" = PV."Original Document"::Imprest then begin
                    PV."Payment Type":=PV."Payment Type"::"Imprest Surrender";
                    PV.Status:=PV.Status::Open;
                    PV.Modify;
                end;
            end;
        end;
    end;
    procedure CodeRegExChecker(var Variable: Code[50])
    begin
        AdvancedFinanceSetup.Get();
        AdvancedFinanceSetup.TestField("Narration Pattern");
        If RegEx.IsMatch(Variable, AdvancedFinanceSetup."Narration Pattern", 0)then Error(Text0001);
    end;
    procedure TextRegExChecker(var Variable: Text[250])
    begin
        AdvancedFinanceSetup.Get();
        AdvancedFinanceSetup.TestField("Narration Pattern");
        If RegEx.IsMatch(Variable, AdvancedFinanceSetup."Narration Pattern", 0)then Error(Text0001);
    end;
}
