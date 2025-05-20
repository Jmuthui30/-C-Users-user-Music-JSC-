codeunit 51426 "Payroll Calculator"
{
    // version THL- Payroll 1.0
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
    var CompRec: Record "QuantumJumps Payroll Setup";
    TaxCode: Code[10];
    AmountRemaining: Decimal;
    IncomeTax: Decimal;
    PayPeriod: Record "Payroll Period";
    BeginDate: Date;
    CfMpr: Decimal;
    i: Integer;
    TaxableAmount: Decimal;
    Ded: Record Deductions;
    HRSetup: Record "QuantumJumps Payroll Setup";
    Text000: Label 'Pay period must be specified for this report';
    Text001: Label 'You must specify the rounding precision under QuantumJumps Payroll setup';
    Emp: Record "Employee Master";
    SMTPSetup: Record "Email Account";
    ClientRec: Record Employee;
    SMTPMail: Codeunit Mail;
    CompInfo: Record "Company Information";
    TempBlob: Codeunit "Temp Blob";
    FileName: Text;
    procedure GetTaxBracket(var TaxableAmount: Decimal; var EmployeeNo: Code[20])GetTaxBracket: Decimal var
        TaxTable: Record Bracket;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        CompRec.Get;
        TaxCode:=CompRec."Tax Table";
        if Emp.Get(EmployeeNo)then begin
            if Emp."Country Tax Table" <> '' then TaxCode:=Emp."Country Tax Table";
        end;
        AmountRemaining:=TaxableAmount;
        EndTax:=false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-')then begin
            repeat if AmountRemaining <= 0 then EndTax:=true
                else
                begin
                    if Round((TaxableAmount), 1) >= TaxTable."Upper Limit" then begin
                        Tax:=TaxTable."Base Amount" * TaxTable.Percentage / 100;
                        TotalTax:=TotalTax + Tax;
                    end
                    else
                    begin
                        //Deducted 1 here and got the xact figures just chek incase this may have issues
                        //Only the amount in the last Tax band had issues.
                        AmountRemaining:=AmountRemaining - (TaxTable."Lower Limit" - 1);
                        Tax:=AmountRemaining * (TaxTable.Percentage / 100);
                        EndTax:=true;
                        TotalTax:=TotalTax + Tax;
                    end;
                end;
            until(TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax:=TotalTax;
        TotalTax:=PayrollRounding(TotalTax);
        IncomeTax:=-TotalTax;
        GetTaxBracket:=Round(TotalTax, 0.01, '<');
    end;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-')then begin
            BeginDate:=PayPeriod."Starting Date";
        end;
    end;
    procedure CalculateTaxableAmount(var EmployeeNo: Code[20]; var DateSpecified: Date; var FinalTax: Decimal; var TaxableAmountNew: Decimal; var RetirementCont: Decimal)
    var
        PayrollMatrix: Record "Payroll Matrix";
        EmpRec: Record "Employee Master";
        EarnRec: Record Earnings;
        InsuranceRelief: Decimal;
        PersonalRelief: Decimal;
    begin
        CfMpr:=0;
        FinalTax:=0;
        i:=0;
        TaxableAmount:=0;
        RetirementCont:=0;
        InsuranceRelief:=0;
        PersonalRelief:=0;
        //Get payroll period
        GetPayPeriod;
        if DateSpecified = 0D then Error(Text000);
        // Taxable Amount
        EmpRec.Reset;
        EmpRec.SetRange(EmpRec."No.", EmployeeNo);
        EmpRec.SetRange("Pay Period Filter", DateSpecified);
        if EmpRec.Find('-')then begin
            if EmpRec."Pays Tax" = true then begin
                EmpRec.CalcFields(EmpRec."Taxable Allowance");
                TaxableAmount:=EmpRec."Taxable Allowance";
                Ded.Reset;
                Ded.SetRange(Ded."Reduces Taxable Amt", true);
                Ded.SetRange(Ded."Pension Scheme", true);
                if Ded.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, Ded.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-')then begin
                            if Ded."Pension Limit Amount" > 0 then begin
                                if Abs(PayrollMatrix.Amount) > Ded."Pension Limit Amount" then RetirementCont:=Abs(RetirementCont) + Ded."Pension Limit Amount"
                                else
                                    RetirementCont:=Abs(RetirementCont) + Abs(PayrollMatrix.Amount);
                            end
                            else
                                RetirementCont:=Abs(RetirementCont) + Abs(PayrollMatrix.Amount);
                        end;
                    until Ded.Next = 0;
                end;
                //Giovanni added 6th Dec 2016
                HRSetup.Get;
                if RetirementCont > HRSetup."Pension Limit Amount" then RetirementCont:=HRSetup."Pension Limit Amount";
                //Giovanni added 6th Dec 2016
                TaxableAmount:=TaxableAmount - RetirementCont;
                // end Taxable Amount
                // added to cater for Owner occupier Specific
                //Other Tax Deductible Deductions
                Ded.Reset;
                Ded.SetRange(Ded."Reduces Taxable Amt", true);
                Ded.SetRange(Ded."Pension Scheme", false);
                if Ded.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, Ded.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-')then begin
                            TaxableAmount:=TaxableAmount - Abs(PayrollMatrix.Amount);
                        end;
                    until Ded.Next = 0;
                end;
                if EmpRec."Home Ownership Status" = EmpRec."Home Ownership Status"::"Owner Occupier" then begin
                    // Get owner Occuper From Earning Table
                    EarnRec.Reset;
                    EarnRec.SetCurrentKey(EarnRec."Earning Type");
                    EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Owner Occupier");
                    if EarnRec.Find('-')then begin
                        repeat PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                            if PayrollMatrix.Find('-')then TaxableAmount:=TaxableAmount - PayrollMatrix.Amount;
                        until EarnRec.Next = 0;
                    end;
                end;
                // End ofOwner occupier Specific
                // Low Interest Benefits
                EarnRec.Reset;
                EarnRec.SetCurrentKey(EarnRec."Earning Type");
                EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Low Interest");
                if EarnRec.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-')then TaxableAmount:=TaxableAmount + PayrollMatrix.Amount;
                    until EarnRec.Next = 0;
                end;
                //End of Low Interest benefits
                TaxableAmount:=Round(TaxableAmount, 0.01, '<');
                TaxableAmountNew:=TaxableAmount;
                // Get PAYE
                FinalTax:=GetTaxBracket(TaxableAmountNew, EmployeeNo);
                // Get Reliefs
                InsuranceRelief:=0;
                // Calculate insurance relief;
                EarnRec.Reset;
                EarnRec.SetCurrentKey(EarnRec."Earning Type");
                EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Insurance Relief");
                if EarnRec.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-')then InsuranceRelief:=InsuranceRelief + PayrollMatrix.Amount;
                    until EarnRec.Next = 0;
                end;
                // Personal Relief
                PersonalRelief:=0;
                EarnRec.Reset;
                EarnRec.SetCurrentKey(EarnRec."Earning Type");
                EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Tax Relief");
                if EarnRec.Find('-')then begin
                    repeat PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(PayrollMatrix.Code, EarnRec.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Employee No", EmployeeNo);
                        if PayrollMatrix.Find('-')then PersonalRelief:=PersonalRelief + PayrollMatrix.Amount;
                    until EarnRec.Next = 0;
                end;
                FinalTax:=FinalTax - (PersonalRelief + InsuranceRelief);
                if FinalTax < 0 then FinalTax:=0;
            end
            else
                FinalTax:=0;
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
    procedure PayrollRounding(var Amount: Decimal)PayrollRounding: Decimal var
        HRsetup: Record "QuantumJumps Payroll Setup";
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
        DecPosistion:=StrPos(amttext, '.');
        Stringlen:=StrLen(amttext);
        if DecPosistion > 0 then begin
            Wholeamt:=CopyStr(amttext, 1, DecPosistion - 1);
            Decplace:=Stringlen - DecPosistion;
            Decvalue:=CopyStr(amttext, DecPosistion + 1, 2);
            if StrLen(Decvalue) = 1 then holdamt:=Decvalue + '0';
            if StrLen(Decvalue) > 1 then begin
                FirstNoText:=CopyStr(Decvalue, 1, 1);
                SecNoText:=CopyStr(Decvalue, 2, 1);
                Evaluate(SecNo, Format(SecNoText));
                if SecNo >= 5 then holdamt:=FirstNoText + '5'
                else
                    holdamt:=FirstNoText + '0' end;
            amttext:=Wholeamt + '.' + holdamt;
            Evaluate(Amttoround, Format(amttext));
        end
        else
        begin
            Evaluate(amttext, Format(Amount));
            Evaluate(Amttoround, Format(amttext));
        end;
        Amount:=Amttoround;
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error(Text001);
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
    procedure InsertDeductionPayrollEntry(var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal)
    var
        PayrollMatrix: Record "Payroll Matrix";
        PayrollMatrix2: Record "Payroll Matrix";
    begin
        GetPayPeriod;
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Deduction);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate("Payroll Period", BeginDate);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(EmployeeNo, PayrollMatrix2.Type::Deduction, Code, BeginDate, '')then PayrollMatrix.Insert
        else
        begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;
    procedure InsertEarningPayrollEntry(var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal)
    var
        PayrollMatrix: Record "Payroll Matrix";
        PayrollMatrix2: Record "Payroll Matrix";
    begin
        GetPayPeriod;
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Payment);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate("Payroll Period", BeginDate);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(EmployeeNo, PayrollMatrix2.Type::Payment, Code, BeginDate, '')then PayrollMatrix.Insert
        else
        begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;
    procedure GeneratePayslip(var EmpNo: Code[20]; var Period: Date)
    var
        Employee: Record "Employee Master";
        PeriodName: Text;
        ClientEmail: List of[Text];
    begin
    /*
              //Generation
              if PayPeriod.Get(Period) then
                  PeriodName := PayPeriod.Name + ' ' + Format(Date2DMY(Period, 3));

              Employee.Reset;
              Employee.SetRange("No.", EmpNo);
              Employee.SetFilter(Employee."Pay Period Filter", '%1', Period);
              if Employee.FindFirst then begin
                  REPORT.SaveAsPdf(51426, 'C:\Program Files\Microsoft Dynamics 365 Business Central\' + Employee."No." + Format(Date2DMY(Period, 2)) + Format(Date2DMY(Period, 3)) + '.pdf', Employee);
              end;

              //Sending

              SMTPSetup.Get;
              ClientRec.Get(EmpNo);
              CompInfo.Get;
              if ClientRec."Company E-Mail" <> '' then
                  //SMTPMail.AddCC(ClientRec."E-Mail");
                  ClientEmail.Add(ClientRec."Company E-Mail");
              ClientEmail.Add(ClientRec."E-Mail");

              SMTPMail.CreateMessage(CompInfo.Name, SMTPSetup."User ID", ClientEmail, 'PAYSLIP FOR THE MONTH OF' + ' ' + UpperCase(PeriodName), '', true);
              //IF ClientRec."E-Mail" <> '' THEN

              SMTPMail.AddCC(ClientEmail);
              SMTPMail.AppendBody('Dear' + ' ' + ClientRec."First Name" + ' ' + ClientRec."Last Name");
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Please find attached your payslip for the month of' + ' ' + PeriodName);
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('For any queries kindly do not hesitate to contact the undersigned.');
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Should you experience any difficulty viewing this attachment, kindly click on the link below to download adobe PDF reader');
              SMTPMail.AppendBody('<br>');
              SMTPMail.AppendBody('from http://www.adobe.com/products/acrobat/readstep2.html.');
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Thank you.');
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('Yours Sincerely,');
              SMTPMail.AppendBody('<br><br>');
              SMTPMail.AppendBody('<b>Payroll Accountant<b>');
              SMTPMail.AppendBody('<br>');
              CompInfo.Get;
              SMTPMail.AppendBody(CompInfo.Name);
              SMTPMail.AppendBody('<br>');

              if FILE.Exists('C:\Program Files\Microsoft Dynamics 365 Business Central\' + Employee."No." + Format(Date2DMY(Period, 2)) + Format(Date2DMY(Period, 3)) + '.pdf') then begin
                  SMTPMail.AddAttachment('C:\Program Files\Microsoft Dynamics 365 Business Central\' + Employee."No." + Format(Date2DMY(Period, 2)) + Format(Date2DMY(Period, 3)) + '.pdf', Employee."No." + Format(Date2DMY(Period, 2)) + Format(Date2DMY(Period, 3)) + '.pdf');
                  SMTPMail.Send;
              end;

              //Deleting
              Erase('C:\Program Files\Microsoft Dynamics 365 Business Central\' + Employee."No." + Format(Date2DMY(Period, 2)) + Format(Date2DMY(Period, 3)) + '.pdf');
*/
    end;
    procedure InsertDeductionPayrollEntrySpecificPeriod(var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal; var Period: Date)
    var
        PayrollMatrix: Record "Payroll Matrix";
        PayrollMatrix2: Record "Payroll Matrix";
    begin
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Deduction);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate("Payroll Period", Period);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(EmployeeNo, PayrollMatrix2.Type::Deduction, Code, Period, '')then PayrollMatrix.Insert
        else
        begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;
    procedure InsertEarningPayrollEntrySpecificPeriod(var EmployeeNo: Code[20]; var "Code": Code[10]; var Amount: Decimal; var Period: Date)
    var
        PayrollMatrix: Record "Payroll Matrix";
        PayrollMatrix2: Record "Payroll Matrix";
    begin
        PayrollMatrix.Init;
        PayrollMatrix.Validate("Employee No", EmployeeNo);
        PayrollMatrix.Validate(Type, PayrollMatrix.Type::Payment);
        PayrollMatrix.Validate(Code, Code);
        PayrollMatrix.Validate("Payroll Period", Period);
        PayrollMatrix.Validate(Amount, Amount);
        if not PayrollMatrix2.Get(EmployeeNo, PayrollMatrix2.Type::Payment, Code, Period, '')then PayrollMatrix.Insert
        else
        begin
            PayrollMatrix2.Validate(Amount, PayrollMatrix2.Amount + Amount);
        end;
    end;
}
