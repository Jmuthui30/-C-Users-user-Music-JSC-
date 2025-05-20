codeunit 51454 "Client Employee Mgt"
{
    // version THL- Client Payroll 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51453 - 51499 = 76
    // Advanced Finance: 52100 - 52199 = 99
    // QuantumJumps HR: 51600 - 51799 = 199
    // QuantumJumps Procumement: 51800 - 51899 = 99
    // ***********************
    // EasyPFA: 51900 - 52099 = 199
    // Investment: 52100 - 52199 = 99
    // DynamicsHMIS: 52200 - 52299 = 99
    // EasyProperty: 52300 - 52399 = 99
    // Insurance: 61423 - 61622 = 199
    // Sacco:   61623 - 62422 = ***
    // ***********************
    trigger OnRun()
    begin
    end;
    var Text000: Label 'Employee %1 has not been mapped to a Manager. Kindly contact HR Department.';
    procedure InsertEmployeeMaster(var Rec: Record Employee; RunTrigger: Boolean)
    var
        EmployeeMaster: Record "Client Employee Master";
        EmployeeMaster2: Record "Client Employee Master";
    begin
        EmployeeMaster.Init;
        EmployeeMaster."No.":=Rec."No.";
        EmployeeMaster."Resource No.":=Rec."Resource No.";
        if not EmployeeMaster2.Get(Rec."No.")then EmployeeMaster.Insert
        else
        begin
            EmployeeMaster2."Resource No.":=Rec."Resource No.";
        end;
    end;
    procedure DeleteEmployeeMaster(var Rec: Record Employee; RunTrigger: Boolean)
    var
        EmployeeMaster: Record "Client Employee Master";
    begin
        if EmployeeMaster.Get(Rec."No.")then EmployeeMaster.Delete;
    end;
    [EventSubscriber(ObjectType::Table, 5200, 'OnAfterModifyEvent', '', false, false)]
    procedure UpdatePayrollEmployee(var Rec: Record Employee; var xRec: Record Employee; RunTrigger: Boolean)
    var
        EmployeeMaster: Record "Client Employee Master";
    begin
        if EmployeeMaster.Get(Rec."No.")then begin
            EmployeeMaster."Resource No.":=Rec."Resource No.";
            EmployeeMaster.Modify;
        end
        else
            InsertEmployeeMaster(Rec, true);
    end;
    [EventSubscriber(ObjectType::Table, 51453, 'UpdateNAVEmployee', '', false, false)]
    procedure UpdateNAVEmployee(var Rec: Record "Client Employee Master")
    var
        NAVEmp: Record Employee;
    begin
        if NAVEmp.Get(Rec."No.")then begin
            NAVEmp.Validate("Manager No.", Rec."Manager No.");
            NAVEmp.Modify;
        end;
    end;
    procedure FindEmployeeManager(var EmpNo: Code[20])ManagerNo: Code[20]var
        NAVEmp: Record Employee;
    begin
        if NAVEmp.Get(EmpNo)then if NAVEmp."Manager No." <> '' then ManagerNo:=NAVEmp."Manager No."
            else
                Error(Text000, NAVEmp."First Name" + ' ' + NAVEmp."Last Name");
        exit(ManagerNo);
    end;
}
