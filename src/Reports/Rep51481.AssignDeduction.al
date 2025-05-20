report 51481 "Assign Deduction"
{
    ApplicationArea = All;
    Caption = 'Assign Deduction';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(ClientDeductions; "Client Deductions")
        {
            RequestFilterFields = Code, Company;

            trigger OnAfterGetRecord()
            begin
                Employee.Reset();
                Employee.SetRange(Status, Employee.Status::Active);
                if ClientDeductions.Company <> '' then Employee.SetRange("Company Code", ClientDeductions.Company);
                Employee.SetFilter("No.", '<>%1', '');
                if Employee.FindFirst()then begin
                    repeat PayrollMatrix.Init();
                        PayrollMatrix.Type:=PayrollMatrix.Type::Deduction;
                        PayrollMatrix.Code:=ClientDeductions.Code;
                        PayrollMatrix."Payroll Period":=BeginDate;
                        if Employee."Company Code" = '' then PayrollMatrix.Company:='JSC'
                        else
                            PayrollMatrix.Company:=Employee."Company Code";
                        PayrollMatrix."Payroll Group":=Employee."Employee Group";
                        PayrollMatrix."Employee No":=Employee."No.";
                        PayrollMatrix.Validate("Payroll Period");
                        PayrollMatrix.Validate(Code);
                        PayrollMatrix.Insert(true);
                    until Employee.Next() = 0;
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
    Employee: Record "Client Employee Master";
}
