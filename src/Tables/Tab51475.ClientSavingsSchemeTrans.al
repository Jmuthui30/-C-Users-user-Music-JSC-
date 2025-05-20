table 51475 "Client Savings Scheme Trans"
{
    fields
    {
        field(1; "Entry No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Employee No"; Code[30])
        {
            NotBlank = true;
            TableRelation = Employee;
        }
        field(3; Type; Option)
        {
            NotBlank = false;
            OptionCaption = ' ,Deposit,Withdrawal,Repayment';
            OptionMembers = " ", Deposit, Withdrawal, Repayment;
        }
        field(4; "Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = Deductions;

            trigger OnValidate()
            begin
            /*
                GetPayPeriod;
                "Payroll Period":=PayStartDate;
                 "Pay Period":=PayPeriodText;

               //*********************Allowances Calculation rules etc***************
                  IF Type=Type::Payment THEN BEGIN
                    IF Payments.GET(Code) THEN
                      BEGIN
                       // check if blocked
                       IF Payments.Block=TRUE THEN
                        ERROR(' Earning Blocked');
                        "Time Sheet":=Payments."Time Sheet";
                        Description:=Payments.Description;
                        IF Payments."Earning Type"=Payments."Earning Type"::"Tax Relief" THEN
                        "Tax Relief":=TRUE;

                        "Non-Cash Benefit":=Payments."Non-Cash Benefit";
                        Quarters:=Payments.Quarters;
                        //Paydeduct:=Payments."End Date";
                        Taxable:=Payments.Taxable;
                       // MESSAGE('Taxable=%1',Taxable);
                       "Tax Deductible":=Payments."Reduces Tax";
                        IF Payments."Pay Type"=Payments."Pay Type"::Recurring THEN
                       "Next Period Entry":=TRUE;
                       "Basic Salary Code":=Payments."Basic Salary Code";
                       "Basic Pay Arrears":=Payments."Basic Pay Arrears";
                        IF Payments."Earning Type"=Payments."Earning Type"::"Normal Earning" THEN
                         "Normal Earnings":=TRUE
                        ELSE
                         "Normal Earnings":=FALSE;

                         IF Payments."Calculation Method"=Payments."Calculation Method"::"Flat amount" THEN
                        Amount:=Payments."Flat Amount";


                        IF Payments."Calculation Method"=Payments."Calculation Method"::"% of Basic pay" THEN BEGIN
                        IF Empl.GET("Employee No") THEN BEGIN
                        Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                        Empl.CALCFIELDS(Basic,Empl."Basic Arrears");
                        //MESSAGE('Basic=%1 and Basic arrears =%2',Empl.Basic,Empl."Basic Arrears");
                        Amount:=Payments.Percentage/100*(Empl.Basic-Empl."Basic Arrears");
                        //Check For Limits
                        IF Payments."Minimum Limit"<>0 THEN
                         IF Amount <Payments."Minimum Limit" THEN
                            Amount:=Payments."Minimum Limit";
                        IF Payments."Maximum Limit"<>0 THEN
                         IF Amount>Payments."Maximum Limit" THEN
                           Amount:=Payments."Maximum Limit";

                        Amount:=PayrollRounding(Amount);//round
                        END;
                        END;

                         IF Payments.Fringe=TRUE THEN BEGIN

                         // MESSAGE('fRINGE');

                           LoanProductType.RESET;
                           LoanProductType.SETRANGE(LoanProductType."Fringe Benefit Code",Payments.Code);
                           IF LoanProductType.FIND('-') THEN BEGIN

                           //  MESSAGE('LOAN PRODUCT TYPE');

                             LoanApp.RESET;
                             LoanApp.SETRANGE(LoanApp."Loan Product Type",LoanProductType.Code);
                             LoanApp.SETRANGE(LoanApp."Employee No","Employee No");
                            // LoanApp.SETRANGE(LoanApp."Issued Date","Payroll Period");
                             IF LoanApp.FIND('-') THEN BEGIN

                            TotalRepayment:=0;

                              SalarySteps.RESET;
                              SalarySteps.SETRANGE(SalarySteps.Code,LoanApp."Deduction Code");
                              SalarySteps.SETRANGE(SalarySteps."Payroll Period","Payroll Period");
                              SalarySteps.SETRANGE(SalarySteps."Employee No",LoanApp."Employee No");
                              IF SalarySteps.FIND('-') THEN
                               REPEAT

                                 TotalRepayment:=TotalRepayment+SalarySteps.Amount;
                               UNTIL SalarySteps.NEXT=0;

                         TotalTopups:=0;

                         LoanTopUps.RESET;
                         LoanTopUps.SETRANGE(LoanTopUps."Loan No",LoanApp."Loan No");
                         IF LoanTopUps.FIND('-') THEN REPEAT
                          TotalTopups:=TotalTopups + LoanTopUps.Amount;
                         UNTIL LoanTopUps.NEXT=0;

                               IF LoanProductType."Calculate On"=LoanProductType."Calculate On"::"Closing Balance" THEN BEGIN

                             LoanApp.CALCFIELDS(LoanApp."Total Repayment",LoanApp."Total Loan");

                           IF LoanApp."Total Loan"<>0 THEN

                               LoanBalance:=LoanApp."Total Loan" + TotalRepayment - LoanApp.Repayment

                           ELSE
                               LoanBalance:=LoanApp."Approved Amount" + TotalRepayment - LoanApp.Repayment;//LoanApp."Total Loan"
                              // SalarySteps."Loan Balance":=LoanBalance;

                                // MESSAGE(' Loan Balance=%1',LoanBalance);
                            Amount:=((Payments."Market Rate"-Payments."Company Rate")*LoanBalance)/100/12;
                            Amount:=PayrollRounding(Amount);
                              END ELSE
                              BEGIN
                             LoanApp.CALCFIELDS(LoanApp."Total Repayment",LoanApp."Total Loan");

                           IF LoanApp."Total Loan"<>0 THEN

                               LoanBalance:=LoanApp."Total Loan" + TotalRepayment //LoanApp."Total Repayment"
                            ELSE
                               LoanBalance:=LoanApp."Approved Amount" + TotalRepayment;//LoanApp."Total Loan" LoanApp."Total Repayment";//
                                               // SalarySteps."Loan Balance":=LoanBalance;

                            Amount:=((Payments."Market Rate"-Payments."Company Rate")*LoanBalance)/100/12;
                            Amount:=PayrollRounding(Amount);
                      //     MESSAGE('Period=%5, Earning%3, Market Rate=%1, Company Rate=%2 Amount=%4',Payments."Market Rate",Payments."Company Rate",Payments.Description,Amount,"Payroll Period");

                                END;

                 //  MESSAGE('Code=%1, Amount=%2',Code,Amount);
                             END;
                            END;
                         END;


                        IF Payments."Calculation Method"=Payments."Calculation Method"::"% of Basic after tax" THEN BEGIN
                        IF Empl.GET("Employee No") THEN BEGIN
                        HRSetup.GET;
                        IF HRSetup."Company overtime hours"<>0 THEN
                        Amount:=("No. of Units"* Empl."Hourly Rate" *Payments."Overtime Factor");//HRSetup."Company overtime hours";

                        //Check For Limits
                        IF Payments."Minimum Limit"<>0 THEN
                         IF Amount <Payments."Minimum Limit" THEN
                            Amount:=Payments."Minimum Limit";
                        IF Payments."Maximum Limit"<>0 THEN
                         IF Amount>Payments."Maximum Limit" THEN
                           Amount:=Payments."Maximum Limit";

                        Amount:=PayrollRounding(Amount);//round
                        END;
                        END;

                        IF Payments."Calculation Method"=Payments."Calculation Method"::"Based on Hourly Rate" THEN BEGIN
                          IF Empl.GET("Employee No") THEN BEGIN
                           Amount:="No. of Units"* Empl."Daily Rate";//*Payments."Overtime Factor";
                           IF Payments."Overtime Factor"<>0 THEN
                           Amount:="No. of Units"* Empl."Daily Rate"*Payments."Overtime Factor";

                         //Check For Limits
                         IF Payments."Minimum Limit"<>0 THEN
                          IF Amount <Payments."Minimum Limit" THEN
                             Amount:=Payments."Minimum Limit";
                         IF Payments."Maximum Limit"<>0 THEN
                          IF Amount>Payments."Maximum Limit" THEN
                            Amount:=Payments."Maximum Limit";


                           Amount:=PayrollRounding(Amount);//round
                          END;
                  END;

               //kugun
               //insurance relief

                  IF Payments."Calculation Method"=Payments."Calculation Method"::"% of Insurance Amount" THEN BEGIN
                  IF Empl.GET("Employee No") THEN
                  BEGIN
                  Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                  Empl.CALCFIELDS(Empl.Insurance);
                  //MESSAGE('%1',Empl.Insurance);
                  Amount:=ABS((Payments.Percentage/100)* (Empl.Insurance));
                 // MESSAGE('%1',Amount);
                        //Check For Limits
                        IF Payments."Minimum Limit"<>0 THEN
                         IF Amount <Payments."Minimum Limit" THEN
                            Amount:=Payments."Minimum Limit";
                        IF Payments."Maximum Limit"<>0 THEN
                         IF Amount>Payments."Maximum Limit" THEN
                           Amount:=Payments."Maximum Limit";


                  Amount:=PayrollRounding(Amount);//round
                 // MESSAGE('%1',Amount);
                  END;
                  END;




                  IF Payments."Calculation Method"=Payments."Calculation Method"::"% of Gross pay" THEN BEGIN
                  IF Empl.GET("Employee No") THEN
                  BEGIN
                  Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                  Empl.CALCFIELDS(Basic,Empl."Total Allowances");
                  Amount:=((Payments.Percentage/100)* (Empl.Basic+Empl."Total Allowances"));

                        //Check For Limits
                        IF Payments."Minimum Limit"<>0 THEN
                         IF Amount <Payments."Minimum Limit" THEN
                            Amount:=Payments."Minimum Limit";
                        IF Payments."Maximum Limit"<>0 THEN
                         IF Amount>Payments."Maximum Limit" THEN
                           Amount:=Payments."Maximum Limit";


                  Amount:=PayrollRounding(Amount);//round
                  END;
                  END;
                  IF Payments."Calculation Method"=Payments."Calculation Method"::"% of Taxable income" THEN
                    BEGIN
                      IF Empl.GET("Employee No") THEN
                    BEGIN
                      Empl.SETRANGE("Pay Period Filter",PayStartDate);
                      Empl.CALCFIELDS(Empl."Taxable Allowance");
                      Amount:=((Payments.Percentage/100)* (Empl."Basic Pay"+Empl."Taxable Allowance"));

                          //Check For Limits
                        IF Payments."Minimum Limit"<>0 THEN
                         IF Amount <Payments."Minimum Limit" THEN
                            Amount:=Payments."Minimum Limit";
                        IF Payments."Maximum Limit"<>0 THEN
                         IF Amount>Payments."Maximum Limit" THEN
                           Amount:=Payments."Maximum Limit";

                      Amount:=PayrollRounding(Amount);//round
                    //IF "Value of Quarters">Amount THEN
                    // Amount:="Value of Quarters";
                    END;
                    END;
                      IF Payments."Reduces Tax" THEN BEGIN
                        //Amount:=-Amount;
                        Amount:=PayrollRounding(Amount);//round
                      END;

                  END;
                  END;

                  //*********Deductions****************************************
                  IF Type=Type::Deduction THEN BEGIN
                    IF Deductions.GET(Code) THEN
                  BEGIN
                     IF Deductions.Block=TRUE THEN
                      ERROR('Deduction Blocked');
                     Description:=Deductions.Description;
                     "G/L Account":=Deductions."G/L Account";
                     "Tax Deductible":=Deductions."Tax deductible";
                      Retirement:=Deductions."Pension Scheme";
                     Shares:=Deductions.Shares;
                     Paye:=Deductions."PAYE Code";
                     "Insurance Code":=Deductions."Insurance Code";
                     "Main Deduction Code":=Deductions."Main Deduction Code";



                  IF Deductions.Type=Deductions.Type::Recurring THEN
                  "Next Period Entry":=TRUE;
                  IF Deductions."Calculation Method"=Deductions."Calculation Method"::"Flat Amount" THEN
                   BEGIN
                     Amount:=Deductions."Flat Amount";
                     "Employer Amount":=Deductions."Flat Amount Employer";
                   END;
                  IF Deductions."Calculation Method"=Deductions."Calculation Method"::"% of Basic Pay" THEN BEGIN
                  IF Empl.GET("Employee No") THEN BEGIN
                  Empl.SETRANGE(Empl."Pay Period Filter",PayStartDate);
                  Empl.CALCFIELDS(Empl.Basic);
                    Amount:=Deductions.Percentage/100 *Empl.Basic;
                     IF (Deductions."PAYE Code"=TRUE) THEN
                      "Taxable amount":=Empl.Basic;
                   // MESSAGE('NO ROUNDING AMOUNT=%1',Amount);
                    Amount:=PayrollRounding(Amount);//round
                     "Employer Amount":=Deductions."Percentage Employer"/100*Empl.Basic;
                    "Employer Amount":=PayrollRounding("Employer Amount");//round
                    //pension amount may exceed the maximum limit but the additional amount is tax
                    {
                    IF Deductions."Maximum Amount"<> 0 THEN BEGIN
                    IF ABS(Amount) > Deductions."Maximum Amount" THEN
                     Amount:=Deductions."Maximum Amount";
                     "Employer Amount":=Deductions."Percentage Employer"/100*Empl.Basic;
                     //Employer amount should not have maximum pension deduction
                     {
                       IF "Employer Amount">Deductions."Maximum Amount" THEN
                  "Employer Amount":=Deductions."Maximum Amount";
                     }
                     }
                     //end of Employer pension
                  "Employer Amount":=PayrollRounding("Employer Amount");//round
                  // Added by Lob

                  END;
                  END;
                  //End of addition

                 //Salary Recovery
                    SalaryRecoveryAmt:=0;
                  IF Deductions."Calculation Method"=Deductions."Calculation Method"::"% of Salary Recovery" THEN BEGIN
                  IF Empl.GET("Employee No") THEN
                  BEGIN
                        Deductions.RESET;
                        Deductions.SETRANGE(Deductions."Salary Recovery",TRUE);
                        IF Deductions.FIND('-') THEN BEGIN
                        SalarySteps.RESET;
                        SalarySteps.SETRANGE(SalarySteps.Code,Deductions.Code);
                        SalarySteps.SETRANGE(SalarySteps."Employee No","Employee No");
                        SalarySteps.SETRANGE(SalarySteps."Payroll Period","Payroll Period");
                       // SalarySteps.SETRANGE(SalarySteps."Employee No",LoanApp."Employee No");
                         IF SalarySteps.FIND('-') THEN

                             SalaryRecoveryAmt:=SalarySteps.Amount;
                  Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                 // Empl.CALCFIELDS();
                    Amount:=((Deductions.Percentage/100)*SalaryRecoveryAmt);
                  Amount:=PayrollRounding(Amount);//round
                  END;
                  END;
                  END;
               //end of salary recovery



                  IF Deductions.CoinageRounding=TRUE THEN
                    BEGIN
                 //     HRSetup.GET();
                 //     Maxlimit:=HRSetup."Pension Limit Amount";
                      Retirement:=Deductions.CoinageRounding;
                      IF Deductions."Calculation Method"=Deductions."Calculation Method"::"% of Basic Pay" THEN
                       "Employer Amount":=Deductions.Percentage/100*Empl."Basic Pay"
                      ELSE
                       "Employer Amount":=Deductions."Flat Amount";
                       "Employer Amount":=PayrollRounding("Employer Amount");//round
                    END;

                //end of uganda requirement addition

                //  IF "Employer Amount" > Deductions."Maximum Amount" THEN
                //     "Employer Amount":=Deductions."Maximum Amount";
                  Amount:=PayrollRounding(Amount);//round
                  "Employer Amount":=PayrollRounding("Employer Amount");//round
                  END;

                  //added for Uganda requirements
                  // added by Lob vega
                  IF Deductions."Calculation Method"=Deductions."Calculation Method"::"Based on Table" THEN BEGIN
                  IF Empl.GET("Employee No") THEN
                  BEGIN
                  Empl.CALCFIELDS(Empl."Total Allowances");
                  Amount:=((Deductions.Percentage/100)* (Empl."Basic Pay"+Empl."Total Allowances"));
                  "Employer Amount":=((Deductions.Percentage/100)*(Empl."Basic Pay"+Empl."Total Allowances"));
                   Amount:=PayrollRounding(Amount);
                  "Employer Amount":=PayrollRounding("Employer Amount");
                  END;
                  END;
                  //added for BM requirements
                  IF Deductions."Calculation Method"=Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance" THEN BEGIN
                  IF Empl.GET("Employee No") THEN
                  BEGIN
                  //SalarySteps.GET(Empl."Salary Steps",SalarySteps.Level::"Level 1",Empl."Salary Scheme Category");
                  //Amount:=((Deductions.Percentage/100)* (Empl."Basic Pay"+SalarySteps."House allowance"));
                  //"Employer Amount":=((Deductions.Percentage/100)*(Empl."Working Days Per Year"+SalarySteps."House allowance"));
                   Amount:=PayrollRounding(Amount);
                  "Employer Amount":=PayrollRounding("Employer Amount");
                  END;
                  END;
                  //
                  IF Type=Type::Deduction THEN
                     Amount:=-Amount;

                  //*******New Addition*******************
                 IF Deductions."Calculation Method"=Deductions."Calculation Method"::"Based on Table" THEN BEGIN
                  GetPayPeriod;
                  Empl.RESET;
                  Empl.SETRANGE(Empl."No.","Employee No");
                  Empl.SETRANGE(Empl."Pay Period Filter",PayStartDate);
                  Empl.CALCFIELDS(Empl."Total Allowances",Empl.Basic);
                  // used gross pay new requirement for SHIF changed by Linus
                 // MESSAGE('Deduction Table');
                  GetBracket(Deductions."Deduction Table",Empl."Total Allowances");
                  Amount:=-TableAmount;
                  END;


                 //*******Upto here

                  //END;
                  END;
                  {
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
                 }

                 // Added for Loan deductions

                 IF (Type=Type::Loan) THEN BEGIN
                    LoanApp.RESET;
                    LoanApp.SETRANGE(LoanApp."Loan No",Code);
                    LoanApp.SETRANGE(LoanApp."Employee No","Employee No");
                    IF LoanApp.FIND('-') THEN BEGIN
                     IF LoanProductType.GET(LoanApp."Loan Product Type") THEN
                      Description:=LoanProductType.Description;
                       Amount:=-LoanApp.Repayment;
                       VALIDATE(Amount);
                    END;

                 END;









                */
            //**********END**************************************************************************
            end;
        }
        field(5; "Payroll Period"; Date)
        {
            NotBlank = false;
            TableRelation = "Payroll Period"."Starting Date";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;

            trigger OnValidate()
            begin
                if PayPeriod.Get("Payroll Period")then "Pay Period":=PayPeriod.Name;
            end;
        }
        field(6; Amount; Decimal)
        {
            DecimalPlaces = 2: 2;

            trigger OnValidate()
            begin
            /*
                IF (Type=Type::Payment) THEN
                IF Payments.GET(Code) THEN
                IF Payments."Reduces Tax" THEN
                BEGIN
                //Amount:=-Amount;
                END;
                IF (Type=Type::Payment) THEN
                 IF Amount<0 THEN
                  ERROR('Earning must not be negative');
                
                IF (Type=Type::Deduction) THEN
                IF Amount>0 THEN
                Amount:=-Amount;
                // TESTFIELD(Closed,FALSE);
                //Added
                IF "Loan Repay"=TRUE THEN
                BEGIN
                 IF Loan.GET(Rec.Code,Rec."Employee No") THEN BEGIN
                  Loan.CALCFIELDS(Loan."Cumm. Period Repayments");
                  "Period Repayment":=ABS(Amount)+"Interest Amount";
                  "Initial Amount":=Loan."Loan Amount";
                 // MESSAGE('amount %1  Cul repayment %2',Amount,Loan."Cumm. Period Repayments1");
                  "Outstanding Amount":=Loan."Loan Amount"-Loan."Cumm. Period Repayments";
                 END;
                END;
                 Amount:=PayrollRounding(Amount);
                IF "Manual Entry" THEN
                BEGIN
                IF Empl.GET("Employee No") THEN
                BEGIN
                Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                Empl.CALCFIELDS(Empl."Total Allowances",Empl."Total Deductions");
                {
                IF ((Empl."Total Allowances"+Empl."Total Deductions")+Amount)<0 THEN
                ERROR('Assigning this deduction for Employee %1 will result in a negative pay, Total allowances=%2 Total deductions=%3'
                ,"Employee No",Empl."Total Allowances",Empl."Total Deductions");
                 }
                END;
                END;
                
                IF NOT "Manual Entry" THEN
                BEGIN
                IF Empl.GET("Employee No") THEN
                BEGIN
                Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                Empl.CALCFIELDS(Empl."Total Allowances",Empl."Total Deductions");
                IF ((Empl."Total Allowances"+Empl."Total Deductions"))<0 THEN
                MESSAGE('Assigning this deduction for Employee %1 will result in a negative pay, Total allowances=%2 Total deductions=%3'
                ,"Employee No",Empl."Total Allowances",Empl."Total Deductions");
                
                END;
                END;
                 */
            end;
        }
        field(7; Description; Text[80])
        {
            trigger OnValidate()
            begin
            // TESTFIELD(Closed,FALSE);
            end;
        }
        field(8; "Pay Period"; Text[30])
        {
        }
    }
    keys
    {
        key(Key1; "Entry No")
        {
        }
    }
    fieldgroups
    {
    }
    var PayPeriod: Record "Client Payroll Period";
}
