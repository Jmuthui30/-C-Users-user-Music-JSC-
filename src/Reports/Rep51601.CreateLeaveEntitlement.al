report 51601 "Create Leave Entitlement"
{
    // version THL- HRM 1.0
    Caption = 'Create Leave Entitlements';
    ProcessingOnly = true;
    UsageCategory = Tasks;

    dataset
    {
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(StartingDate; FiscalYearStartDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Starting Date';
                    }
                    field(NextMaturityDate; NextMaturityDate)
                    {
                        ApplicationArea = All;
                        Caption = 'Maturity Date';
                    }
                    field(LeaveCode; LeaveCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Code';

                        trigger OnLookup(var Text: Text): Boolean begin
                            LeaveType.Reset;
                            if PAGE.RunModal(Page::"Leave Setup", LeaveType) = ACTION::LookupOK then LeaveCode:=LeaveType.Code;
                        end;
                    }
                    field(EmployeeFilter; EmployeeFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'Employee';
                        TableRelation = Employee;

                        trigger OnLookup(var Text: Text): Boolean begin
                            Emp.Reset;
                            if PAGE.RunModal(PAGE::"Stores Employee List", Emp) = ACTION::LookupOK then begin
                                EmployeeFilter:=Emp."No.";
                                Staff:=Emp."No.";
                            end;
                        end;
                        trigger OnValidate()
                        begin
                            Staff:=EmployeeFilter;
                        end;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            if NoOfPeriods = 0 then begin
                NoOfPeriods:=12;
                Evaluate(PeriodLength, '<1M>');
            end;
            if AccountingPeriod.Find('+')then FiscalYearStartDate:=AccountingPeriod."Starting Date";
        end;
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        Emp.Reset;
        if EmployeeFilter <> '' then Emp.SetRange("No.", EmployeeFilter);
        Emp.SetRange(Emp.Status, Emp.Status::Active);
        if Emp.Find('-')then repeat MaturityDate:=CalcDate('-1Y', NextMaturityDate);
                if EmpleaveCpy.Get(Emp."No.", LeaveCode, MaturityDate)then begin
                    EmpleaveCpy.CalcFields(EmpleaveCpy."Total Days Taken", EmpleaveCpy."Recalled Days", EmpleaveCpy."Days Absent");
                    CarryForwardDays:=EmpleaveCpy.Entitlement + EmpleaveCpy."Balance Brought Forward" + EmpleaveCpy."Recalled Days" - (EmpleaveCpy."Total Days Taken" + EmpleaveCpy."Days Absent");
                    if LeaveTypes.Get(LeaveCode)then begin
                        if CarryForwardDays > LeaveType."Max Carry Forward Days" then begin
                            CarryForwardDays:=LeaveType."Max Carry Forward Days";
                        end;
                    end;
                end;
                Empleave.Init;
                Empleave."Employee No":=Emp."No.";
                Empleave."Leave Code":=LeaveCode;
                Empleave."Maturity Date":=NextMaturityDate;
                if LeaveTypes.Get(LeaveCode)then begin
                    if Emp."Employment Date" > FiscalYearStartDate then Empleave.Entitlement:=Round(((Empleave."Maturity Date" - Emp."Employment Date") / 30 * (LeaveTypes.Days / 12)), 1)
                    else
                        Empleave.Entitlement:=LeaveTypes.Days;
                    Empleave."Balance Brought Forward":=CarryForwardDays;
                end;
                QJHRSetup.Get();
                if Emp."Employee Age" >= QJHRSetup."Threshold Age For Leave Enti" then begin
                    Empleave.Entitlement:=LeaveTypes.Days + QJHRSetup."Threshold Addit. Entitilement";
                end;
                if not Empleave.Get(Empleave."Employee No", Empleave."Leave Code", Empleave."Maturity Date")then Empleave.Insert;
            until Emp.Next = 0;
        Message('Leave Entitlements Created for Leave Type ' + Format(LeaveCode) + ', Maturity Date ' + Format(NextMaturityDate));
    end;
    var Text000: Label 'The new fiscal year begins before an existing fiscal year, so the new year will be closed automatically.\\';
    Text001: Label 'Do you want to create and close the fiscal year?';
    Text002: Label 'Once you create the new fiscal year you cannot change its starting date.\\';
    Text003: Label 'Do you want to create the fiscal year?';
    Text004: Label 'It is only possible to create new fiscal years before or after the existing ones.';
    AccountingPeriod: Record "Accounting Period";
    InvtSetup: Record "Inventory Setup";
    NoOfPeriods: Integer;
    PeriodLength: DateFormula;
    FiscalYearStartDate: Date;
    FiscalYearStartDate2: Date;
    FirstPeriodStartDate: Date;
    LastPeriodStartDate: Date;
    FirstPeriodLocked: Boolean;
    i: Integer;
    Emp: Record Employee;
    MaturityDate: Date;
    NextMaturityDate: Date;
    LeaveCode: Code[30];
    EmpleaveCpy: Record "Employee Leaves";
    CarryForwardDays: Decimal;
    LeaveTypes: Record "Leave Setup";
    Empleave: Record "Employee Leaves";
    LeaveType: Record "Leave Setup";
    CurrentEntitlement: Decimal;
    Staff: Code[20];
    EmployeeFilter: Code[20];
    QJHRSetup: Record "QuantumJumps HR Setup";
    procedure InitializeRequest(NewNoOfPeriods: Integer; NewPeriodLength: DateFormula; StartingDate: Date)
    begin
        NoOfPeriods:=NewNoOfPeriods;
        PeriodLength:=NewPeriodLength;
        if AccountingPeriod.FindLast then FiscalYearStartDate:=AccountingPeriod."Starting Date"
        else
            FiscalYearStartDate:=StartingDate;
    end;
}
