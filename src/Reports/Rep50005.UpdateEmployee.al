report 50005 "Update Employee"
{
    ApplicationArea = All;
    Caption = 'Update Employee';
    UsageCategory = ReportsAndAnalysis;

    //ProcessingOnly = true;
    dataset
    {
        dataitem(HREmployee; Employee)
        {
            trigger OnAfterGetRecord()
            begin
                ClientPayroll.Reset();
                ClientPayroll.SetRange("No.", HREmployee."No.");
                if ClientPayroll.FindSet()then begin
                    ClientPayroll."First Name":=HREmployee."First Name";
                    ClientPayroll."Middle Name":=HREmployee."Middle Name";
                    ClientPayroll."Last Name":=HREmployee."Last Name";
                    ClientPayroll."Full Name":=HREmployee.FullName();
                    ClientPayroll.Modify();
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var ClientPayroll: Record "Client Employee Master";
}
