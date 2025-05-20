report 50011 "Update Employee Data"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Update Employee Data.rdlc';

    dataset
    {
        dataitem("Employee Information_Data"; "Employee Information_Data")
        {
            RequestFilterFields = "Payroll No.";

            trigger OnAfterGetRecord()
            begin
                if NAVEmp.Get("Employee Information_Data"."Payroll No.")then begin
                    if "Employee Information_Data".Gender = 'Male' then NAVEmp.Gender:=NAVEmp.Gender::Male
                    else
                        NAVEmp.Gender:=NAVEmp.Gender::Female;
                    NAVEmp."Job Title":="Employee Information_Data"."Job Title";
                    NAVEmp."Birth Date":="Employee Information_Data"."Date of Birth";
                    NAVEmp."Address 2":="Employee Information_Data"."Residential Address";
                    if NAVEmp."Phone No." = '' then NAVEmp."Phone No.":="Employee Information_Data"."Phone No.";
                    if NAVEmp."E-Mail" = '' then begin
                        NAVEmp."E-Mail":="Employee Information_Data"."Email Address";
                        NAVEmp."Company E-Mail":="Employee Information_Data"."Email Address";
                    end;
                    NAVEmp.Modify;
                end;
                if Emp.Get("Employee Information_Data"."Payroll No.")then begin
                    if Emp."ID Number" = '' then Emp."ID Number":="Employee Information_Data"."ID Number";
                    if Emp."PIN Number" = '' then Emp."PIN Number":="Employee Information_Data"."PIN Number";
                    if Emp."NSSF No" = '' then Emp."NSSF No":="Employee Information_Data"."NSSF No.";
                    if Emp."SHIF No" = '' then Emp."SHIF No":="Employee Information_Data"."SHIF No.";
                    if Emp."Bank Code" = '' then Emp."Bank Code":="Employee Information_Data"."Bank Code";
                    if Emp."Bank Branch" = '' then Emp."Bank Branch":="Employee Information_Data"."Branch Code";
                    if Emp."Bank Account Number" = '' then Emp."Bank Account Number":="Employee Information_Data"."Bank A/C";
                    Emp.Modify;
                end;
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
    var NAVEmp: Record Employee;
    Emp: Record "Employee Master";
}
