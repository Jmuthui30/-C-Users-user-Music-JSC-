
report 53056 "NSSF New"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/NSSFnew.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(DataItemName; Employee)
        {
            RequestFilterFields = "No.";
            column(No_; "No.")
            {

            }
            column(Name; Name) { }
            column(Social_Security_No_; "Social Security No.") { }
            column(EmployeeAmount; EmployeeAmount) { }
            column(EmployerAmount; EmployerAmount) { }

            trigger OnAfterGetRecord()
            begin
                EmployeeAmount := 0;
                EmployerAmount := 0;

                if ClientPayrollMatrix.Get("Employee No. Filter") then begin
                    ClientPayrollMatrix.SetRange(ClientPayrollMatrix."Payroll Period", DateSpecified);
                    if ClientPayrollMatrix.Code = 'NSSFTIERI' then
                        EmployeeAmount := ClientPayrollMatrix.Amount;
                    if ClientPayrollMatrix.Code = 'NSSFTIERII' then
                        EmployerAmount := ClientPayrollMatrix.Amount;
                end;


            end;

        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(DateSpecified; DateSpecified)
                    {
                        TableRelation = "Client Payroll Period"."Starting Date";
                        ApplicationArea = All;

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(LayoutName)
                // {

                // }
            }
        }
    }

    trigger OnPreReport()
    begin

        //DateSpecified := .GetRangeMin("Payroll Matrix"."Pay Period Filter");
        //if PayPeriod.Get(DateSpecified) then PayPeriodText := PayPeriod.Name;
    end;

    var
        EmployeeAmount: Decimal;
        EmployerAmount: Decimal;
        ClientPayrollMatrix: Record "Client Payroll Matrix";

        TotalFor: Label 'Total for ';

        TypeFilter: Text[30];
        GroupHeader: Text[30];
        BasicPay: Decimal;
        PayPeriod: Record "Payroll Period";
        PayPeriodText: Text[30];
        Title: Text[30];
        DateSpecified: Date;
        BeginDate: Date;
        CompRec: Record "Company Information";

        GetGroup: Codeunit "Payroll Calculator";
        StartDate: Date;
        EndDate: Date;
}
