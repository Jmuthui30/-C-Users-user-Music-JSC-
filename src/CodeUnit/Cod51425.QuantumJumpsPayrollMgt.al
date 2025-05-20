codeunit 51425 "QuantumJumps Payroll Mgt"
{
    // version THL- Payroll 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
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
    var EmployeeMaster: Record "Employee Master";
    Window: Dialog;
    Names: Text;
    [EventSubscriber(ObjectType::Table, 51424, 'OnActivatePayroll', '', false, false)]
    procedure SyncEmployeeMaster()
    var
        Employee: Record Employee;
        EmployeeMaster2: Record "Employee Master";
    begin
        Window.Open('Synchronizing Employee Master Data for #####1', Names);
        Employee.Reset;
        if Employee.Find('-')then begin
            repeat Window.Update(1, Employee.FullName);
                EmployeeMaster.Init;
                EmployeeMaster."No.":=Employee."No.";
                if not EmployeeMaster2.Get(Employee."No.")then EmployeeMaster.Insert;
            until Employee.Next = 0;
        end;
        Window.Close;
    end;
}
