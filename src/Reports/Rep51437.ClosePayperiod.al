report 51437 "Close Pay period"
{
    // version THL- Payroll 1.0
    //       // Used for previous loan handling
    //         //  IF Loan.GET(PaymentDed.Code,PaymentDed."Employee No") THEN
    //         //    BEGIN
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Payroll Matrix"; "Payroll Matrix")
        {
            trigger OnPostDataItem()
            begin
                if PayperiodStart <> StartingDate then Error('Cannot Close this Pay period Without Closing the preceding ones')
                else
                begin
                    if PayPeriod.Get(StartingDate)then begin
                        PayPeriod."Close Pay":=true;
                        PayPeriod.Closed:=true;
                        PayPeriod."Closed By":=UserId;
                        PayPeriod."Closed on Date":=CurrentDateTime;
                        PayPeriod.Modify;
                        Message('The period has been closed');
                    end;
                end;
                // Go thru assignment matrix for loans and validate code
                NewPeriod:=CalcDate('1M', PayperiodStart);
                Loan.Reset;
                if Loan.Find('-')then begin
                    repeat AssMatrix.Reset;
                        AssMatrix.SetRange(AssMatrix."Payroll Period", NewPeriod);
                        AssMatrix.SetRange(Code, Loan.Code);
                        if AssMatrix.Find('-')then begin
                            repeat if NAVEmp.Get("Payroll Matrix"."Employee No")then begin
                                    if(NAVEmp.Status = NAVEmp.Status::Active)then AssMatrix.Validate(Code);
                                    AssMatrix.Modify end;
                            until AssMatrix.Next = 0;
                        end;
                    until Loan.Next = 0;
                end;
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
        if not Confirm('Please ensure all checks for the current period have been done. Do you wish to continue?')then Error('The period has not been closed');
        //PayrollRun.RUN;
        DeducePayPeriod;
        ClosePeriodTrans;
        CreateNewEntries(PayperiodStart);
        UpdateSalaryPointers(PayperiodStart);
    end;
    var Proceed: Boolean;
    CurrentPeriodEnd: Date;
    DaysAdded: Code[10];
    PayPeriod: Record "Payroll Period";
    StartingDate: Date;
    PayperiodStart: Date;
    LoansUpdate: Boolean;
    EmpRec: Record "Employee Master";
    TaxableAmount: Decimal;
    RightBracket: Boolean;
    AmountRemaining: Decimal;
    IncomeTax: Decimal;
    NetPay: Decimal;
    Loan: Record "Loan Transactions";
    ReducedBal: Decimal;
    InterestAmt: Decimal;
    CompRec: Record "Human Resources Setup";
    HseLimit: Decimal;
    ExcessRetirement: Decimal;
    relief: Decimal;
    Outstanding: Decimal;
    CreateRec: Boolean;
    benefits: Record Earnings;
    deductions: Record Deductions;
    InterestDiff: Decimal;
    Rounding: Boolean;
    PD: Record "Payroll Matrix";
    Pay: Record Earnings;
    Ded: Record Deductions;
    TaxCode: Code[10];
    CfAmount: Decimal;
    TempAmount: Decimal;
    EmpRec1: Record "Employee Master";
    Emprec2: Record "Employee Master";
    NewPeriod: Date;
    AssMatrix: Record "Payroll Matrix";
    PayrollRun: Report "Payroll Calculator";
    Schedule: Record "Loan Schedule";
    Window: Dialog;
    EmployeeName: Text[200];
    GetGroup: Codeunit "Payroll Calculator";
    GroupCode: Code[20];
    CUser: Code[50];
    LoanApplicationForm: Record "Loan Application";
    Discontinue: Boolean;
    NAVEmp: Record Employee;
    RemainingAmount: Decimal;
    procedure GetCurrentPeriod(var Payperiod: Record "Payroll Period")
    begin
        CurrentPeriodEnd:=Payperiod."Starting Date";
        StartingDate:=CurrentPeriodEnd;
        CurrentPeriodEnd:=CalcDate('1M', CurrentPeriodEnd - 1);
    end;
    procedure DeducePayPeriod()
    var
        PayPeriodRec: Record "Payroll Period";
    begin
        PayPeriodRec.Reset;
        PayPeriodRec.SetRange(PayPeriodRec."Close Pay", false);
        if PayPeriodRec.Find('-')then PayperiodStart:=PayPeriodRec."Starting Date";
    end;
    procedure ClosePeriodTrans()
    var
        EarnDeduct: Record "Payroll Matrix";
    begin
        EarnDeduct.Reset;
        EarnDeduct.SetRange(EarnDeduct."Payroll Period", PayperiodStart);
        if EarnDeduct.Find('-')then repeat EarnDeduct.Closed:=true;
                EarnDeduct."Payroll Period":=PayperiodStart;
                EarnDeduct.Modify;
            until EarnDeduct.Next = 0;
    end;
    procedure CreateNewEntries(var CurrPeriodStat: Date)
    var
        PaymentDed: Record "Payroll Matrix";
        AssignMatrix: Record "Payroll Matrix";
    begin
        /*This function creates new entries for the next Payroll period which are accessible and editable
        by the user of the Payroll. It should ideally create new entries if the EmpRec is ACTIVE*/
        NewPeriod:=CalcDate('1M', PayperiodStart);
        Window.Open('Creating Next period entries ##############################1', EmployeeName);
        PaymentDed.Reset;
        PaymentDed.SetRange(PaymentDed."Payroll Period", PayperiodStart);
        PaymentDed.SetRange(PaymentDed."Next Period Entry", true);
        //PaymentDed.SETFILTER(PaymentDed.Amount, '<>%1',0);
        if PaymentDed.Find('-')then begin
            repeat CreateRec:=true;
                AssignMatrix.Init;
                AssignMatrix."Employee No":=PaymentDed."Employee No";
                AssignMatrix.Type:=PaymentDed.Type;
                AssignMatrix.Code:=PaymentDed.Code;
                AssignMatrix."Global Dimension 1 code":=PaymentDed."Global Dimension 1 code";
                AssignMatrix."Global Dimension 2 Code":=PaymentDed."Global Dimension 2 Code";
                AssignMatrix."Reference No":=PaymentDed."Reference No";
                AssignMatrix.Retirement:=PaymentDed.Retirement;
                AssignMatrix."Payroll Period":=CalcDate('1M', PayperiodStart);
                AssignMatrix.Amount:=PaymentDed.Amount;
                AssignMatrix.Description:=PaymentDed.Description;
                AssignMatrix.Taxable:=PaymentDed.Taxable;
                AssignMatrix."Reduces Taxable Amt":=PaymentDed."Reduces Taxable Amt";
                AssignMatrix."Non-Cash Benefit":=PaymentDed."Non-Cash Benefit";
                AssignMatrix."No. of Units":=PaymentDed."No. of Units";
                AssignMatrix."Employer Amount":=PaymentDed."Employer Amount";
                AssignMatrix."Global Dimension 1 code":=PaymentDed."Global Dimension 1 code";
                AssignMatrix."Global Dimension 2 Code":=PaymentDed."Global Dimension 2 Code";
                AssignMatrix."Global Dimension 3 Code":=PaymentDed."Global Dimension 3 Code";
                AssignMatrix."Next Period Entry":=PaymentDed."Next Period Entry";
                AssignMatrix."Payroll Group":=PaymentDed."Payroll Group";
                AssignMatrix."Basic Salary Code":=PaymentDed."Basic Salary Code";
                AssignMatrix."Normal Earnings":=PaymentDed."Normal Earnings";
                AssignMatrix."Tax Relief":=PaymentDed."Tax Relief";
                if PaymentDed."Global Dimension 1 code" = '' then begin
                    Emprec2.Reset;
                    if Emprec2.Get(PaymentDed."Employee No")then begin
                        AssignMatrix."Global Dimension 1 code":=Emprec2."Global Dimension 1 Code";
                        AssignMatrix."Global Dimension 2 Code":=Emprec2."Global Dimension 2 Code";
                        AssignMatrix."Global Dimension 3 Code":=Emprec2."Global Dimension 3 Code";
                    end;
                end;
                EmpRec.Reset;
                if EmpRec.Get(PaymentDed."Employee No")then begin
                    AssignMatrix."Payroll Group":=EmpRec."Employee Group";
                    NAVEmp.Get(PaymentDed."Employee No");
                    Window.Update(1, NAVEmp."First Name" + ' ' + NAVEmp."Middle Name" + ' ' + NAVEmp."Last Name");
                    if(NAVEmp.Status = NAVEmp.Status::Active) and (CreateRec = true)then if not AssignMatrix.Get(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")then AssignMatrix.Insert;
                end;
            until PaymentDed.Next = 0;
        end;
        //Manage loans
        PaymentDed.Reset;
        PaymentDed.SetRange(PaymentDed."Payroll Period", NewPeriod);
        PaymentDed.SetRange(Type, PaymentDed.Type::Deduction);
        if PaymentDed.Find('-')then begin
            repeat LoanApplicationForm.Reset;
                LoanApplicationForm.SetRange(LoanApplicationForm."Deduction Code", PaymentDed.Code);
                LoanApplicationForm.SetRange(LoanApplicationForm."Loan No", PaymentDed."Reference No");
                if LoanApplicationForm.Find('-')then begin
                    LoanApplicationForm.SetRange(LoanApplicationForm."Date filter", 0D, PayperiodStart);
                    LoanApplicationForm.CalcFields(LoanApplicationForm."Total Repayment", LoanApplicationForm."Total Loan", LoanApplicationForm.Receipts);
                    if LoanApplicationForm."Total Loan" <> 0 then begin
                        if((LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment") - LoanApplicationForm.Receipts) <= 0 then begin
                            Message('Loan %1 has expired', PaymentDed."Reference No");
                            PaymentDed.Delete;
                        end
                        else
                        begin
                            if(LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment") < LoanApplicationForm.Repayment then begin
                                LoanApplicationForm.CalcFields(LoanApplicationForm."Total Repayment");
                                PaymentDed.Amount:=-(LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment");
                                // PaymentDed."Next Period Entry":=FALSE;
                                PaymentDed.Modify;
                            end;
                        end;
                    end
                    else
                    begin
                        if(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment") <= 0 then begin
                            Message('Loan %1 has expired', PaymentDed."Reference No");
                            PaymentDed.Delete;
                        end
                        else
                        begin
                            if(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment") < LoanApplicationForm.Repayment then begin
                                LoanApplicationForm.CalcFields(LoanApplicationForm."Total Repayment");
                                PaymentDed.Amount:=-(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment");
                                // PaymentDed."Next Period Entry":=FALSE;
                                PaymentDed.Modify;
                            end;
                        end;
                    end;
                end;
            until PaymentDed.Next = 0;
        end;
    end;
    procedure Initialize()
    var
        InitEarnDeduct: Record "Payroll Matrix";
    begin
        InitEarnDeduct.SetRange(InitEarnDeduct.Closed, false);
        repeat InitEarnDeduct."Payroll Period":=PayperiodStart;
            InitEarnDeduct.Modify;
        until InitEarnDeduct.Next = 0;
    end;
    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record Bracket;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining:=TaxableAmount;
        AmountRemaining:=AmountRemaining;
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
        IncomeTax:=-TotalTax;
    end;
    procedure CreateLIBenefit(var Employee: Code[10]; var BenefitCode: Code[10]; var ReducedBalance: Decimal)
    var
        PaymentDeduction: Record "Payroll Matrix";
        Payrollmonths: Record "Payroll Period";
        allowances: Record Earnings;
    begin
        PaymentDeduction.Init;
        PaymentDeduction."Employee No":=Employee;
        PaymentDeduction.Code:=BenefitCode;
        PaymentDeduction.Type:=PaymentDeduction.Type::Payment;
        PaymentDeduction."Payroll Period":=CalcDate('1M', PayperiodStart);
        PaymentDeduction.Amount:=ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit":=true;
        PaymentDeduction.Taxable:=true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.Get(BenefitCode)then PaymentDeduction.Description:=allowances.Description;
        PaymentDeduction.Insert;
    end;
    procedure CoinageAnalysis(var NetPay: Decimal)NetPay1: Decimal var
        Index: Integer;
        Intex: Integer;
        AmountArray: array[15]of Decimal;
        NoOfUnitsArray: array[15]of Integer;
        MinAmount: Decimal;
    begin
    end;
    procedure UpdateSalaryPointers(var PayrollPeriod: Date)
    var
        Emp: Record Employee;
        RollingMonth: Integer;
    begin
        Emp.Reset;
        Emp.SetRange(Emp.Status, Emp.Status::Active);
        if Emp.Find('-')then begin
            repeat /*IF FORMAT(DATE2DMY(NewPeriod,2))=Emp."Incremental Month" THEN
            BEGIN
            IF INCSTR(Emp.Present)<Emp.Halt THEN
            BEGIN
            Emp.Previous:=Emp.Present;
            Emp.Present:=INCSTR(Emp.Present);
            Emp.MODIFY;
            END;
            END;*/
            until Emp.Next = 0;
        end;
    end;
}
