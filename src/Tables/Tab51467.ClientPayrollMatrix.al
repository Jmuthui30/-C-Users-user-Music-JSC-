table 51467 "Client Payroll Matrix"
{
    fields
    {
        field(1; "Employee No"; Code[30])
        {
            NotBlank = true;
            TableRelation = "Client Employee Master";

            trigger OnValidate()
            begin
                if Empl.Get("Employee No")then begin
                    if Empl."Employee Group" <> '' then begin
                        //Empl.TESTFIELD("Global Dimension 3 Code");
                        //Empl.TESTFIELD("Global Dimension 2 Code");
                        Empl.TestField("Global Dimension 1 Code");
                        Empl.TestField(Empl."Employee Group");
                    end;
                    "Global Dimension 1 code":=Empl."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=Empl."Global Dimension 2 Code";
                    "Payroll Group":=Empl."Employee Group";
                    "Job Grade":=Empl.Scale;
                    "Salary Level":=Empl.Level;
                    if Empl."Employee Group" = '' then Error('Assign employee  %2 an employee group before assigning any earning or deduction', Empl."No.");
                end;
            end;
        }
        field(2; Type;Enum ClientPayrollMatrixType)
        {
            NotBlank = false;
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = IF(Type=CONST(Payment))"Client Earnings".Code WHERE(Company=field(Company))
            ELSE IF(Type=CONST(Deduction))"Client Deductions".Code;

            trigger OnValidate()
            var
                MarketIntRateRec: Record "Client Mkt Interest Rates";
                MarketIntRate: Decimal;
                InterestRate: Decimal;
                LoanApplicationRec: Record "Client Loan Application";
                LoanTopupRec: Record "Client Loan Top-up";
                LoanBalance: Decimal;
                RepSchedule: Record "Client Loan Schedule";
            begin
                TestField("Employee No");
                if NAVEmployee.Get("Employee No")then begin
                    "Payroll Group":=NAVEmployee."Employee Group";
                    if NAVEmployee.Status = NAVEmployee.Status::Inactive then Error('Can only assign Earnings and deductions to Active Employees Please confirm if ' + '%1 %2 is an Active Employee', NAVEmployee."First Name", NAVEmployee."Last Name");
                end;
                GetPayPeriod;
                "Payroll Period":=PayStartDate;
                // RESET;
                //*********************Allowances Calculation rules etc***************
                case Type of Type::Payment: begin
                    if Payments.Get(Company, Code)then begin
                        // check if blocked
                        if Payments.Block = true then Error(' Earning Blocked');
                        "Time Sheet":=Payments."Time Sheet";
                        Description:=Payments.Description;
                        if Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" then "Tax Relief":=true;
                        if Payments."Earning Type" = Payments."Earning Type"::"Insurance Relief" then "Insurance Relief":=true;
                        "Non-Cash Benefit":=Payments."Non-Cash Benefit";
                        Taxable:=Payments.Taxable;
                        // MESSAGE('Taxable=%1',Taxable);
                        "Reduces Taxable Amt":=Payments."Reduces Tax";
                        if Payments."Pay Type" = Payments."Pay Type"::Recurring then "Next Period Entry":=true
                        else
                            "Earning/Deduction Type":="Earning/Deduction Type"::"Non-recurring";
                        "Basic Salary Code":=Payments."Basic Salary Code";
                        "Basic Pay Arrears":=Payments."Basic Pay Arrears";
                        "Basic+Regular Allowances":=Payments."Regular Cash Allowance";
                        if Payments."Earning Type" = Payments."Earning Type"::"Normal Earning" then "Normal Earnings":=true
                        else
                            "Normal Earnings":=false;
                        if Payments."Calculation Method" = Payments."Calculation Method"::"Flat amount" then Amount:=Payments."Flat Amount";
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Basic pay" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Basic, Empl."Basic Arrears");
                                //Amount := Payments.Percentage / 100 * (Empl.Basic - Empl."Basic Arrears");
                                Amount:=Payments.Percentage / 100 * (Empl.Basic);
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                Amount:=PayrollRounding(Amount); //round
                            end;
                        end;
                        // END;
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Basic after tax" then begin
                            if Empl.Get("Employee No")then begin
                                HRSetup.Get(Company);
                                if HRSetup."Company overtime hours" <> 0 then Amount:=("No. of Units" * Empl."Hourly Rate" * Payments."Overtime Factor"); //HRSetup."Company overtime hours";
                                //Check For Limits
                                /*if Payments."Minimum Limit" <> 0 then
                                                                                                                                                                                if Amount < Payments."Minimum Limit" then
                                                                                                                                                                                    Amount := Payments."Minimum Limit";
                                                                                                                                                                            if Payments."Maximum Limit" <> 0 then
                                                                                                                                                                                if Amount > Payments."Maximum Limit" then
                                                                                                                                                                                    Amount := Payments."Maximum Limit";*/
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
                        //insurance relief
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Insurance Amount" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Empl.Insurance);
                                //MESSAGE('%1', Empl.Insurance);                                        
                                Amount:=Abs((Payments.Percentage / 100) * (Empl.Insurance));
                                // MESSAGE('%1',Amount);
                                //Check For Limits
                                if Payments."Minimum Limit" <> 0 then if Amount < Payments."Minimum Limit" then Amount:=Payments."Minimum Limit";
                                if Payments."Maximum Limit" <> 0 then if Amount > Payments."Maximum Limit" then Amount:=Payments."Maximum Limit";
                                //if Amount > (5000 - 255) then Amount := (5000 - 255);
                                Amount:=PayrollRounding(Amount); //round
                            // MESSAGE('%1',Amount);
                            end;
                        end;
                        //Based on SHIF % Added by Dennis
                        //Modified by Grace
                        IF Payments."Calculation Method" = Payments."Calculation Method"::"% of SHIF" then begin
                            IF Empl.GET("Employee No")then begin
                                Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                Empl.SetRange(Empl."Company Code", Company);
                                Empl.CalcFields(Empl.SHIF);
                                //MESSAGE('%1', Empl.SHIF);
                                Amount:=Abs((Payments.Percentage / 100) * (Empl.SHIF));
                                Amount:=PayrollRounding(Amount);
                            end;
                        end;
                        //SHIFAmount := 0;
                        /* Assignmatrix.RESET;
                                Assignmatrix.SETRANGE(Assignmatrix."Employee No", "Employee No");
                                Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Deduction);
                                Assignmatrix.SETRANGE(Code, 'SHIF');
                                IF Assignmatrix.FINDSET THEN
                                    SHIFAmount := Assignmatrix.Amount;
                                Amount := ABS(Payments.Percentage / 100 * SHIFAmount);
                            END;
                        END; */
                        // ************ Interdicted Employees ********************
                        // if Empl.Get("Employee No") then begin
                        //     if Empl.Status = Empl.Status::Interdicted then begin
                        //         Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                        //         Empl.SetRange(Empl."Company Code", Company);
                        //         Amount := Empl.Basic * 0.5;
                        //         // Message('Amount is % 1', Rec.);
                        //         Message('Your Basic is %1', Empl.Basic);
                        //     end;
                        // end;
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
                                    "Amount LCY":=Amount;
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
                                Amount:=PayrollRounding(Amount);
                                "Amount LCY":=Amount; //round
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
                                Amount:=PayrollRounding(Amount);
                                "Amount LCY":=Amount; //round
                            //IF "Value of Quarters">Amount THEN
                            // Amount:="Value of Quarters";
                            end;
                        end;
                        if Payments."Reduces Tax" then begin
                            //Amount:=-Amount;
                            Amount:=PayrollRounding(Amount);
                            "Amount LCY":=Amount; //round
                        end;
                    end;
                end;
                //*********Deductions****************************************
                // IF Type=Type::Deduction THEN BEGIN
                Type::Deduction: begin
                    if Deductions.Get(Company, Code)then begin
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
                        "Next Period Entry":=true;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount" then begin
                            // MESSAGE('%1=%2',Deductions.Description,Amount);
                            if Deductions."Flat Amount" <> 0 then Amount:=Deductions."Flat Amount"
                            else
                                Amount:=Amount;
                            if Deductions."Flat Amount Employer" <> 0 then "Employer Amount":=Deductions."Flat Amount Employer"
                            else
                                "Employer Amount":="Employer Amount";
                            "Amount LCY":=Amount;
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
                                Empl.SetRange(Empl."No.", "Employee No");
                                //Message('no%1', "Employee No");
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Basic, Empl."Total Allowances");
                                Amount:=((Deductions.Percentage / 100) * (Empl."Total Allowances")); //Empl.Basic+
                                Amount:=PayrollRounding(Amount); //round
                                "Employer Amount":=((Deductions."Percentage Employer" / 100) * (Empl."Total Allowances"));
                                "Employer Amount":=PayrollRounding("Employer Amount"); //round
                                "Taxable amount":=Empl."Total Allowances"; //Empl.Basic+//"Employer Amount":=(Deductions."Percentage Employer"/100)*(
                            //  "Employer Amount":=PayrollRounding("Employer Amount");//round
                            end;
                        end;
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic + Regular Allowances" then begin
                            if Empl.Get("Employee No")then begin
                                Empl.SetRange(Empl."No.", "Employee No");
                                //Message('no%1', "Employee No");
                                Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                                Empl.CalcFields(Empl."Basic + Regular Allowances");
                                Amount:=((Deductions.Percentage / 100) * (Empl."Basic + Regular Allowances")); //Empl.Basic+
                                Amount:=PayrollRounding(Amount); //round
                                "Employer Amount":=((Deductions."Percentage Employer" / 100) * (Empl."Basic + Regular Allowances"));
                                "Employer Amount":=PayrollRounding("Employer Amount"); //round
                                "Taxable amount":=Empl."Basic + Regular Allowances"; //Empl.Basic+//"Employer Amount":=(Deductions."Percentage Employer"/100)*(
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
                                    "Amount LCY":=Amount;
                                    Amount:=PayrollRounding(Amount);
                                    "Amount LCY":=PayrollRounding(Amount); //round
                                end;
                            end;
                        end;
                        //end of salary recovery
                        if Deductions.CoinageRounding = true then begin
                            //     HRSetup.GET(Company);
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
                            "Employer Amount":=((Deductions."Percentage Employer" / 100) * (Empl.Basic + Empl."Total Allowances"));
                            Amount:=PayrollRounding(Amount);
                            Validate(Amount);
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
                // Added for Loan deductions
                //IF (Type=Type::Loan) THEN BEGIN
                Type::Loan: begin
                    LoanApp.Reset;
                    LoanApp.SetRange(LoanApp."Loan No", Code);
                    LoanApp.SetRange(LoanApp."Employee No", "Employee No");
                    if LoanApp.Find('-')then begin
                        if LoanProductType.Get(LoanApp."Client Loan Product Type")then Description:=LoanProductType.Description;
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
            TableRelation = "Client Payroll Period"."Starting Date";
        }
        field(5; "Currency Code"; Code[10])
        {
        }
        field(6; Amount; Decimal)
        {
            DecimalPlaces = 2: 2;

            trigger OnValidate()
            begin
                if(Type = Type::Payment)then if Payments.Get(Company, Code)then if Payments."Reduces Tax" then begin
                        //Amount := Amount;
                        end;
                if(Type = Type::Payment)then if Amount < 0 then Error('Earning must not be negative');
                if(Type = Type::Payment)then if Payments."Salary Recovery" then if(Amount > 0)then Amount:=-Amount;
                if(Type = Type::Deduction)then if(Amount > 0)then Amount:=-Amount;
                if(Type = Type::Deduction)then begin
                    if Deductions.Get(Company, Code)then begin
                        if Deductions."Pension Arrears" = true then begin
                            "Employer Amount":=2 * Amount;
                            "Employer Amount":=PayrollRounding("Employer Amount"); //round
                        //pension amount may exceed the maximum limit but the additional amount is tax
                        // END;
                        end;
                    end;
                end;
                Amount:=PayrollRounding(Amount);
                if "Manual Entry" then begin
                    if Empl.Get("Employee No")then begin
                        Empl.SetRange(Empl."Pay Period Filter", "Payroll Period");
                        Empl.CalcFields(Empl."Total Allowances", Empl."Total Deductions");
                    end;
                end;
                // ************ Interdicted Employees ********************
                if Empl.Get("Employee No")then begin
                    if Empl.Status = Empl.Status::Interdicted then begin
                        if Payments."Basic Salary Code" = true then begin
                            Amount:=Rec.Amount * 0.5;
                            Message('Your Basic is %1', Amount);
                        end
                        else if Payments."House Allowance Code" = true then Amount:=Rec.Amount
                            else
                                Amount:=Rec.Amount * 0;
                        Amount:=Rec.Amount;
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
            TableRelation = "Client Payroll Period"."Starting Date";
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
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "No. of Units" > 0 then Amount:="No. of Units" * Amount;
                Validate(Amount);
            end;
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
        field(82; Company; Code[10])
        {
            TableRelation = "Client Company Information";
        }
        field(83; Department; Code[50])
        {
        }
        field(84; "SHIF Code"; Boolean)
        {
        }
        field(85; AKI; Code[20])
        {
        }
        field(86; "Cetificate Expiry date"; Date)
        {
        }
        field(87; "Insurance Relief"; Boolean)
        {
        }
        field(88; "Basic+Regular Allowances"; Boolean)
        {
        }
        field(89; NSSF; Boolean)
        {
        }
        field(90; "Prorate Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Pay_Month: Integer;
                Pay_Year: Integer;
                Prorate_Month: Integer;
                Prorate_Year: Integer;
            begin
                //TestField("Prorating Type", "Prorating Type"::Inactive);
                Prorate_Month:=Date2DMY("Prorate Date", 2);
                Prorate_Year:=Date2DMY("Prorate Date", 3);
                Pay_Month:=Date2DMY("Payroll Period", 2);
                Pay_Year:=Date2DMY("Payroll Period", 3);
                if(Prorate_Year <> Pay_Year) or (Prorate_Month <> Pay_Month)then Error('Prorate Date is out of Payroll Period Month');
            end;
        }
        field(91; Prorate; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Date: Date;
                Emp_Month: Integer;
                Pay_Month: Integer;
                Emp_Year: Integer;
                Pay_Year: Integer;
                PeriodEndDate: Date;
                DaysWorked: Integer;
                DaysToWork: Integer;
                Prorate_Month: Integer;
                Prorate_Year: Integer;
            begin
                TestField(Prorated, false);
                if "Prorating Type" = "Prorating Type"::" " then Error('Please Specify Proration Type');
                PeriodEndDate:=CalcDate('CM', "Payroll Period");
                DaysToWork:=PeriodEndDate - "Payroll Period";
                if "Prorating Type" = "Prorating Type"::Inactive then begin
                    TestField("Prorate Date");
                    DaysWorked:=Round(("Prorate Date" - "Payroll Period"), 1);
                end
                else if "Prorating Type" = "Prorating Type"::Employement then begin
                        Pay_Month:=Date2DMY("Payroll Period", 2);
                        Pay_Year:=Date2DMY("Payroll Period", 3);
                        if NAVEmployee.Get("Employee No")then begin
                            NAVEmployee.TestField("Starting Date");
                            Date:=NAVEmployee."Starting Date";
                        end;
                        Emp_Month:=Date2DMY(Date, 2);
                        Emp_Year:=Date2DMY(Date, 3);
                        if(Emp_Year <> Pay_Year) or (Emp_Month <> Pay_Month)then Error('You cannot Prorate %1 since the Employement date is %2', "Employee No", Date);
                        DaysWorked:=Round((PeriodEndDate - Date), 1);
                    end;
                Amount:=((DaysWorked / DaysToWork) * Amount);
                Prorated:=true;
                Rec.Modify(true);
            end;
        }
        field(92; "Prorating Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Employement, Inactive;

            trigger OnValidate()
            begin
                if "Prorating Type" = "Prorating Type"::Employement then begin
                    if NAVEmployee.Get("Employee No")then NAVEmployee.TestField("Starting Date");
                end;
            end;
        }
        field(93; Prorated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "No. Of Days Worked"; Decimal)
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
        field(95; "Job Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Client Salary Scale".Scale;
        }
        field(96; "Salary Level"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Client Salary Level"."Level";
        }
    }
    keys
    {
        key(Key1; Company, "Employee No", Type, "Code", "Payroll Period", "Reference No")
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
        key(Key18; Type, "Employee No", "Payroll Period", "Insurance Code", "SHIF Code")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key19; "Employee No", Taxable, "Reduces Taxable Amt", Retirement, "Non-Cash Benefit", "Insurance Relief")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
        key(Key20; "Basic+Regular Allowances")
        {
            SumIndexFields = Amount, "Amount LCY", "Employer Amount", "Employer Amount LCY";
        }
    }
    fieldgroups
    {
    }
    var Empl: Record "Client Employee Master";
    NAVEmployee: Record "Client Employee Master";
    Payments: Record "Client Earnings";
    Deductions: Record "Client Deductions";
    Paydeduct: Decimal;
    PayPeriod: Record "Client Payroll Period";
    Loan: Record "Client Loan Transactions";
    PayStartDate: Date;
    PayPeriodText: Text[30];
    TableAmount: Decimal;
    Basic: Decimal;
    ReducedBal: Decimal;
    InterestAmt: Decimal;
    HRSetup: Record "Client Payroll Setup";
    Maxlimit: Decimal;
    Benefits: Record "Client Bracket";
    InterestDiff: Decimal;
    SalarySteps: Record "Client Payroll Matrix";
    LoanProductType: Record "Client Loan Product";
    LoanApp: Record "Client Loan Application";
    "reference no": Record "Client Payroll Matrix";
    LoanBalance: Decimal;
    TotalRepayment: Decimal;
    SalaryRecoveryAmt: Decimal;
    LoanTopUps: Record "Client Loan Top-up";
    TotalTopups: Decimal;
    BasicSalary: Decimal;
    Month: Date;
    Assignmatrix: Record "Client Payroll Matrix";
    BasicSalaryCode: Code[30];
    CurrExchRate: Record "Currency Exchange Rate";
    SHIFAmount: Decimal;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-')then PayStartDate:=PayPeriod."Starting Date";
        PayPeriodText:=PayPeriod.Name;
    end;
    procedure GetBracket(DeductionsRec: Record "Client Deductions"; BasicPay: Decimal; var TierI: Decimal; var TierII: Decimal)TotalAmt: Decimal var
        BracketTable: Record "Client Bracket";
        BracketSource: Record "Client Bracket Table";
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
                                if i = 1 then begin
                                    if(BracketTable.Percentage = 0) and (BracketTable.Amount <> 0)then TierI:=BracketTable.Amount
                                    else
                                        TierI:=TableAmount;
                                end
                                else
                                begin
                                    if(BracketTable.Percentage = 0) and (BracketTable.Amount <> 0)then TierII:=BracketTable.Amount
                                    else
                                        TierII:=TableAmount;
                                end;
                            end;
                            TotalAmt:=TotalAmt + TableAmount;
                            if Deductions."Pension Scheme" then TotalAmt:=TotalAmt + TierI;
                        end
                        else
                        begin
                            PensionableAmt:=PensionableAmt - BracketTable."Lower Limit";
                            TableAmount:=PensionableAmt * (BracketTable.Percentage / 100);
                            Loop:=true;
                            if Deductions."Pension Scheme" then begin
                                if i = 1 then begin
                                    if(BracketTable.Percentage = 0) and (BracketTable.Amount <> 0)then TierI:=BracketTable.Amount
                                    else
                                        TierI:=TableAmount;
                                end
                                else
                                begin
                                    if(BracketTable.Percentage = 0) and (BracketTable.Amount <> 0)then TierII:=BracketTable.Amount
                                    else
                                        TierII:=TableAmount;
                                end;
                            end;
                            TotalAmt:=TotalAmt + TableAmount;
                            if Deductions."Pension Scheme" then TotalAmt:=TotalAmt + TierI;
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
        PaymentDeduction: Record "Client Payroll Matrix";
        Payrollmonths: Record "Client Payroll Period";
        allowances: Record "Earnings Master";
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
        HRsetup: Record "Client Payroll Setup";
    begin
        HRsetup.Get(Company);
        if HRsetup."Payroll Rounding Precision" = 0 then Error('You must specify the rounding precision under HR setup');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '=');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '>');
        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then PayrollRounding:=Round(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;
    procedure CheckIfRatesInclusive(EmpNo: Code[20]; PayPeriod: Date; DeductionCode: Code[20]; var DeductibleAmt: Decimal)
    var
        DeductionsRec: Record "Deductions Master";
        BracketTable: Record "Client Bracket";
        BracketSource: Record "Client Bracket Table";
        AssMatrix: Record "Client Payroll Matrix";
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
    trigger OnDelete()
    begin
        if Rec.Closed then Error('You cannot modify a closed period.');
    end;
    trigger OnModify()
    begin
        if Rec.Closed then Error('You cannot modify a closed period.');
    end;
}
