report 50022 "Update Employee Groups"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Update Employee Groups.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Employee Master"; "Employee Master")
        {
            DataItemTableView = WHERE("Employee Group"=FILTER(<>'PARTNER'));

            trigger OnAfterGetRecord()
            begin
                "Employee Master"."Employee Group":="Employee Master"."Global Dimension 1 Code";
                "Employee Master".Modify;
                Matrix.Reset;
                Matrix.SetRange("Employee No", "Employee Master"."No.");
                Matrix.ModifyAll("Payroll Group", "Employee Master"."Global Dimension 1 Code");
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
    trigger OnPostReport()
    begin
        Message('Complete');
    end;
    var Matrix: Record "Payroll Matrix";
}
