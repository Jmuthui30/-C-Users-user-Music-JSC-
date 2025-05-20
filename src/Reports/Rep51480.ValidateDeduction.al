report 51480 "Validate Deduction"
{
    ApplicationArea = All;
    Caption = 'Validate Deduction';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(ClientDeductions; "Client Deductions")
        {
            RequestFilterFields = Code, Company;

            trigger OnAfterGetRecord()
            begin
                PayrollMatrix.Reset();
                PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Deduction);
                PayrollMatrix.SetRange(Code, ClientDeductions.Code);
                PayrollMatrix.SetRange("Payroll Period", BeginDate);
                if PayrollMatrix.FindFirst()then begin
                    repeat PayrollMatrix.Validate(Code);
                        PayrollMatrix.Modify();
                        Commit();
                    until PayrollMatrix.Next() = 0;
                end;
            end;
        }
    }
    trigger OnPreReport()
    begin
        GetPayPeriod();
        if ClientDeductions.GetFilter(Code) = '' then Error('You must select a deduction code!');
    end;
    trigger OnPostReport()
    begin
        Message('Completed');
    end;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.FindFirst()then begin
            BeginDate:=PayPeriod."Starting Date";
        end;
    end;
    var PayPeriod: Record "Client Payroll Period";
    BeginDate: Date;
    PayrollMatrix: Record "Client Payroll Matrix";
}
