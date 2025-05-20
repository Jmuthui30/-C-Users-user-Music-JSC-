report 51482 "Clear SHIF Relief"
{
    ApplicationArea = All;
    Caption = 'Clear SHIF Relief';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(ClientEmployeeMaster; "Client Employee Master")
        {
            DataItemTableView = where(Status=const(Active));

            trigger OnAfterGetRecord()
            begin
                PayrollMatrix.Reset();
                PayrollMatrix.SetRange("Employee No", ClientEmployeeMaster."No.");
                PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                PayrollMatrix.SetRange(Code, 'SHIF-RL');
                PayrollMatrix.SetRange("Payroll Period", BeginDate);
                IF PayrollMatrix.FindFirst()then PayrollMatrix.Delete();
            end;
        }
    }
    trigger OnPreReport()
    begin
        GetPayPeriod();
    end;
    trigger OnPostReport()
    begin
        Message('Complete');
    end;
    procedure GetPayPeriod()
    begin
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.FindFirst()then begin
            BeginDate:=PayPeriod."Starting Date";
        end;
    end;
    var PayrollMatrix: Record "Client Payroll Matrix";
    PayrollMatrix2: Record "Client Payroll Matrix";
    PayPeriod: Record "Client Payroll Period";
    BeginDate: Date;
}
