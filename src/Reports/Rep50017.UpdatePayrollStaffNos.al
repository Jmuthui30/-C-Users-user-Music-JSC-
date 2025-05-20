report 50017 "Update Payroll Staff Nos"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Update Payroll Staff Nos.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = WHERE(Status=CONST(Active));

            trigger OnAfterGetRecord()
            begin
                /*Payroll.RESET;
                Payroll.SETRANGE("Full Names",Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name");
                IF Payroll.FINDSET THEN
                  Payroll.MODIFYALL("Payroll No.",Employee."No.")
                ELSE BEGIN
                Payroll.RESET;
                Payroll.SETRANGE("Full Names",Employee."First Name"+' '+Employee."Last Name"+' '+Employee."Middle Name");
                IF Payroll.FINDSET THEN
                  Payroll.MODIFYALL("Payroll No.",Employee."No.")
                ELSE BEGIN
                Payroll.RESET;
                Payroll.SETRANGE("Full Names",Employee."First Name"+' '+Employee."Middle Name");
                IF Payroll.FINDSET THEN
                  Payroll.MODIFYALL("Payroll No.",Employee."No.");
                END;
                END;*/
                PayrollMatrix.Reset;
                PayrollMatrix.SetRange("Employee No", Employee."No.");
                PayrollMatrix.SetRange(Type, PayrollMatrix.Type::Payment);
                PayrollMatrix.SetRange(Code, 'RELIEF');
                PayrollMatrix.SetRange("Payroll Period", DMY2Date(1, 8, 2017));
                if not PayrollMatrix.FindFirst then begin
                    PayrollMatrix.Init;
                    PayrollMatrix."Employee No":=Employee."No.";
                    PayrollMatrix.Type:=PayrollMatrix.Type::Payment;
                    PayrollMatrix."Payroll Period":=DMY2Date(1, 8, 2017);
                    PayrollMatrix.Validate(Code, 'RELIEF');
                    PayrollMatrix.Insert;
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
    var Payroll: Record "Payroll OB";
    PayrollMatrix: Record "Payroll Matrix";
}
