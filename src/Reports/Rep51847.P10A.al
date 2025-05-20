report 51847 "P10 A"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/P10 A.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll matrix"; "Client Payroll Matrix")
        {
            DataItemTableView = WHERE(Type=FILTER(Deduction), Paye=const(true));
            RequestFilterFields = "Payroll Period";

            column(EmployeeNo_Payrollmatrix; "Payroll matrix"."Employee No")
            {
            }
            column(Type_Payrollmatrix; "Payroll matrix".Type)
            {
            }
            column(Code_Payrollmatrix; "Payroll matrix".Code)
            {
            }
            column(PayrollPeriod_Payrollmatrix; "Payroll matrix"."Payroll Period")
            {
            }
            column(Amount_Payrollmatrix; "Payroll matrix".Amount)
            {
            }
            column(Description_Payrollmatrix; "Payroll matrix".Description)
            {
            }
            column(YEAR; Year)
            {
            }
            column(PIN; PIN)
            {
            }
            dataitem("Payroll Period"; "Payroll Period")
            {
                DataItemLink = "Starting Date"=FIELD("Payroll Period");

                column(Name_PayrollPeriod; "Payroll Period".Name)
                {
                }
            }
            trigger OnAfterGetRecord()
            begin
                CompInfor.Get;
                CompInfor.CalcFields(Picture);
                PIN:=CompInfor."KRA PIN";
                Year:=Date2DMY(Today, 3);
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
    var CompInfor: Record "Company Information";
    PIN: Text;
    "Pay Period": Record "Client Payroll Period";
    Year: Integer;
}
