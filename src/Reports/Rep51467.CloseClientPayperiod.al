report 51467 "Close Client Pay period"
{
    // version THL- Client Payroll 1.0
    //       // Used for previous loan handling
    //         //  IF Loan.GET(PaymentDed.Code,PaymentDed."Employee No") THEN
    //         //    BEGIN
    ProcessingOnly = true;

    dataset
    {
        dataitem("Client Payroll Matrix"; "Client Payroll Matrix")
        {
            trigger OnPostDataItem()
            begin
                if PayperiodStart < StartingDate then Error('Cannot Close this Pay period Without Closing the preceding ones')
                else
                begin
                    // MESSAGE('We are closing %1 but payperiod start is %2',FORMAT(StartingDate),PayperiodStart);
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
                NewPeriod:=CalcDate('1M', StartingDate);
                Loan.Reset;
                if Loan.Find('-')then begin
                    repeat AssMatrix.Reset;
                        AssMatrix.SetRange(AssMatrix."Payroll Period", NewPeriod);
                        AssMatrix.SetRange(Code, Loan.Code);
                        if AssMatrix.Find('-')then begin
                            repeat if NAVEmp.Get("Client Payroll Matrix"."Employee No")then begin
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
            area(content)
            {
                field(Company; Company)
                {
                    ApplicationArea = All;
                    Caption = 'Company';
                    TableRelation = "Client Company Information";
                }
            }
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
        if not Confirm('Please ensure all checks for the current period have been done and payroll has been run for all clients. Do you wish to continue?')then Error('The period has not been closed');
        //PayrollRun.RUN;
        DeducePayPeriod;
        ClosePeriodTrans(Company);
        CreateNewEntries(PayperiodStart, Company);
        UpdateSalaryPointers(PayperiodStart);
    end;
    var Proceed: Boolean;
    CurrentPeriodEnd: Date;
    DaysAdded: Code[10];
    PayPeriod: Record "Client Payroll Period";
    StartingDate: Date;
    PayperiodStart: Date;
    LoansUpdate: Boolean;
    EmpRec: Record "Client Employee Master";
    TaxableAmount: Decimal;
    RightBracket: Boolean;
    AmountRemaining: Decimal;
    IncomeTax: Decimal;
    NetPay: Decimal;
    Loan: Record "Client Loan Transactions";
    ReducedBal: Decimal;
    InterestAmt: Decimal;
    CompRec: Record "Human Resources Setup";
    HseLimit: Decimal;
    ExcessRetirement: Decimal;
    relief: Decimal;
    Outstanding: Decimal;
    CreateRec: Boolean;
    benefits: Record "Client Earnings";
    deductions: Record "Client Deductions";
    InterestDiff: Decimal;
    Rounding: Boolean;
    PD: Record "Client Payroll Matrix";
    Pay: Record "Client Earnings";
    Ded: Record "Client Deductions";
    TaxCode: Code[10];
    CfAmount: Decimal;
    TempAmount: Decimal;
    EmpRec1: Record "Client Employee Master";
    Emprec2: Record "Client Employee Master";
    NewPeriod: Date;
    AssMatrix: Record "Client Payroll Matrix";
    PayrollRun: Report "Client Payroll Calculator";
    Schedule: Record "Client Loan Schedule";
    Window: Dialog;
    EmployeeName: Text[200];
    GetGroup: Codeunit "Client Payroll Calculator";
    GroupCode: Code[20];
    CUser: Code[50];
    LoanApplicationForm: Record "Client Loan Application";
    Discontinue: Boolean;
    NAVEmp: Record "Client Employee Master";
    Company: Code[10];
    procedure GetCurrentPeriod(var Payperiod: Record "Client Payroll Period")
    begin
        CurrentPeriodEnd:=Payperiod."Starting Date";
        StartingDate:=CurrentPeriodEnd;
        CurrentPeriodEnd:=CalcDate('1M', CurrentPeriodEnd - 1);
    end;
    procedure DeducePayPeriod()
    var
        PayPeriodRec: Record "Client Payroll Period";
    begin
        PayPeriodRec.Reset;
        PayPeriodRec.SetRange(PayPeriodRec."Close Pay", false);
        if PayPeriodRec.Find('-')then PayperiodStart:=PayPeriodRec."Starting Date";
    end;
    procedure ClosePeriodTrans(var Comp: Code[10])
    var
        EarnDeduct: Record "Client Payroll Matrix";
    begin
        EarnDeduct.Reset;
        EarnDeduct.SetRange(EarnDeduct."Payroll Period", StartingDate);
        if Comp <> '' then EarnDeduct.SetRange(EarnDeduct.Company, Comp);
        if EarnDeduct.Find('-')then repeat EarnDeduct.Closed:=true;
                EarnDeduct."Payroll Period":=StartingDate;
                EarnDeduct.Modify;
            until EarnDeduct.Next = 0;
    end;
    procedure CreateNewEntries(var CurrPeriodStat: Date; var Comp: Code[10])
    var
        PaymentDed: Record "Client Payroll Matrix";
        AssignMatrix: Record "Client Payroll Matrix";
    begin
        /*This function creates new entries for the next Payroll period which are accessible and editable
        by the user of the Payroll. It should ideally create new entries if the EmpRec is ACTIVE*/
        NewPeriod:=CalcDate('1M', StartingDate);
        Window.Open('Creating Next period entries ##############################1', EmployeeName);
        PaymentDed.Reset;
        PaymentDed.SetRange(PaymentDed."Payroll Period", StartingDate);
        PaymentDed.SetRange(PaymentDed."Next Period Entry", true);
        if Comp <> '' then PaymentDed.SetRange(PaymentDed.Company, Comp);
        if PaymentDed.Find('-')then begin
            repeat CreateRec:=true;
                AssignMatrix.Init;
                AssignMatrix.Company:=PaymentDed.Company;
                AssignMatrix."Employee No":=PaymentDed."Employee No";
                AssignMatrix.Type:=PaymentDed.Type;
                AssignMatrix.Code:=PaymentDed.Code;
                AssignMatrix."Global Dimension 1 code":=PaymentDed."Global Dimension 1 code";
                AssignMatrix."Global Dimension 2 Code":=PaymentDed."Global Dimension 2 Code";
                AssignMatrix."Reference No":=PaymentDed."Reference No";
                AssignMatrix.Retirement:=PaymentDed.Retirement;
                AssignMatrix."Payroll Period":=CalcDate('1M', StartingDate);
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
                AssignMatrix.Company:=PaymentDed.Company;
                AssignMatrix."Insurance Code":=PaymentDed."Insurance Code";
                AssignMatrix."SHIF Code":=PaymentDed."SHIF Code";
                AssignMatrix.NSSF:=PaymentDed.NSSF;
                AssignMatrix."Tax Relief":=PaymentDed."Tax Relief";
                AssignMatrix."Tax Relief":=PaymentDed."Insurance Relief";
                AssignMatrix."Insurance Relief":=PaymentDed."Insurance Relief";
                AssignMatrix.AKI:=PaymentDed.AKI;
                AssignMatrix."Cetificate Expiry date":=PaymentDed."Cetificate Expiry date";
                AssignMatrix."Basic+Regular Allowances":=PaymentDed."Basic+Regular Allowances";
                AssignMatrix."Job Grade":=PaymentDed."Job Grade";
                AssignMatrix."Salary Level":=PaymentDed."Salary Level";
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
                    if(NAVEmp.Status = NAVEmp.Status::Active) and (CreateRec = true)then if not AssignMatrix.Get(AssignMatrix.Company, AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No")then AssignMatrix.Insert;
                end;
            until PaymentDed.Next = 0;
        end;
    //Manage loans
    /*
          PaymentDed.RESET;
          PaymentDed.SETRANGE(PaymentDed."Payroll Period",NewPeriod);
          PaymentDed.SETRANGE(Type,PaymentDed.Type::Deduction);
          IF Comp <> '' THEN
          PaymentDed.SETRANGE(PaymentDed.Company,Comp);
          IF PaymentDed.FIND('-') THEN  BEGIN
          REPEAT
           LoanApplicationForm.RESET;
           LoanApplicationForm.SETRANGE(LoanApplicationForm."Deduction Code",PaymentDed.Code);
           LoanApplicationForm.SETRANGE(LoanApplicationForm."Loan No",PaymentDed."Reference No");
           IF LoanApplicationForm.FIND('-') THEN
           BEGIN
              LoanApplicationForm.SETRANGE(LoanApplicationForm."Date filter",0D,PayperiodStart);
              LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment",LoanApplicationForm."Total Loan");
        
             IF LoanApplicationForm."Total Loan"<>0 THEN
             BEGIN
              IF (LoanApplicationForm."Total Loan"+LoanApplicationForm."Total Repayment")<=0 THEN
              BEGIN
              MESSAGE('Loan %1 has expired',PaymentDed."Reference No");
              PaymentDed.DELETE;
              END
              ELSE
              BEGIN
              IF (LoanApplicationForm."Total Loan"+LoanApplicationForm."Total Repayment")<LoanApplicationForm.Repayment THEN
              BEGIN
        
              LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment");
        
              PaymentDed.Amount:=-(LoanApplicationForm."Total Loan"+LoanApplicationForm."Total Repayment");
             // PaymentDed."Next Period Entry":=FALSE;
              PaymentDed.MODIFY;
              END;
        
              END;
        
             END ELSE
             BEGIN
              IF (LoanApplicationForm."Approved Amount"+LoanApplicationForm."Total Repayment")<=0 THEN
              BEGIN
              MESSAGE('Loan %1 has expired',PaymentDed."Reference No");
              PaymentDed.DELETE;
              END
              ELSE
              BEGIN
              IF (LoanApplicationForm."Approved Amount"+LoanApplicationForm."Total Repayment")<LoanApplicationForm.Repayment THEN
              BEGIN
        
              LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment");
        
              PaymentDed.Amount:=-(LoanApplicationForm."Approved Amount"+LoanApplicationForm."Total Repayment");
             // PaymentDed."Next Period Entry":=FALSE;
              PaymentDed.MODIFY;
              END;
        
              END;
             END;
            END;
        
          UNTIL PaymentDed.NEXT=0;
          END;*/
    end;
    procedure Initialize()
    var
        InitEarnDeduct: Record "Client Payroll Matrix";
    begin
        InitEarnDeduct.SetRange(InitEarnDeduct.Closed, false);
        repeat InitEarnDeduct."Payroll Period":=StartingDate;
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
        PaymentDeduction: Record "Client Payroll Matrix";
        Payrollmonths: Record "Client Payroll Period";
        allowances: Record "Client Earnings";
    begin
        PaymentDeduction.Init;
        PaymentDeduction."Employee No":=Employee;
        PaymentDeduction.Code:=BenefitCode;
        PaymentDeduction.Type:=PaymentDeduction.Type::Payment;
        PaymentDeduction."Payroll Period":=CalcDate('1M', StartingDate);
        PaymentDeduction.Amount:=ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit":=true;
        PaymentDeduction.Taxable:=true;
        PaymentDeduction."Next Period Entry":=TRUE;
        PaymentDeduction."Insurance Relief":=true;
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
        Emp: Record "Client Employee Master";
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
