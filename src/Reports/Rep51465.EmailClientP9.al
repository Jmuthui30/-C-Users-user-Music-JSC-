report 51465 "Email Client P9"
{
    ApplicationArea = All;
    Caption = 'Email Employee P9A';
    UsageCategory = Tasks;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; "Client Employee Master")
        {
            DataItemTableView = WHERE("Email Address" = FILTER(<> ''), "Total Allowances" = filter(<> 0));
            RequestFilterFields = "Company Code", "No.";

            trigger OnAfterGetRecord()
            begin
                Clear(ReportParameters);
                XmlParameters := '';
                XmlParameters := Payroll.CreateReportParameters(Employee."No.", StartDate, EndDate, Comp);
                CurrentUser := UserId;
                with ReportParameters do begin
                    if ReportParameters.Get(51464, CurrentUser) then ReportParameters.Delete();
                    ReportParameters.SetAutoCalcFields(Parameters);
                    ReportParameters.ReportId := 51464;
                    ReportParameters.UserId := CurrentUser;
                    ReportParameters.Parameters.CreateOutStream(OStream, TextEncoding::UTF8);
                    OStream.WriteText(XmlParameters);
                    ReportParameters.Insert();
                end;
                //
                Commit();
                Payroll.GeneratePNine(Employee."No.", StartDate, EndDate, Comp, XmlParameters);
                Counter := Counter + 1;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(Period)
                {
                }
                field("Start Date"; StartDate)
                {
                    ApplicationArea = All;
                    StyleExpr = FALSE;
                    TableRelation = "Client Payroll Period";
                }
                field("End Date"; EndDate)
                {
                    ApplicationArea = All;
                    StyleExpr = FALSE;
                    TableRelation = "Client Payroll Period";
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
        if Employee.GetFilter("Company Code") = '' then Error('Company must be specified.');
        Comp := Employee.GetFilter("Company Code");
        Counter := 0;
    end;

    trigger OnPostReport()
    begin
        Message(Format(Counter) + ' P9 forms have been emailed successfully');
    end;

    var
        Payroll: Codeunit "Client Payroll Calculator";
        ReportParameters: Record "Report Parameters";
        XmlParameters: Text;
        CurrentUser: Code[50];
        OStream: OutStream;
        StartDate: Date;
        EndDate: Date;
        Comp: Code[20];
        Counter: Integer;
}
