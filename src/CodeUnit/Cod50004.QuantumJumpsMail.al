codeunit 50004 "QuantumJumps Mail"
{
    // version THL
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
    // *********************************************
    trigger OnRun()
    begin
    //Mail.NewMessage('henry.ngari@teknohub.systems','','','Hi','We are Testing','',FALSE);
    end;
    var Mail: Codeunit 397;
    procedure NewIncidentMail(ToName: Text[80]; ToSubject: Text[80]; ToBody: Text[500]): Boolean begin
        ; //Mail.NewMessage(ToName, '', '', ToSubject, ToBody, '', false);
    end;
}
