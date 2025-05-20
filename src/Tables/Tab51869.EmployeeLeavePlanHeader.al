table 51869 "Employee Leave Plan Header"
{
    DrillDownPageID = "Emp Leave Plan List-Approved";
    LookupPageID = "Emp Leave Plan List-Approved";

    fields
    {
        field(1; "Employee No"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
            trigger OnValidate()
            begin
                if emp.Get("Employee No") then begin
                    "Employee Name" := Format(emp.Title) + ' ' + emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                    "Date Of Joining Company" := emp."Employment Date";
                    "Department Code" := emp."Global Dimension 1 Code";
                    LeaveTypes.Reset;
                    LeaveTypes.SetRange("Annual Leave", true);
                    LeaveTypes.SetRange(Status, LeaveTypes.Status::Active);
                    if LeaveTypes.Find('-') then "Leave Code" := LeaveTypes.Code;
                end;
                if EmpRec.Get("Employee No") then begin
                    Designation := EmpRec."Job Title";
                    "Contract Type" := EmpRec."Contract Type";
                end;
                VerifyForwarding;
            end;
        }
        field(2; "Employee Name"; Text[40])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Leave Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Leave Setup" where("Annual Leave" = const(true));

            trigger OnValidate()
            begin
            end;
        }
        field(4; "Leave Balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Fiscal Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Department Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Leave Entitlement"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Date Of Joining Company"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Application No"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(16; Status; Enum "Document Status")
        {
            Editable = false;
        }
        field(17; "No. series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Days in Plan"; Decimal)
        {
            CalcFormula = Sum("Employee Leave Plan"."Days Applied" WHERE("Application No" = FIELD("Application No"), "Employee No" = FIELD("Employee No"), "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(19; "Leave Earned to Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Contract Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Designation; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Recalled Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Off Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Total Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "HOD Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Application No", "Maturity Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Application No" = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Leave Plan Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Leave Plan Nos", xRec."No. series", 0D, "Application No", "No. series");
        end;
        "Application Date" := Today;
        Status := Status::Open;
        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
        "User ID" := UserId;
        if not "HOD Created" then begin
            if UserSetup.Get(UserId) then begin
                "Employee No" := UserSetup."Employee No.";
                Validate("Employee No");
            end;
            VerifyForwarding;
        end;
    end;

    var
        MaturityDate: Date;
        FiscalStart: Date;
        UserSetup: Record "User Setup";
        emp: Record Employee;
        LeaveTypes: Record "Leave Setup";
        HumanResSetup: Record "QuantumJumps HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PlanHeader: Record "Employee Leave Plan";
        EmpLeave: Record "Employee Leaves";
        NoofMonthsWorked: Integer;
        Nextmonth: Date;
        EmpRec: Record "Employee Master";

    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
        AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            FiscalStart := AccPeriod."Starting Date";
            MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;
        end;
    end;

    local procedure VerifyForwarding()
    begin
        EmpLeave.Reset();
        EmpLeave.SetRange("Employee No", "Employee No");
        EmpLeave.SetRange("Leave Code", "Leave Code");
        EmpLeave.SetRange("Maturity Date", "Maturity Date");
        if EmpLeave.FindFirst() then begin
            "Leave Entitlement" := EmpLeave.Entitlement;
        end;
        PlanHeader.Reset;
        PlanHeader.SetRange(PlanHeader."Employee No", "Employee No");
        PlanHeader.SetRange(PlanHeader."Leave Code", "Leave Code");
        PlanHeader.SetRange(PlanHeader."Fiscal Start Date", "Fiscal Start Date");
        PlanHeader.SetRange(PlanHeader."Maturity Date", "Maturity Date");
        if PlanHeader.Find('+') then Error('You have already forwarded leave plan for the current year');
    end;
}
