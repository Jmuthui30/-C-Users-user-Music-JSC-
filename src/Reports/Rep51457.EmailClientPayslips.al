report 51457 "Email Client Payslips"
{
    // version THL- Client Payroll 1.0
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            DataItemTableView = WHERE(Status=CONST(Active), "Email Address"=FILTER(<>''), "Total Allowances"=filter(<>0));
            RequestFilterFields = "Company Code", "No.";

            trigger OnAfterGetRecord()
            begin
                Payroll.GeneratePayslip(Employee."No.", Period);
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
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        XmlParameters:=Report.RunRequestPage(Report::"Client Payslip");
        CurrentUser:=UserId;
        with ReportParameters do begin
            if ReportParameters.Get(51455, CurrentUser)then ReportParameters.Delete();
            ReportParameters.SetAutoCalcFields(Parameters);
            ReportParameters.ReportId:=51455;
            ReportParameters.UserId:=CurrentUser;
            ReportParameters.Parameters.CreateOutStream(OStream, TextEncoding::UTF8);
            Message(XmlParameters);
            OStream.WriteText(XmlParameters);
            ReportParameters.Insert();
        end;
        Commit();
    end;
    trigger OnPostReport()
    begin
        Message('Payslips emailed successfully');
    end;
    var Payroll: Codeunit "Client Payroll Calculator";
    ReportParameters: Record "Report Parameters";
    XmlParameters: Text;
    CurrentUser: Code[50];
    OStream: OutStream;
    Period: Date;
}
