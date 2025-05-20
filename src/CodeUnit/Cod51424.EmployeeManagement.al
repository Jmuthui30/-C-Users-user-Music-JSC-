codeunit 51424 "Employee Management"
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
    var Text000: Label 'Employee %1 has not been mapped to a Manager. Kindly contact HR Department.';
    [EventSubscriber(ObjectType::Table, 5200, 'OnAfterInsertEvent', '', false, false)]
    procedure InsertEmployeeMaster(var Rec: Record Employee; RunTrigger: Boolean)
    var
        EmployeeMaster: Record "Employee Master";
        EmployeeMaster2: Record "Employee Master";
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
    [EventSubscriber(ObjectType::Table, 5200, 'OnAfterDeleteEvent', '', false, false)]
    procedure DeleteEmployeeMaster(var Rec: Record Employee; RunTrigger: Boolean)
    var
        EmployeeMaster: Record "Employee Master";
    begin
        if EmployeeMaster.Get(Rec."No.")then EmployeeMaster.Delete;
    end;
    [EventSubscriber(ObjectType::Table, 5200, 'OnAfterModifyEvent', '', false, false)]
    procedure UpdatePayrollEmployee(var Rec: Record Employee; var xRec: Record Employee; RunTrigger: Boolean)
    var
        EmployeeMaster: Record "Employee Master";
    begin
        if EmployeeMaster.Get(Rec."No.")then begin
            EmployeeMaster."Resource No.":=Rec."Resource No.";
            EmployeeMaster.Modify;
        end
        else
            InsertEmployeeMaster(Rec, true);
    end;
    [EventSubscriber(ObjectType::Table, 51423, 'UpdateNAVEmployee', '', false, false)]
    procedure UpdateNAVEmployee(var Rec: Record "Employee Master")
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
    procedure ApproveRedeployment(var Redeployment: Record Redeployment)
    var
        Redep: Record Redeployment;
    begin
        if Redep.Get(Redeployment."No.")then begin
            Redep.TestField("To Dimension 1 Code");
            Redep.TestField("To Dimension 2 Code");
            Redep.TestField("To Establishment");
            Redep.TestField("Old Line Manager");
            Redep.TestField("New Line Manager");
            Redep.Status:=Redep.Status::Approved;
            Redep.Select:=false;
            Redep."Selected By":='';
            Redep."Date Approved":=CurrentDateTime;
            Redep.Modify();
        end;
    end;
    procedure NotifyOldLineManager(var Redeployment: Record Redeployment)
    var
        Redep: Record Redeployment;
    begin
        if Redep.Get(Redeployment."No.")then begin
            Redep.Status:=Redep.Status::"Old Line Manager Notified";
            Redep.Select:=false;
            Redep."Selected By":='';
            Redep."Date Old Line Manager Notified":=CurrentDateTime;
            Redep.Modify();
        end;
    end;
    procedure NotifyNewLineManager(var Redeployment: Record Redeployment)
    var
        Redep: Record Redeployment;
    begin
        if Redep.Get(Redeployment."No.")then begin
            Redep.Status:=Redep.Status::"New Line Manager Notified";
            Redep.Select:=false;
            Redep."Selected By":='';
            Redep."Date New Line Manager Notified":=CurrentDateTime;
            Redep.Modify();
        end;
    end;
    procedure SendRedeploymentLetter(var Redeployment: Record Redeployment)
    var
        Redep: Record Redeployment;
    begin
        if Redep.Get(Redeployment."No.")then begin
            Redep.Status:=Redep.Status::"Redeployment Letter Sent";
            Redep.Select:=false;
            Redep."Selected By":='';
            Redep."Date Redeployment Letter Sent":=CurrentDateTime;
            Redep.Modify();
        end;
    end;
    procedure CompleteRedeployment(var Redeployment: Record Redeployment)
    var
        Redep: Record Redeployment;
        Emp: Record "Employee Master";
        BCEmp: Record Employee;
    begin
        if Redep.Get(Redeployment."No.")then begin
            //Update Employee Records
            if BCEmp.Get(Redep."Employee No")then begin
                BCEmp."Global Dimension 1 Code":=Redep."To Dimension 1 Code";
                BCEmp."Global Dimension 2 Code":=Redep."To Dimension 2 Code";
                BCEmp."Job Id":=Redep."To Establishment";
                BCEmp."Job Title":=Redep."To Title";
                BCEmp.validate("Global Dimension 1 Code");
                BCEmp.validate("Global Dimension 2 Code");
                BCEmp.validate("Job Id");
                BCEmp.Modify();
            end;
            if Emp.Get(Redep."Employee No")then begin
                Emp."Global Dimension 1 Code":=Redep."To Dimension 1 Code";
                Emp."Global Dimension 2 Code":=Redep."To Dimension 2 Code";
                Emp."Job ID":=Redep."To Establishment";
                Emp."Job Title":=Redep."To Title";
                Emp.validate("Global Dimension 1 Code");
                Emp.validate("Global Dimension 2 Code");
                Emp.validate("Job ID");
                if Redep."To Grade" <> Emp.Scale then Emp.Scale:=Redep."To Grade";
                if Redep."To Level" <> Emp.Level then Emp.Level:=Redep."To Level";
                Emp.validate(Level);
                Emp.Modify();
            end;
            //
            Redep.Status:=Redep.Status::"Redeployment Completed";
            Redep.Select:=false;
            Redep."Selected By":='';
            Redep."Date Redeployment Completed":=CurrentDateTime;
            Redep.Modify();
        end;
    end;
    procedure StepDown(var Redeployment: Record Redeployment)
    var
        Redep: Record Redeployment;
    begin
        if Redep.Get(Redeployment."No.")then begin
            Redep.Status:=Redep.Status::"Stepped Down";
            Redep.Select:=false;
            Redep."Selected By":='';
            Redep.Modify();
        end;
    end;
    procedure Reactivate(var Redeployment: Record Redeployment)
    var
        Redep: Record Redeployment;
    begin
        if Redep.Get(Redeployment."No.")then begin
            Redep.Status:=Redep.Status::New;
            Redep.Select:=false;
            Redep."Selected By":='';
            Redep."Created Date":=Today;
            Redep."Created By":=UserId;
            Redep.Modify();
        end;
    end;
}
