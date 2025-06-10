report 51454 "Client Payroll Calculator"
{
    // version THL- Client Payroll 1.0
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            RequestFilterFields = "No.", "Full Name", "Company Code", "Pay Period Filter";

            trigger OnAfterGetRecord()
            begin
                //*******************************************************************************************************
                IF "Date of Birth" <> 0D THEN BEGIN
                    IF HRSetup.GET(0) THEN BEGIN
                        IF CALCDATE(HRSetup."Minimum Employee Age", "Date of Birth") > TODAY THEN
                            ERROR('Employee bellow the mininmum  age of Employment %1', HRSetup."Minimum Employee Age");

                        IF CALCDATE(HRSetup."Retirement Age", "Date of Birth") < TODAY THEN
                            ERROR('Employee Above the Retirement age of Employment %1', HRSetup."Retirement Age");

                    END;
                END;

                //******************************************************************************************************
                NoOfHoursPerMonth := CalcNoOfWorkingDaysInAmonth(DateSpecified, Employee."Company Code");
                CompRec.Get(Employee."Company Code");
                TaxCode := CompRec."Tax Table";
                if NAVEmp.Get(Employee."No.") then if NAVEmp.Status <> NAVEmp.Status::Active then CurrReport.Skip;
                Employee.SetRange(Employee."Pay Period Filter", DateSpecified);
                Employee.CalcFields(Employee.Basic);
                if NoOfHoursPerMonth <> 0 then RatePerHour := Round(Employee.Basic / NoOfHoursPerMonth);
                if Employee."Country Tax Table" <> '' then TaxCode := Employee."Country Tax Table";
                // // **************** Interdicted **********************
                // if Employee.Status = Employee.Status::Interdicted then begin
                //     // if PayrollMatrix.
                //     if PayrollMatrix."Basic Salary Code" = true then
                //         PayrollMatrix.Amount := PayrollMatrix.Amount * 0.5;
                // end;
                Employee.SetFilter("Date Filter", '%1..%2', DateSpecified, CalcDate('1M', DateSpecified) - 1);
                Employee.CalcFields("Resource Hours");
                if NoOfHoursPerMonth <> Employee."Resource Hours" then begin
                    if NoOfHoursPerMonth > Employee."Resource Hours" then begin //Hours Per Month > Resource Hours
                        Earnings.Reset;
                        Earnings.SetRange(Company, Employee."Company Code");
                        Earnings.SetRange(Earnings."Salary Recovery", true);
                        if Earnings.Find('-') then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(Company, Employee."Company Code");
                            PayrollMatrix.SetRange("Employee No", "No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(Code, Earnings.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            if PayrollMatrix.FindFirst then begin
                                PayrollMatrix.Validate(PayrollMatrix.Code);
                                PayrollMatrix.Amount := Round((NoOfHoursPerMonth - Employee."Resource Hours") * RatePerHour, 1);
                                PayrollMatrix.Validate(PayrollMatrix.Amount);
                                //Update Working hours
                                PayrollMatrix."Expected Hrs" := NoOfHoursPerMonth;
                                PayrollMatrix."Worked Hrs" := Employee."Resource Hours";
                                //
                                //Added Giovanni
                                if not Employee."Use Timesheets" then begin
                                    PayrollMatrix.Amount := 0;
                                    PayrollMatrix."Expected Hrs" := 0;
                                    PayrollMatrix."Worked Hrs" := 0;
                                    PayrollMatrix.Delete;
                                end
                                else
                                    PayrollMatrix.Modify;
                            end
                            else begin
                                PayrollMatrix.Init;
                                PayrollMatrix.Company := Employee."Company Code";
                                PayrollMatrix."Employee No" := Employee."No.";
                                PayrollMatrix.Type := PayrollMatrix.Type::Payment;
                                PayrollMatrix.Code := Earnings.Code;
                                PayrollMatrix.Validate(PayrollMatrix.Code);
                                PayrollMatrix."Payroll Period" := DateSpecified;
                                PayrollMatrix.Amount := Round((NoOfHoursPerMonth - Employee."Resource Hours") * RatePerHour, 1);
                                PayrollMatrix.Validate(PayrollMatrix.Amount);
                                //Update Working hours
                                PayrollMatrix."Expected Hrs" := NoOfHoursPerMonth;
                                PayrollMatrix."Worked Hrs" := Employee."Resource Hours";
                                //
                                //Added Giovanni
                                if not Employee."Use Timesheets" then begin
                                    PayrollMatrix.Amount := 0;
                                    PayrollMatrix."Expected Hrs" := 0;
                                    PayrollMatrix."Worked Hrs" := 0;
                                end;
                                // End Added Giovanni
                                if not PayrollMatrix.Get(PayrollMatrix.Company, PayrollMatrix."Employee No", PayrollMatrix.Type, PayrollMatrix.Code, PayrollMatrix."Payroll Period") and (Employee."Use Timesheets") then PayrollMatrix.Insert;
                            end;
                        end; // ELSE
                    end
                    else begin //***End Hours Per Month > Resource Hours***Hours Per Month < Resource Hours
                        Earnings.Reset;
                        Earnings.SetRange(Company, Employee."Company Code");
                        Earnings.SetRange(Earnings."Salary Recovery", true);
                        if Earnings.Find('-') then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(Company, Employee."Company Code");
                            PayrollMatrix.SetRange("Employee No", "No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(Code, Earnings.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            if PayrollMatrix.FindFirst then begin
                                //Update Working hours
                                PayrollMatrix.Amount := 0;
                                PayrollMatrix."Expected Hrs" := NoOfHoursPerMonth;
                                PayrollMatrix."Worked Hrs" := Employee."Resource Hours";
                                //
                                //Added Giovanni
                                if not Employee."Use Timesheets" then begin
                                    PayrollMatrix.Amount := 0;
                                    PayrollMatrix."Expected Hrs" := 0;
                                    PayrollMatrix."Worked Hrs" := 0;
                                    PayrollMatrix.Delete;
                                end
                                else
                                    // End Added Giovanni
                                    PayrollMatrix.Modify;
                            end
                        end;
                    end;
                end
                else begin
                    Earnings.Reset;
                    Earnings.SetRange(Company, Employee."Company Code");
                    Earnings.SetRange(Earnings."Salary Recovery", true);
                    if Earnings.Find('-') then begin
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange(Company, Employee."Company Code");
                        PayrollMatrix.SetRange("Employee No", "No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(Code, Earnings.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        if PayrollMatrix.FindFirst then begin
                            //Update Working hours
                            PayrollMatrix.Amount := 0;
                            PayrollMatrix."Expected Hrs" := NoOfHoursPerMonth;
                            PayrollMatrix."Worked Hrs" := Employee."Resource Hours";
                            //
                            //Added Giovanni
                            if not Employee."Use Timesheets" then begin
                                PayrollMatrix.Amount := 0;
                                PayrollMatrix."Expected Hrs" := 0;
                                PayrollMatrix."Worked Hrs" := 0;
                                PayrollMatrix.Delete;
                            end
                            else
                                // End Added Giovanni
                                PayrollMatrix.Modify;
                        end
                    end;
                end;
                ClosingBal := 0;
                Deductions.Reset;
                Deductions.SetRange(Company, Employee."Company Code");
                Deductions.SetRange(Deductions.Loan, true);
                if Deductions.Find('-') then begin
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange(Company, Employee."Company Code");
                    PayrollMatrix.SetRange("Employee No", "No.");
                    PayrollMatrix.SetRange(Code, Deductions.Code);
                    if PayrollMatrix.Find('+') then begin
                        RepaymentAmt := PayrollMatrix.Amount;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Employee No", PayrollMatrix."Employee No");
                        LoanApp.SetRange(LoanApp."Loan No", PayrollMatrix."Reference No");
                        if LoanApp.Find('-') then begin
                            if LoanApp."Stop Loan" then begin
                                PayrollMatrix.Reset;
                                PayrollMatrix.SetRange("Employee No", "No.");
                                PayrollMatrix.SetRange(Code, Deductions.Code);
                                PayrollMatrix.SetRange("Payroll Period", DateSpecified);
                                PayrollMatrix.SetRange("Reference No", LoanApp."Loan No");
                                PayrollMatrix.Delete;
                            end;
                            if Loans.Get(LoanApp."Client Loan Product Type") then begin
                                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Flat Rate" then begin
                                    LoanApp.CalcFields("Total Repayment", "Total Loan");
                                    if LoanApp."Total Loan" <> 0 then begin
                                        ClosingBal := LoanApp."Total Loan" + LoanApp."Total Repayment"
                                    end
                                    else
                                        ClosingBal := LoanApp."Approved Amount" + LoanApp."Total Repayment";
                                    if (ClosingBal = 0) or (ClosingBal < Abs(RepaymentAmt)) then begin
                                        PayrollMatrix.Reset;
                                        PayrollMatrix.SetRange("Employee No", "No.");
                                        PayrollMatrix.SetRange(Code, Deductions.Code);
                                        PayrollMatrix.SetRange("Payroll Period", DateSpecified);
                                        PayrollMatrix.Amount := ClosingBal;
                                        PayrollMatrix.Modify;
                                    end;
                                end
                                else if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Reducing Balance" then begin //Amortization
                                end;
                            end;
                        end;
                    end;
                end;
                Earnings.Reset;
                Earnings.SetRange(Company, Employee."Company Code");
                Earnings.SetRange(Earnings."Basic Salary Code", true);
                if Earnings.Find('-') then BasicSalaryCode := Earnings.Code;
                if ScaleBenefits.Get(Employee."Company Code", Employee.Scale, Employee.Level, BasicSalaryCode) then begin
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange(Company, Employee."Company Code");
                    PayrollMatrix.SetRange(PayrollMatrix.Code, BasicSalaryCode);
                    PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                    PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                    PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                    if PayrollMatrix.Find('-') then begin
                        PayrollMatrix.Amount := ScaleBenefits.Amount;
                        if PayrollMatrix."Manual Entry" = false then PayrollMatrix.Modify;
                        if PayrollMatrix.Modify then;
                    end
                    else begin
                        PayrollMatrix.Init;
                        PayrollMatrix."Employee No" := Employee."No.";
                        PayrollMatrix.Type := PayrollMatrix.Type::Payment;
                        PayrollMatrix.Code := BasicSalaryCode;
                        PayrollMatrix.Validate(PayrollMatrix.Code);
                        PayrollMatrix."Payroll Period" := Month;
                        PayrollMatrix.Amount := ScaleBenefits.Amount;
                        PayrollMatrix."Manual Entry" := false;
                        PayrollMatrix.Insert;
                        if PayrollMatrix.Insert then;
                    end;
                end;
                Deductions.Reset;
                Deductions.SetRange(Company, Employee."Company Code");
                Deductions.SetRange(Deductions."PAYE Code", true);
                if Deductions.Find('-') then begin
                    // Delete all Previous PAYE
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange(Company, Employee."Company Code");
                    PayrollMatrix.SetRange(PayrollMatrix.Code, Deductions.Code);
                    PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                    PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                    PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                    PayrollMatrix.DeleteAll;
                    // end of deletion
                end;
                // validate assigment matrix code incase basic salary change and update calculation based on basic salary
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(Company, Employee."Company Code");
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                if PayrollMatrix.Find('-') then begin
                    repeat
                        if PayrollMatrix.Type = PayrollMatrix.Type::Payment then begin
                            if Earnings.Get(Employee."Company Code", PayrollMatrix.Code) then begin
                                if (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic pay") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic after tax") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"Based on Hourly Rate") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Insurance Amount") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of SHIF") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Loan Amount") then begin
                                    PayrollMatrix.Validate(Code);
                                    PayrollMatrix.Amount := (PayrollMatrix.Amount);
                                    PayrollMatrix.Modify;
                                end;
                            end;
                        end;
                        if PayrollMatrix.Retirement = false then begin
                            if PayrollMatrix.Type = PayrollMatrix.Type::Deduction then begin
                                if Deductions.Get(Employee."Company Code", PayrollMatrix.Code) then begin
                                    if (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic + Regular Allowances") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ") then begin
                                        PayrollMatrix.Validate(Code);
                                        PayrollMatrix.Amount := (PayrollMatrix.Amount);
                                        PayrollMatrix.Modify;
                                    end;
                                end;
                            end;
                        end;
                        if PayrollMatrix.Retirement = true then begin
                            if PayrollMatrix.Type = PayrollMatrix.Type::Deduction then begin
                                if Deductions.Get(Employee."Company Code", PayrollMatrix.Code) then begin
                                    if (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ") then begin
                                        PayrollMatrix.Validate(Code);
                                        PayrollMatrix.Amount := (PayrollMatrix.Amount);
                                        PayrollMatrix.Modify;
                                    end;
                                end;
                            end;
                        end;
                        if PayrollMatrix.Type = PayrollMatrix.Type::Deduction then begin
                            if Deductions.Get(Employee."Company Code", PayrollMatrix.Code) then begin
                                if (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table") and (Deductions."PAYE Code" = false) then begin
                                    PayrollMatrix.Validate(Code);
                                    //Message('code%1', PayrollMatrix.Code);
                                    PayrollMatrix.Amount := Round(PayrollMatrix.Amount, 1);
                                    PayrollMatrix.Modify;
                                end;
                            end;
                        end;
                    until PayrollMatrix.Next = 0;
                end;
                if Employee."Employee Group" <> '' then begin
                    Deductions.Reset;
                    Deductions.SetRange(Company, Employee."Company Code");
                    Deductions.SetRange(Deductions."PAYE Code", true);
                    if Deductions.Find('-') then begin
                        PayrollCalc.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetirementCont, Employee."Company Code");
                        // Create PAYE
                        //  Message('RetirementCont is%1', RetirementCont);
                        PayrollMatrix.Init;
                        PayrollMatrix.Company := Employee."Company Code";
                        PayrollMatrix."Employee No" := Employee."No.";
                        PayrollMatrix.Type := PayrollMatrix.Type::Deduction;
                        PayrollMatrix.Code := Deductions.Code;
                        PayrollMatrix.Validate(Code);
                        PayrollMatrix."Payroll Period" := Month;
                        PayrollMatrix."Global Dimension 1 code" := Employee."Global Dimension 1 Code";
                        PayrollMatrix."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                        if IncomeTax > 0 then IncomeTax := -IncomeTax;
                        PayrollMatrix.Amount := IncomeTax;
                        PayrollMatrix.Paye := true;
                        PayrollMatrix."Taxable amount" := TaxableAmount;
                        PayrollMatrix."Less Pension Contribution" := RetirementCont;
                        PayrollMatrix.Paye := true;
                        PayrollMatrix."Payroll Group" := Employee."Employee Group";
                        PayrollMatrix.Validate("Payroll Group");
                        PayrollMatrix.Validate(Amount);
                        if (PayrollMatrix."Taxable amount" <> 0) then PayrollMatrix.Insert;
                    end
                    else
                        Error('Must specify Paye Code under deductions');
                end;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(Company, Employee."Company Code");
                PayrollMatrix.SetRange(PayrollMatrix.Code, '869');
                PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                PayrollMatrix.DeleteAll;
                RefNo := 'INT-000';
                LoanBalance := 0;
                TotalTopUp := 0;
                InterestAmt := 0;
                LoanApplication.Reset;
                LoanApplication.SetRange(LoanApplication."Employee No", "No.");
                LoanApplication.SetRange("Stop Loan", false);
                if LoanApplication.Find('-') then
                    repeat
                        RefNo := IncStr(RefNo);
                        if LoanType.Get(LoanApplication."Client Loan Product Type") then begin
                            if LoanType."Calculate Interest" then begin
                                if LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::"Flat Rate" then begin
                                    LoanApplication.SetRange("Date filter", 0D, LastMonth);
                                    LoanApplication.CalcFields("Total Loan", "Total Repayment");
                                    if LoanApplication."Total Loan" <> 0 then begin
                                        LoanTopup.Reset;
                                        LoanTopup.SetCurrentKey("Loan No", "Payroll Period");
                                        LoanTopup.SetRange("Loan No", LoanApplication."Loan No");
                                        LoanTopup.SetRange("Payroll Period", 0D, Month);
                                        LoanTopup.CalcSums(Amount);
                                        LoanBalance := LoanTopup.Amount + LoanApplication."Total Repayment"
                                    end
                                    else
                                        LoanBalance := LoanApplication."Approved Amount" + LoanApplication."Total Repayment";
                                    InterestAmt := LoanType."Interest Rate" / 100 / 12 * LoanBalance;
                                    Informational := false;
                                end
                                else if LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::"Reducing Balance" then begin
                                    InterestAmt := 0;
                                    RepSchedule.Reset;
                                    RepSchedule.SetRange(RepSchedule."Loan No", LoanApplication."Loan No");
                                    RepSchedule.SetRange("Employee No", LoanApplication."Employee No");
                                    RepSchedule.SetRange("Repayment Date", Month);
                                    if RepSchedule.Find('-') then begin
                                        Informational := true;
                                        InterestAmt := RepSchedule."Monthly Interest";
                                        PayrollMatrix.Init;
                                        PayrollMatrix.Company := Employee."Company Code";
                                        PayrollMatrix."Employee No" := Employee."No.";
                                        PayrollMatrix.Type := PayrollMatrix.Type::Deduction;
                                        PayrollMatrix.Code := LoanType."Principal Deduction Code";
                                        PayrollMatrix.Validate(Code);
                                        PayrollMatrix."Payroll Period" := Month;
                                        PayrollMatrix."Global Dimension 1 code" := Employee."Global Dimension 1 Code";
                                        PayrollMatrix."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                                        PayrollMatrix.Amount := -Abs(RepSchedule."Monthly Repayment" - RepSchedule."Monthly Interest");
                                        PayrollMatrix.Validate(Amount);
                                        PayrollMatrix.Information := true;
                                        PayrollMatrix."Reference No" := LoanApplication."Loan No";
                                        PayrollMatrix."Payroll Group" := Employee."Employee Group";
                                        PayrollMatrix.Validate("Payroll Group");
                                        if not PayrollMatrix.Get(Employee."Company Code", PayrollMatrix."Employee No", PayrollMatrix.Type, PayrollMatrix.Code, PayrollMatrix."Payroll Period", PayrollMatrix."Reference No") then // BEGIN
                                            PayrollMatrix.Insert
                                        else
                                            PayrollMatrix.Modify;
                                    end;
                                end;
                            end
                            else
                                InterestAmt := 0;
                            InterestAmt := PayrollRounding(InterestAmt, Employee."Company Code");
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(Company, Employee."Company Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Interest Deduction Code");
                            PayrollMatrix.Init;
                            PayrollMatrix.Company := Employee."Company Code";
                            PayrollMatrix."Employee No" := Employee."No.";
                            PayrollMatrix.Type := PayrollMatrix.Type::Deduction;
                            PayrollMatrix.Code := LoanType."Interest Deduction Code";
                            PayrollMatrix.Validate(Code);
                            PayrollMatrix."Payroll Period" := Month;
                            PayrollMatrix."Global Dimension 1 code" := Employee."Global Dimension 1 Code";
                            PayrollMatrix."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                            PayrollMatrix.Amount := -Abs(InterestAmt);
                            PayrollMatrix.Validate(Amount);
                            if Informational then PayrollMatrix.Information := true;
                            PayrollMatrix."Reference No" := LoanApplication."Loan No";
                            PayrollMatrix."Payroll Group" := Employee."Employee Group";
                            PayrollMatrix.Validate("Payroll Group");
                            if not PayrollMatrix.Get(PayrollMatrix.Company, PayrollMatrix."Employee No", PayrollMatrix.Type, PayrollMatrix.Code, PayrollMatrix."Payroll Period", PayrollMatrix."Reference No") then begin
                                if PayrollMatrix.Amount <> 0 then PayrollMatrix.Insert;
                            end
                            else begin
                                PayrollMatrix.Amount := -Abs(InterestAmt);
                                PayrollMatrix.Modify;
                                if PayrollMatrix.Amount = 0 then PayrollMatrix.Delete;
                            end;
                        end;
                        if LoanApplication."Stop Loan" then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(Company, Employee."Company Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Deduction Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.DeleteAll;
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(Company, Employee."Company Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Interest Deduction Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.DeleteAll;
                        end;
                    until LoanApplication.Next = 0;
                LoanApplication.Reset;
                LoanApplication.SetRange(LoanApplication."Employee No", "No.");
                LoanApplication.SetRange("Stop Loan", true);
                if LoanApplication.Find('-') then
                    repeat
                        LoanType.Reset;
                        if LoanType.Get(LoanApplication."Client Loan Product Type") then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(Company, Employee."Company Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Deduction Code");
                            PayrollMatrix.DeleteAll;
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(Company, Employee."Company Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Interest Deduction Code");
                            PayrollMatrix.DeleteAll;
                        end;
                    until LoanApplication.Next = 0;
                Window.Update(1, Employee."No.");
            end;

            trigger OnPreDataItem()
            begin
                Window.Open(Text003, EmployeeName);
                PayrollPeriod.SetRange(Closed, false);
                if PayrollPeriod.Find('-') then Month := PayrollPeriod."Starting Date";
                LastMonth := CalcDate('-1M', Month);
            end;

            trigger OnPostDataItem()
            var
                Text00000001: Label 'Payroll Processing Completed Successfully';
            begin
                Message(Text00000001);
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
    trigger OnPreReport()
    begin
        GetPayPeriod;
        DateSpecified := BeginDate;
        if PayPeriod.Get(DateSpecified) then PayPeriodtext := PayPeriod.Name;
        EndDate := CalcDate('1M', DateSpecified - 1);
    end;

    var
        HRSetup: Record "Human Resources Setup";

        AmountRemaining: Decimal;
        TaxCode: Code[10];
        IncomeTax: Decimal;
        PayPeriod: Record "Client Payroll Period";
        BeginDate: Date;
        Text000: Label 'You must specify the rounding precision under QuantumJumps Payroll setup.';
        Text001: Label 'Please setup working hours per day on QuantumJumps Payroll setup.';
        Text002: Label 'Please specify a date period.';
        DateSpecified: Date;
        PayPeriodtext: Text[30];
        EndDate: Date;
        CompRec: Record "Client Payroll Setup";
        NoOfHoursPerMonth: Decimal;
        Window: Dialog;
        Text003: Label 'Calculating Values for ##############################1';
        EmployeeName: Text;
        PayrollPeriod: Record "Client Payroll Period";
        Month: Date;
        LastMonth: Date;
        RatePerHour: Decimal;
        ResourceRec: Record Resource;
        Earnings: Record "Client Earnings";
        PayrollMatrix: Record "Client Payroll Matrix";
        ClosingBal: Decimal;
        Deductions: Record "Client Deductions";
        RepaymentAmt: Decimal;
        LoanApp: Record "Client Loan Application";
        Loans: Record "Client Loan Product";
        BasicSalaryCode: Code[10];
        ScaleBenefits: Record "Client Scale Benefits";
        TaxableAmount: Decimal;
        RetirementCont: Decimal;
        RefNo: Code[10];
        LoanBalance: Decimal;
        TotalTopUp: Decimal;
        InterestAmt: Decimal;
        LoanApplication: Record "Client Loan Application";
        LoanType: Record "Client Loan Product";
        LoanTopup: Record "Client Loan Top-up";
        Informational: Boolean;
        RepSchedule: Record "Client Loan Schedule";
        PayrollCalc: Codeunit "Client Payroll Calculator";
        NAVEmp: Record "Client Employee Master";

    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record "Client Bracket";
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := Round(AmountRemaining, 0.01);
        EndTax := false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-') then begin
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if Round((TaxableAmount), 0.01) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax, Employee."Company Code");
        IncomeTax := -TotalTax;
        if not Employee."Pays Tax" then IncomeTax := 0;
    end;

    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            BeginDate := PayPeriod."Starting Date";
        end;
    end;

    procedure PayrollRounding(var Amount: Decimal; var Company: Code[20]) PayrollRounding: Decimal
    var
        HRsetup: Record "Client Payroll Setup";
    begin
        HRsetup.Get(Company);
        if HRsetup."Payroll Rounding Precision" = 0 then Error(Text000);
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding := Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    procedure CalculateUnderOverHrs(var StartDate: Date; var EmpNo: Code[20]) PayrollValue: Decimal
    var
        BaseCalendar: Record Date;
        CompanyInfo: Record "Company Information";
        ResourceRec: Record Resource;
    begin
    end;

    procedure CalcNoOfWorkingDaysInAmonth(var StartDate: Date; var Company: Code[20]) NoOfHrsPerMonth: Decimal
    var
        CompInfo: Record "Company Information";
        CalenderRec: Record Date;
        NextDate: Date;
        EndDate: Date;
        CalendarMgmt: Codeunit "AL Calendar Management";
        Description: Text;
        NoOfWorkingDays: Integer;
        HRSetup: Record "Client Payroll Setup";
    begin
        HRSetup.Get(Company);
        if StartDate <> 0D then begin
            NextDate := StartDate;
            EndDate := CalcDate('1M', NextDate) - 1;
            repeat
                if not CalendarMgmt.CheckDateStatus(HRSetup."Base Calendar Code", NextDate, Description) then NoOfWorkingDays := NoOfWorkingDays + 1;
                NextDate := CalcDate('1D', NextDate);
            until NextDate > EndDate;
            if HRSetup."Working Hours" = 0 then Error(Text001);
            NoOfHrsPerMonth := NoOfWorkingDays * HRSetup."Working Hours";
        end
        else
            Error(Text002);
    end;
}
