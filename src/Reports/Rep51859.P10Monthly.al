report 51859 "P10Monthly"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/P10Monthly.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(Employee; "Employee Master")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "Pay Period Filter", "No.";

            column(PIN; Employee."PIN Number")
            {
            }
            column(No; Employee."No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Residential;'Residential')
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
            column(LeavePay;'LeavePay')
            {
            }
            column(OverTimeAll;'Overtime')
            {
            }
            column(DirectorsFee;'Directors Fee')
            {
            }
            column(LumpSum;'LumpSum')
            {
            }
            column(OtherAll; OtherAllowances)
            {
            }
            trigger OnAfterGetRecord()
            begin
                EmpInfor.Reset;
                EmpInfor.SetRange("No.", Employee."No.");
                if EmpInfor.FindSet then Name:=EmpInfor.FullName;
                PayPeriodDate:=PayMatrix.GetFilter("Pay Period Filter");
                PayMatrix.Reset;
                PayMatrix.SetRange("Employee No", Employee."No.");
                PayMatrix.SetFilter("Pay Period Filter", PayPeriodDate);
                if PayMatrix.FindSet then begin
                    PayMatrix.SetRange(Type, PayMatrix.Type::Payment);
                    PayMatrix.SetRange(Code, '001');
                    if PayMatrix.FindSet then BasicPay:=PayMatrix.Amount;
                    PayMatrix.SetRange(Code, '002');
                    if PayMatrix.FindSet then HouseAll:=PayMatrix.Amount;
                    PayMatrix.SetRange(Code, '003');
                    if PayMatrix.FindSet then TransportAll:=PayMatrix.Amount;
                    PayMatrix.SetFilter(Code, '004..024');
                    PayMatrix.CalcSums(Amount);
                    OtherAllowances:=PayMatrix.Amount;
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
    var EarnRec: Record Earnings;
    DedRec: Record Deductions;
    PayMatrix: Record "Payroll Matrix";
    MASTER_ROLLCaptionLbl: Label 'MASTER ROLL';
    CurrReport_PAGENOCaptionLbl: Label 'Page';
    Other_AllowancesCaptionLbl: Label 'Other Allowances';
    BasicPay: Decimal;
    EmpInfor: Record Employee;
    Name: Text;
    Resident: Text;
    EmpType: Integer;
    HouseAll: Decimal;
    TransportAll: Decimal;
    OtherAllowances: Decimal;
    DateSpecified: Date;
    PayPeriodDate: Text;
}
