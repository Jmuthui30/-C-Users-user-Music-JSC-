report 51855 "Employee Kins"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Employee Kins.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee Kins"; "Employee Kins")
        {
            RequestFilterFields = "Employee Code", Relationship;

            column(EmployeeCode_EmployeeKins; "Employee Kins"."Employee Code")
            {
            }
            column(Relationship_EmployeeKins; "Employee Kins".Relationship)
            {
            }
            column(SurName_EmployeeKins; "Employee Kins".SurName + '' + "Employee Kins"."Other Names")
            {
            }
            column(IDNoPassportNo_EmployeeKins; "Employee Kins"."ID No/Passport No")
            {
            }
            column(DateOfBirth_EmployeeKins; "Employee Kins"."Date Of Birth")
            {
            }
            column(Occupation_EmployeeKins; "Employee Kins".Occupation)
            {
            }
            column(Address_EmployeeKins; "Employee Kins".Address)
            {
            }
            column(HomeTelNo_EmployeeKins; "Employee Kins"."Home Tel No")
            {
            }
            column(Remarks_EmployeeKins; "Employee Kins".Remarks)
            {
            }
            column(Name; Name)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Employee.Reset;
                Employee.SetRange("No.", "Employee Kins"."Employee Code");
                if Employee.FindSet then Name:=Employee.FullName;
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
    Name: Text;
}
