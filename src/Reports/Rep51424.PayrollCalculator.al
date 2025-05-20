report 51424 "Payroll Calculator"
{
    // version THL- Payroll 1.0
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Employee; "Employee Master")
        {
            RequestFilterFields = "No.", "Pay Period Filter";

            trigger OnAfterGetRecord()
            begin
                if NAVEmp.Get(Employee."No.")then if NAVEmp.Status <> NAVEmp.Status::Active then CurrReport.Skip;
                Employee.SetRange(Employee."Pay Period Filter", DateSpecified);
                Employee.CalcFields(Employee.Basic);
                if NoOfHoursPerMonth <> 0 then RatePerHour:=Round(Employee.Basic / NoOfHoursPerMonth);
                if Employee."Country Tax Table" <> '' then TaxCode:=Employee."Country Tax Table";
                Employee.SetFilter("Date Filter", '%1..%2', DateSpecified, CalcDate('1M', DateSpecified) - 1);
                Employee.CalcFields("Resource Hours");
                if NoOfHoursPerMonth <> Employee."Resource Hours" then begin
                    if NoOfHoursPerMonth > Employee."Resource Hours" then begin //Hours Per Month > Resource Hours
                        Earnings.Reset;
                        Earnings.SetRange(Earnings."Salary Recovery", true);
                        if Earnings.Find('-')then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange("Employee No", "No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(Code, Earnings.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            if PayrollMatrix.FindFirst then begin
                                PayrollMatrix.Validate(PayrollMatrix.Code);
                                PayrollMatrix.Amount:=Round((NoOfHoursPerMonth - Employee."Resource Hours") * RatePerHour, 1);
                                PayrollMatrix.Validate(PayrollMatrix.Amount);
                                //Update Working hours
                                PayrollMatrix."Expected Hrs":=NoOfHoursPerMonth;
                                PayrollMatrix."Worked Hrs":=Employee."Resource Hours";
                                //
                                //Added Giovanni
                                if not Employee."Use Timesheets" then begin
                                    PayrollMatrix.Amount:=0;
                                    PayrollMatrix."Expected Hrs":=0;
                                    PayrollMatrix."Worked Hrs":=0;
                                    PayrollMatrix.Delete;
                                end
                                else
                                    PayrollMatrix.Modify;
                            end
                            else
                            begin
                                PayrollMatrix.Init;
                                PayrollMatrix."Employee No":=Employee."No.";
                                PayrollMatrix.Type:=PayrollMatrix.Type::Payment;
                                PayrollMatrix.Code:=Earnings.Code;
                                PayrollMatrix.Validate(PayrollMatrix.Code);
                                PayrollMatrix."Payroll Period":=DateSpecified;
                                PayrollMatrix.Amount:=Round((NoOfHoursPerMonth - Employee."Resource Hours") * RatePerHour, 1);
                                PayrollMatrix.Validate(PayrollMatrix.Amount);
                                //Update Working hours
                                PayrollMatrix."Expected Hrs":=NoOfHoursPerMonth;
                                PayrollMatrix."Worked Hrs":=Employee."Resource Hours";
                                //
                                //Added Giovanni
                                if not Employee."Use Timesheets" then begin
                                    PayrollMatrix.Amount:=0;
                                    PayrollMatrix."Expected Hrs":=0;
                                    PayrollMatrix."Worked Hrs":=0;
                                end;
                                // End Added Giovanni
                                if not PayrollMatrix.Get(PayrollMatrix."Employee No", PayrollMatrix.Type, PayrollMatrix.Code, PayrollMatrix."Payroll Period") and (Employee."Use Timesheets")then PayrollMatrix.Insert;
                            end;
                        end; // ELSE
                    end
                    else
                    begin //***End Hours Per Month > Resource Hours***Hours Per Month < Resource Hours
                        Earnings.Reset;
                        Earnings.SetRange(Earnings."Salary Recovery", true);
                        if Earnings.Find('-')then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange("Employee No", "No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                            PayrollMatrix.SetRange(Code, Earnings.Code);
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            if PayrollMatrix.FindFirst then begin
                                //Update Working hours
                                PayrollMatrix.Amount:=0;
                                PayrollMatrix."Expected Hrs":=NoOfHoursPerMonth;
                                PayrollMatrix."Worked Hrs":=Employee."Resource Hours";
                                //
                                //Added Giovanni
                                if not Employee."Use Timesheets" then begin
                                    PayrollMatrix.Amount:=0;
                                    PayrollMatrix."Expected Hrs":=0;
                                    PayrollMatrix."Worked Hrs":=0;
                                    PayrollMatrix.Delete;
                                end
                                else
                                    // End Added Giovanni
                                    PayrollMatrix.Modify;
                            end end;
                    end;
                end
                else
                begin
                    Earnings.Reset;
                    Earnings.SetRange(Earnings."Salary Recovery", true);
                    if Earnings.Find('-')then begin
                        PayrollMatrix.Reset;
                        PayrollMatrix.SetRange("Employee No", "No.");
                        PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                        PayrollMatrix.SetRange(Code, Earnings.Code);
                        PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                        if PayrollMatrix.FindFirst then begin
                            //Update Working hours
                            PayrollMatrix.Amount:=0;
                            PayrollMatrix."Expected Hrs":=NoOfHoursPerMonth;
                            PayrollMatrix."Worked Hrs":=Employee."Resource Hours";
                            //
                            //Added Giovanni
                            if not Employee."Use Timesheets" then begin
                                PayrollMatrix.Amount:=0;
                                PayrollMatrix."Expected Hrs":=0;
                                PayrollMatrix."Worked Hrs":=0;
                                PayrollMatrix.Delete;
                            end
                            else
                                // End Added Giovanni
                                PayrollMatrix.Modify;
                        end end;
                end;
                ClosingBal:=0;
                Deductions.Reset;
                Deductions.SetRange(Deductions.Loan, true);
                if Deductions.Find('-')then begin
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange("Employee No", "No.");
                    PayrollMatrix.SetRange(Code, Deductions.Code);
                    if PayrollMatrix.Find('+')then begin
                        RepaymentAmt:=PayrollMatrix.Amount;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Employee No", PayrollMatrix."Employee No");
                        LoanApp.SetRange(LoanApp."Loan No", PayrollMatrix."Reference No");
                        if LoanApp.Find('-')then begin
                            if LoanApp."Stop Loan" then begin
                                PayrollMatrix.Reset;
                                PayrollMatrix.SetRange("Employee No", "No.");
                                PayrollMatrix.SetRange(Code, Deductions.Code);
                                PayrollMatrix.SetRange("Payroll Period", DateSpecified);
                                PayrollMatrix.SetRange("Reference No", LoanApp."Loan No");
                                PayrollMatrix.Delete;
                            end;
                            UpdateLoansPayrollMatrix(PayrollMatrix."Employee No", PayrollMatrix."Reference No");
                            if Loans.Get(LoanApp."Loan Product Type")then begin
                                if Loans."Interest Calculation Method" = Loans."Interest Calculation Method"::"Flat Rate" then begin
                                    LoanApp.CalcFields("Total Repayment", "Total Loan");
                                    if LoanApp."Total Loan" <> 0 then begin
                                        ClosingBal:=LoanApp."Total Loan" + LoanApp."Total Repayment" end
                                    else
                                        ClosingBal:=LoanApp."Approved Amount" + LoanApp."Total Repayment";
                                    if(ClosingBal = 0) or (ClosingBal < Abs(RepaymentAmt))then begin
                                        PayrollMatrix.Reset;
                                        PayrollMatrix.SetRange("Employee No", "No.");
                                        PayrollMatrix.SetRange(Code, Deductions.Code);
                                        PayrollMatrix.SetRange("Payroll Period", DateSpecified);
                                        PayrollMatrix.Amount:=ClosingBal;
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
                Earnings.SetRange(Earnings."Basic Salary Code", true);
                if Earnings.Find('-')then BasicSalaryCode:=Earnings.Code;
                if ScaleBenefits.Get(Employee.Scale, Employee.Level, BasicSalaryCode)then begin
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange(PayrollMatrix.Code, BasicSalaryCode);
                    PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                    PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                    PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                    if PayrollMatrix.Find('-')then begin
                        PayrollMatrix.Amount:=ScaleBenefits.Amount;
                        if PayrollMatrix."Manual Entry" = false then PayrollMatrix.Modify;
                        if PayrollMatrix.Modify then;
                    end
                    else
                    begin
                        PayrollMatrix.Init;
                        PayrollMatrix."Employee No":=Employee."No.";
                        PayrollMatrix.Type:=PayrollMatrix.Type::Payment;
                        PayrollMatrix.Code:=BasicSalaryCode;
                        PayrollMatrix.Validate(PayrollMatrix.Code);
                        PayrollMatrix."Payroll Period":=Month;
                        PayrollMatrix.Amount:=ScaleBenefits.Amount;
                        PayrollMatrix."Manual Entry":=false;
                        PayrollMatrix.Insert;
                        if PayrollMatrix.Insert then;
                    end;
                end;
                Deductions.Reset;
                Deductions.SetRange(Deductions."PAYE Code", true);
                if Deductions.Find('-')then begin
                    // Delete all Previous PAYE
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange(PayrollMatrix.Code, Deductions.Code);
                    PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                    PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                    PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                    PayrollMatrix.DeleteAll;
                // end of deletion
                end;
                // validate assigment matrix code incase basic salary change and update calculation based on basic salary
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                if PayrollMatrix.Find('-')then begin
                    repeat if PayrollMatrix.Type = PayrollMatrix.Type::Payment then begin
                            if Earnings.Get(PayrollMatrix.Code)then begin
                                if(Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic pay") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic after tax") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"Based on Hourly Rate") or (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Loan Amount")then begin
                                    PayrollMatrix.Validate(Code);
                                    PayrollMatrix.Amount:=(PayrollMatrix.Amount);
                                    PayrollMatrix.Modify;
                                end;
                            end;
                        end;
                        if PayrollMatrix.Retirement = false then begin
                            if PayrollMatrix.Type = PayrollMatrix.Type::Deduction then begin
                                if Deductions.Get(PayrollMatrix.Code)then begin
                                    if(Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ")then begin
                                        PayrollMatrix.Validate(Code);
                                        PayrollMatrix.Amount:=(PayrollMatrix.Amount);
                                        PayrollMatrix.Modify;
                                    end;
                                end;
                            end;
                        end;
                        if PayrollMatrix.Retirement = true then begin
                            if PayrollMatrix.Type = PayrollMatrix.Type::Deduction then begin
                                if Deductions.Get(PayrollMatrix.Code)then begin
                                    if(Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ")then begin
                                        PayrollMatrix.Validate(Code);
                                        PayrollMatrix.Amount:=(PayrollMatrix.Amount);
                                        PayrollMatrix.Modify;
                                    end;
                                end;
                            end;
                        end;
                        if PayrollMatrix.Type = PayrollMatrix.Type::Deduction then begin
                            if Deductions.Get(PayrollMatrix.Code)then begin
                                if(Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table") and (Deductions."PAYE Code" = false)then begin
                                    PayrollMatrix.Validate(Code);
                                    PayrollMatrix.Amount:=Round(PayrollMatrix.Amount, 1);
                                    PayrollMatrix.Modify;
                                end;
                            end;
                        end;
                    until PayrollMatrix.Next = 0;
                end;
                if Employee."Employee Group" <> 'BOARD' then begin
                    Deductions.Reset;
                    Deductions.SetRange(Deductions."PAYE Code", true);
                    if Deductions.Find('-')then begin
                        PayrollCalc.CalculateTaxableAmount(Employee."No.", Month, IncomeTax, TaxableAmount, RetirementCont);
                        // Create PAYE
                        PayrollMatrix.Init;
                        PayrollMatrix."Employee No":=Employee."No.";
                        PayrollMatrix.Type:=PayrollMatrix.Type::Deduction;
                        PayrollMatrix.Code:=Deductions.Code;
                        PayrollMatrix.Validate(Code);
                        PayrollMatrix."Payroll Period":=Month;
                        PayrollMatrix."Global Dimension 1 code":=Employee."Global Dimension 1 Code";
                        PayrollMatrix."Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
                        if IncomeTax > 0 then IncomeTax:=-IncomeTax;
                        PayrollMatrix.Amount:=IncomeTax;
                        PayrollMatrix.Paye:=true;
                        PayrollMatrix."Taxable amount":=TaxableAmount;
                        PayrollMatrix."Less Pension Contribution":=RetirementCont;
                        PayrollMatrix.Paye:=true;
                        PayrollMatrix."Payroll Group":=Employee."Employee Group";
                        PayrollMatrix.Validate(Amount);
                        if(PayrollMatrix."Taxable amount" <> 0)then PayrollMatrix.Insert;
                    end
                    else
                        Error('Must specify Paye Code under deductions');
                end;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(PayrollMatrix.Code, '869');
                PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                PayrollMatrix.DeleteAll;
                RefNo:='INT-000';
                LoanBalance:=0;
                TotalTopUp:=0;
                InterestAmt:=0;
                LoanApplication.Reset;
                LoanApplication.SetRange(LoanApplication."Employee No", "No.");
                LoanApplication.SetRange("Stop Loan", false);
                if LoanApplication.Find('-')then repeat RefNo:=IncStr(RefNo);
                        if LoanType.Get(LoanApplication."Loan Product Type")then begin
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
                                        LoanBalance:=LoanTopup.Amount + LoanApplication."Total Repayment" end
                                    else
                                        LoanBalance:=LoanApplication."Approved Amount" + LoanApplication."Total Repayment";
                                    InterestAmt:=LoanType."Interest Rate" / 100 / 12 * LoanBalance;
                                    Informational:=false;
                                end
                                else if LoanType."Interest Calculation Method" = LoanType."Interest Calculation Method"::"Reducing Balance" then begin
                                        InterestAmt:=0;
                                        RepSchedule.Reset;
                                        RepSchedule.SetRange(RepSchedule."Loan No", LoanApplication."Loan No");
                                        RepSchedule.SetRange("Employee No", LoanApplication."Employee No");
                                        RepSchedule.SetRange("Repayment Date", Month);
                                        if RepSchedule.Find('-')then begin
                                            Informational:=true;
                                            InterestAmt:=RepSchedule."Monthly Interest";
                                            PayrollMatrix.Init;
                                            PayrollMatrix."Employee No":=Employee."No.";
                                            PayrollMatrix.Type:=PayrollMatrix.Type::Deduction;
                                            PayrollMatrix.Code:=LoanType."Principal Deduction Code";
                                            PayrollMatrix.Validate(Code);
                                            PayrollMatrix."Payroll Period":=Month;
                                            PayrollMatrix."Global Dimension 1 code":=Employee."Global Dimension 1 Code";
                                            PayrollMatrix."Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
                                            PayrollMatrix.Amount:=-Abs(RepSchedule."Monthly Repayment" - RepSchedule."Monthly Interest");
                                            PayrollMatrix.Validate(Amount);
                                            PayrollMatrix.Information:=true;
                                            PayrollMatrix."Reference No":=LoanApplication."Loan No";
                                            PayrollMatrix."Payroll Group":=Employee."Employee Group";
                                            if not PayrollMatrix.Get(PayrollMatrix."Employee No", PayrollMatrix.Type, PayrollMatrix.Code, PayrollMatrix."Payroll Period", PayrollMatrix."Reference No")then // BEGIN
 PayrollMatrix.Insert
                                            else
                                                PayrollMatrix.Modify;
                                        end;
                                    end;
                            end
                            else
                                InterestAmt:=0;
                            InterestAmt:=PayrollRounding(InterestAmt);
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", Month);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Interest Deduction Code");
                            PayrollMatrix.Init;
                            PayrollMatrix."Employee No":=Employee."No.";
                            PayrollMatrix.Type:=PayrollMatrix.Type::Deduction;
                            PayrollMatrix.Code:=LoanType."Interest Deduction Code";
                            PayrollMatrix.Validate(Code);
                            PayrollMatrix."Payroll Period":=Month;
                            PayrollMatrix."Global Dimension 1 code":=Employee."Global Dimension 1 Code";
                            PayrollMatrix."Global Dimension 2 Code":=Employee."Global Dimension 2 Code";
                            PayrollMatrix.Amount:=-Abs(InterestAmt);
                            PayrollMatrix.Validate(Amount);
                            if Informational then PayrollMatrix.Information:=true;
                            PayrollMatrix."Reference No":=LoanApplication."Loan No";
                            PayrollMatrix."Payroll Group":=Employee."Employee Group";
                            if not PayrollMatrix.Get(PayrollMatrix."Employee No", PayrollMatrix.Type, PayrollMatrix.Code, PayrollMatrix."Payroll Period", PayrollMatrix."Reference No")then begin
                                if PayrollMatrix.Amount <> 0 then PayrollMatrix.Insert;
                            end
                            else
                            begin
                                PayrollMatrix.Amount:=-Abs(InterestAmt);
                                PayrollMatrix.Modify;
                                if PayrollMatrix.Amount = 0 then PayrollMatrix.Delete;
                            end;
                        end;
                        if LoanApplication."Stop Loan" then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Deduction Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.DeleteAll;
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Interest Deduction Code");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.DeleteAll;
                        end;
                    until LoanApplication.Next = 0;
                LoanApplication.Reset;
                LoanApplication.SetRange(LoanApplication."Employee No", "No.");
                LoanApplication.SetRange("Stop Loan", true);
                if LoanApplication.Find('-')then repeat LoanType.Reset;
                        if LoanType.Get(LoanApplication."Loan Product Type")then begin
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Deduction Code");
                            PayrollMatrix.DeleteAll;
                            PayrollMatrix.Reset;
                            PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                            PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                            PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                            PayrollMatrix.SetRange(PayrollMatrix."Reference No", LoanApplication."Loan No");
                            PayrollMatrix.SetRange(PayrollMatrix.Code, LoanType."Interest Deduction Code");
                            PayrollMatrix.DeleteAll;
                        end;
                    until LoanApplication.Next = 0;
                PayrollMonth:=0;
                PayrollYear:=0;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange(PayrollMatrix."Payroll Period", DateSpecified);
                PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Payment);
                PayrollMatrix.SetRange(PayrollMatrix."Employee No", Employee."No.");
                PayrollMatrix.SetRange(Code, '006');
                if PayrollMatrix.FindFirst then begin
                    PayrollMonth:=Date2DMY(DateSpecified, 2);
                    PayrollYear:=Date2DMY(DateSpecified, 3);
                    PayrollMatrix."No. Of Days Worked":=Date2DMY(CalcDate('CM', DMY2Date(1, PayrollMonth, PayrollYear)), 1);
                    PayrollMatrix.Validate("No. Of Days Worked");
                    PayrollMatrix.Modify;
                end;
                Window.Update(1, Employee."No.");
            end;
            trigger OnPreDataItem()
            begin
                Window.Open(Text003, EmployeeName);
                PayrollPeriod.SetRange(Closed, false);
                if PayrollPeriod.Find('-')then Month:=PayrollPeriod."Starting Date";
                LastMonth:=CalcDate('-1M', Month);
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
        DateSpecified:=BeginDate;
        if PayPeriod.Get(DateSpecified)then PayPeriodtext:=PayPeriod.Name;
        EndDate:=CalcDate('1M', DateSpecified - 1);
        CompRec.Get;
        TaxCode:=CompRec."Tax Table";
        NoOfHoursPerMonth:=CalcNoOfWorkingDaysInAmonth(DateSpecified);
    end;
    var AmountRemaining: Decimal;
    TaxCode: Code[10];
    IncomeTax: Decimal;
    PayPeriod: Record "Payroll Period";
    BeginDate: Date;
    Text000: Label 'You must specify the rounding precision under QuantumJumps Payroll setup.';
    Text001: Label 'Please setup working hours per day on QuantumJumps Payroll setup.';
    Text002: Label 'Please specify a date period.';
    DateSpecified: Date;
    PayPeriodtext: Text[30];
    EndDate: Date;
    CompRec: Record "QuantumJumps Payroll Setup";
    NoOfHoursPerMonth: Decimal;
    Window: Dialog;
    Text003: Label 'Calculating Values for ##############################1';
    EmployeeName: Text;
    PayrollPeriod: Record "Payroll Period";
    Month: Date;
    LastMonth: Date;
    RatePerHour: Decimal;
    ResourceRec: Record Resource;
    Earnings: Record Earnings;
    PayrollMatrix: Record "Payroll Matrix";
    ClosingBal: Decimal;
    Deductions: Record Deductions;
    RepaymentAmt: Decimal;
    LoanApp: Record "Loan Application";
    Loans: Record "Loan Product";
    BasicSalaryCode: Code[10];
    ScaleBenefits: Record "Scale Benefits";
    TaxableAmount: Decimal;
    RetirementCont: Decimal;
    RefNo: Code[10];
    LoanBalance: Decimal;
    TotalTopUp: Decimal;
    InterestAmt: Decimal;
    LoanApplication: Record "Loan Application";
    LoanType: Record "Loan Product";
    LoanTopup: Record "Loan Top-up";
    Informational: Boolean;
    RepSchedule: Record "Loan Schedule";
    PayrollCalc: Codeunit "Payroll Calculator";
    NAVEmp: Record Employee;
    RemainingAmount: Decimal;
    ReceiptedAmount: Decimal;
    PayrollMonth: Integer;
    PayrollYear: Integer;
    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record Bracket;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining:=TaxableAmount;
        AmountRemaining:=Round(AmountRemaining, 0.01);
        EndTax:=false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-')then begin
            repeat if AmountRemaining <= 0 then EndTax:=true
                else
                begin
                    if Round((TaxableAmount), 0.01) > TaxTable."Upper Limit" then Tax:=TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else
                    begin
                        Tax:=AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax:=TotalTax + Tax;
                        EndTax:=true;
                    end;
                    if not EndTax then begin
                        AmountRemaining:=AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax:=TotalTax + Tax;
                    end;
                end;
            until(TaxTable.Next = 0) or EndTax = true;
        end;
        TotalTax:=TotalTax;
        TotalTax:=PayrollRounding(TotalTax);
        IncomeTax:=-TotalTax;
        if not Employee."Pays Tax" then IncomeTax:=0;
    end;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-')then begin
            BeginDate:=PayPeriod."Starting Date";
        end;
    end;
    procedure PayrollRounding(var Amount: Decimal)PayrollRounding: Decimal var
        HRsetup: Record "QuantumJumps Payroll Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error(Text000);
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
    procedure CalculateUnderOverHrs(var StartDate: Date; var EmpNo: Code[20])PayrollValue: Decimal var
        BaseCalendar: Record Date;
        CompanyInfo: Record "Company Information";
        ResourceRec: Record Resource;
    begin
    end;
    procedure CalcNoOfWorkingDaysInAmonth(var StartDate: Date)NoOfHrsPerMonth: Decimal var
        CompInfo: Record "Company Information";
        CalenderRec: Record Date;
        NextDate: Date;
        EndDate: Date;
        CalendarMgmt: Codeunit "AL Calendar Management";
        Description: Text;
        NoOfWorkingDays: Integer;
        HRSetup: Record "QuantumJumps Payroll Setup";
    begin
        HRSetup.Get;
        if StartDate <> 0D then begin
            NextDate:=StartDate;
            EndDate:=CalcDate('1M', NextDate) - 1;
            repeat if not CalendarMgmt.CheckDateStatus(HRSetup."Base Calendar Code", NextDate, Description)then NoOfWorkingDays:=NoOfWorkingDays + 1;
                NextDate:=CalcDate('1D', NextDate);
            until NextDate > EndDate;
            if HRSetup."Working Hours" = 0 then Error(Text001);
            NoOfHrsPerMonth:=NoOfWorkingDays * HRSetup."Working Hours";
        end
        else
            Error(Text002);
    end;
    procedure UpdateLoanStatus(EmployeeNo: Code[20]; LoanNo: Code[20]; RemainingAmount: Decimal)
    var
        LoanApp: Record "Loan Application";
    begin
        LoanApp.Reset;
        LoanApp.SetRange("Stop Loan", false);
        LoanApp.SetRange("Employee No", EmployeeNo);
        LoanApp.SetRange("Interest Calculation Method", LoanApp."Interest Calculation Method"::" ");
        LoanApp.SetRange("Loan No", LoanNo);
        if LoanApp.FindSet then repeat begin
                LoanApp.CalcFields("Total Repayment", Receipts);
                if RemainingAmount <= 0 then begin
                    LoanApp."Stop Loan":=true;
                    LoanApp.Modify;
                end;
            end;
            until LoanApp.Next = 0;
    end;
    procedure UpdateLoansPayrollMatrix(EmployeeNo: Code[20]; LoanNo: Code[20])
    begin
        LoanApp.Reset;
        LoanApp.SetRange("Stop Loan", false);
        LoanApp.SetRange("Employee No", EmployeeNo);
        LoanApp.SetRange("Interest Calculation Method", LoanApp."Interest Calculation Method"::" ");
        LoanApp.SetRange("Loan No", LoanNo);
        if LoanApp.FindSet then repeat begin
                ReceiptedAmount:=0;
                RemainingAmount:=0;
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange("Employee No", LoanApp."Employee No");
                PayrollMatrix.SetRange(Code, LoanApp."Deduction Code");
                PayrollMatrix.SetFilter("Payroll Period", '<>%1', DateSpecified);
                PayrollMatrix.SetRange(PayrollMatrix.Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange("Reference No", LoanApp."Loan No");
                if PayrollMatrix.FindSet then begin
                    PayrollMatrix.CalcSums(Amount);
                    ReceiptedAmount:=PayrollMatrix.Amount;
                end;
                LoanApp.CalcFields(Receipts);
                RemainingAmount:=LoanApp."Approved Amount" + ReceiptedAmount - LoanApp.Receipts;
                if(RemainingAmount <> LoanApp.Repayment) and (RemainingAmount < LoanApp.Repayment)then begin
                    PayrollMatrix.Reset;
                    PayrollMatrix.SetRange("Employee No", EmployeeNo);
                    PayrollMatrix.SetRange(Code, LoanApp."Deduction Code");
                    PayrollMatrix.SetRange("Payroll Period", DateSpecified);
                    PayrollMatrix.SetRange("Reference No", LoanNo);
                    if PayrollMatrix.FindLast then begin
                        PayrollMatrix.Amount:=RemainingAmount;
                        PayrollMatrix.Validate(Amount);
                        PayrollMatrix.Modify;
                    end;
                end;
                UpdateLoanStatus(EmployeeNo, LoanNo, RemainingAmount);
            end;
            until LoanApp.Next = 0;
    end;
}
