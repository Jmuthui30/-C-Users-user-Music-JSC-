report 51811 "Close Cost period"
{
    // version THL- Payroll 1.0
    //       // Used for previous loan handling
    //         //  IF Loan.GET(PaymentDed.Code,PaymentDed."Employee No") THEN
    //         //    BEGIN
    ProcessingOnly = true;
    UseRequestPage = false;

    dataset
    {
        dataitem("Motorpool Cost Matrix"; "Motorpool Cost Matrix")
        {
            trigger OnPostDataItem()
            begin
                IF PayperiodStart <> StartingDate THEN ERROR('Cannot Close this Pay period Without Closing the preceding ones')
                ELSE
                BEGIN
                    IF PayPeriod.GET(StartingDate)THEN BEGIN
                        PayPeriod."Close Pay":=TRUE;
                        PayPeriod.Closed:=TRUE;
                        PayPeriod."Closed By":=USERID;
                        PayPeriod."Closed on Date":=CURRENTDATETIME;
                        PayPeriod.MODIFY;
                        MESSAGE('The period has been closed');
                    END;
                END;
                // Go thru assignment matrix for loans and validate code
                NewPeriod:=CALCDATE('1M', PayperiodStart);
                Loan.RESET;
                IF Loan.FIND('-')THEN BEGIN
                    REPEAT AssMatrix.RESET;
                        AssMatrix.SETRANGE(AssMatrix."Payroll Period", NewPeriod);
                        AssMatrix.SETRANGE(Code, Loan.Code);
                        IF AssMatrix.FIND('-')THEN BEGIN
                            REPEAT IF NAVEmp.GET(AssMatrix."Employee No")THEN BEGIN
                                    IF(NAVEmp.Status = NAVEmp.Status::Active)THEN AssMatrix.VALIDATE(Code);
                                    AssMatrix.MODIFY END;
                            UNTIL AssMatrix.NEXT = 0;
                        END;
                    UNTIL Loan.NEXT = 0;
                END;
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
        IF NOT CONFIRM('Please ensure all checks for the current period have been done. Do you wish to continue?')THEN ERROR('The period has not been closed');
        //PayrollRun.RUN;
        DeducePayPeriod;
        ClosePeriodTrans;
    end;
    var Proceed: Boolean;
    CurrentPeriodEnd: Date;
    DaysAdded: Code[10];
    PayPeriod: Record "Cost Period";
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
    procedure GetCurrentPeriod(var Payperiod: Record "Payroll Period")
    begin
        CurrentPeriodEnd:=Payperiod."Starting Date";
        StartingDate:=CurrentPeriodEnd;
        CurrentPeriodEnd:=CALCDATE('1M', CurrentPeriodEnd - 1);
    end;
    procedure DeducePayPeriod()
    var
        PayPeriodRec: Record "Payroll Period";
    begin
        PayPeriodRec.RESET;
        PayPeriodRec.SETRANGE(PayPeriodRec."Close Pay", FALSE);
        IF PayPeriodRec.FIND('-')THEN PayperiodStart:=PayPeriodRec."Starting Date";
    end;
    procedure ClosePeriodTrans()
    var
        EarnDeduct: Record "Payroll Matrix";
    begin
        EarnDeduct.RESET;
        EarnDeduct.SETRANGE(EarnDeduct."Payroll Period", PayperiodStart);
        IF EarnDeduct.FIND('-')THEN REPEAT EarnDeduct.Closed:=TRUE;
                EarnDeduct."Payroll Period":=PayperiodStart;
                EarnDeduct.MODIFY;
            UNTIL EarnDeduct.NEXT = 0;
    end;
    procedure CreateNewEntries(var CurrPeriodStat: Date)
    var
        PaymentDed: Record "Payroll Matrix";
        AssignMatrix: Record "Payroll Matrix";
    begin
        /*This function creates new entries for the next Payroll period which are accessible and editable
        by the user of the Payroll. It should ideally create new entries if the EmpRec is ACTIVE*/
        NewPeriod:=CALCDATE('1M', PayperiodStart);
        Window.OPEN('Creating Next period entries ##############################1', EmployeeName);
        PaymentDed.RESET;
        PaymentDed.SETRANGE(PaymentDed."Payroll Period", PayperiodStart);
        PaymentDed.SETRANGE(PaymentDed."Next Period Entry", TRUE);
        //PaymentDed.SETFILTER(PaymentDed.Amount, '<>%1',0);
        IF PaymentDed.FIND('-')THEN BEGIN
            REPEAT CreateRec:=TRUE;
                AssignMatrix.INIT;
                AssignMatrix."Employee No":=PaymentDed."Employee No";
                AssignMatrix.Type:=PaymentDed.Type;
                AssignMatrix.Code:=PaymentDed.Code;
                AssignMatrix."Global Dimension 1 code":=PaymentDed."Global Dimension 1 code";
                AssignMatrix."Global Dimension 2 Code":=PaymentDed."Global Dimension 2 Code";
                AssignMatrix."Reference No":=PaymentDed."Reference No";
                AssignMatrix.Retirement:=PaymentDed.Retirement;
                AssignMatrix."Payroll Period":=CALCDATE('1M', PayperiodStart);
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
                IF PaymentDed."Global Dimension 1 code" = '' THEN BEGIN
                    Emprec2.RESET;
                    IF Emprec2.GET(PaymentDed."Employee No")THEN BEGIN
                        AssignMatrix."Global Dimension 1 code":=Emprec2."Global Dimension 1 Code";
                        AssignMatrix."Global Dimension 2 Code":=Emprec2."Global Dimension 2 Code";
                        AssignMatrix."Global Dimension 3 Code":=Emprec2."Global Dimension 3 Code";
                    END;
                END;
                EmpRec.RESET;
                IF EmpRec.GET(PaymentDed."Employee No")THEN BEGIN
                    AssignMatrix."Payroll Group":=EmpRec."Employee Group";
                    NAVEmp.GET(PaymentDed."Employee No");
                    Window.UPDATE(1, NAVEmp."First Name" + ' ' + NAVEmp."Middle Name" + ' ' + NAVEmp."Last Name");
                    IF(NAVEmp.Status = NAVEmp.Status::Active) AND (CreateRec = TRUE)THEN IF NOT AssignMatrix.GET(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")THEN AssignMatrix.INSERT;
                END;
            UNTIL PaymentDed.NEXT = 0;
        END;
        //Manage loans
        PaymentDed.RESET;
        PaymentDed.SETRANGE(PaymentDed."Payroll Period", NewPeriod);
        PaymentDed.SETRANGE(Type, PaymentDed.Type::Deduction);
        IF PaymentDed.FIND('-')THEN BEGIN
            REPEAT LoanApplicationForm.RESET;
                LoanApplicationForm.SETRANGE(LoanApplicationForm."Deduction Code", PaymentDed.Code);
                LoanApplicationForm.SETRANGE(LoanApplicationForm."Loan No", PaymentDed."Reference No");
                IF LoanApplicationForm.FIND('-')THEN BEGIN
                    LoanApplicationForm.SETRANGE(LoanApplicationForm."Date filter", 0D, PayperiodStart);
                    LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment", LoanApplicationForm."Total Loan");
                    IF LoanApplicationForm."Total Loan" <> 0 THEN BEGIN
                        IF(LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment") <= 0 THEN BEGIN
                            MESSAGE('Loan %1 has expired', PaymentDed."Reference No");
                            PaymentDed.DELETE;
                        END
                        ELSE
                        BEGIN
                            IF(LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment") < LoanApplicationForm.Repayment THEN BEGIN
                                LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment");
                                PaymentDed.Amount:=-(LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment");
                                // PaymentDed."Next Period Entry":=FALSE;
                                PaymentDed.MODIFY;
                            END;
                        END;
                    END
                    ELSE
                    BEGIN
                        IF(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment") <= 0 THEN BEGIN
                            MESSAGE('Loan %1 has expired', PaymentDed."Reference No");
                            PaymentDed.DELETE;
                        END
                        ELSE
                        BEGIN
                            IF(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment") < LoanApplicationForm.Repayment THEN BEGIN
                                LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment");
                                PaymentDed.Amount:=-(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment");
                                // PaymentDed."Next Period Entry":=FALSE;
                                PaymentDed.MODIFY;
                            END;
                        END;
                    END;
                END;
            UNTIL PaymentDed.NEXT = 0;
        END;
    end;
    procedure Initialize()
    var
        InitEarnDeduct: Record "Payroll Matrix";
    begin
        InitEarnDeduct.SETRANGE(InitEarnDeduct.Closed, FALSE);
        REPEAT InitEarnDeduct."Payroll Period":=PayperiodStart;
            InitEarnDeduct.MODIFY;
        UNTIL InitEarnDeduct.NEXT = 0;
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
        AmountRemaining:=ROUND(AmountRemaining, 0.01);
        EndTax:=FALSE;
        TaxTable.SETRANGE("Table Code", TaxCode);
        IF TaxTable.FIND('-')THEN BEGIN
            REPEAT IF AmountRemaining <= 0 THEN EndTax:=TRUE
                ELSE
                BEGIN
                    IF ROUND((TaxableAmount), 0.01) > TaxTable."Upper Limit" THEN Tax:=TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    ELSE
                    BEGIN
                        Tax:=AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax:=TotalTax + Tax;
                        EndTax:=TRUE;
                    END;
                    IF NOT EndTax THEN BEGIN
                        AmountRemaining:=AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax:=TotalTax + Tax;
                    END;
                END;
            UNTIL(TaxTable.NEXT = 0) OR EndTax = TRUE;
        END;
        TotalTax:=TotalTax;
        IncomeTax:=-TotalTax;
    end;
    procedure CreateLIBenefit(var Employee: Code[10]; var BenefitCode: Code[10]; var ReducedBalance: Decimal)
    var
        PaymentDeduction: Record "Payroll Matrix";
        Payrollmonths: Record "Payroll Period";
        allowances: Record Earnings;
    begin
        PaymentDeduction.INIT;
        PaymentDeduction."Employee No":=Employee;
        PaymentDeduction.Code:=BenefitCode;
        PaymentDeduction.Type:=PaymentDeduction.Type::Payment;
        PaymentDeduction."Payroll Period":=CALCDATE('1M', PayperiodStart);
        PaymentDeduction.Amount:=ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit":=TRUE;
        PaymentDeduction.Taxable:=TRUE;
        //PaymentDeduction."Next Period Entry":=TRUE;
        IF allowances.GET(BenefitCode)THEN PaymentDeduction.Description:=allowances.Description;
        PaymentDeduction.INSERT;
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
        Emp.RESET;
        Emp.SETRANGE(Emp.Status, Emp.Status::Active);
        IF Emp.FIND('-')THEN BEGIN
            REPEAT /*IF FORMAT(DATE2DMY(NewPeriod,2))=Emp."Incremental Month" THEN
            BEGIN
            IF INCSTR(Emp.Present)<Emp.Halt THEN
            BEGIN
            Emp.Previous:=Emp.Present;
            Emp.Present:=INCSTR(Emp.Present);
            Emp.MODIFY;
            END;
            END;*/
            UNTIL Emp.NEXT = 0;
        END;
    end;
}
