report 51457 "Email Client Payslips"
{
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            DataItemTableView = WHERE(Status = CONST(Active), "Email Address" = FILTER(<> ''), "Total Allowances" = filter(<> 0));
            RequestFilterFields = "Company Code", "No.";

            trigger OnAfterGetRecord()
            begin
                Payroll.GeneratePayslip(Employee."No.", Period);
            end;

            trigger OnPostDataItem()
            begin
                Window.Close();
                Message('Payslips sent Successfully!');
            end;

            trigger OnPreDataItem()
            begin
                Window.Open('Sending Payslips: @1@@@@@@@@@@@@@@@' + 'Employee:#2###############');
                TotalCount := Count;
            end;
        }


    }


    requestpage
    {
        layout
        {
            area(content)
            {
                field(Period; Period)
                {
                    ApplicationArea = All;
                    Caption = 'Month Begin Date';
                }
            }
        }
    }

    trigger OnPreReport()
    begin
        if Period = 0D then
            Error('Please select a valid Period (Month Begin Date)');
    end;

    trigger OnPostReport()
    begin
        Message('Payslips emailed successfully for period: %1', Period);
    end;


    var
        Payroll: Codeunit "Client Payroll Calculator";
        Period: Date;
        TotalCount: Integer;
        Window: Dialog;

}