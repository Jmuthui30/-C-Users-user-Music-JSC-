report 50012 "Leave Opening Balances"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Leave Opening Balances.rdlc';

    dataset
    {
        dataitem("Employee Information_Data"; "Employee Information_Data")
        {
            trigger OnAfterGetRecord()
            begin
                if "Employee Information_Data"."Remaining Leave Days" <> 24 then begin
                    if Emp.Get("Employee Information_Data"."Payroll No.")then begin
                        if Emp."Employment Date" <> 0D then begin
                            Leave.Init;
                            Leave."HR Created":=true;
                            Leave.Insert(true);
                            //IF Leave2.GET(Leave."Application No") THEN BEGIN
                            Leave.Validate("Employee No", "Employee Information_Data"."Payroll No.");
                            Leave.Validate("Leave Code", 'ANNUAL');
                            Leave.Validate("Days Applied", 24 - "Employee Information_Data"."Remaining Leave Days");
                            Leave.Validate("Start Date", Today);
                            Leave.Status:=Leave.Status::Released;
                            Leave.Modify;
                        //END;
                        end;
                    end;
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
    trigger OnPostReport()
    begin
        Message('Complete');
    end;
    var Leave: Record "Employee Leave Application";
    Emp: Record Employee;
    Leave2: Record "Employee Leave Application";
}
