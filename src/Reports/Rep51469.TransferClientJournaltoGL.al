report 51469 "Transfer Client Journal to GL"
{
    // version THL- Client Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Transfer Client Journal to GL.rdlc';
    Caption = 'Generate Payroll Journal ';
    ProcessingOnly = false;
    UseRequestPage = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem("Client Employee Groups"; "Client Employee Groups")
        {
            RequestFilterFields = "Code";

            column(Employee_Posting_GroupX1_Code; Code)
            {
            }
            column(Employee_Posting_GroupX1_Pay_Period_Filter; "Pay Period Filter")
            {
            }
            dataitem(Employee; "Client Employee Master")
            {
                DataItemLink = "Employee Group"=FIELD(Code), "Pay Period Filter"=FIELD("Pay Period Filter");
                DataItemTableView = SORTING("No.");
                RequestFilterFields = "No.";

                column(COMPANYNAME; CompanyName)
                {
                }
                column(Employee_Posting_GroupX1__Description; "Client Employee Groups".Description)
                {
                }
                column(Employee_Posting_GroupX1__Code; "Client Employee Groups".Code)
                {
                }
                column(Payroll_Journal_summary_reportCaption; Payroll_Journal_summary_reportCaptionLbl)
                {
                }
                column(Employee_No_; "No.")
                {
                }
                column(Employee_Posting_Group; "Global Dimension 1 Code")
                {
                }
                column(Employee_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    Employee.SetFilter("Pay Period Filter", '%1', Month);
                    Employee.CalcFields(Employee."Total Allowances", Employee."Total Deductions");
                    TotalNetPay:=TotalNetPay + (Employee."Total Allowances" + Employee."Total Deductions");
                    if Employee."Total Allowances" = 0 then CurrReport.Skip;
                //IndividualEarning := IndividualEarning + Employee."Total Allowances";
                end;
                trigger OnPostDataItem()
                begin
                    TotalCredits:=TotalCredits + TotalNetPay;
                    //Post Total Earnings
                    repeat GenJnline.INIT;
                        LineNumber:=LineNumber + 10;
                        GenJnline."Journal Template Name":='GENERAL';
                        GenJnline."Journal Batch Name":='SALARIES';
                        GenJnline."Line No.":=GenJnline."Line No." + 100000;
                        //GenJnline."Account No." := "Client Employee Groups"."Basic Salary Account";by grace for JSC
                        GenJnline."Account No.":=EarningsCopy."G/L Account";
                        GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                        GenJnline.Description:='Earnings' + Description + FORMAT(DateSpecified, 0, '<month text> <year4>') + '-' + "Client Employee Groups".Code;
                        GenJnline."Document No.":=Payperiodtext;
                        GenJnline."Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                        GenJnline.VALIDATE("Shortcut Dimension 1 Code");
                        GenJnline."Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                        GenJnline.VALIDATE("Shortcut Dimension 2 Code");
                        GenJnline.Amount:=IndividualEarning;
                        GenJnline.VALIDATE(GenJnline.Amount);
                        IF GenJnline.Amount <> 0 THEN GenJnline.INSERT;
                    until GenJnline.next = 0;
                    Totalgross:=0;
                end;
                //post individual earnings 
                trigger OnPreDataItem()
                begin
                    LastFieldNo:=FieldNo("No.");
                    LineNumber:=LineNumber + 2000;
                end;
            }
            dataitem(Earnings; "Earnings Master")
            {
                DataItemLink = "Posting Group Filter"=FIELD(Code), "Pay Period Filter"=FIELD("Pay Period Filter");
                DataItemTableView = SORTING(Code);

                column(EarningsX1_Description; Description)
                {
                }
                column(EarningsX1__Total_Amount_; "Total Amount")
                {
                }
                column(EarningsX1_Code; Code)
                {
                }
                column(EarningsX1_Posting_Group_Filter; Earnings."Global Dimension 1 Filter")
                {
                }
                column(EarningsX1_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LineNumber:=LineNumber + 100;
                    Earnings.SetFilter("Pay Period Filter", '%1', Month);
                    Earnings.SetRange("Earning Type", Earnings."Earning Type"::"Normal Earning");
                    Earnings.CalcFields("Flat Amount");
                    EarningsCopy.SetRange(EarningsCopy."Pay Period Filter", DateSpecified, CalcDate('1M', DateSpecified) - 1);
                    TotalDebits:=TotalDebits + "Total Amount";
                    if Earnings."Total Amount" = 0 then CurrReport.Skip;
                    Earnings.TestField("G/L Account");
                    //Post Earning Individually
                    //Total Earnings
                    GenJnline.Init;
                    LineNumber:=LineNumber + 10;
                    GenJnline."Journal Template Name":='GENERAL';
                    GenJnline."Journal Batch Name":='SALARIES';
                    GenJnline."Line No.":=GenJnline."Line No." + 10000;
                    GenJnline."Account No.":=Earnings."G/L Account";
                    GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                    GenJnline.Description:=Earnings.Description + ' - ' + Format(DateSpecified, 0, '<month text> <year4>') + '-' + "Client Employee Groups".Code;
                    GenJnline."Document No.":=Payperiodtext;
                    GenJnline."Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    GenJnline.Validate("Shortcut Dimension 1 Code");
                    GenJnline."Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                    GenJnline.Validate("Shortcut Dimension 2 Code");
                    GenJnline.Amount:=Earnings."Total Amount";
                    GenJnline.Validate(GenJnline.Amount);
                    if GenJnline.Amount <> 0 then GenJnline.Insert;
                end;
                trigger OnPreDataItem()
                begin
                    LineNumber:=LineNumber + 10;
                    Earnings.SetFilter("Pay Period Filter", '%1', Month);
                    Earnings.SetRange(Earnings."Non-Cash Benefit", false);
                //IndividualEarning := 0;
                end;
            }
            dataitem(Employer; "Deductions Master")
            {
                DataItemLink = "Employee Group Filter"=FIELD(Code), "Pay Period Filter"=FIELD("Pay Period Filter");
                DataItemTableView = SORTING(Code);

                trigger OnPreDataItem()
                begin
                    LineNumber:=LineNumber + 100;
                    Employer.SetRange(Employer."Pay Period Filter", DateSpecified);
                end;
            }
            dataitem(Deductions; "Deductions Master")
            {
                DataItemLink = "Employee Group Filter"=FIELD(Code), "Pay Period Filter"=FIELD("Pay Period Filter");
                DataItemTableView = SORTING(Code)WHERE(Loan=CONST(false));

                column(DeductionsX1_Description; Description)
                {
                }
                column(DeductionsX1__Total_Amount_; "Total Amount")
                {
                }
                column(DeductionsX1_Code; Code)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    LineNumber:=LineNumber + 100;
                    Deductions.CalcFields(Deductions."Total Amount", Deductions."Total Amount Employer");
                    if((Deductions."Total Amount" <> 0) and (Deductions."Total Amount Employer" = 0))then begin
                        TotalCredits:=Abs(TotalCredits) + Abs("Total Amount");
                        //*************Transfer DeductionsX************
                        Deductions.TestField(Deductions."G/L Account");
                        if(Deductions."Total Amount" = 0) or Deductions.Advance then CurrReport.Skip;
                        begin
                            repeat GenJnline."Journal Template Name":='GENERAL';
                                GenJnline."Journal Batch Name":='SALARIES';
                                GenJnline."Line No.":=GenJnline."Line No." + 20000;
                                GenJnline."Account No.":=Deductions."G/L Account";
                                GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                                GenJnline.Description:=Deductions.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>') + '-' + "Client Employee Groups".Code;
                                GenJnline."Document No.":=Payperiodtext;
                                GenJnline."Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                                GenJnline.Validate("Shortcut Dimension 1 Code");
                                GenJnline."Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                                GenJnline.Validate("Shortcut Dimension 2 Code");
                                GenJnline.Amount:=Deductions."Total Amount";
                                GenJnline.Validate(GenJnline.Amount);
                                //IF TransferLoans=FALSE THEN
                                if GenJnline.Amount <> 0 then GenJnline.Insert;
                            until GenJnline.next = 0;
                        end;
                    end;
                    if Deductions."Total Amount Employer" <> 0 then begin
                        TotalSSF:=Abs(Deductions."Total Amount") + Abs(Deductions."Total Amount Employer");
                        //TotalSSF:=ABS(Deductions."Total Amount");
                        GenJnline.Init;
                        GenJnline."Journal Template Name":='GENERAL';
                        GenJnline."Journal Batch Name":='SALARIES';
                        GenJnline."Line No.":=GenJnline."Line No." + 30000;
                        GenJnline."Account No.":=Deductions."G/L Account";
                        GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                        GenJnline.Description:=Deductions.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>') + '-' + "Client Employee Groups".Code;
                        GenJnline."Document No.":=Payperiodtext;
                        GenJnline."Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                        GenJnline.Validate("Shortcut Dimension 1 Code");
                        GenJnline."Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                        GenJnline.Validate("Shortcut Dimension 2 Code");
                        GenJnline.Amount:=-TotalSSF;
                        GenJnline.Validate(GenJnline.Amount);
                        GenJnline.Insert;
                        TotalDebits:=TotalDebits + Abs(Deductions."Total Amount Employer");
                        TotalCredits:=TotalCredits + TotalSSF;
                        //PENSION
                        GenJnline.Init;
                        //Employer.CALCFIELDS(Employer."Total Amount Employer");
                        GenJnline."Journal Template Name":='GENERAL';
                        GenJnline."Journal Batch Name":='SALARIES';
                        GenJnline."Line No.":=GenJnline."Line No." + 40000;
                        GenJnline."Account No.":=Deductions."G/L Account Employer";
                        GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                        GenJnline.Description:=Deductions.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>') + '-' + "Client Employee Groups".Code;
                        GenJnline."Document No.":=Payperiodtext;
                        GenJnline."Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                        GenJnline.Validate("Shortcut Dimension 1 Code");
                        GenJnline."Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                        GenJnline.Validate("Shortcut Dimension 2 Code");
                        GenJnline.Amount:=Deductions."Total Amount Employer";
                        GenJnline.Validate(GenJnline.Amount);
                        if GenJnline.Amount <> 0 then GenJnline.Insert;
                    end;
                end;
                trigger OnPreDataItem()
                begin
                    LineNumber:=LineNumber + 50000;
                    Deductions.SetRange(Deductions."Pay Period Filter", DateSpecified);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                TotalncomeTax:=0;
                TotalBasic:=0;
                //TotalNetPay:=0;                
                IndividualEarning:=0;
                //"Client Employee Groups".TESTFIELD("Client Employee Groups"."Basic Salary Account");
                "Client Employee Groups".TestField("Client Employee Groups"."Income Tax account");
                "Client Employee Groups".TestField("Client Employee Groups"."Net Pay Account");
                //"Client Employee Groups".TESTFIELD("Client Employee Groups"."SSF Employer Account");
                PayablesAcc:="Client Employee Groups"."Net Pay Account";
                LineNumber:=LineNumber + 10;
            end;
            trigger OnPostDataItem()
            begin
                Totalgross:=0;
            end;
            trigger OnPreDataItem()
            begin
                LineNumber:=LineNumber + 60000;
            end;
        }
        dataitem(LoansRec; "Deductions Master")
        {
            DataItemTableView = SORTING(Code)WHERE(Loan=CONST(true));

            column(LoansRec_Description; Description)
            {
            }
            column(LoansRec__Total_Amount_; "Total Amount")
            {
            }
            column(LoansRec_Code; Code)
            {
            }
            trigger OnAfterGetRecord()
            begin
                LoansRec.CalcFields("Total Amount");
                TotalCredits:=Abs(TotalCredits) + Abs("Total Amount");
                AssignmentMat.Reset;
                AssignmentMat.SetRange(AssignmentMat.Type, AssignmentMat.Type::Deduction);
                AssignmentMat.SetRange(AssignmentMat.Code, LoansRec.Code);
                AssignmentMat.SetRange(AssignmentMat."Payroll Period", DateSpecified);
                if AssignmentMat.Find('-')then begin
                    repeat GenJnline.Init;
                        GenJnline."Journal Template Name":='GENERAL';
                        GenJnline."Journal Batch Name":='SALARIES';
                        GenJnline."Line No.":=GenJnline."Line No." + 70000;
                        GenJnline."Account Type":=GenJnline."Account Type"::Customer;
                        LoanApp.Reset;
                        LoanApp.SetRange(LoanApp."Loan No", AssignmentMat."Reference No");
                        if LoanApp.Find('+')then if EmpRec.Get(AssignmentMat."Employee No")then GenJnline."Account No.":=EmpRec."Customer Code";
                        GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                        GenJnline.Description:=LoansRec.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                        ;
                        GenJnline."Document No.":=Payperiodtext;
                        GenJnline.Amount:=AssignmentMat.Amount;
                        GenJnline.Validate(GenJnline.Amount);
                        if LoanAccount.Get(EmpRec."Customer Code")then begin
                            GenJnline."Shortcut Dimension 1 Code":=LoanAccount."Global Dimension 1 Code";
                            GenJnline."Shortcut Dimension 2 Code":=LoanAccount."Global Dimension 2 Code";
                            GenJnline.Validate("Shortcut Dimension 1 Code");
                            GenJnline.Validate("Shortcut Dimension 2 Code");
                        end;
                        if GenJnline.Amount <> 0 then GenJnline.Insert;
                    until AssignmentMat.Next = 0;
                end;
                TotalDebits:=TotalDebits + Abs(LoansRec."Total Amount Employer");
                TotalCredits:=TotalCredits + LoansRec."Total Amount";
            end;
            trigger OnPreDataItem()
            begin
                LoansRec.SetRange(LoansRec."Pay Period Filter", DateSpecified);
            end;
        }
        dataitem(SalAdvance; "Deductions Master")
        {
            DataItemTableView = SORTING(Code)WHERE(Advance=CONST(true));

            column(Advance_Description; Description)
            {
            }
            column(Advance__Total_Amount_; "Total Amount")
            {
            }
            column(Advance_Code; Code)
            {
            }
            trigger OnAfterGetRecord()
            begin
                SalAdvance.CalcFields("Total Amount");
                TotalCredits:=Abs(TotalCredits) + Abs("Total Amount");
                AssignmentMat.Reset;
                AssignmentMat.SetRange(AssignmentMat.Type, AssignmentMat.Type::Deduction);
                AssignmentMat.SetRange(AssignmentMat.Code, SalAdvance.Code);
                AssignmentMat.SetRange(AssignmentMat."Payroll Period", DateSpecified);
                if AssignmentMat.Find('-')then begin
                    repeat GenJnline.Init;
                        GenJnline."Journal Template Name":='GENERAL';
                        GenJnline."Journal Batch Name":='SALARIES';
                        GenJnline."Line No.":=GenJnline."Line No." + 80000;
                        GenJnline."Account Type":=GenJnline."Account Type"::Customer;
                        if EmpRec.Get(AssignmentMat."Employee No")then GenJnline."Account No.":=EmpRec."Customer Code";
                        GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                        GenJnline.Description:=SalAdvance.Description + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                        ;
                        GenJnline."Document No.":=Payperiodtext;
                        GenJnline.Amount:=AssignmentMat.Amount;
                        GenJnline.Validate(GenJnline.Amount);
                        if LoanAccount.Get(EmpRec."Customer Code")then begin
                            GenJnline."Shortcut Dimension 1 Code":=LoanAccount."Global Dimension 1 Code";
                            GenJnline."Shortcut Dimension 2 Code":=LoanAccount."Global Dimension 2 Code";
                            GenJnline.Validate("Shortcut Dimension 1 Code");
                            GenJnline.Validate("Shortcut Dimension 2 Code");
                        end;
                        if GenJnline.Amount <> 0 then GenJnline.Insert;
                    until AssignmentMat.Next = 0;
                end;
                TotalDebits:=TotalDebits + Abs(SalAdvance."Total Amount Employer");
                TotalCredits:=TotalCredits + SalAdvance."Total Amount";
            end;
            trigger OnPreDataItem()
            begin
                SalAdvance.SetRange(SalAdvance."Pay Period Filter", DateSpecified);
            end;
        }
        dataitem(Summary; "Integer")
        {
            DataItemTableView = SORTING(Number)WHERE(Number=CONST(1));

            column(TotalDebits; TotalDebits)
            {
            }
            column(TotalCredits; TotalCredits)
            {
            }
            column(TotalNetPay; TotalNetPay)
            {
            }
            column(Net_PayCaption; Net_PayCaptionLbl)
            {
            }
            column(Summary_Number; Number)
            {
            }
            trigger OnAfterGetRecord()
            begin
                GenJnline.Init;
                LineNumber:=LineNumber + 10;
                GenJnline."Journal Template Name":='GENERAL';
                //GenJnline."Journal Batch Name" := 'SALARIES';
                GenJnline."Journal Batch Name":='SALARIES';
                GenJnline."Line No.":=GenJnline."Line No." + 90000;
                GenJnline."Account No.":=PayablesAcc;
                GenJnline."Posting Date":=PayrollPeriod."Pay Date";
                GenJnline.Description:='Salary payable' + ' ' + Format(DateSpecified, 0, '<month text> <year4>');
                ;
                GenJnline."Document No.":=Payperiodtext;
                GenJnline.Amount:=-TotalNetPay;
                GenJnline.Validate(GenJnline.Amount);
                if GenJnline.Amount <> 0 then GenJnline.Insert;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(Month; Month)
                {
                    ApplicationArea = All;
                    Caption = 'Month Begin Date';
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
    trigger OnPostReport()
    begin
        if JnlTemp.Get('GENERAL', 'SALARIES')then Found:=true
        else
        begin
            JnlTemp.Init;
            JnlTemp."Journal Template Name":='GENERAL';
            JnlTemp.Name:='SALARIES';
            JnlTemp.Description:='Salary Journal';
        // JnlTemp.Insert;
        end;
    end;
    trigger OnPreReport()
    begin
        "Client Employee Groups".SetFilter("Pay Period Filter", '%1', Month);
        Payperiodtext:="Client Employee Groups".GetFilter("Client Employee Groups"."Pay Period Filter");
        Payperiodtext:=CopyStr(Payperiodtext, 4, 6);
        GetPeriodFilter:="Client Employee Groups".GetRangeMin("Client Employee Groups"."Pay Period Filter");
        DateSpecified:="Client Employee Groups".GetRangeMin("Client Employee Groups"."Pay Period Filter");
        if PayrollPeriod.Get(DateSpecified)then Payday:=PayrollPeriod."Pay Date";
        IndividualEarning:=0;
        if Payday = 0D then Error('Pay Date must be Specified for the Period');
        LineNumber:=0;
        GetCurrentPeriod;
        if PeriodStartDate <> PayrollPeriod."Starting Date" then if not Confirm('You are about to Transfer the Payroll summary for the Wrong Period,Continue?', false)then CurrReport.Quit;
        AdjustPostingGr;
    end;
    var LastFieldNo: Integer;
    FooterPrinted: Boolean;
    TaxableAmount: Decimal;
    IncomeTax: Decimal;
    NetPay: Decimal;
    RightBracket: Boolean;
    AmountRemaining: Decimal;
    Company: Record "Company Information";
    Companyz: Code[10];
    "Posting Date": Date;
    BatchName: Text[30];
    DocumentNo: Code[10];
    Description: Text[30];
    Amount: Decimal;
    "G/LAccount": Code[10];
    TotalncomeTax: Decimal;
    GrossPay: Decimal;
    Totalgross: Decimal;
    TotalNetPay: Decimal;
    Payday: Date;
    GenJnline: Record "Gen. Journal Line";
    LineNumber: Integer;
    TotalBasic: Decimal;
    PayrollPeriod: Record "Client Payroll Period";
    PostingGroup: Record "Client Employee Groups";
    TaxAccount: Code[10];
    EmpPostingGroup: Record "Employee Posting Group";
    SalariesAcc: Code[10];
    PayablesAcc: Code[10];
    First: Code[10];
    Last: Code[10];
    EmployeeTemp: Record Employee temporary;
    TotalDebits: Decimal;
    TotalCredits: Decimal;
    AssignmentMat: Record "Client Payroll Matrix";
    JnlTemp: Record "Gen. Journal Batch";
    Found: Boolean;
    TotalSSF: Decimal;
    PeriodStartDate: Date;
    EmpRec: Record "Client Employee Master";
    DateSpecified: Date;
    Payperiodtext: Text[30];
    TransferLoans: Boolean;
    TaxCode: Code[10];
    BasicSalary: Decimal;
    PAYE: Decimal;
    CompRec: Record "Human Resources Setup";
    HseLimit: Decimal;
    ExcessRetirement: Decimal;
    CfMpr: Decimal;
    relief: Decimal;
    GetPeriodFilter: Date;
    ActivityRec: Record "Dimension Value";
    EarningsCopy: Record "Earnings Master";
    LoanApp: Record "Client Loan Application";
    Payroll_Journal_summary_reportCaptionLbl: Label 'Payroll Journal summary report';
    Net_PayCaptionLbl: Label 'Net Pay';
    Month: Date;
    Gross: Decimal;
    IndividualEarning: Decimal;
    LoanAccount: Record Customer;
    procedure GetTaxBracket(var TaxableAmount: Decimal)
    var
        TaxTable: Record Bracket;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining:=TaxableAmount;
        AmountRemaining:=AmountRemaining;
        AmountRemaining:=PayrollRounding(AmountRemaining);
        EndTax:=false;
        TaxTable.SetRange("Table Code", TaxCode);
        if TaxTable.Find('-')then begin
            repeat if AmountRemaining <= 0 then EndTax:=true
                else
                begin
                    if(TaxableAmount) > TaxTable."Upper Limit" then Tax:=TaxTable."Taxable Amount" * TaxTable.Percentage / 100
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
    procedure GetPayPeriod(var PayPeriods: Record "Client Payroll Period")
    begin
        PayrollPeriod:=PayPeriods;
    end;
    procedure GetCurrentPeriod()
    var
        PayPeriodRec: Record "Payroll Period";
    begin
    /*PayPeriodRec.SETRANGE(PayPeriodRec.Closed,FALSE);
        IF PayPeriodRec.FIND('-') THEN
        PeriodStartDate:=PayPeriodRec."Starting Date";
        */
    end;
    procedure AdjustPostingGr()
    begin
        if AssignmentMat.Find('-')then begin
            repeat if EmpRec.Get(AssignmentMat."Employee No")then AssignmentMat."Payroll Group":=EmpRec."Employee Group";
                AssignmentMat.Modify;
            until AssignmentMat.Next = 0;
        end;
    end;
    procedure PayrollRounding(var Amount: Decimal)PayrollRounding: Decimal var
        HRsetup: Record "QuantumJumps Payroll Setup";
    begin
        HRsetup.Get;
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
}
