table 51442 "Loan Top-up"
{
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            TableRelation = "Client Loan Application";
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; Description; Text[100])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Installment; Decimal)
        {
        }
        field(6; Repayment; Decimal)
        {
            trigger OnValidate()
            begin
                LoanApp.Reset;
                LoanApp.SetRange(LoanApp."Loan No", "Loan No");
                if LoanApp.Find('-')then begin
                    AssMatrix.Reset;
                    AssMatrix.SetRange(AssMatrix."Payroll Period", "Payroll Period");
                    AssMatrix.SetRange(AssMatrix.Code, LoanApp."Deduction Code");
                    if AssMatrix.Find('-')then begin
                        repeat AssMatrix.Amount:=Repayment;
                            AssMatrix.Modify;
                        until AssMatrix.Next = 0;
                    end;
                end;
            end;
        }
        field(7; Interest; Decimal)
        {
        }
        field(8; "Payroll Period"; Date)
        {
            TableRelation = "Client Payroll Period"."Starting Date";
        }
    }
    keys
    {
        key(Key1; "Loan No")
        {
        }
    }
    fieldgroups
    {
    }
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    HRsetup: Record "Human Resources Setup";
    LoanType: Record "Client Loan Product";
    EmpRec: Record Employee;
    PeriodInterest: Decimal;
    Installments: Decimal;
    NewSchedule: Record "Client Loan Schedule";
    RunningDate: Date;
    Interest: Decimal;
    FlatPeriodInterest: Decimal;
    FlatRateTotalInterest: Decimal;
    FlatPeriodInterval: Code[10];
    LineNoInt: Integer;
    RemainingPrincipalAmountDec: Decimal;
    AssMatrix: Record "Client Payroll Matrix";
    LoanApp: Record "Client Loan Application";
}
