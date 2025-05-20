codeunit 52104 "Cash Management"
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
    var EFTEntries: Record "EFT Entries";
    CompInfo: Record "Company Information";
    GenLedSetup: Record "General Ledger Setup";
    Countries: Record "Country/Region";
    ExcelBuf: Record "Excel Buffer";
    PVHeader: Record "PV Header";
    CashMgtSetup: Record "Cash Management Setup";
    TempCSVBuffer: Record "CSV Buffer" temporary;
    BankRec: Record "Bank Account";
    PVLines: Record "PV Lines";
    Counter: Integer;
    TotalAmount: Decimal;
    SN: Integer;
    Text0002: Label 'One or more selected record is not VENDOR (account type), Kindly select only vendor Transactions';
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    EFTLines: Record "EFT Lines";
    dup: Dialog;
    PVLine: Record "PV Lines";
    Vendor: Record Vendor;
    EmploeeBankAcc: Record "Employee Bank Account";
    Payment: Record "PV Header";
    FinanceMgt: Codeunit "Finance Management";
    isautopost: Boolean;
    ImprestHeader: Record "Imprest Header";
    ImprestManagement: Codeunit "Imprest Management";
    LineNo: Integer;
    ImprestLines: Record "Imprest Details";
    EmployeeMaster: Record "Employee Master";
    CommercialBanks: Record "Commercial Banks";
    TotalTaxPercent: Decimal;
    TotalPercent: Decimal;
    EFTPost: Codeunit EFTPost;
    resp: Text;
    CashMgnt: Codeunit "Cash Management";
    EFTHeaderCount: Record "EFT Header";
    EFTHeader_Check: Record "EFT Header";
    EFTNo: Code[20];
    procedure InsertEFTEntries(var BankCode: Code[10]; var BranchCode: Code[10]; var AccNo: Code[20]; var BenName: Text; var Amount: Decimal; var Remarks: Text)
    begin
        CompInfo.Get;
        GenLedSetup.Get;
        EFTEntries.Init;
        //EFTEntries."Paying Account" := CompInfo."Bank Account No.";
        EFTEntries.Date:=Today;
        EFTEntries."Bank Code":=BankCode;
        EFTEntries."Branch Code":=BranchCode;
        EFTEntries."Receiving Account":=AccNo;
        EFTEntries."Account Name":=BenName;
        EFTEntries.Amount:=Amount;
        EFTEntries.Reference:=Remarks;
        /*IF Currency = '' THEN
        EFTEntries.Currency := GenLedSetup."LCY Code"
        ELSE
        EFTEntries.Currency := Currency;
        EFTEntries."Receiving Bank" := RecevingBank;
        IF Countries.GET(CompInfo."Country/Region Code") THEN
        EFTEntries."Source Country" := Countries.Name;
        EFTEntries."Receiving Country" := EFTEntries."Source Country";
        EFTEntries.City := CompInfo.City;
        EFTEntries."Country Code" := CompInfo."Country/Region Code";
        EFTEntries."Bank Swift" := CompInfo."SWIFT Code";
        */
        EFTEntries.Insert;
    end;
    procedure GenerateEFTFile()
    begin
        //Before Anything
        ExcelBuf.DeleteAll;
        //Create Header
        /* BEGIN
         ExcelBuf.NewRow;
         ExcelBuf.AddColumn('DATE',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
         ExcelBuf.AddColumn('BANK CODE',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
         ExcelBuf.AddColumn('BRANCH CODE',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
         ExcelBuf.AddColumn('ACC NO.',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
         ExcelBuf.AddColumn('BEN NAME',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
         ExcelBuf.AddColumn('AMOUNT',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
         ExcelBuf.AddColumn('REFERENCE',FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
         END;*/
        //
        EFTEntries.Reset;
        EFTEntries.SetCurrentKey("File Generated");
        EFTEntries.SetRange("File Generated", false);
        if EFTEntries.Find('-')then begin
            repeat ExcelBuf.NewRow;
                ExcelBuf.AddColumn(Format(EFTEntries.Date, 0, '<Day,2>/<Month,2>/<Year4>'), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(EFTEntries."Bank Code", false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(PadStr('', 3 - StrLen(EFTEntries."Branch Code"), '0') + EFTEntries."Branch Code", false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(EFTEntries."Receiving Account", false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(EFTEntries."Account Name", false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(Format(EFTEntries.Amount, 0, '<Standard Format,2>'), false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(EFTEntries.Reference, false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
            until EFTEntries.Next = 0;
        end;
    //After Everything
    //ExcelBuf.CreateBookAndOpenExcel('', 'EFT PAYMENT', 'EFT PAYMENT', CompanyName, UserId);
    end;
    procedure NICOnlineEFT(RefNo: Code[20])
    var
        CustCSVFile: File;
        CSVStream: OutStream;
        IsExported: Boolean;
        FromFile: Text;
        ToFile: Text;
        Text000: Label 'The NIC Online EFT File submission is completed';
        Text001: Label 'The Submission Failed';
    begin
        CashMgtSetup.Get;
        PVHeader.Reset;
        PVHeader.SetRange("No.", RefNo);
        // CustCSVFile.Create(CashMgtSetup."EFT Files Path" + DelChr(RefNo, '=', '!|@|#|$|%|/|\') + '-EFT.csv');
        // CustCSVFile.CreateOutStream(CSVStream);
        IsExported:=XMLPORT.Export(XMLPORT::"NIC EFT File", CSVStream, PVHeader);
        //FromFile := CustCSVFile.Name;
        ToFile:=RefNo + '-EFT.csv';
        //CustCSVFile.Close;
        if IsExported then begin
            Message(Text000);
        end
        else
            Message(Text001);
    end;
    procedure NICOnlineEFTWithHeaders(RefNo: Code[20])
    var
        Text000: Label 'The NIC Online EFT File submission is completed';
        Text001: Label 'The Submission Failed';
    begin
        //Header
        if PVHeader.Get(RefNo)then begin
            if BankRec.Get(PVHeader."Paying Bank Account")then TempCSVBuffer.InsertEntry(1, 1, BankRec."Bank Account No.");
            TempCSVBuffer.InsertEntry(1, 2, 'Vendor Payment');
            TempCSVBuffer.InsertEntry(1, 3, 'M');
            TempCSVBuffer.InsertEntry(1, 4, Format(Today, 0, '<Day,2>/<Month,2>/<Year4>'));
            TempCSVBuffer.InsertEntry(1, 5, 'NIC.EFT');
            TempCSVBuffer.InsertEntry(1, 6, PVHeader."No.");
            TempCSVBuffer.InsertEntry(1, 7, 'KES');
            //Body
            TempCSVBuffer.InsertEntry(2, 1, Format(Today, 0, '<Day,2>/<Month,2>/<Year4>'));
            TempCSVBuffer.InsertEntry(2, 2, PVHeader."Payee Bank Code");
            TempCSVBuffer.InsertEntry(2, 3, PadStr('', 3 - StrLen(PVHeader."Branch Code"), '0') + PVHeader."Branch Code");
            TempCSVBuffer.InsertEntry(2, 4, Format(PVHeader."Payee Account No."));
            TempCSVBuffer.InsertEntry(2, 5, PVHeader."Payee Account Name");
            PVHeader.CalcFields("Total Amount", "Total Amount LCY");
            if(PVHeader.Currency = '') or (PVHeader.Currency = 'KES')then TempCSVBuffer.InsertEntry(2, 6, Format(PVHeader."Total Amount", 0, '<Precision,2><sign><Integer><Decimals,3>'))
            else
                TempCSVBuffer.InsertEntry(2, 6, Format(PVHeader."Total Amount LCY", 0, '<Precision,2><sign><Integer><Decimals,3>'));
            TempCSVBuffer.InsertEntry(2, 7, PVHeader."No.");
        //Footer
        end;
        //Save
        TempCSVBuffer.InsertEntry(3, 1, '1');
        TempCSVBuffer.InsertEntry(3, 2, '');
        TempCSVBuffer.InsertEntry(3, 3, '');
        TempCSVBuffer.InsertEntry(3, 4, '');
        TempCSVBuffer.InsertEntry(3, 5, '');
        PVHeader.CalcFields("Total Amount", "Total Amount LCY");
        if(PVHeader.Currency = '') or (PVHeader.Currency = 'KES')then TempCSVBuffer.InsertEntry(3, 6, Format(PVHeader."Total Amount", 0, '<Precision,2><sign><Integer><Decimals,3>'))
        else
            TempCSVBuffer.InsertEntry(3, 6, Format(PVHeader."Total Amount LCY", 0, '<Precision,2><sign><Integer><Decimals,3>'));
        TempCSVBuffer.InsertEntry(3, 7, '');
        //
        CashMgtSetup.Get;
        //TempCSVBuffer.SaveData(CashMgtSetup."EFT Files Path" + DelChr(RefNo, '=', '!|@|#|$|%|/|\') + '-EFT.csv', ',');
        Message(Text000);
    end;
    procedure NICOnlineMPESA(RefNo: Code[20])
    var
        Text000: Label 'The NIC Online MMTS File submission is completed';
        Text001: Label 'The Submission Failed';
    begin
        Counter:=1;
        //Header
        if PVHeader.Get(RefNo)then begin
            if BankRec.Get(PVHeader."Paying Bank Account")then TempCSVBuffer.InsertEntry(1, 1, BankRec."Bank Account No.");
            TempCSVBuffer.InsertEntry(1, 2, 'Vendor Payment');
            TempCSVBuffer.InsertEntry(1, 3, 'M');
            TempCSVBuffer.InsertEntry(1, 4, Format(Today, 0, '<Day,2>/<Month,2>/<Year4>'));
            TempCSVBuffer.InsertEntry(1, 5, 'MMTS');
            TempCSVBuffer.InsertEntry(1, 6, PVHeader."No.");
            TempCSVBuffer.InsertEntry(1, 7, 'KES');
            TempCSVBuffer.InsertEntry(1, 8, '');
            TempCSVBuffer.InsertEntry(1, 9, '');
            TempCSVBuffer.InsertEntry(1, 10, '');
            SN:=0;
            PVLines.Reset;
            PVLines.SetRange(No, PVHeader."No.");
            if PVLines.FindSet then begin
                repeat //Body
                    Counter:=Counter + 1;
                    TempCSVBuffer.InsertEntry(Counter, 1, Format(Today, 0, '<Year4><Month,2><Day,2>'));
                    CashMgtSetup.Get;
                    TempCSVBuffer.InsertEntry(Counter, 2, '');
                    TempCSVBuffer.InsertEntry(Counter, 3, Format(PVLines."M-Pesa Phone No."));
                    TempCSVBuffer.InsertEntry(Counter, 4, PVLines."Account Name");
                    TempCSVBuffer.InsertEntry(Counter, 5, '');
                    TempCSVBuffer.InsertEntry(Counter, 6, '');
                    TempCSVBuffer.InsertEntry(Counter, 7, '');
                    TempCSVBuffer.InsertEntry(Counter, 8, Format(PVLines."Net Amount", 0, '<Precision,2><sign><Integer><Decimals,3>'));
                    TempCSVBuffer.InsertEntry(Counter, 9, PVHeader."No.");
                    SN:=SN + 1;
                until PVLines.Next = 0;
            end;
            //Footer
            Counter:=Counter + 1;
            TempCSVBuffer.InsertEntry(Counter, 1, Format(SN));
            TempCSVBuffer.InsertEntry(Counter, 2, '');
            TempCSVBuffer.InsertEntry(Counter, 3, '');
            TempCSVBuffer.InsertEntry(Counter, 4, '');
            TempCSVBuffer.InsertEntry(Counter, 5, '');
            PVHeader.CalcFields("Total Amount", "Total Amount LCY");
            if(PVHeader.Currency = '') or (PVHeader.Currency = 'KES')then TempCSVBuffer.InsertEntry(Counter, 6, Format(PVHeader."Total Amount", 0, '<Precision,2><sign><Integer><Decimals,3>'))
            else
                TempCSVBuffer.InsertEntry(Counter, 6, Format(PVHeader."Total Amount LCY", 0, '<Precision,2><sign><Integer><Decimals,3>'));
            TempCSVBuffer.InsertEntry(Counter, 7, '');
            TempCSVBuffer.InsertEntry(Counter, 8, '');
            TempCSVBuffer.InsertEntry(Counter, 9, '');
            TempCSVBuffer.InsertEntry(Counter, 10, '');
            //
            CashMgtSetup.Get;
            //TempCSVBuffer.SaveData(CashMgtSetup."EFT Files Path" + DelChr(RefNo, '=', '!|@|#|$|%|/|\') + '-MMTS.csv', ',');
            Message(Text000);
        end;
    end;
    procedure PostPVEFT(PVHeader: Record "PV Header"; EFTHeader: Record "EFT Header")
    begin
        PVHeader.TestField("Pay Mode");
        PVHeader.TestField(Payee);
        PVHeader.TestField("Sort Code");
        //  Payment2.TESTFIELD("Total Amount");
        PVHeader.CalcFields("Total Amount");
        PVLine.Reset;
        PVLine.SetRange(No, PVHeader."No.");
        if PVLine.FindFirst then begin
            if PVLine."Account Type" <> PVLine."Account Type"::Vendor then Error(Text0002);
            EFTLines."Vendor Code":=PVLine."Account No";
            EFTLines."Vendor Name":=PVLine."Account Name";
            EFTLines."Account No":=PVLine."Account No";
            EFTLines."Account Name":=PVLine."Account Name";
            EFTLines.Description:=PVLine.Description;
        end;
        EFTLines."EFT No":=EFTHeader.No;
        EFTLines."PV No":=PVHeader."No.";
        EFTLines."Sort Code":=PVHeader."Sort Code";
        EFTLines.Payee:=PVHeader.Payee;
        EFTLines."Bank Account No":=PVHeader."Payee Account No.";
        EFTLines.Amount:=PVHeader."Total Amount";
        EFTLines.Insert(true);
        PVHeader.EFT_No:=EFTHeader.No;
        PVHeader.Modify(true);
    end;
    procedure PostStaffClaimEFT(StaffClaim: Record "Imprest Header"; EFTHeader: Record "EFT Header")
    begin
        StaffClaim.TestField("Claim Pay Mode");
        StaffClaim.TestField("Employee No.");
        StaffClaim.CalcFields("Total Surrender Amount");
        EFTLines."EFT No":=EFTHeader.No;
        EFTLines."PV No":=StaffClaim."No.";
        EFTLines.Amount:=StaffClaim."Total Surrender Amount";
        EFTLines.Payee:=StaffClaim."Employee Name";
        EFTLines."Account No":=StaffClaim."Payroll No.";
        EFTLines."Account Name":=StaffClaim."Employee Name";
        if EmployeeMaster.Get(StaffClaim."Employee No.")then begin
            EmployeeMaster.TestField("Bank Account Number");
            EmployeeMaster.TestField("Bank Code");
            EmployeeMaster.TestField("Bank Branch");
            EFTLines."Bank Account No":=EmployeeMaster."Bank Account Number";
            if CommercialBanks.Get(EmployeeMaster."Bank Code")then EFTLines."Bank Name":=CommercialBanks.Name;
            EFTLines."Sort Code":=EmployeeMaster."Bank Branch";
        end;
        // emploeebankacc.Reset;
        // emploeebankacc.SetRange(Code, EmployeeMaster."Bank Code");
        // if emploeebankacc.FindFirst then begin
        //     emploeebankacc.TestField("Bank Branch No.");
        //     "Sort Code" := emploeebankacc."Bank Branch No.";
        // end;
        StaffClaim.Description:=ImprestLines.Narration;
        if StaffClaim.Description = '' then StaffClaim.Description:=Format(EFTHeader."Process Module") + ' for ' + StaffClaim."No.";
        EFTLines.Insert(true);
        StaffClaim."EFT No":=EFTHeader.No;
        //"Claim Paying Account" := '111001';
        StaffClaim."Claim Payment Tx No":=EFTHeader.No;
        StaffClaim.Modify(true);
    end;
    procedure PostCashAdvanceEFT(CashAdvance: Record "Imprest Header"; EFTHeader: Record "EFT Header")
    begin
        CashAdvance.TestField("Pay Mode");
        CashAdvance.TestField("Employee No.");
        ImprestLines.Reset;
        ImprestLines.SetRange("No.", CashAdvance."No.");
        ImprestLines.FindFirst;
        CashAdvance.CalcFields("Total Request Amount");
        EFTLines."EFT No":=EFTHeader.No;
        EFTLines."PV No":=CashAdvance."No.";
        EFTLines.Amount:=CashAdvance."Total Request Amount";
        EFTLines.Payee:=CashAdvance."Employee Name";
        EFTLines."Account No":=CashAdvance."Payroll No.";
        EFTLines."Account Name":=CashAdvance."Employee Name";
        if EmployeeMaster.Get(CashAdvance."Employee No.")then begin
            EmployeeMaster.TestField("Bank Account Number");
            EmployeeMaster.TestField("Bank Code");
            EmployeeMaster.TestField("Bank Branch");
            EFTLines."Bank Account No":=EmployeeMaster."Bank Account Number";
            if CommercialBanks.Get(EmployeeMaster."Bank Code")then EFTLines."Bank Name":=CommercialBanks.Name;
            EFTLines."Sort Code":=EmployeeMaster."Bank Branch";
        // emploeebankacc.Reset;
        // emploeebankacc.SetRange(Code, EmployeeMaster."Bank Code");
        // if emploeebankacc.FindFirst then
        //     "Sort Code" := emploeebankacc."Bank Branch No.";
        end;
        EFTLines.Description:=ImprestLines.Narration;
        if EFTLines.Description = '' then EFTLines.Description:=Format(EFTHeader."Process Module") + ' for ' + CashAdvance."No.";
        EFTLines.Insert(true);
        CashAdvance."EFT No":=EFTHeader.No;
        CashAdvance."Claim Paying Account":='111001';
        CashAdvance."Payment Tx No.(Cheque No.)":=EFTHeader.No;
        CashAdvance.Modify;
    end;
    procedure SendEmail(var EFTHeader: Record "EFT Header")
    var
        attachmentName: Text;
        filemgt: Codeunit "File Management";
        pathcode: Text;
        generalMail: List of[Text];
        PVReport: Report "Payment Voucher";
        pathcode2: Text;
        npayment: Record "PV Header";
        imprestheader: Record "Imprest Header";
        mail: Codeunit "Email Message";
        email: Codeunit Email;
        Body: Text;
    begin
        Body:='Dear Sir / Ma,';
        Body+='<span style="font-family: Baskerville; color: black; FONT-SIZE: 11pt;">';
        Body+='<span style="font-family: Baskerville; color: black;FONT-SIZE: 11pt;">';
        Body+='<br><br>';
        Body+='This is to inform you that payment(s) have been sent from Business Central to GAPS for your approval.  ';
        Body+='<br/><br/>';
        Body+='Kindly find the attached supporting document for more details.';
        Body+='<br/><br/>';
        Body+='Regards,';
        Body+='<br/><br/></span>';
        Body+='Finance Dept';
        Body+='<br/>ARM PENSION<br/></span>';
        //mail.Create('gapspayment@armpension.com', 'EFT PAYMENT REQUEST for ' + No, Body, true);
        mail.Create('henry.ngari@teknohub.systems', 'EFT PAYMENT REQUEST for ' + EFTHeader.No, Body, true);
        //email.OpenInEditorModally(mail)
        EFTLines.Reset;
        EFTLines.SetRange("EFT No", EFTHeader.No);
        EFTLines.SetRange(Status, EFTLines.Status::Processed);
        if EFTLines.FindFirst then begin
            repeat if EFTHeader."Process Module" = EFTHeader."Process Module"::PVs then begin
                    Payment.Reset;
                    Payment.Get(EFTLines."PV No");
                    LineNo:=0;
                // if PRHeader.Get(Payment."Payment Request No") then begin
                //     IncomingDocumentAttachment.SetRange("Incoming Document Entry No.", PRHeader."Incoming Document Entry No.");
                //     if IncomingDocumentAttachment.FindFirst then begin
                //         attachmentName := IncomingDocumentAttachment.Name + '.' + IncomingDocumentAttachment."File Extension";
                //         if FILE.Exists(smtpsetup."Path to Save Report" + attachmentName) then FILE.Erase(smtpsetup."Path to Save Report" + attachmentName);
                //         pathcode := IncomingDocumentAttachment.Export2ServerPath(smtpsetup."Path to Save Report" + attachmentName);
                //         smtp.AddAttachment(pathcode, attachmentName);
                //         npayment.Reset;
                //         npayment.SetRange(No, Payment.No);
                //         if npayment.FindFirst then begin
                //             PVReport.SetTableView(npayment);
                //             pathcode2 := TemporaryPath + IncomingDocumentAttachment.Name + '_PV' + '.pdf';
                //             if FILE.Exists(pathcode2) then FILE.Erase(pathcode2);
                //             PVReport.SaveAsPdf(pathcode2);
                //             Clear(PVReport);
                //             smtp.AddAttachment(pathcode2, IncomingDocumentAttachment.Name + '_PV' + '.pdf');
                //         end;
                //     end;
                // end;
                end;
                if(EFTHeader."Process Module" = EFTHeader."Process Module"::"Staff Claim") or (EFTHeader."Process Module" = EFTHeader."Process Module"::"Imprest") or (EFTHeader."Process Module" = EFTHeader."Process Module"::Surrender)then begin
                    imprestheader.Get(EFTLines."PV No");
                    imprestheader.SetRange("No.", EFTLines."PV No");
                // IncomingDocumentAttachment.Reset;
                // IncomingDocumentAttachment.SetRange("Incoming Document Entry No.", imprestheader."Incoming Document Entry No.");
                // if IncomingDocumentAttachment.FindFirst then begin
                //     attachmentName := IncomingDocumentAttachment.Name + '.' + IncomingDocumentAttachment."File Extension";
                //     pathcode := IncomingDocumentAttachment.Export2ServerPath(smtpsetup."Path to Save Report" + attachmentName);
                //     smtp.AddAttachment(pathcode, attachmentName);
                // end;
                // if imprestheader.FindFirst then begin
                //     if ("Process Module" = "Process Module"::"Staff Claim") then begin
                //         StaffClaimVoucherReport.SetTableView(imprestheader);
                //         pathcode2 := TemporaryPath + IncomingDocumentAttachment.Name + '_Attachment' + '.pdf';
                //         StaffClaimVoucherReport.SaveAsPdf(pathcode2);
                //         Clear(StaffClaimVoucherReport);
                //         smtp.AddAttachment(pathcode2, IncomingDocumentAttachment.Name + '_Attachment' + '.pdf');
                //     end;
                //     if (Rec."Process Module" = Rec."Process Module"::"Imprest") then begin
                //         CashAdvanceVoucherReport.SetTableView(imprestheader);
                //         pathcode2 := TemporaryPath + IncomingDocumentAttachment.Name + '_Attachment' + '.pdf';
                //         CashAdvanceVoucherReport.SaveAsPdf(pathcode2);
                //         Clear(CashAdvanceVoucherReport);
                //         smtp.AddAttachment(pathcode2, IncomingDocumentAttachment.Name + '_Attachment' + '.pdf');
                //     end;
                //     if (Rec."Process Module" = Rec."Process Module"::Surrender) then begin
                //         SurrenderVoucherReport.SetTableView(imprestheader);
                //         pathcode2 := TemporaryPath + IncomingDocumentAttachment.Name + '_Surrender' + '.pdf';
                //         SurrenderVoucherReport.SaveAsPdf(pathcode2);
                //         Clear(SurrenderVoucherReport);
                //         smtp.AddAttachment(pathcode2, IncomingDocumentAttachment.Name + '_Surrender' + '.pdf');
                //     end;
                // end;
                end;
            until EFTLines.Next = 0;
        // dup.CLOSE;
        end;
    //email.Send(mail);
    //email.OpenInEditorModally(mail)
    end;
    procedure PostPV(EFTLines: Record "EFT Lines")
    begin
        Payment.Reset;
        Payment.Get(EFTLines."PV No");
        FinanceMgt."Post Payment Voucher"(Payment);
    end;
    procedure AutoPost(eftheaderNo: Text)
    var
        eftHead: Record "EFT Header";
    begin
        eftHead.Reset;
        eftHead.Get(eftheaderNo);
        if isautopost = false then if eftHead.Status <> eftHead.Status::"Processed by Bank" then Error('The Transaction cannot be posted at this stage.');
        //IF "EFT Posted" THEN ERROR ('The transaction has already been posted');
        dup.Open('Posting Transactions for #1');
        EFTLines.Reset;
        EFTLines.SetRange("EFT No", eftHead.No);
        EFTLines.SetRange(Status, EFTLines.Status::Processed);
        if eftHead."Process Module" = eftHead."Process Module"::"Staff Claim" then begin
            if EFTLines.FindFirst then begin
                repeat ImprestHeader.Get(EFTLines."PV No");
                    ImprestHeader.CalcFields("Total Claim");
                    ImprestHeader."Claim Pay Mode":='EFT';
                    ImprestHeader."Claim Payment Tx No":=eftHead.No;
                    if ImprestHeader."Surrender Posted" = false then ImprestManagement.PostStaffClaim(ImprestHeader);
                //IF (ImprestHeader."No."<> 'CLM000574') AND (ImprestHeader."No."<> 'CLM000583') AND (ImprestHeader."No."<> 'CLM000604')AND (ImprestHeader."No."<> 'CLM000610') AND (ImprestHeader."No."<> 'CLM000611')THEN
                until EFTLines.Next = 0;
                Message('Staff Claim Updated Successfully');
            end;
        end;
        if eftHead."Process Module" = eftHead."Process Module"::"Imprest" then begin
            if EFTLines.FindFirst then begin
                repeat ImprestHeader.Get(EFTLines."PV No");
                    ImprestHeader.CalcFields("Total Request Amount");
                    ImprestHeader."Pay Mode":='EFT';
                    ImprestHeader."Payment Tx No.(Cheque No.)":=eftHead.No;
                    if ImprestHeader."Paying Bank Code" = '' then ImprestHeader."Paying Bank Code":='111001';
                    if ImprestHeader."Request Posted" = false then ImprestManagement.PostImprestRequest(ImprestHeader);
                until EFTLines.Next = 0;
                Message('Imprest Updated Successfully');
            end;
        end;
        if eftHead."Process Module" = eftHead."Process Module"::Surrender then begin
            if EFTLines.FindFirst then begin
                repeat ImprestHeader.Get(EFTLines."PV No");
                    ImprestHeader.CalcFields("Total Claim");
                    ImprestHeader."Claim Pay Mode":='EFT';
                    ImprestManagement.PostImprestSurrender(ImprestHeader);
                until EFTLines.Next = 0;
                Message('Surrender Updated Successfully');
            end;
        end;
        if eftHead."Process Module" = eftHead."Process Module"::PVs then begin
            if EFTLines.FindFirst then begin
                repeat Payment.Reset;
                    Payment.Get(EFTLines."PV No");
                    if Payment."Paying Bank Account" = '' then Payment."Paying Bank Account":='111001';
                    Payment.Modify;
                    PostPV(EFTLines);
                until EFTLines.Next = 0;
                Message('Payment vouchers Updated Successfully');
            end;
        end;
        eftHead."EFT Posted":=true;
        eftHead.Modify;
        dup.Close;
    end;
    procedure MakeEFTPayment(var EFT: Record "EFT Header")
    begin
        EftLines.Reset;
        EftLines.SetRange("EFT No", EFT.No);
        //EftLines.SETRANGE(Status,EftLines.Status::Logged);
        if EftLines.FindFirst then begin
            repeat EftLines.TestField("Bank Account No");
                EftLines.TestField("Sort Code");
            // if StrLen(EftLines."Bank Account No") <> 10 then
            //     Error('Account Number must be 10 digit for %1', EftLines."PV No");
            // if Evaluate(TotalPercent, EftLines."Bank Account No") = false then
            //     Error('Account Number must be  digit ONLY for %1', EftLines."PV No");
            // if StrLen(EftLines."Sort Code") <> 9 then
            //     Error('Sort Code must be 9 digit for %1', EftLines."PV No");
            // if Evaluate(TotalPercent, EftLines."Sort Code") = false then
            //     Error('Sort Code must be  digit ONLY for %1', EftLines."PV No");
            until EftLines.Next = 0;
        end;
        dup.Open('Processing Payment...');
        if(EFT.Status <> EFT.Status::Logged) and (EFT.Status <> EFT.Status::Approved)then Error('Cannot make payment at this stage');
        resp:=EFTPost.SendEFTPayment(EFT.No);
        if UpperCase(resp) = 'SUCCESS' then begin
            CashMgnt.SendEmail(EFT);
        //AutoPost;
        end;
        Message(resp);
        dup.Close;
    end;
    procedure PostProcessedEFT(var EFT: Record "EFT Header")
    begin
        if EFT.Status <> EFT.Status::"Processed by Bank" then Error('The Transaction cannot be posted at this stage.');
        //IF "EFT Posted" THEN ERROR ('The transaction has already been posted');
        dup.Open('Posting Transactions for #1');
        EftLines.Reset;
        EftLines.SetRange("EFT No", EFT.No);
        EftLines.SetRange(Status, EftLines.Status::Processed);
        if EFT."Process Module" = EFT."Process Module"::"Staff Claim" then begin
            if EftLines.FindFirst then begin
                repeat ImprestHeader.Get(EftLines."PV No");
                    ImprestHeader.CalcFields("Total Claim");
                    ImprestHeader."Claim Pay Mode":='EFT';
                    ImprestHeader."Claim Payment Tx No":=EFT.No;
                    if ImprestHeader."Surrender Posted" = false then ImprestManagement.PostStaffClaim(ImprestHeader);
                until EftLines.Next = 0;
                Message('Staff Claim Updated Successfully');
            end;
        end;
        if EFT."Process Module" = EFT."Process Module"::"Imprest" then begin
            if EftLines.FindFirst then begin
                repeat ImprestHeader.Get(EftLines."PV No");
                    ImprestHeader.CalcFields("Total Request Amount");
                    ImprestHeader."Pay Mode":='EFT';
                    ImprestHeader."Payment Tx No.(Cheque No.)":=EFT.No;
                    if ImprestHeader."Paying Bank Code" = '' then ImprestHeader."Paying Bank Code":='111001';
                    if ImprestHeader."Request Posted" = false then ImprestManagement.PostImprestRequest(ImprestHeader);
                until EftLines.Next = 0;
                Message('Imprest Updated Successfully');
            end;
        end;
        if EFT."Process Module" = EFT."Process Module"::Surrender then begin
            if EftLines.FindFirst then begin
                repeat ImprestHeader.Get(EftLines."PV No");
                    ImprestHeader.CalcFields("Total Claim");
                    ImprestHeader."Claim Pay Mode":='EFT';
                    ImprestManagement.PostImprestSurrender(ImprestHeader);
                until EftLines.Next = 0;
                Message('Surrender Updated Successfully');
            end;
        end;
        if EFT."Process Module" = EFT."Process Module"::PVs then begin
            if EftLines.FindFirst then begin
                repeat CashMgnt.PostPV(EftLines);
                until EftLines.Next = 0;
                Message('Payment vouchers Updated Successfully');
            end;
        end;
        EFT."EFT Posted":=true;
        EFT.Modify;
        dup.Close;
    end;
    procedure ReturnEFT(var EFT: Record "EFT Header")
    begin
        EftLines.Reset;
        EftLines.SetRange("EFT No", EFT.No);
        EftLines.SetFilter(Status, '%1|%2', EftLines.Status::Logged, EftLines.Status::Failed);
        if EftLines.FindFirst then begin
            repeat if EFT."Process Module" = EFT."Process Module"::PVs then begin
                    Payment.Reset;
                    Payment.Get(EftLines."PV No");
                    if Payment.EFT_No = EftLines."EFT No" then begin
                        Payment.EFT_No:='';
                        Payment.Modify;
                    end;
                    EftLines.Status:=EftLines.Status::Returned;
                    EftLines.Modify;
                end;
            until EftLines.Next = 0 end;
        if EFT."Process Module" = EFT."Process Module"::"Imprest" then begin
            ImprestHeader.Reset;
            ImprestHeader.Get(EftLines."PV No");
            if ImprestHeader."EFT No" = EftLines."EFT No" then begin
                ImprestHeader."EFT No":='';
                ImprestHeader.Modify;
            end;
        end;
        if EFT."Process Module" = EFT."Process Module"::"Staff Claim" then begin
            ImprestHeader.Reset;
            ImprestHeader.Get(EftLines."PV No");
            if ImprestHeader."EFT No" = EftLines."EFT No" then begin
                ImprestHeader."EFT No":='';
                ImprestHeader.Modify;
            end;
        end;
        if EFT."Process Module" = EFT."Process Module"::Surrender then begin
            ImprestHeader.Reset;
            ImprestHeader.Get(EftLines."PV No");
            if ImprestHeader."Surrender EFT No" = EftLines."EFT No" then begin
                ImprestHeader."Surrender EFT No":='';
                ImprestHeader.Modify;
            end;
        end;
        if EFT."No of Record Processed" = 0 then begin
            EFT.Status:=EFT.Status::Rejected;
            EFT.Modify;
        end;
    end;
    procedure EFTPayAndPost(var EFT: Record "EFT Header")
    begin
        begin
            isautopost:=false;
            EftLines.Reset;
            EftLines.SetRange("EFT No", EFT.No);
            //EftLines.SETRANGE(Status,EftLines.Status::Logged);
            if EftLines.FindFirst then begin
                repeat EftLines.TestField("Bank Account No");
                    EftLines.TestField("Sort Code");
                    if StrLen(EftLines."Bank Account No") <> 10 then Error('Account Number must be 10 digit for %1', EftLines."PV No");
                    if Evaluate(TotalPercent, EftLines."Bank Account No") = false then Error('Account Number must be  digit ONLY for %1', EftLines."PV No");
                    if StrLen(EftLines."Sort Code") <> 9 then Error('Sort Code must be 9 digit for %1', EftLines."PV No");
                    if Evaluate(TotalPercent, EftLines."Sort Code") = false then Error('Sort Code must be  digit ONLY for %1', EftLines."PV No");
                until EftLines.Next = 0;
            end;
            dup.Open('Processing Payment...');
            if(EFT.Status <> EFT.Status::Logged) and (EFT.Status <> EFT.Status::Approved)then Error('Cannot make payment at this stage');
            resp:=eftpost.SendEFTPayment(EFT.No);
            if UpperCase(resp) = 'SUCCESS' then begin
                CashMgnt.SendEmail(EFT);
                Commit;
                isautopost:=true;
                EFT.Reset;
                Sleep(30);
                CashMgnt.AutoPost(EFT.No);
            end;
            Message(resp);
            dup.Close;
        end;
    end;
    procedure GenerateEFTNo(): Code[20]begin
        // Create EFT Header
        EFTHeaderCount.Reset();
        if EFTHeaderCount.Count = 0 then EFTNo:='EFT000001'
        else if((EFTHeaderCount.Count > 0) AND (EFTHeaderCount.Count < 10))then EFTNo:='EFT00000' + Format(EFTHeaderCount.Count)
            else if((EFTHeaderCount.Count > 10) AND (EFTHeaderCount.Count < 100))then EFTNo:='EFT0000' + Format(EFTHeaderCount.Count)
                else if((EFTHeaderCount.Count > 100) AND (EFTHeaderCount.Count < 1000))then EFTNo:='EFT000' + Format(EFTHeaderCount.Count)
                    else if((EFTHeaderCount.Count > 1000) AND (EFTHeaderCount.Count < 10000))then EFTNo:='EFT00' + Format(EFTHeaderCount.Count)
                        else if((EFTHeaderCount.Count > 10000) AND (EFTHeaderCount.Count < 100000))then EFTNo:='EFT0' + Format(EFTHeaderCount.Count)
                            else if(EFTHeaderCount.Count > 100000)then EFTNo:='EFT' + Format(EFTHeaderCount.Count);
        if EFTHeader_Check.Get(EFTNo)then EFTNo:=EFTNo + '_B';
        exit(EFTNo);
    end;
}
