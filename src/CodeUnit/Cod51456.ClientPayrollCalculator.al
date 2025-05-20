codeunit 51456 "Client Payroll Calculator"
{
    // version THL- Client Payroll 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51453 - 51499 = 76
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
        CompRec: Record "Client Payroll Setup";
        TaxCode: Code[10];
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        PayPeriod: Record "Client Payroll Period";
        BeginDate: Date;
        CfMpr: Decimal;
        i: Integer;
        TaxableAmount: Decimal;
        Ded: Record "Client Deductions";
        HRSetup: Record "Client Payroll Setup";
        Text000: Label 'Pay period must be specified for this report';
        Text001: Label 'You must specify the rounding precision under QuantumJumps Payroll setup';
        Emp: Record "Client Employee Master";
        SMTPSetup: Record "Email Account";
        SmtpEmail: page "Email Accounts";
        ClientRec: Record "Client Employee Master";
        SMTPMail: Codeunit Email;
        CompInfo: Record "Client Company Information";
        TempBlob: Codeunit "Temp Blob";
        FileName: Text;
        FileMgt: Codeunit 419;
        Comp: Code[20];

    procedure GetTaxBracket(var TaxableAmount: Decimal; var EmployeeNo: Code[20]) GetTaxBracket: Decimal
    var
        TaxTable: Record "Client Bracket";
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        if Emp.Get(EmployeeNo) then begin
            Comp := Emp."Company Code";
            CompRec.Get(Emp."Company Code");
            TaxCode := CompRec."Tax Table";
            if Emp."Country Tax Table" <> '' then TaxCode := Emp."Country Tax Table";
        end;
        AmountRemaining := TaxableAmount;
        //MESSAGE('Taxable %1',TaxableAmount);
        EndTax := false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-') then begin
            repeat //MESSAGE('Bracket');
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if Round((TaxableAmount), 1) >= TaxTable."Upper Limit" then begin
                        Tax := TaxTable."Base Amount" * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                    end
                    else begin
                        //Deducted 1 here and got the xact figures just chek incase this may have issues
                        //Only the amount in the last Tax band had issues.
                        AmountRemaining := AmountRemaining - (TaxTable."Lower Limit" - 1);
                        Tax := AmountRemaining * (TaxTable.Percentage / 100);
                        EndTax := true;
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax, Comp);
        IncomeTax := -TotalTax;
        GetTaxBracket := Round(TotalTax, 0.01, '<');
    end;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            BeginDate := PayPeriod."Starting Date";
        end;
    end;

    procedure CalculateTaxableAmount(var EmployeeNo: Code[20]; var DateSpecified: Date; var FinalTax: Decimal; var TaxableAmountNew: Decimal; var RetirementCont: Decimal; var Company: Code[20])
    var
        PayrollMatrix: Record "Client Payroll Matrix";
        EmpRec: Record "Client Employee Master";
        EarnRec: Record "Client Earnings";
        InsuranceRelief: Decimal;
        PersonalRelief: Decimal;
        SHIFRelief: Decimal;
        Comp: Code[20];
    begin
        CfMpr := 0;
        FinalTax := 0;
        i := 0;
        TaxableAmount := 0;
        RetirementCont := 0;
        InsuranceRelief := 0;
        PersonalRelief := 0;
        //Get payroll period
        GetPayPeriod;
        if DateSpecified = 0D then Error(Text000);
        // Taxable Amount
        EmpRec.Reset;
        EmpRec.SetRange(EmpRec."No.", EmployeeNo);
        EmpRec.SetRange("Pay Period Filter", DateSpecified);
        EmpRec.SetRange("Company Code", Company);
        if EmpRec.Find('-') then begin
            Comp := EmpRec."Company Code";
            if EmpRec."Pays Tax" = true then begin
                EmpRec.CalcFields(EmpRec."Taxable Allowance");
                TaxableAmount := EmpRec."Taxable Allowance";
                //Message('Taxable Allowance%1', TaxableAmount);
                Ded.Reset;
                Ded.SetRange(Company, EmpRec."Company Code");
                Ded.SetRange(Ded."Reduces Taxable Amt", true);
                Ded.SetRange(Ded."Pension Scheme", true);
                if Ded.Find('-') then begin
                    repeat
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                        PayrollMatrix.SetRange(Company, Comp);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, Ded.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-') then begin
                            if Ded."Pension Limit Amount" > 0 then begin
                                if Abs(PayrollMatrix.Amount) > Ded."Pension Limit Amount" then
                                    RetirementCont := Abs(RetirementCont) + Ded."Pension Limit Amount"
                                else
                                    RetirementCont := Abs(RetirementCont) + Abs(PayrollMatrix.Amount);
                            end
                            else
                                RetirementCont := Abs(RetirementCont) + Abs(PayrollMatrix.Amount);
                        end;
                    // Message('Name RetirementCont IS %1...#...amount is %2 ', PayrollMatrix.Description, PayrollMatrix.Amount);


                    until Ded.Next = 0;
                end;
                //Giovanni added 6th Dec 2016

                HRSetup.Get(Comp);
                if RetirementCont > HRSetup."Pension Limit Amount" then RetirementCont := HRSetup."Pension Limit Amount";
                //Giovanni added 6th Dec 2016
                TaxableAmount := TaxableAmount - RetirementCont;
                // end Taxable Amount
                // added to cater for Owner occupier Specific
                //Other Tax Deductible Deductions
                // Message('RetirementCont this is %1', RetirementCont);
                Ded.Reset;
                Ded.SetRange(Company, Comp);
                Ded.SetRange(Ded."Reduces Taxable Amt", true);
                Ded.SetRange(Ded."Pension Scheme", false);
                if Ded.Find('-') then begin
                    repeat
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, Ded.Code);
                        PayrollMatrix.SetRange(Company, Comp);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-') then begin
                            TaxableAmount := TaxableAmount - Abs(PayrollMatrix.Amount);
                            RetirementCont := RetirementCont + Abs(PayrollMatrix.Amount); //VOKOTH - 17th Jan 2025
                                                                                          // Message('RetirementCont 123 is%1', RetirementCont);
                                                                                          // Message('Name IS %1...#...amount is %2..#  RetirementCont    %3 ', PayrollMatrix.Description, PayrollMatrix.Amount, RetirementCont);

                        end;
                    //   Message('RetirementCont 1 is%1', RetirementCont);
                    until Ded.Next = 0;
                end;


                if EmpRec."Home Ownership Status" = EmpRec."Home Ownership Status"::"Owner Occupier" then begin
                    // Get owner Occuper From Earning Table
                    EarnRec.Reset;
                    EarnRec.SetCurrentKey(EarnRec."Earning Type");
                    EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Owner Occupier");
                    if EarnRec.Find('-') then begin
                        repeat
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                            if PayrollMatrix.Find('-') then TaxableAmount := TaxableAmount - PayrollMatrix.Amount;
                        until EarnRec.Next = 0;
                    end;
                end;
                // End ofOwner occupier Specific
                // Low Interest Benefits
                EarnRec.Reset;
                EarnRec.SetCurrentKey(EarnRec."Earning Type");
                EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Low Interest");
                EarnRec.SetRange(Company, Comp);
                if EarnRec.Find('-') then begin
                    repeat
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-') then TaxableAmount := TaxableAmount + PayrollMatrix.Amount;
                    until EarnRec.Next = 0;
                end;
                //  Message('TAXA IS %1', TaxableAmount);
                //End of Low Interest benefits
                TaxableAmount := Round(TaxableAmount, 0.01, '<');
                TaxableAmountNew := TaxableAmount;
                // Get PAYE
                //modified by Grace
                FinalTax := GetTaxBracket(TaxableAmountNew, EmployeeNo);
                // Message('first Finaltax%1', FinalTax);

                // Get Reliefs
                InsuranceRelief := 0;
                // Calculate insurance relief;
                EarnRec.Reset;
                EarnRec.SetCurrentKey(EarnRec."Earning Type");
                EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Insurance Relief");
                EarnRec.SetRange("Calculation Method", EarnRec."Calculation Method"::"% of Insurance Amount");
                EarnRec.SetRange(Company, Comp);
                if EarnRec.Find('-') then begin
                    repeat
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-') then InsuranceRelief := InsuranceRelief + PayrollMatrix.Amount;
                    //Message('relief%1', InsuranceRelief);
                    until EarnRec.Next = 0;
                end;
                begin
                    //SHIF Relief
                    //InsuranceRelief := 0;
                    // Calculate SHIF relief;
                    SHIFRelief := 0;
                    EarnRec.Reset;
                    EarnRec.SetCurrentKey(EarnRec."Earning Type");
                    EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Insurance Relief");
                    EarnRec.SetRange("Calculation Method", EarnRec."Calculation Method"::"% of SHIF");
                    EarnRec.SetRange(Company, Comp);
                    if EarnRec.Find('-') then begin
                        repeat
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                            if PayrollMatrix.Find('-') then SHIFRelief := SHIFRelief + PayrollMatrix.Amount;
                        //Message('relief%1', SHIFRelief);
                        until EarnRec.Next = 0;
                    end;
                end;
                begin
                    // Personal Relief
                    PersonalRelief := 0;
                    EarnRec.Reset;
                    EarnRec.SetCurrentKey(EarnRec."Earning Type");
                    EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Tax Relief");
                    EarnRec.SetRange(Company, Comp);
                    if EarnRec.Find('-') then begin
                        repeat
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                            if PayrollMatrix.Find('-') then PersonalRelief := PersonalRelief + PayrollMatrix.Amount;
                        //Message('relief%1', PersonalRelief);
                        until EarnRec.Next = 0;
                    end;
                end;
                begin
                    if InsuranceRelief + SHIFRelief > 5000 then InsuranceRelief := InsuranceRelief - SHIFRelief;
                end;
                begin
                    FinalTax := FinalTax - (PersonalRelief + InsuranceRelief + SHIFRelief);
                    // Message('Final tax%1', FinalTax);
                end;
                if FinalTax < 0 then FinalTax := 0;
            end
            else
                FinalTax := 0;
        end;
    end;

    procedure GetUserGroup(var UserIDs: Code[10]; var PGroup: Code[20])
    var
        UserSetup: Record "User Setup";
    begin
        /*
            IF UserSetup.GET(UserIDs) THEN BEGIN
             PGroup
             :=UserSetup.Picture;
             IF PGroup='' THEN
              ERROR('Dont have payroll permission');
            END;
              */
    end;

    procedure PayrollRounding(var Amount: Decimal; var Company: Code[20]) PayrollRounding: Decimal
    var
        HRsetup: Record "Client Payroll Setup";
        amt: Decimal;
        DecPosistion: Integer;
        Decvalue: Text[30];
        amttext: Text[30];
        Wholeamt: Text[30];
        Stringlen: Integer;
        Decplace: Integer;
        holdamt: Text[30];
        FirstNoText: Text[30];
        SecNoText: Text[30];
        FirstNo: Integer;
        SecNo: Integer;
        Amttoround: Decimal;
    begin
        Evaluate(amttext, Format(Amount));
        DecPosistion := StrPos(amttext, '.');
        Stringlen := StrLen(amttext);
        if DecPosistion > 0 then begin
            Wholeamt := CopyStr(amttext, 1, DecPosistion - 1);
            Decplace := Stringlen - DecPosistion;
            Decvalue := CopyStr(amttext, DecPosistion + 1, 2);
            if StrLen(Decvalue) = 1 then holdamt := Decvalue + '0';
            if StrLen(Decvalue) > 1 then begin
                FirstNoText := CopyStr(Decvalue, 1, 1);
                SecNoText := CopyStr(Decvalue, 2, 1);
                Evaluate(SecNo, Format(SecNoText));
                if SecNo >= 5 then
                    holdamt := FirstNoText + '5'
                else
                    holdamt := FirstNoText + '0'
            end;
            amttext := Wholeamt + '.' + holdamt;
            Evaluate(Amttoround, Format(amttext));
        end
        else begin
            Evaluate(amttext, Format(Amount));
            Evaluate(Amttoround, Format(amttext));
        end;
        Amount := Amttoround;
        HRsetup.Get(Company);
        if HRsetup."Payroll Rounding Precision" = 0 then Error(Text001);
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    procedure InsertDeductionPayrollEntry(var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal)
    var
        PayrollMatrix: Record "Client Payroll Matrix";
        PayrollMatrix2: Record "Client Payroll Matrix";
    begin
        GetPayPeriod;
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Deduction);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate("Payroll Period", BeginDate);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(EmployeeNo, PayrollMatrix2.Type::Deduction, Code, BeginDate, '') then
            PayrollMatrix.Insert
        else begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;

    procedure InsertEarningPayrollEntry(var Comp: Code[20]; var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal)
    var
        PayrollMatrix: Record "Client Payroll Matrix";
        PayrollMatrix2: Record "Client Payroll Matrix";
    begin
        GetPayPeriod;
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Payment);
        PayrollMatrix.Validate(Company, Comp);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate("Payroll Period", BeginDate);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(Comp, EmployeeNo, PayrollMatrix2.Type::Payment, Code, BeginDate, '') then
            PayrollMatrix.Insert
        else begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;

    procedure GeneratePayslip(var EmpNo: Code[20]; var Period: Date)
    var
        Employee: Record "Client Employee Master";
        PeriodName: Text;
        Comp: Code[20];
        ClientEmail: List of [Text];
        TempBlob: Codeunit "Temp Blob";
        Subject: Text;
        Body: Text;
        CompInfo: Record "Client Company Information";
        Mail: Codeunit "Email Message";
        Email: Codeunit Email;
        outStreamReport: OutStream;
        inStreamReport: InStream;
        RecRef: RecordRef;
        ReportParameters: Record "Report Parameters";
        XmlParameters: Text;
        CurrentUser: Code[50];
        IStream: InStream;
        Content: File;
    begin
        Clear(ReportParameters);
        Clear(XmlParameters);
        CurrentUser := UserId;
        //Generation
        if PayPeriod.Get(Period) then PeriodName := PayPeriod.Name + ' '; //+ Format(Period, 1, 3);        
        Comp := '';
        Employee.Reset;
        Employee.SetRange("No.", EmpNo);
        Employee.SetFilter("Pay Period Filter", '%1', Period);
        if Employee.FindFirst then Comp := Employee."Company Code";
        if Comp <> '' then begin
            //Sending
            ClientRec.Get(EmpNo);
            CompInfo.Get(Comp);
            if ClientRec."Email Address" <> '' then ClientEmail.Add(ClientRec."Email Address");
            //ClientEmail.Add('vincent.okoth@teknohub.sytems');
            if ClientEmail.Count <> 0 then begin
                Subject := StrSubstNo(Comp + ' ' + '%1 Payslip', Format(Period, 0, '<Month text>-<Year4>'));
                Body += 'Hello, ' + Employee."Full Name";
                //Body += '<br><br>';
                //Body += 'Kindly ignore this mail is for test purpose';
                Body += '<br><br>';
                Body += StrSubstNo('Kindly find the attached payslip for the month of %1', Format(Period, 0, '<Month text>-<Year4>'));
                Body += '<br><br>';
                Body += 'Thank you.';
                Body += '<br><br>';
                Body += 'Kindly do not respond as this is a system genated email.';
                Body += '<br><br>';
                Body += 'Yours Sincerely,';
                Body += '<br><br>';
                Body += '<b>Payroll Department<b>';
                Body += '<br>';
                Body += CompInfo.Name;
                Body += '<br><br>';
                Body += 'This email message and any file(s) transmitted with it is intended solely for the individual or entity to whom it is addressed and may contain confidential and/or legally privileged information which confidentiality and/or privilege is not lost or waived by reason of mistaken transmission.';
                Body += '<br>';
                Body += 'If you have received this message by error you are not authorized to view disseminate distribute or copy the message without the written consent of Judicial Service Commission and are requested to contact the sender by telephone or e-mail and destroy the original.';
                Body += '<br>';
                Mail.Create(ClientEmail, Subject, Body, true);
                Employee.Reset();
                Employee.SETRANGE("No.", Employee."No.");
                Employee.SetFilter("Pay Period Filter", '%1', Period);
                if Employee.FindFirst() then RecRef.GetTable(Employee);
                //Generate blob from report
                //with ReportParameters do begin
                ReportParameters.SetAutoCalcFields(Parameters);
                ReportParameters.Get(51455, CurrentUser);
                ReportParameters.Parameters.CreateInStream(IStream);
                IStream.ReadText(XmlParameters);
                //end;
                TempBlob.CreateOutStream(outStreamReport);
                TempBlob.CreateInStream(inStreamReport);
                Report.SaveAs(51455, XmlParameters, ReportFormat::Pdf, outStreamReport, RecRef);
                Mail.AddAttachment(Format(Period, 0, '<Month Text>-<Year4>') + ' Payslip ' + Employee."No." + '.pdf', 'PDF', inStreamReport);
                Email.Send(Mail);
            end;
        end;
    end;

    procedure GeneratePNine(var EmpNo: Code[20]; var StartPeriod: Date; var EndPeriod: Date; var Comp: Code[20]; var XmlParameters: Text)
    var
        Employee: Record "Client Employee Master";
        StartPeriodName: Text;
        EndPeriodName: Text;
        ClientEmail: List of [Text];
        TempBlob: Codeunit "Temp Blob";
        Subject: Text;
        Body: Text;
        CompInfo: Record "Client Company Information";
        Mail: Codeunit "Email Message";
        Email: Codeunit Email;
        outStreamReport: OutStream;
        inStreamReport: InStream;
        RecRef: RecordRef;
        CurrentUser: Code[50];
        IStream: InStream;
        Content: File;
        CCEmail: List of [Text];
        BCCEmail: List of [Text];
    begin
        Clear(BCCEmail);
        //Generation
        if PayPeriod.Get(StartPeriod) then StartPeriodName := PayPeriod.Name + ' ';
        if PayPeriod.Get(EndPeriod) then EndPeriodName := PayPeriod.Name + ' ';
        if Comp <> '' then begin
            //Sending
            ClientRec.Get(EmpNo);
            CompInfo.Get(Comp);
            if ClientRec."Email Address" <> '' then begin
                ClientEmail.Add(ClientRec."Email Address");
                BCCEmail.Add('thlsystemalerts@gmail.com');
            end;
            if ClientEmail.Count <> 0 then begin
                Subject := StrSubstNo(Comp + ' ' + 'P9 Report for the Period from %1 to %2', Format(StartPeriod, 0, '<Month text>-<Year4>'), Format(EndPeriod, 0, '<Month text>-<Year4>'));
                Body += 'Hello ' + ClientRec."First Name" + ',';
                //Body += '<br><br>';
                //Body += 'Kindly ignore this mail is for test purpose';
                Body += '<br><br>';
                Body += StrSubstNo('Kindly find the attached P9 Report for the period from %1 to %2.', Format(StartPeriod, 0, '<Month text>-<Year4>'), Format(EndPeriod, 0, '<Month text>-<Year4>'));
                Body += '<br><br>';
                Body += 'Thank you.';
                Body += '<br><br>';
                Body += 'Kindly do not respond as this is a system genated email.';
                Body += '<br><br>';
                Body += 'Yours Sincerely,';
                Body += '<br><br>';
                Body += '<b>Payroll Department<b>';
                Body += '<br>';
                Body += CompInfo.Name;
                Body += '<br><br>';
                Body += 'This email message and any file(s) transmitted with it is intended solely for the individual or entity to whom it is addressed and may contain confidential and/or legally privileged information which confidentiality and/or privilege is not lost or waived by reason of mistaken transmission.';
                Body += '<br>';
                Body += 'If you have received this message by error you are not authorized to view disseminate distribute or copy the message without the written consent of Judicial Service Commission and are requested to contact the sender by telephone or e-mail and destroy the original.';
                Body += '<br>';
                Mail.Create(ClientEmail, Subject, Body, true, CCEmail, BCCEmail);
                Employee.Reset();
                Employee.SETRANGE("No.", Employee."No.");
                Employee.SetFilter("Pay Period Filter", '%1..%2', StartPeriod, EndPeriod);
                if Employee.FindFirst() then RecRef.GetTable(Employee);
                TempBlob.CreateOutStream(outStreamReport);
                TempBlob.CreateInStream(inStreamReport);
                Report.SaveAs(51464, XmlParameters, ReportFormat::Pdf, outStreamReport, RecRef);
                Mail.AddAttachment(Format(StartPeriod, 0, '<Month Text>-<Year4>') + Format(EndPeriod, 0, '<Month Text>-<Year4>') + ' P9 ' + Employee."No." + '.pdf', 'PDF', inStreamReport);
                Email.Send(Mail);
            end;
        end;
    end;

    procedure InsertDeductionPayrollEntrySpecificPeriod(var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal; var Period: Date)
    var
        PayrollMatrix: Record "Client Payroll Matrix";
        PayrollMatrix2: Record "Client Payroll Matrix";
    begin
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Deduction);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate("Payroll Period", Period);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(EmployeeNo, PayrollMatrix2.Type::Deduction, Code, Period, '') then
            PayrollMatrix.Insert
        else begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;

    procedure InsertEarningPayrollEntrySpecificPeriod(var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal; var Period: Date; var Comp: Code[20])
    var
        PayrollMatrix: Record "Client Payroll Matrix";
        PayrollMatrix2: Record "Client Payroll Matrix";
    begin
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Payment);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate(Company, Comp);
        PayrollMatrix.Validate("Payroll Period", Period);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(Comp, EmployeeNo, PayrollMatrix2.Type::Payment, Code, Period, '') then
            PayrollMatrix.Insert
        else begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;

    procedure NetPayRounding(var Amount: Decimal; var Company: Code[20]) PayrollRounding: Decimal
    var
        HRsetup: Record "Client Payroll Setup";
        amt: Decimal;
        DecPosistion: Integer;
        Decvalue: Text[30];
        amttext: Text[30];
        Wholeamt: Text[30];
        Stringlen: Integer;
        Decplace: Integer;
        holdamt: Text[30];
        FirstNoText: Text[30];
        SecNoText: Text[30];
        FirstNo: Integer;
        SecNo: Integer;
        Amttoround: Decimal;
    begin
        Evaluate(amttext, Format(Amount));
        DecPosistion := StrPos(amttext, '.');
        Stringlen := StrLen(amttext);
        if DecPosistion > 0 then begin
            Wholeamt := CopyStr(amttext, 1, DecPosistion - 1);
            Decplace := Stringlen - DecPosistion;
            Decvalue := CopyStr(amttext, DecPosistion + 1, 2);
            if StrLen(Decvalue) = 1 then holdamt := Decvalue + '0';
            if StrLen(Decvalue) > 1 then begin
                FirstNoText := CopyStr(Decvalue, 1, 1);
                SecNoText := CopyStr(Decvalue, 2, 1);
                Evaluate(SecNo, Format(SecNoText));
                if SecNo >= 5 then
                    holdamt := FirstNoText + '5'
                else
                    holdamt := FirstNoText + '0'
            end;
            amttext := Wholeamt + '.' + holdamt;
            Evaluate(Amttoround, Format(amttext));
        end
        else begin
            Evaluate(amttext, Format(Amount));
            Evaluate(Amttoround, Format(amttext));
        end;
        Amount := Amttoround;
        HRsetup.Get(Company);
        if HRsetup."Net Pay Rounding Precision" <> 0 then begin
            if HRsetup."Net Pay Rounding Type" = HRsetup."Net Pay Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Net Pay Rounding Precision", '=');
            if HRsetup."Net Pay Rounding Type" = HRsetup."Net Pay Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Net Pay Rounding Precision", '>');
            if HRsetup."Net Pay Rounding Type" = HRsetup."Net Pay Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Net Pay Rounding Precision", '<');
        end
        else
            PayrollRounding := Amount;
    end;

    procedure CreateReportParameters(var EmpNo: Code[20]; var StartDate: Date; var EndDate: Date; var Comp: Code[10]): Text
    var
        Declaration: XmlDeclaration;
        XmlDoc: XmlDocument;
        Parameters: XmlElement;
        Options: XmlElement;
        DataItems: XmlElement;
        DataItem: XmlElement;
        Fields: XmlElement;
        Comment: XmlComment;
        e, i : Integer;
        XmlData: Text;
        XmlWriteOptions: XmlWriteOptions;
    begin
        // Create the XML Document
        XmlDoc := XmlDocument.Create();
        // Create the Declaration
        Declaration := XmlDeclaration.Create('1.0', 'utf-8', 'yes');
        // Add the declaration to the XML File
        XmlDoc.SetDeclaration(Declaration);
        // Create Root Element
        Parameters := XmlElement.Create('ReportParameters');
        //Add some attributes to the root node
        Parameters.SetAttribute('name', 'Client P9A');
        Parameters.SetAttribute('id', '51464');
        Clear(Options);
        Options := XmlElement.Create('Options');
        // Create and add data Parameters to the element
        Clear(Fields);
        Fields := XmlElement.Create('Field');
        Fields.SetAttribute('name', 'StringDate');
        Fields.Add(XmlText.Create(Format(StartDate, 0, '<Year4>-<Month,2>-<Day,2>')));
        Options.Add(Fields);
        Clear(Fields);
        Fields := XmlElement.Create('Field');
        Fields.SetAttribute('name', 'EndDate');
        Fields.Add(XmlText.Create(Format(EndDate, 0, '<Year4>-<Month,2>-<Day,2>')));
        Options.Add(Fields);
        Parameters.Add(Options);
        Clear(DataItems);
        DataItems := XmlElement.Create('DataItems');
        // Create and add data Parameters to the element
        Clear(DataItem);
        DataItem := XmlElement.Create('DataItem');
        DataItem.SetAttribute('name', 'Employee');
        DataItem.Add(XmlText.Create('VERSION(1) SORTING(Field1) WHERE(Field1=1(' + EmpNo + '),Field65=1(' + Comp + '))'));
        DataItems.Add(DataItem);
        Clear(DataItem);
        DataItem := XmlElement.Create('DataItem');
        DataItem.SetAttribute('name', 'Client Payroll Period');
        DataItem.Add(XmlText.Create('VERSION(1) SORTING(Field1)'));
        DataItems.Add(DataItem);
        Clear(DataItem);
        DataItem := XmlElement.Create('DataItem');
        DataItem.SetAttribute('name', 'Earnings');
        DataItem.Add(XmlText.Create('VERSION(1) SORTING(Field1)'));
        DataItems.Add(DataItem);
        Parameters.Add(DataItems);
        // Add Parameters to document
        XmlDoc.Add(Parameters);
        // Set the option to preserve whitespace - true makes it "more human readable"
        XmlDoc.WriteTo(XmlData);
        exit(XmlData);
    end;
}
