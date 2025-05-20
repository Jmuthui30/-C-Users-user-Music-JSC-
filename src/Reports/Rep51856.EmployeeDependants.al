report 51856 "Employee Dependants"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Employee Dependants.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employees Dependants"; "Employees Dependants")
        {
            RequestFilterFields = "Employee Code", Relationship;

            column(Distribution; "Employees Dependants"."Distribution %")
            {
            }
            column(EmployeeCode; "Employees Dependants"."Employee Code")
            {
            }
            column(Relationship; "Employees Dependants".Relationship)
            {
            }
            column(SurName; "Employees Dependants".SurName + "Employees Dependants"."Other Names")
            {
            }
            column(IDNoPassportNo; "Employees Dependants"."ID No/Passport No")
            {
            }
            column(DateOfBirth; "Employees Dependants"."Date Of Birth")
            {
            }
            column(Occupation; "Employees Dependants".Occupation)
            {
            }
            column(Address; "Employees Dependants".Address)
            {
            }
            column(HomeTelNo; "Employees Dependants"."Home Tel No")
            {
            }
            column(EmpName; EmpName)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Employees Dependants"."Employee Code");
                if Employee.FindSet then EmpName:=Employee.FullName;
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
    var Employee: Record Employee;
    EmpName: Text;
}
