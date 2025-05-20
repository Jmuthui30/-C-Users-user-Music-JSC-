table 51437 "Payroll Matrix"
{
    // version THL- Payroll 1.0
    DrillDownPageID = "Payroll Matrix Loan View";
    LookupPageID = "Payroll Matrix Loan View";

    fields
    {
        field(1; "Employee No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Empl.Get("Employee No")then begin
                    if Empl."Employee Group" <> 'BOARD' then begin
                        //Empl.TESTFIELD("Global Dimension 3 Code");
                        //Empl.TESTFIELD("Global Dimension 2 Code");
                        Empl.TestField("Global Dimension 1 Code");
                    end;
                    "Global Dimension 1 code":=Empl."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=Empl."Global Dimension 2 Code";
                    "Payroll Group":=Empl."Employee Group";
                    if Empl."Employee Group" = '' then Error('Assign employee  %2 an employee group before assigning any earning or deduction', Empl."No.");
                end;
            end;
        }
        field(2; Type; Option)
        {
            NotBlank = false;
            OptionMembers = Payment, Deduction, "Saving Scheme", Loan, Informational;
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF(Type=CONST(Payment))Earnings
            ELSE IF(Type=CONST(Deduction))Deductions;

            trigger OnValidate()
            var
                MarketIntRateRec: Record "Market Interest Rates";
                MarketIntRate: Decimal;
                InterestRate: Decimal;
                LoanApplicationRec: Record "Loan Application";
                LoanTopupRec: Record "Loan Top-up";
                LoanBalance: Decimal;
                RepSchedule: Record "Loan Schedule";
                EmployeeMaster: Record "Client Employee Master";
            begin
                TestField("Employee No");
                if NAVEmployee.Get("Employee No")then begin
                    if NAVEmployee.Status = NAVEmployee.Status::Inactive then Error('Can only assign Earnings and deductions to Active Employees Please confirm if ' + '%1 %2 is an Active Employee', NAVEmployee."First Name", NAVEmployee."Last Name");
                end;
                GetPayPeriod;
                "Payroll Period":=PayStartDate;
                // RESET;
                //*********************Allowances Calculation rules etc***************
                case Type of Type::Payment: begin
                    if Payments.Get(Code)then begin
                        // check if blocked
                        if Payments.Block = true then Error(' Earning Blocked');
                        "Time Sheet":=Payments."Time Sheet";
                        Description:=Payments.Description;
                        if Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" then "Tax Relief":=true;
                        "Non-Cash Benefit":=Payments."Non-Cash Benefit";
                        Taxable:=Payments.Taxable;
                        // MESSAGE('Taxable=%1',Taxable);
                        "Reduces Taxable Amt":=Payments."Reduces Tax";
                        if Payments."Pay Type" = Payments."Pay Type"::Recurring then "Next Period Entry":=true
                        else
                            "Earning/Deduction Type":="Earning/Deduction Type"::"Non-recurring";
                        "Basic Salary Code":=Payments."Basic Salary Code";
                        "Basic Pay Arrears":=Payments."Basic Pay Arrears";
                        if Payments."Earning Type" = Payments."Earning Type"::"Normal Earning" then "Normal Earnings":=true
                        else
                            "Normal Earnings":=false;
                        if Payments."Calculation Method" = Payments."Calculation Method"::"Flat amount" then Amount:=Payments."Flat Amount";
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Basic pay" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Basic, Empl."Basic Arrears");
                                Amount:=Payments.Percentage / 100 * (Empl.Basic - Empl."Basic Arrears");
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                Amount:=PayrollRounding(Amount); //round
                            end;
                        end;
                        // END;
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Basic after tax" then begin
                            if Empl.Get("Employee No")then begin
                                HRSetup.Get;
                                if HRSetup."Company overtime hours" <> 0 then Amount:=("No. of Units" * Empl."Hourly Rate" * Payments."Overtime Factor"); //HRSetup."Company overtime hours";
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                Amount:=PayrollRounding(Amount); //round
                            end;
                        end;
                        if Payments."Calculation Method" = Payments."Calculation Method"::"Based on Hourly Rate" then begin
                            if Empl.Get("Employee No")then begin
                                Amount:="No. of Units" * Empl."Daily Rate"; //*Payments."Overtime Factor";
                                if Payments."Overtime Factor" <> 0 then Amount:="No. of Units" * Empl."Daily Rate" * Payments."Overtime Factor";
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                Amount:=PayrollRounding(Amount); //round
                            end;
                        end;
                        //kugun
                        //insurance relief'
                        //modified by grace to check if an employee has insurance certificate to qualify for the relief
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Insurance Amount" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Empl.Insurance);
                                //MESSAGE('%1',Empl.Insurance);
                                Amount:=Abs((Payments.Percentage / 100) * (Empl.Insurance));
                                // MESSAGE('%1',Amount);
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                Amount:=PayrollRounding(Amount); //round
                            // MESSAGE('%1',Amount);
                            end;
                        end;
                        //Based on SHIF % Added by Dennis
                        //modified by Grace
                        IF Payments."Calculation Method" = Payments."Calculation Method"::"% of SHIF" THEN BEGIN
                            IF Empl.GET("Employee No")THEN BEGIN
                                Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Empl.SHIF);
                                Amount:=Abs((Payments.Percentage / 100) * (Empl.SHIF));
                            /* SHIFAmount := 0;
                                        Assignmatrix.RESET;
                                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", "Employee No");
                                        Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Deduction);
                                        Assignmatrix.SETRANGE(Code, 'SHIF');
                                        IF Assignmatrix.FINDSET THEN
                                            SHIFAmount := Assignmatrix.Amount;


                                        Amount := ABS(Payments.Percentage / 100 * SHIFAmount); */
                            END;
                        END;
                        //Calculate Fringe Benefit
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Loan Amount" then begin
                            if Payments.Fringe = true then begin
                                //Get The Interest Rate;
                                LoanBalance:=0;
                                LoanProductType.Reset;
                                LoanProductType.SetRange(LoanProductType."Fringe Benefit Code", Code);
                                if LoanProductType.Find('-')then begin
                                    MarketIntRateRec.Reset;
                                    MarketIntRateRec.SetRange("Loan Code", LoanProductType.Code);
                                    MarketIntRateRec.SetFilter("Start Date", '<=%1', "Payroll Period");
                                    MarketIntRateRec.SetFilter("End Date", '>=%1', "Payroll Period");
                                    if MarketIntRateRec.Find('-')then MarketIntRate:=MarketIntRateRec.Intrest;
                                    InterestRate:=LoanProductType."Interest Rate";
                                    InterestRate:=PayrollRounding(InterestRate);
                                    //  MESSAGE('%3\MR=%1\IR=%2',MarketIntRate,InterestRate,LoanProductType.Description);
                                    //Get the Loan Balance;
                                    case LoanProductType."Interest Calculation Method" of LoanProductType."Interest Calculation Method"::"Flat Rate": begin
                                        case LoanProductType."Calculate On" of LoanProductType."Calculate On"::"Closing Balance": begin
                                            LoanApplicationRec.Reset;
                                            LoanApplicationRec.SetRange(LoanApplicationRec."Date filter", 0D, "Payroll Period");
                                            LoanApplicationRec.SetRange("Deduction Code", LoanProductType."Deduction Code");
                                            LoanApplicationRec.SetRange("Employee No", "Employee No");
                                            LoanApplicationRec.SetFilter("Stop Loan", '<>%1', true);
                                            if LoanApplicationRec.Find('-')then begin
                                                LoanApplicationRec.CalcFields(LoanApplicationRec."Total Repayment", LoanApplicationRec."Total Loan");
                                                if LoanApplicationRec."Total Loan" <> 0 then begin
                                                    LoanTopupRec.Reset;
                                                    LoanTopupRec.SetCurrentKey("Loan No", "Payroll Period");
                                                    LoanTopupRec.SetRange("Loan No", LoanApplicationRec."Loan No");
                                                    LoanTopupRec.SetRange("Payroll Period", 0D, "Payroll Period");
                                                    LoanTopupRec.CalcSums(Amount);
                                                    LoanBalance:=LoanTopupRec.Amount + LoanApplicationRec."Total Repayment";
                                                end
                                                else
                                                    LoanBalance:=LoanApplicationRec."Approved Amount" + LoanApplicationRec."Total Repayment";
                                            end;
                                        end;
                                        LoanProductType."Calculate On"::"Opening Balance": begin
                                            LoanApplicationRec.Reset;
                                            LoanApplicationRec.SetRange(LoanApplicationRec."Date filter", 0D, CalcDate('-1M', "Payroll Period"));
                                            LoanApplicationRec.SetRange("Deduction Code", LoanProductType."Deduction Code");
                                            LoanApplicationRec.SetRange("Employee No", "Employee No");
                                            LoanApplicationRec.SetFilter("Stop Loan", '<>%1', true);
                                            if LoanApplicationRec.Find('-')then begin
                                                LoanApplicationRec.CalcFields(LoanApplicationRec."Total Repayment", LoanApplicationRec."Total Loan");
                                                if LoanApplicationRec."Total Loan" <> 0 then begin
                                                    LoanTopupRec.Reset;
                                                    LoanTopupRec.SetCurrentKey("Loan No", "Payroll Period");
                                                    LoanTopupRec.SetRange("Loan No", LoanApplicationRec."Loan No");
                                                    LoanTopupRec.SetRange("Payroll Period", 0D, "Payroll Period");
                                                    LoanTopupRec.CalcSums(Amount);
                                                    LoanBalance:=LoanTopupRec.Amount + LoanApplicationRec."Total Repayment";
                                                // MESSAGE('TotalLoan=%1\TotalRepayment=%3\LoanBalance=%2',LoanApplicationRec."Total Loan",LoanBalance,LoanApplicationRec."Total Repayment");
                                                end
                                                else
                                                    LoanBalance:=LoanApplicationRec."Approved Amount" + LoanApplicationRec."Total Repayment";
                                            //MESSAGE('ApprovedAmount=%1\LoanBalance=%2',LoanApplicationRec."Approved Amount",LoanBalance);
                                            end;
                                        end;
                                        end;
                                    end;
                                    LoanProductType."Interest Calculation Method"::"Reducing Balance": begin
                                        LoanApplicationRec.Reset;
                                        LoanApplicationRec.SetRange(LoanApplicationRec."Date filter", 0D, CalcDate('-1M', "Payroll Period"));
                                        LoanApplicationRec.SetRange("Deduction Code", LoanProductType."Deduction Code");
                                        LoanApplicationRec.SetRange("Employee No", "Employee No");
                                        LoanApplicationRec.SetFilter("Stop Loan", '<>%1', true);
                                        if LoanApplicationRec.Find('-')then begin
                                            RepSchedule.Reset;
                                            RepSchedule.SetRange("Loan No", LoanApplicationRec."Loan No");
                                            RepSchedule.SetRange("Repayment Date", "Payroll Period"); //CALCDATE('-1M',"Payroll Period")
                                            if RepSchedule.Find('-')then LoanBalance:=RepSchedule."Remaining Debt" + RepSchedule."Principal Repayment";
                                        //  MESSAGE('%1, %2',LoanBalance);
                                        // Amount:=((MarketIntRate-InterestRate)/100/12)*LoanBalance;
                                        end;
                                    end;
                                    end; //CASE
                                    Amount:=(((MarketIntRate - InterestRate) / 100) / 12) * LoanBalance;
                                    Amount:=PayrollRounding(Amount);
                                    // MESSAGE('%1\Fringe=%2\Balance=%3',"Employee No", Amount,LoanBalance);
                                    "Employer Amount":=0.3 * Amount;
                                end;
                            end;
                        end;
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Gross pay" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Basic, Empl."Total Allowances");
                                Amount:=((Payments.Percentage / 100) * (Empl.Basic + Empl."Total Allowances"));
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                Amount:=PayrollRounding(Amount); //round
                            end;
                        end;
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Taxable income" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange("Pay Period Filter", PayStartDate);
                                Empl.CalcFields(Empl."Taxable Allowance");
                                Amount:=((Payments.Percentage / 100) * (Empl."Taxable Allowance"));
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                Amount:=PayrollRounding(Amount); //round
                            //IF "Value of Quarters">Amount THEN
                            // Amount:="Value of Quarters";
                            end;
                        end;
                        if Payments."Reduces Tax" then begin
                            //Amount:=-Amount;
                            Amount:=PayrollRounding(Amount); //round
                        end;
                    end;
                end;
                //*********Deductions****************************************
                // IF Type=Type::Deduction THEN BEGIN
                Type::Deduction: begin
                    if Deductions.Get(Code)then begin
                        if Deductions.Block = true then Error('Deduction Blocked');
                        Description:=Deductions.Description;
                        "Reduces Taxable Amt":=Deductions."Reduces Taxable Amt";
                        Retirement:=Deductions."Pension Scheme";
                        Shares:=Deductions.Shares;
                        Paye:=Deductions."PAYE Code";
                        "Insurance Code":=Deductions."Insurance Code";
                        "SHIF Code":=Deductions."SHIF Code";
                        "Main Deduction Code":=Deductions."Main Deduction Code";
                        if Deductions.Type = Deductions.Type::Recurring then "Next Period Entry":=true
                        else
                            "Earning/Deduction Type":="Earning/Deduction Type"::"Non-recurring";
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount" then begin
                            // MESSAGE('%1=%2',Deductions.Description,Amount);
                            if Deductions."Flat Amount" <> 0 then Amount:=Deductions."Flat Amount"
                            else
                                Amount:=Amount;
                            if Deductions."Flat Amount Employer" <> 0 then "Employer Amount":=Deductions."Flat Amount Employer"
                            else
                                "Employer Amount":="Employer Amount";
                        end;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."Pay Period Filter", PayStartDate);
                                Empl.CalcFields(Empl.Basic);
                                Amount:=Deductions.Percentage / 100 * Empl.Basic;
                                if(Deductions."PAYE Code" = true)then "Taxable amount":=Empl.Basic;
                                // MESSAGE('NO ROUNDING AMOUNT=%1',Amount);
                                Amount:=PayrollRounding(Amount); //round
                                "Employer Amount":=Deductions."Percentage Employer" / 100 * Empl.Basic;
                                "Employer Amount":=PayrollRounding("Employer Amount"); //round
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                //pension amount may exceed the maximum limit but the additional amount is tax
                                /*
                                        IF Deductions."Maximum Amount"<> 0 THEN BEGIN
                                        IF ABS(Amount) > Deductions."Maximum Amount" THEN
                                         Amount:=Deductions."Maximum Amount";
                                         "Employer Amount":=Deductions."Percentage Employer"/100*Empl.Basic;
                                         //Employer amount should not have maximum pension deduction
                                         {
                                           IF "Employer Amount">Deductions."Maximum Amount" THEN
                                      "Employer Amount":=Deductions."Maximum Amount";
                                         }
                                         */
                                //end of Employer pension
                                "Employer Amount":=PayrollRounding("Employer Amount"); //round
                                CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");
                            // Added by Lob
                            end;
                        end;
                        //End of addition
                        //Added by Jacob
                        //Calculate CMFIU PAYE2
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Basic, Empl."Total Allowances");
                                Amount:=((Deductions.Percentage / 100) * (Empl."Total Allowances")); //Empl.Basic+
                                Amount:=PayrollRounding(Amount); //round
                                "Taxable amount":=Empl."Total Allowances"; //Empl.Basic+//"Employer Amount":=(Deductions."Percentage Employer"/100)*(
                            //  "Employer Amount":=PayrollRounding("Employer Amount");//round
                            end;
                        end;
                        //End Calculate CMFIU PAYE2
                        //Added by Jacob
                        //Salary Recovery
                        SalaryRecoveryAmt:=0;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Salary Recovery" then begin
                            if Empl.Get("Employee No")then begin
                                Deductions.Reset;
                                Deductions.SetRange(Deductions."Salary Recovery", true);
                                if Deductions.Find('-')then begin
                                    SalarySteps.Reset;
                                    SalarySteps.SetRange(SalarySteps.Code, Deductions.Code);
                                    SalarySteps.SetRange(SalarySteps."Employee No", "Employee No");
                                    SalarySteps.SetRange(SalarySteps."Payroll Period", "Payroll Period");
                                    // SalarySteps.SETRANGE(SalarySteps."Employee No",LoanApp."Employee No");
                                    if SalarySteps.Find('-')then SalaryRecoveryAmt:=SalarySteps.Amount;
                                    Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                    // Empl.CALCFIELDS();
                                    Amount:=((Deductions.Percentage / 100) * SalaryRecoveryAmt);
                                    Amount:=PayrollRounding(Amount); //round
                                end;
                            end;
                        end;
                        //end of salary recovery
                        if Deductions.CoinageRounding = true then begin
                            //     HRSetup.GET();
                            //     Maxlimit:=HRSetup."Pension Limit Amount";
                            Retirement:=Deductions.CoinageRounding;
                            if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then "Employer Amount":=Deductions.Percentage / 100 * Empl.Basic
                            else
                                "Employer Amount":=Deductions."Flat Amount";
                            "Employer Amount":=PayrollRounding("Employer Amount"); //round
                        end;
                        //end of uganda requirement addition
                        //  IF "Employer Amount" > Deductions."Maximum Amount" THEN
                        //     "Employer Amount":=Deductions."Maximum Amount";
                        Amount:=PayrollRounding(Amount); //round
                        "Employer Amount":=PayrollRounding("Employer Amount"); //round
                    end;
                    //added for Uganda requirements
                    // added by Lob vega
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table" then begin
                        if Empl.Get("Employee No")then begin
                            Empl.CalcFields(Empl.Basic, Empl."Total Allowances");
                            Amount:=((Deductions.Percentage / 100) * (Empl.Basic + Empl."Total Allowances"));
                            "Employer Amount":=((Deductions.Percentage / 100) * (Empl.Basic + Empl."Total Allowances"));
                            Amount:=PayrollRounding(Amount);
                            "Employer Amount":=PayrollRounding("Employer Amount");
                        end;
                    end;
                    //added for BM requirements
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance" then begin
                        if Empl.Get("Employee No")then begin
                            //SalarySteps.GET(Empl."Salary Steps",SalarySteps.Level::"Level 1",Empl."Salary Scheme Category");
                            //Amount:=((Deductions.Percentage/100)* (Empl."Basic Pay"+SalarySteps."House allowance"));
                            //"Employer Amount":=((Deductions.Percentage/100)*(Empl."Working Days Per Year"+SalarySteps."House allowance"));
                            Amount:=PayrollRounding(Amount);
                            "Employer Amount":=PayrollRounding("Employer Amount");
                        end;
                    end;
                    //
                    if Type = Type::Deduction then Amount:=-Amount;
                    //*******New Addition*******************
                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table" then begin
                        GetPayPeriod;
                        Empl.Reset;
                        Empl.SetRange(Empl."No.", "Employee No");
                        Empl.SetRange(Empl."Pay Period Filter", PayStartDate);
                        Empl.CalcFields(Empl."Total Allowances", Empl.Basic);
                        // used gross pay new requirement for SHIF changed by Linus
                        // MESSAGE('Deduction Table');
                        Amount:=-(GetBracket(Deductions, Empl."Total Allowances", "Employee Tier I", "Employee Tier II"));
                        if Deductions."Pension Scheme" then "Employer Amount":=(GetBracket(Deductions, Empl."Total Allowances", "Employer Tier I", "Employer Tier II"));
                    end;
                //*******Upto here
                //END;
                end;
                /*
                  //*********Special Deductions.....Loans,Staff welfare,Union Dues etc....Keep track*****
                   IF (Type=Type::Deduction) THEN BEGIN
                    IF Deductions.GET(Code) THEN
                    BEGIN
                    IF Deductions.Loan=TRUE THEN BEGIN
                    IF Loan.GET(Rec.Code,Rec."Employee No") THEN BEGIN
                         Description:=Deductions.Description;
                         "G/L Account":=Deductions."G/L Account";
                        "Tax Deductible":=Deductions."Tax deductible";
                        "Effective Start Date":=Loan."Repayment Begin Date";
                        "Effective End Date":=Loan."Repayment End Date";
                         {****New addition to take care of compound interest***}
                         Loan.CALCFIELDS(Loan."Cumm. Period Repayments1");
                         ReducedBal:=Loan."Loan Amount"-Loan."Cumm. Period Repayments1";
                         InterestAmt:=Loan."Interest Rate"/(100);
                         InterestAmt:=-ReducedBal*InterestAmt;
                         Amount:=-Loan."Period Repayments"+InterestAmt;
                         "Interest Amount":=InterestAmt;
                         "Period Repayment":=Loan."Period Repayments";
                         {****ENDS HERE*****}
                         "Initial Amount":=Loan."Loan Amount";
                         "Outstanding Amount":=Loan."Loan Amount"+Loan."Amount Paid"+Rec.Amount;
                         "Loan Repay":=TRUE;
                         InterestDiff:=((Loan."External Interest Rate"-Loan."Interest Rate")/(12*100));
                      //**LOW INTEREST RATE CALCULATION
                         IF Deductions."Loan Type"=Deductions."Loan Type"::"Low Interest Benefit" THEN
                         BEGIN
                         Benefits.RESET;
                         //Benefits.SETRANGE(Benefits."Low Interest Benefit",TRUE);
                         IF Benefits.FIND('-') THEN
                                    CreateLIBenefit("Employee No",Benefits."Tax Band",ReducedBal)
                          ELSE
                          ERROR('Low Interest Rate Benefit has not been defined in the Earnings Setup please');
                       END;

                       END
                     ELSE
                     ERROR('EMPLOYEE %1  HAS NOT TAKEN THIS TYPE OF LOAN -Loan Code-- %2',"Employee No",Deductions.Code );


                    END;

                    VALIDATE(Amount);
                    END;

                    END;

                   */
                // Added for Loan deductions
                //IF (Type=Type::Loan) THEN BEGIN
                Type::Loan: begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No", Code);
                    LoanApp.SetRange(LoanApp."Employee No", "Employee No");
                    if LoanApp.Find('-')then begin
                        if LoanProductType.Get(LoanApp."Loan Product Type")then Description:=LoanProductType.Description;
                        Amount:=-LoanApp.Repayment;
                        Validate(Amount);
                    end;
                end;
                end;
            //**********END**************************************************************************
            end;
        }
        field(4; "Payroll Period"; Date)
        {
            NotBlank = false;
            TableRelation = "Payroll Period"."Starting Date";
        }
        field(5; "Currency Code"; Code[10])
        {
        }
        field(6; Amount; Decimal)
        {
            DecimalPlaces = 2: 2;

            trigger OnValidate()
            var
                CEmpl: Record "Client Employee Master";
            begin
                if((Rec.Type = Rec.Type::Payment) and (Rec.Code = '006'))then Error('Amount for Toup Salary Depends on Number of Days Worked');
                if(Type = Type::Payment)then if Payments.Get(Code)then if Payments."Reduces Tax" then begin
                        //Amount:=-Amount;
                        end;
                if(Type = Type::Payment)then if Amount < 0 then Error('Earning must not be negative');
                if(Type = Type::Payment)then if Payments."Salary Recovery" then if(Amount > 0)then Amount:=-Amount;
                if(Type = Type::Deduction)then if(Amount > 0)then Amount:=-Amount;
                if(Type = Type::Deduction)then begin
                    if Deductions.Get(Code)then begin
                        if Deductions."Pension Arrears" = true then begin
                            "Employer Amount":=2 * Amount;
                            "Employer Amount":=PayrollRounding("Employer Amount"); //round
                        //pension amount may exceed the maximum limit but the additional amount is tax
                        // END;
                        end;
                    end;
                end;
                // ************ Interdicted Employees ********************
                // if CEmpl.Get("Employee No") then begin
                //     if CEmpl.Status = CEmpl.Status::Interdicted then begin
                //         if Payments."Basic Salary Code" = true then begin
                //             Amount := Rec.Amount * 0.5;
                //             // Message('Your Basic is %1', Amount);
                //         end
                //         else
                //             Amount := Rec.Amount;
                //     end;
                // end;
                Amount:=PayrollRounding(Amount);
                if "Manual Entry" then begin
                    if Empl.Get("Employee No")then begin
                        Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                        Empl.CalcFields(Empl."Total Allowances", Empl."Total Deductions");
                    end;
                end;
            end;
        }
        field(7; "Amount LCY"; Decimal)
        {
        }
        field(9; Description; Text[80])
        {
            trigger OnValidate()
            begin
            // TESTFIELD(Closed,FALSE);
            end;
        }
        field(10; "Employer Amount"; Decimal)
        {
            DecimalPlaces = 2: 2;

            trigger OnValidate()
            begin
            //TESTFIELD(Closed,FALSE);
            end;
        }
        field(11; "Employer Amount LCY"; Decimal)
        {
        }
        field(12; Taxable; Boolean)
        {
            trigger OnValidate()
            begin
            // TESTFIELD(Closed,FALSE);
            end;
        }
        field(13; "Reduces Taxable Amt"; Boolean)
        {
            trigger OnValidate()
            begin
            //TESTFIELD(Closed,FALSE);
            end;
        }
        field(14; "Global Dimension 1 code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(16; "Global Dimension 3 Code"; Code[20])
        {
        }
        field(17; "Next Period Entry"; Boolean)
        {
        }
        field(18; Closed; Boolean)
        {
            Editable = false;
        }
        field(19; "Tax Relief"; Boolean)
        {
        }
        field(20; "Non-Cash Benefit"; Boolean)
        {
            trigger OnValidate()
            begin
            // TESTFIELD(Closed,FALSE);
            end;
        }
        field(21; Retirement; Boolean)
        {
            trigger OnValidate()
            begin
            // TESTFIELD(Closed,FALSE);
            end;
        }
        field(22; Shares; Boolean)
        {
        }
        field(23; "Show on Report"; Boolean)
        {
        }
        field(24; "Earning/Deduction Type"; Option)
        {
            OptionMembers = Recurring, "Non-recurring";
        }
        field(25; "Time Sheet"; Boolean)
        {
        }
        field(26; "Basic Salary Code"; Boolean)
        {
        }
        field(27; "Payroll Group"; Code[20])
        {
            TableRelation = "Employee Groups".Code;
        }
        field(28; Paye; Boolean)
        {
        }
        field(29; "Taxable amount"; Decimal)
        {
        }
        field(30; "Less Pension Contribution"; Decimal)
        {
        }
        field(31; "Normal Earnings"; Boolean)
        {
            Editable = false;
        }
        field(32; "Main Deduction Code"; Code[20])
        {
        }
        field(33; "Insurance Code"; Boolean)
        {
        }
        field(34; "Reference No"; Code[50])
        {
        }
        field(35; "Manual Entry"; Boolean)
        {
        }
        field(36; "Loan Product Type"; Code[20])
        {
            TableRelation = "Loan Product".Code;
        }
        field(37; "Basic Pay Arrears"; Boolean)
        {
        }
        field(38; "Policy No./Loan No."; Code[20])
        {
        }
        field(39; Information; Boolean)
        {
        }
        field(40; "Expected Hrs"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Worked Hrs");
            end;
        }
        field(41; "Worked Hrs"; Decimal)
        {
            trigger OnValidate()
            begin
                "No. of Units":="Expected Hrs" - "Worked Hrs";
            end;
        }
        field(42; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period"."Starting Date";
            ValidateTableRelation = false;
        }
        field(74; "Employee Tier I"; Decimal)
        {
        }
        field(75; "Employee Tier II"; Decimal)
        {
        }
        field(76; "Employer Tier I"; Decimal)
        {
        }
        field(77; "Employer Tier II"; Decimal)
        {
        }
        field(78; "No. of Units"; Decimal)
        {
        }
        field(79; "Non-Interest Loan"; Boolean)
        {
        }
        field(80; "Opening Balance"; Decimal)
        {
        }
        field(81; "Opening Balance Company"; Decimal)
        {
        }
        field(82; "Prorate Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Pay_Month: Integer;
                Pay_Year: Integer;
                Prorate_Month: Integer;
                Prorate_Year: Integer;
            begin
                TestField("Prorating Type", "Prorating Type"::Inactive);
                Prorate_Month:=Date2DMY("Prorate Date", 2);
                Prorate_Year:=Date2DMY("Prorate Date", 3);
                Pay_Month:=Date2DMY("Payroll Period", 2);
                Pay_Year:=Date2DMY("Payroll Period", 3);
                if(Prorate_Year <> Pay_Year) or (Prorate_Month <> Pay_Month)then Error('Prorate Date is out of Payroll Period Month');
            end;
        }
        field(83; Prorate; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Date: Date;
                Emp_Month: Integer;
                Pay_Month: Integer;
                Emp_Year: Integer;
                Pay_Year: Integer;
                Paym_endd: Date;
                Dayworked: Integer;
                DaysToWork: Integer;
                Prorate_Month: Integer;
                Prorate_Year: Integer;
            begin
                TestField(Prorated, false);
                if "Prorating Type" = "Prorating Type"::" " then Error('Please Specify Prorating Type');
                Paym_endd:=CalcDate('CM', "Payroll Period");
                DaysToWork:=Paym_endd - "Payroll Period";
                if "Prorating Type" = "Prorating Type"::Inactive then begin
                    TestField("Prorate Date");
                    Dayworked:="Prorate Date" - "Payroll Period";
                end
                else if "Prorating Type" = "Prorating Type"::Employement then begin
                        Pay_Month:=Date2DMY("Payroll Period", 2);
                        Pay_Year:=Date2DMY("Payroll Period", 3);
                        if NAVEmployee.Get("Employee No")then begin
                            NAVEmployee.TestField("Employment Date");
                            Date:=NAVEmployee."Employment Date";
                        end;
                        Emp_Month:=Date2DMY(Date, 2);
                        Emp_Year:=Date2DMY(Date, 3);
                        if(Emp_Year <> Pay_Year) or (Emp_Month <> Pay_Month)then Error('You cannot Prorate %1 since the Employement date is %2', "Employee No", Date);
                        Dayworked:=Paym_endd - Date end;
                Amount:=((Dayworked / DaysToWork) * Amount);
                Prorated:=true;
                Rec.Modify(true);
            end;
        }
        field(84; "Prorating Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Employement, Inactive;

            trigger OnValidate()
            begin
                if "Prorating Type" = "Prorating Type"::Employement then begin
                    if NAVEmployee.Get("Employee No")then NAVEmployee.TestField("Employment Date");
                end;
            end;
        }
        field(85; Prorated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(86; "No. Of Days Worked"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec.Code <> '006' then Error('Worked Days can only be allocated to Earning Code Topup Salary');
                if Empl.Get("Employee No")then begin
                    Empl.TestField("Daily Rate");
                    Rec.Amount:=Rec."No. Of Days Worked" * Empl."Daily Rate";
                    Rec.Modify(true);
                end;
            end;
        }
        field(87; "SHIF Code"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; "Employee No", Type, "Code", "Payroll Period", "Reference No")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key2; "Employee No", Taxable, "Reduces Taxable Amt", Retirement, "Non-Cash Benefit", "Tax Relief")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key3; Type, "Code")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key4; "Non-Cash Benefit")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key5; "Non-Cash Benefit", Taxable)
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key6; Type, Retirement)
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key7; "Global Dimension 1 code", "Payroll Period", "Code")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key8; "Employee No", Shares)
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key9; Closed, "Code", Type, "Employee No")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key10; "Show on Report")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key11; "Employee No", "Code", "Payroll Period", "Next Period Entry")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key12; "Global Dimension 1 code", "Payroll Period", Type, "Code")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key13; "Basic Salary Code", "Basic Pay Arrears")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key14; Paye)
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key15; "Employee No", "Payroll Period", Type, "Non-Cash Benefit", "Normal Earnings")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key16; "Payroll Period", Type, "Code")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key17; Type, "Employee No", "Payroll Period", "Insurance Code")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key18; Type, "Employee No", "Payroll Period", "SHIF Code")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
    }
    fieldgroups
    {
    }
    var Empl: Record "Employee Master";
    NAVEmployee: Record Employee;
    Payments: Record Earnings;
    Deductions: Record Deductions;
    Paydeduct: Decimal;
    PayPeriod: Record "Payroll Period";
    Loan: Record "Loan Transactions";
    PayStartDate: Date;
    PayPeriodText: Text[30];
    TableAmount: Decimal;
    Basic: Decimal;
    ReducedBal: Decimal;
    InterestAmt: Decimal;
    HRSetup: Record "QuantumJumps Payroll Setup";
    Maxlimit: Decimal;
    Benefits: Record Bracket;
    InterestDiff: Decimal;
    SalarySteps: Record "Payroll Matrix";
    LoanProductType: Record "Loan Product";
    LoanApp: Record "Loan Application";
    "reference no": Record "Payroll Matrix";
    LoanBalance: Decimal;
    TotalRepayment: Decimal;
    SalaryRecoveryAmt: Decimal;
    LoanTopUps: Record "Loan Top-up";
    TotalTopups: Decimal;
    BasicSalary: Decimal;
    Month: Date;
    Assignmatrix: Record "Payroll Matrix";
    BasicSalaryCode: Code[30];
    CurrExchRate: Record "Currency Exchange Rate";
    SHIFAmount: Decimal;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-')then PayStartDate:=PayPeriod."Starting Date";
        PayPeriodText:=PayPeriod.Name;
    end;
    procedure GetBracket(DeductionsRec: Record Deductions; BasicPay: Decimal; var TierI: Decimal; var TierII: Decimal)TotalAmt: Decimal var
        BracketTable: Record Bracket;
        BracketSource: Record "Bracket Table";
        Loop: Boolean;
        PensionableAmt: Decimal;
        TableAmount: Decimal;
        i: Integer;
    begin
        TotalAmt:=0;
        TableAmount:=0;
        i:=0;
        if BracketSource.Get(DeductionsRec."Deduction Table")then;
        BracketTable.SetRange(BracketTable."Table Code", DeductionsRec."Deduction Table");
        BracketTable.SetRange(Institution, DeductionsRec."Institution Code");
        if BracketTable.Find('-')then begin
            case BracketSource.Type of BracketSource.Type::Fixed: begin
                repeat if((BasicPay >= BracketTable."Lower Limit") and (BasicPay <= BracketTable."Upper Limit"))then TotalAmt:=BracketTable.Amount;
                until BracketTable.Next = 0;
            end;
            BracketSource.Type::"Graduating Scale": begin
                PensionableAmt:=BasicPay;
                repeat i:=i + 1;
                    if BasicPay <= 0 then Loop:=true
                    else
                    begin
                        if BasicPay >= BracketTable."Upper Limit" then begin
                            TableAmount:=(BracketTable."Taxable Amount" * BracketTable.Percentage / 100);
                            if Deductions."Pension Scheme" then begin
                                if i = 1 then TierI:=TableAmount
                                else
                                    TierII:=TableAmount;
                            end;
                            TotalAmt:=TotalAmt + TableAmount;
                        end
                        else
                        begin
                            PensionableAmt:=PensionableAmt - BracketTable."Lower Limit";
                            TableAmount:=PensionableAmt * (BracketTable.Percentage / 100);
                            Loop:=true;
                            if Deductions."Pension Scheme" then begin
                                if i = 1 then TierI:=TableAmount
                                else
                                    TierII:=TableAmount;
                            end;
                            TotalAmt:=TotalAmt + TableAmount;
                        end;
                    end;
                until(BracketTable.Next = 0) or Loop = true;
            end;
            end;
        end;
        exit(TotalAmt);
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
        PaymentDeduction."Payroll Period":=PayStartDate;
        PaymentDeduction.Amount:=ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit":=true;
        PaymentDeduction.Taxable:=true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.Get(BenefitCode)then PaymentDeduction.Description:=allowances.Description;
        PaymentDeduction.Insert;
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
    procedure CheckIfRatesInclusive(EmpNo: Code[20]; PayPeriod: Date; DeductionCode: Code[20]; var DeductibleAmt: Decimal)
    var
        DeductionsRec: Record Deductions;
        BracketTable: Record Bracket;
        BracketSource: Record "Bracket Table";
        AssMatrix: Record "Payroll Matrix";
        i: Integer;
    begin
        if DeductionsRec.Get(DeductionCode)then begin
            if DeductionsRec."Pension Scheme" then begin
                i:=0;
                DeductionsRec.Reset;
                DeductionsRec.SetRange("Calculation Method", DeductionsRec."Calculation Method"::"Based on Table");
                DeductionsRec.SetRange("Pension Scheme", true);
                if DeductionsRec.Find('-')then begin
                    if BracketSource.Get(DeductionsRec."Deduction Table")then;
                    BracketTable.SetRange(BracketTable."Table Code", DeductionsRec."Deduction Table");
                    if BracketTable.Find('-')then repeat i:=i + 1;
                            if BracketTable."Contribution Rates Inclusive" then begin
                                AssMatrix.Reset;
                                AssMatrix.SetRange("Employee No", EmpNo);
                                AssMatrix.SetRange("Payroll Period", PayPeriod);
                                AssMatrix.SetRange(Type, AssMatrix.Type::Deduction);
                                AssMatrix.SetRange(Code, DeductionsRec.Code);
                                if AssMatrix.Find('-')then begin
                                    if i = 1 then DeductibleAmt:=DeductibleAmt - AssMatrix."Employee Tier I"
                                    else
                                        DeductibleAmt:=DeductibleAmt - AssMatrix."Employee Tier II";
                                end;
                            end;
                        until BracketTable.Next = 0;
                end;
            end;
        end;
    end;
}
