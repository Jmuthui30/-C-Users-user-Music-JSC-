report 51850 "Payroll analysis"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Payroll analysis.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll Matrix"; "Payroll Matrix")
        {
            RequestFilterFields = "Payroll Period";

            column("Code"; Code)
            {
            }
            column(PayrollPeriod; Date)
            {
            }
            column(Amount; Amount)
            {
            }
            column(EarnDesc; EarnDesc)
            {
            }
            column(Dedesc; Dedesc)
            {
            }
            column(CurrPeriod; Currentpayperiod)
            {
            }
            column(AmountX; AmountX)
            {
            }
            column(EmpNo; "Payroll Matrix"."Employee No")
            {
            }
            column(TypeAmount; TypeAmount)
            {
            }
            trigger OnAfterGetRecord()
            begin
                PayMatrix.Reset;
                PayMatrix.SetRange(Code, "Payroll Matrix".Code);
                PayMatrix.SetRange("Payroll Period", CalcDate('<-1M>', DateX));
                if PayMatrix.FindFirst then begin
                    Amount:=PayMatrix.Amount;
                    Code:=PayMatrix.Code;
                    Date:=PayMatrix."Payroll Period";
                    Earnings.Reset;
                    Earnings.SetRange(Code, "Payroll Matrix".Code);
                    Earnings.SetRange("Pay Period Filter", "Payroll Matrix"."Payroll Period");
                    if Earnings.FindFirst then begin
                        EarnDesc:=Earnings.Description;
                    //TypeAmount := TypeAmount + Amount;
                    end;
                    Deductions.Reset;
                    Deductions.SetRange(Code, "Payroll Matrix".Code);
                    if Deductions.FindSet then Dedesc:=Deductions.Description;
                end;
                PayMatrix.Reset;
                PayMatrix.SetRange(Code, "Payroll Matrix".Code);
                PayMatrix.SetRange("Payroll Period", "Payroll Matrix"."Payroll Period");
                if PayMatrix.FindFirst then begin
                    AmountX:=PayMatrix.Amount;
                    Currentpayperiod:=PayMatrix."Payroll Period";
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
        DateX:="Payroll Matrix".GetRangeMin("Payroll Matrix"."Payroll Period");
        PayMatrix."Employee No":="Payroll Matrix"."Employee No";
    end;
    var Earnings: Record Earnings;
    Deductions: Record Deductions;
    EarnDesc: Text;
    Dedesc: Text;
    PayMatrix: Record "Payroll Matrix";
    "Code": Text;
    Amount: Decimal;
    PayPeriod: Date;
    PreviousMonth: Date;
    PayrollPeriod: Record "Payroll Period";
    Date: Date;
    DateX: Date;
    Currentpayperiod: Date;
    AmountX: Decimal;
    EmpNo: Code[20];
    TypeAmount: Decimal;
}
