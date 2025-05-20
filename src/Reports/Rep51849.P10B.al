report 51849 "P10 B"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/P10 B.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll Matrix"; "CLient Payroll Matrix")
        {
            RequestFilterFields = "Employee No", "Payroll Period";

            column(PIN; PIN)
            {
            }
            column(Name; Name)
            {
            }
            column(Residence; Resident)
            {
            }
            column(BasicPay; BasicPay)
            {
            }
            column(HouseAll; HouseAll)
            {
            }
            column(TransportAll; TransportAll)
            {
            }
            column(LeavePay; LeavePay)
            {
            }
            column(EmpNo; EmpNo)
            {
            }
            column(OtherAllowances; OtherAllowances)
            {
            }
            column(Overtime; Overtime)
            {
            }
            column(DirectorsFee; DirectorsFee)
            {
            }
            column(LumpSum; LumpSum)
            {
            }
            column(TotalCashPay; TotalCashPay)
            {
            }
            column(CarBenefit; CarBenefit)
            {
            }
            column(OtherNonCashBenefit; NonCashBenefit)
            {
            }
            column(Payroll_Period; "Payroll Period")
            {
            }
            column(TotalNonCashPay; TotalNonCash)
            {
            }
            column(GlobalIncom; GlobalIncome)
            {
            }
            column(TypeofHousing; TypeofHousing)
            {
            }
            column(HouseRent; HouseRentValue)
            {
            }
            column(Pension; Pension)
            {
            }
            column(EmployeeType; Empmaster."Employee Type")
            {
            }
            column(Pay_Period_Filter; "Pay Period Filter")
            {
            }
            column(TaxReleif; TaxReleif)
            {
            }
            column(InsuranceRelief; InsuranceRelief)
            {
            }
            column(Mortagage; MortagageInterest)
            {
            }
            column(PAYE; PayeMonthly)
            {
            }
            column(Permissible; Permissible)
            {
            }
            trigger OnAfterGetRecord()
            begin
                EmpInfor.Reset;
                EmpInfor.SetRange("No.", "Payroll Matrix"."Employee No");
                if EmpInfor.FindSet then Name:=EmpInfor."Full Name";
                EmpMaster.Reset;
                EmpMaster.SetRange("No.", PayMatrix."Employee No");
                if EmpMaster.FindSet then begin
                    PIN:=EmpMaster."PIN Number";
                    EmpNo:=EmpMaster."No.";
                    if(PIN = EmpMaster."PIN Number")then Resident:='Resident'
                    else
                        Resident:='Foreign';
                    //if EmpMaster."Employee Group" = 'SECONDMENT' then
                    //EmpType := 'Secondary Employee'
                    //else
                    //EmpType := 'Primary Employee';
                    if EmpMaster."Employee Group" = 'SECONDMENT' then Permissible:=''
                    else
                        Permissible:='0';
                end;
                PayPeriodDate:="Payroll Matrix"."Payroll Period";
                PayMatrix.Reset;
                PayMatrix.SetRange(Company, "Payroll Matrix".Company);
                PayMatrix.SetRange("Employee No", "Employee No");
                PayMatrix.SetRange("Payroll Period", PayPeriodDate);
                if PayMatrix.FindSet then begin
                    if PayMatrix."Basic Salary Code" = true then PayMatrix.SetRange(Type, PayMatrix.Type::Payment);
                    PayMatrix.SetRange(PayMatrix.Code, PayMatrix.Code);
                    if PayMatrix.FindSet then BasicPay:=PayMatrix.Amount;
                end;
                begin
                    /*  PayMatrix.SetRange(Code, 'EA010');
                     if PayMatrix.FindSet then
                         HouseAll := PayMatrix.Amount;

                     PayMatrix.SetRange(Code, 'EA016');
                     if PayMatrix.FindSet then
                         TransportAll := PayMatrix.Amount;
  */
                    PayMatrix.SetRange(Code, PayMatrix.Code);
                    "Payroll Matrix".SetRange("Tax Relief", "Payroll Matrix"."Tax Relief");
                    if "Tax Relief" = true then if "Normal Earnings" = false then if PayMatrix.FindSet then TaxReleif:=PayMatrix.Amount;
                end;
                begin
                    PayMatrix.SetRange(Code, PayMatrix.Code);
                    EarnRec.SetRange(EarnRec."Earning Type", EarnRec."Earning Type"::"Insurance Relief");
                    if PayMatrix.FindSet then InsuranceRelief:=PayMatrix.Amount;
                end;
                PayMatrix.SetRange(Code, ' ');
                if PayMatrix.FindSet then MortagageInterest:=PayMatrix.Amount;
                // PayMatrix.SetFilter(Code, '<>%1&<>%2&<>%3&<>%4&<>%5&<>%6', 'EA010', 'EA016', 'E83', 'E85', 'E01', '');
                // PayMatrix.SetFilter(PayMatrix.Type,PayMatrix.Type::Payment)
                if PayMatrix.FindSet then begin
                    PayMatrix.CalcSums(Amount);
                    OtherAllowances:=PayMatrix.Amount - TaxReleif - MortagageInterest - InsuranceRelief;
                end;
                TypeofHousing:='Benefit not given';
                PayMatrix.Reset();
                PayMatrix.SetRange(Type, "Payroll Matrix".Type::Deduction);
                if PayMatrix.FindSet then begin
                    if PayMatrix.Retirement = true then //PayMatrix.SetRange(Code, 'PROVIDENT');
                        if PayMatrix.FindSet then Pension:=PayMatrix.Amount;
                    begin
                        if PayMatrix.FindSet then begin
                            if PayMatrix.Paye = true then PayMatrix.SetRange(Type, PayMatrix.Type::Deduction);
                            PayMatrix.SetRange(PayMatrix.Code, PayMatrix.Code);
                            if PayMatrix.FindSet then PayeMonthly:=PayMatrix.Amount;
                        end end;
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
    var EarnRec: Record "Client Earnings";
    DedRec: Record "Client Deductions";
    PayMatrix: Record "Client Payroll Matrix";
    BasicPay: Decimal;
    EmpInfor: Record "Client Employee Master";
    Name: Text;
    Resident: Text;
    HouseAll: Decimal;
    TransportAll: Decimal;
    OtherAllowances: Decimal;
    DateSpecified: Date;
    PayPeriodDate: Date;
    PIN: Code[20];
    EmpMaster: Record "Client Employee Master";
    EmpNo: Code[20];
    Department: Code[20];
    EmpGroup: Record "Client Employee Groups";
    LeavePay: Integer;
    Overtime: Integer;
    DirectorsFee: Integer;
    LumpSum: Integer;
    TotalCashPay: Decimal;
    CarBenefit: Integer;
    NonCashBenefit: Integer;
    TotalNonCash: Integer;
    GlobalIncome: Integer;
    TypeofHousing: Text;
    HouseRentValue: Text;
    Pension: Decimal;
    TaxReleif: Decimal;
    MortagageInterest: Decimal;
    PayeMonthly: Decimal;
    InsuranceRelief: Decimal;
    Permissible: Text;
}
