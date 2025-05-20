report 51427 "Email Payslips"
{
    // version THL- Payroll 1.0
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = WHERE(Status=CONST(Active), "Company E-Mail"=FILTER(<>''), "No."=FILTER(<>'MA040'));
            RequestFilterFields = "No.";

            trigger OnAfterGetRecord()
            begin
                Employee.TestField("Company E-Mail");
                Payroll.GeneratePayslip(Employee."No.", MonthBeginDate);
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(MonthBeginDate; MonthBeginDate)
                {
                    ApplicationArea = All;
                    Caption = 'Month Begin Date';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        Message('Payslips emailed successfully');
    end;
    var MonthBeginDate: Date;
    Payroll: Codeunit "Payroll Calculator";
}
