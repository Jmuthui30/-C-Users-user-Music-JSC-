table 51439 "Loan Application"
{
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            trigger OnValidate()
            begin
                if "Loan No" <> xRec."Loan No" then begin
                    if LoanType.Get("Loan Product Type")then begin
                        NoSeriesMgt.TestManual(LoanType."Loan No Series");
                        "No Series":='';
                    end;
                end;
            end;
        }
        field(2; "Application Date"; Date)
        {
        }
        field(3; "Loan Product Type"; Code[20])
        {
            TableRelation = "Loan Product".Code;

            trigger OnValidate()
            begin
                if LoanType.Get("Loan Product Type")then begin
                    "Interest Deduction Code":=LoanType."Interest Deduction Code";
                    "Deduction Code":=LoanType."Deduction Code";
                    Description:=LoanType.Description;
                    "Interest Rate":=LoanType."Interest Rate";
                    "Interest Calculation Method":=LoanType."Interest Calculation Method";
                    "Loan Category":=LoanType."Loan Category";
                end;
            end;
        }
        field(4; "Amount Requested"; Decimal)
        {
            trigger OnValidate()
            begin
                "Approved Amount":="Amount Requested";
                Validate("Approved Amount");
            end;
        }
        field(5; "Approved Amount"; Decimal)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Approved Amount" > "Amount Requested" then Error('Approved Amount cannot exceed Amount Requested');
                /*IF "Interest Calculation Method" = "Interest Calculation Method"::" " THEN
                  ERROR('Interest Calculation method can only be Balance');;
                */
                Installments:=Instalment;
                //IF Installments <=0 THEN
                // ERROR('Number of installments must be greater than Zero!');
                if LoanType.Get("Loan Product Type")then begin
                    if "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" then begin
                        // Repayment := ROUND("Approved Amount"/ Installments,0.0001,'>');
                        Repayment:="Approved Amount" * (("Interest Rate" / 12 / 100) + (("Interest Rate" / 12 / 100) / (Power(1 + ("Interest Rate" / 12 / 100), 72) - 1)));
                    /* IF "Interest Rate" = 0 THEN
                           Repayment := ROUND("Approved Amount"/ Installments,0.0001,'>')
                         ELSE
                           Repayment := ROUND(DebtService("Approved Amount","Interest Rate",Installments),0.0001,'>');*/
                    end;
                end;
                //"Total Repayment":=Installments*Repayment;
                //Flat Rate
                //
                if "Interest Calculation Method" = "Interest Calculation Method"::"Flat Rate" then begin
                    //  Repayment:=ROUND(("Approved Amount"/Installments)+FlatRateCalc("Approved Amount",Interest),0.01,'>');
                    "Flat Rate Interest":=Round(FlatRateCalc("Approved Amount", "Interest Rate"), 0.01, '>');
                    "Flat Rate Principal":=Repayment - "Flat Rate Interest";
                end;
                if(("Interest Calculation Method" = "Interest Calculation Method"::" ") and ("Loan Category" = "Loan Category"::Advance))then Repayment:=Round("Approved Amount" / Installments, 0.5, '>');
                if "Interest Calculation Method" <> "Interest Calculation Method"::" " then Repayment:=Round("Approved Amount" / Installments, 0.5, '>');
                "Approved Amount":=Abs("Approved Amount");
            end;
        }
        field(6; "Loan Status"; Option)
        {
            Editable = false;
            OptionCaption = 'Application,Being Processed,Rejected,Approved,Issued,Being Repaid,Repaid';
            OptionMembers = Application, "Being Processed", Rejected, Approved, Issued, "Being Repaid", Repaid;
        }
        field(7; "Issued Date"; Date)
        {
            TableRelation = "Payroll Period"."Starting Date";

            trigger OnValidate()
            begin
                PayPeriodRec.SetRange(PayPeriodRec.Closed, false);
                if PayPeriodRec.Find('-')then begin
                    if "Issued Date" < PayPeriodRec."Starting Date" then Error('Payroll Period Selected is Closed');
                end;
            end;
        }
        field(8; Instalment; Integer)
        {
            Editable = false;

            trigger OnValidate()
            begin
            /*
                IF "Approved Amount"<>0 THEN
                BEGIN
                 IF LoanType.GET("Loan Product Type") THEN
                 BEGIN
                   IF "Interest Calculation Method" = "Interest Calculation Method"::"Reducing Balance" THEN
                   BEGIN
                    Repayment := ROUND("Approved Amount"/ Installments,0.0001,'>');
                   END;
                 END;
                END;
                */
            end;
        }
        field(9; Repayment; Decimal)
        {
        }
        field(10; "Flat Rate Principal"; Decimal)
        {
        }
        field(11; "Flat Rate Interest"; Decimal)
        {
        }
        field(12; "Interest Rate"; Decimal)
        {
        }
        field(13; "No Series"; Code[10])
        {
        }
        field(14; "Interest Calculation Method"; Option)
        {
            OptionMembers = " ", "Flat Rate", "Reducing Balance";
        }
        field(15; "Employee No"; Code[20])
        {
            TableRelation = Employee."No." WHERE(Status=CONST(Active));
        }
        field(16; "Employee Name"; Text[100])
        {
        }
        field(17; "Payroll Group"; Code[20])
        {
            TableRelation = "Employee Groups".Code;
        }
        field(18; Description; Text[80])
        {
        }
        field(19; "Opening Loan"; Boolean)
        {
            Editable = false;
        }
        field(20; "Total Repayment"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE("Employee No"=FIELD("Employee No"), Type=CONST(Deduction), Code=FIELD("Deduction Code"), "Payroll Period"=FIELD(UPPERLIMIT("Date filter")), "Reference No"=FIELD("Loan No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(21; "Date filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(22; "Period Repayment"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE("Employee No"=FIELD("Employee No"), Type=CONST(Deduction), Code=FIELD("Deduction Code"), "Payroll Period"=FIELD(UPPERLIMIT("Date filter")), "Reference No"=FIELD("Loan No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; Interest; Decimal)
        {
        }
        field(24; "Interest Imported"; Decimal)
        {
        }
        field(25; "principal imported"; Decimal)
        {
        }
        field(26; "Interest Rate Per"; Option)
        {
            OptionMembers = " ", Annum, Monthly;
        }
        field(27; "Reference No"; Code[50])
        {
        }
        field(28; "Interest Deduction Code"; Code[10])
        {
            TableRelation = Deductions;
        }
        field(29; "Deduction Code"; Code[10])
        {
            TableRelation = Deductions;
        }
        field(30; "Debtors Code"; Code[10])
        {
            Editable = false;
            TableRelation = Customer;
        }
        field(31; "Interest Amount"; Decimal)
        {
            CalcFormula = Sum("Payroll Matrix".Amount WHERE("Employee No"=FIELD("Employee No"), Type=CONST(Deduction), Code=FIELD("Interest Deduction Code"), "Payroll Period"=FIELD(UPPERLIMIT("Date filter")), "Reference No"=FIELD("Loan No")));
            FieldClass = FlowField;
        }
        field(32; "External Document No"; Code[20])
        {
        }
        field(33; Receipts; Decimal)
        {
            CalcFormula = Sum("Receipt Lines".Amount WHERE("Account No."=FIELD("Debtors Code"), "Advance Loan No."=FIELD("Loan No")));
            Description = '//Sum("Non Payroll Receipts".Amount WHERE (Loan No=FIELD(Loan No),Receipt Date=FIELD(Date filter)))';
            Editable = false;
            FieldClass = FlowField;
        }
        field(34; "HELB No."; Code[50])
        {
        }
        field(35; "University Name"; Code[100])
        {
        }
        field(36; "Stop Loan"; Boolean)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if "Stop Loan" then Error('The loan is already stopped');
            end;
        }
        field(37; Select; Boolean)
        {
        }
        field(38; "Total Loan"; Decimal)
        {
            CalcFormula = Sum("Loan Top-up".Amount WHERE("Loan No"=FIELD("Loan No"), "Payroll Period"=FIELD("Date filter")));
            FieldClass = FlowField;
        }
        field(39; StopagePeriod; Date)
        {
            TableRelation = "Payroll Period"."Starting Date";
        }
        field(40; Reason; Text[30])
        {
        }
        field(41; "Loan Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Advance, "Bisco Loan", "Other Loan";
        }
    }
    keys
    {
        key(Key1; "Loan No", "Loan Product Type")
        {
        }
        key(Key2; "Payroll Group", "Loan Product Type")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if "Loan Status" = "Loan Status"::Issued then begin
            AssMatrix.Reset;
            AssMatrix.SetRange(AssMatrix."Employee No", "Loan No", AssMatrix."Reference No");
            AssMatrix.SetRange(AssMatrix.Closed, true);
            if AssMatrix.Find('-')then Error('Cannot delete loan already issued');
        end;
    end;
    trigger OnInsert()
    begin
        if "Loan No" = '' then begin
            if LoanType.Get("Loan Product Type")then begin
                LoanType.TestField(LoanType."Loan No Series");
                NoSeriesMgt.InitSeries(LoanType."Loan No Series", xRec."No Series", 0D, "Loan No", "No Series");
            end;
        end end;
    trigger OnModify()
    begin
        AssMatrix.Reset;
        AssMatrix.SetRange(AssMatrix."Employee No", "Loan No", AssMatrix."Reference No");
        AssMatrix.SetRange(AssMatrix.Closed, true);
        if AssMatrix.Find('-')then Error('Cannot modify a running loan');
        TestField("Stop Loan", false);
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    HRsetup: Record "Human Resources Setup";
    LoanType: Record "Loan Product";
    EmpRec: Record "Employee Master";
    PeriodInterest: Decimal;
    Installments: Decimal;
    NewSchedule: Record "Loan Schedule";
    RunningDate: Date;
    Interest: Decimal;
    FlatPeriodInterest: Decimal;
    FlatRateTotalInterest: Decimal;
    FlatPeriodInterval: Code[10];
    LineNoInt: Integer;
    RemainingPrincipalAmountDec: Decimal;
    AssMatrix: Record "Payroll Matrix";
    Topups: Record "Loan Top-up";
    RepaymentAmt: Decimal;
    PreviewShedule: Record "Loan Schedule";
    LastDate: Date;
    LoanBalance: Decimal;
    TopupAmt: Decimal;
    EndDate: Date;
    PayPeriodRec: Record "Payroll Period";
    procedure DebtService(Principal: Decimal; Interest: Decimal; PayPeriods: Integer): Decimal var
        PeriodInterest: Decimal;
    begin
        //PeriodInterval:=
        //EVALUATE(PeriodInterval,FORMAT("Instalment Period"));
        //1M
        //IF PeriodInterval='1M' THEN
        PeriodInterest:=Interest / 12 / 100;
        exit(PeriodInterest / (1 - Power((1 + PeriodInterest), -PayPeriods)) * Principal);
    /*
         //1W
        IF PeriodInterval='1W' THEN
         PeriodInterest:= Interest / 52 / 100;
         //2W
        IF PeriodInterval='2W' THEN
         PeriodInterest:= Interest / 26 / 100;
         //1Q
        IF PeriodInterval='1Q' THEN
         PeriodInterest:= Interest / 4 / 100;
        
        
        */
    end;
    procedure CreateAnnuityLoan()
    var
        LoanEntryRec: Record "Loan Application";
        LoanTypeRec: Record "Loan Product";
        LoopEndBool: Boolean;
        LineNoInt: Integer;
        PeriodCode: Code[10];
        InterestAmountDec: Decimal;
        RemainingPrincipalAmountDec: Decimal;
        RepaymentAmountDec: Decimal;
        RoundPrecisionDec: Decimal;
        RoundDirectionCode: Code[10];
    begin
        //Loan Applic. No.,Group Code,Client Code,Loan no
        Evaluate(EndDate, '01019999');
        Topups.Reset;
        Topups.SetRange(Topups."Loan No", "Loan No");
        if Topups.Find('+')then LastDate:=Topups."Payroll Period"
        else
            LastDate:="Issued Date";
        Installments:=Instalment;
        RemainingPrincipalAmountDec:=0;
        if Installments <= 0 then Error('Instalment Amount must be specified');
        //IF  Repayment> "Approved Amount" THEN
        //  ERROR('Instalment Amount is higher than Principal');
        LoopEndBool:=false;
        LineNoInt:=0;
        LoanTypeRec.Get("Loan Product Type");
        case LoanTypeRec.Rounding of LoanTypeRec.Rounding::Nearest: RoundDirectionCode:='=';
        LoanTypeRec.Rounding::Down: RoundDirectionCode:='<';
        LoanTypeRec.Rounding::Up: RoundDirectionCode:='>';
        end;
        RoundPrecisionDec:=LoanTypeRec."Rounding Precision";
        //
        //EVALUATE(GP,FORMAT("Grace Period"));
        // LoanBalance:=0;
        //Find the Loan balance
        PreviewShedule.Reset;
        PreviewShedule.SetRange(PreviewShedule."Employee No", "Employee No");
        PreviewShedule.SetRange("Loan Category", "Loan Product Type");
        PreviewShedule.SetRange(PreviewShedule."Repayment Date", LastDate);
        if PreviewShedule.Find('-')then begin
            LoanBalance:=PreviewShedule."Loan Amount";
        end;
        TopupAmt:=0;
        LoanBalance:=0;
        Topups.Reset;
        Topups.SetRange(Topups."Loan No", "Loan No");
        Topups.SetFilter("Payroll Period", '>=%1', "Issued Date");
        if Topups.Find('-')then repeat TopupAmt:=TopupAmt + Topups.Amount;
            until Topups.Next = 0;
        LoanBalance:=LoanBalance + TopupAmt;
        CalcFields("Total Repayment");
        if LoanBalance = 0 then LoanBalance:="Approved Amount"; //+"Total Repayment";
        //MESSAGE('%1',LoanBalance);
        //Delete Lines
        PreviewShedule.Reset;
        PreviewShedule.SetRange(PreviewShedule."Employee No", "Employee No");
        PreviewShedule.SetRange("Loan Category", "Loan Product Type");
        PreviewShedule.SetRange(PreviewShedule."Repayment Date", LastDate, EndDate);
        if PreviewShedule.Find('-')then begin
            repeat // MESSAGE('%1',PreviewShedule."Repayment Date");
                PreviewShedule.Delete;
            until PreviewShedule.Next = 0;
        end;
        if LoanBalance <> 0 then begin
            // MESSAGE('Loan Balance<>0');
            Topups.Reset;
            Topups.SetRange("Loan No", "Loan No");
            Topups.SetFilter("Payroll Period", '>=%1', "Issued Date");
            Topups.SetFilter(Topups.Repayment, '<>%1', 0);
            if Topups.Find('+')then begin
                RemainingPrincipalAmountDec:=LoanBalance;
                RunningDate:=Topups."Payroll Period";
                RepaymentAmt:=Topups.Repayment;
            end
            else
            begin
                RemainingPrincipalAmountDec:=LoanBalance;
                RunningDate:="Issued Date";
                RepaymentAmt:=Repayment;
            end;
            repeat InterestAmountDec:=Round(RemainingPrincipalAmountDec * (LoanTypeRec."Interest Rate" / 100) / 12, RoundPrecisionDec, RoundDirectionCode); //
                // MESSAGE('%1 %2 %3',RepaymentAmt,RemainingPrincipalAmountDec,RunningDate);
                // IF InterestAmountDec >=RepaymentAmt  THEN
                //   ERROR('This Loan is not possible because\the the instalment Amount must\be higher than %1',InterestAmountDec);
                //
                LineNoInt:=LineNoInt + 1;
                NewSchedule."Instalment No":=LineNoInt;
                NewSchedule."Employee No":="Employee No";
                NewSchedule."Loan No":="Loan No";
                NewSchedule."Repayment Date":=RunningDate;
                NewSchedule."Monthly Interest":=InterestAmountDec;
                NewSchedule."Monthly Repayment":=RepaymentAmt;
                NewSchedule."Loan Category":="Loan Product Type";
                NewSchedule."Loan Amount":=RemainingPrincipalAmountDec;
                NewSchedule."Principal Repayment":=NewSchedule."Monthly Repayment" - NewSchedule."Monthly Interest";
                // Area to be looked at
                if LineNoInt = Installments then begin
                    NewSchedule."Remaining Debt":=0;
                    NewSchedule."Monthly Repayment":=RemainingPrincipalAmountDec + NewSchedule."Monthly Interest";
                    LoopEndBool:=true;
                end;
                if(RepaymentAmt - InterestAmountDec) >= RemainingPrincipalAmountDec then begin
                    NewSchedule."Principal Repayment":=RemainingPrincipalAmountDec;
                    NewSchedule."Remaining Debt":=0;
                    LoopEndBool:=true;
                end
                else
                begin
                    NewSchedule."Principal Repayment":=RepaymentAmt - InterestAmountDec;
                    RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - (RepaymentAmt - InterestAmountDec);
                    NewSchedule."Remaining Debt":=RemainingPrincipalAmountDec;
                end;
                NewSchedule.Insert;
                RunningDate:=CalcDate('1M', RunningDate)//RunningDate:=CALCDATE("Instalment Period",RunningDate)
            //MODIFY;
            until LoopEndBool;
            Message('Schedule Created');
        end;
    end;
    procedure FlatRateCalc(var FlatLoanAmount: Decimal; var FlatInterestRate: Decimal)FlatRateCalc: Decimal begin
        //FlatPeriodInterval:=
        //EVALUATE(FlatPeriodInterval,FORMAT("Instalment Period"));
        //1M
        //IF FlatPeriodInterval='1M' THEN
        FlatPeriodInterest:=FlatLoanAmount * FlatInterestRate / 100 * 1 / 12;
        FlatRateCalc:=FlatPeriodInterest;
    /*
         //1W
        
        IF FlatPeriodInterval='1W' THEN
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/52;
         //2W
        IF FlatPeriodInterval='2W' THEN
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/26;
         //1Q
        IF FlatPeriodInterval='1Q' THEN
         FlatPeriodInterest:= FlatLoanAmount*FlatInterestRate/100*1/4;
        */
    end;
    procedure CreateFlatRateSchedule()
    begin
        // Flat Rate
        LineNoInt:=1;
        Installments:=Instalment;
        if "Interest Calculation Method" = "Interest Calculation Method"::"Flat Rate" then begin
            RunningDate:="Issued Date";
            RemainingPrincipalAmountDec:="Approved Amount";
            if LineNoInt < Installments + 1 then begin
                repeat NewSchedule."Instalment No":=LineNoInt;
                    NewSchedule."Employee No":="Employee No";
                    NewSchedule."Loan No":="Loan No";
                    NewSchedule."Repayment Date":=RunningDate;
                    NewSchedule."Monthly Interest":="Flat Rate Interest";
                    NewSchedule."Monthly Repayment":=Repayment;
                    NewSchedule."Loan Category":="Loan Product Type";
                    NewSchedule."Loan Amount":="Approved Amount";
                    NewSchedule."Principal Repayment":="Flat Rate Principal";
                    if LineNoInt = 1 then RemainingPrincipalAmountDec:="Approved Amount" - Repayment
                    else
                        RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - Repayment;
                    NewSchedule."Remaining Debt":=RemainingPrincipalAmountDec;
                    NewSchedule."Instalment No":=LineNoInt;
                    NewSchedule.Insert;
                    LineNoInt:=LineNoInt + 1;
                    RunningDate:=CalcDate('CD+1M', RunningDate);
                until LineNoInt > Installments end;
        end;
        Message('Schedule Created');
    end;
    procedure CreateLoanSchedule()
    begin
        // Flat Rate
        LineNoInt:=1;
        Installments:=Instalment;
        if "Interest Calculation Method" = "Interest Calculation Method"::" " then begin
            RunningDate:="Issued Date";
            RemainingPrincipalAmountDec:="Approved Amount";
            if LineNoInt < Installments + 1 then begin
                repeat NewSchedule."Instalment No":=LineNoInt;
                    NewSchedule."Employee No":="Employee No";
                    NewSchedule."Loan No":="Loan No";
                    NewSchedule."Repayment Date":=RunningDate;
                    NewSchedule."Loan Category":="Loan Product Type";
                    NewSchedule."Loan Amount":="Approved Amount";
                    NewSchedule."Monthly Repayment":=Repayment;
                    NewSchedule."Principal Repayment":=Repayment;
                    if LineNoInt = 1 then RemainingPrincipalAmountDec:="Approved Amount" - Repayment
                    else
                        RemainingPrincipalAmountDec:=RemainingPrincipalAmountDec - Repayment;
                    NewSchedule."Remaining Debt":=RemainingPrincipalAmountDec;
                    NewSchedule."Instalment No":=LineNoInt;
                    NewSchedule.Insert;
                    LineNoInt:=LineNoInt + 1;
                    RunningDate:=CalcDate('CD+1M', RunningDate);
                until LineNoInt > Installments end;
        end;
        Message('Schedule Created');
    end;
}
