table 51868 "Employee Leave Plan"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = Employee."No.";
        }
        field(2; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;

            trigger OnValidate()
            begin
                PlanHeader.Reset();
                PlanHeader.SetRange("Application No", "Application No");
                if PlanHeader.FindFirst()then begin
                    "Leave Entitlment":=PlanHeader."Leave Entitlement";
                    "Leave Code":=PlanHeader."Leave Code";
                end;
            end;
        }
        field(3; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Setup";
        }
        field(4; "Days Applied"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PlannedDays: Decimal;
            begin
                PlanHeader.Reset();
                PlanHeader.SetRange("Application No", "Application No");
                if PlanHeader.FindFirst()then begin
                    If "Days Applied" < PlanHeader."Leave Entitlement" then begin
                        LeavePlans.Reset();
                        LeavePlans.SetRange("Application No", "Application No");
                        if LeavePlans.FindSet()then begin
                            PlannedDays:=PlannedDays + LeavePlans."Days Applied";
                        end;
                        If PlannedDays > "Leave Entitlment" then Error('You cannot exceed the allocated days');
                    end
                    else
                        Error('You cannot exceed the allocated days');
                end;
            end;
        }
        field(5; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // if xRec.Status <> Status::Open then
                //     Error('You cannot change a document an approved document');
                GeneralOptions.Get;
                NoOfWorkingDays:=0;
                if "Days Applied" <> 0 then begin
                    if "Start Date" <> 0D then begin
                        NextWorkingDate:="Start Date";
                        repeat if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code", NextWorkingDate, Description)then NoOfWorkingDays:=NoOfWorkingDays + 1;
                            if LeaveTypes.Get("Leave Code")then begin
                                if LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.Reset;
                                    BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code");
                                    BaseCalendar.SetRange(BaseCalendar.Date, NextWorkingDate);
                                    BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.Find('-')then begin
                                        NoOfWorkingDays:=NoOfWorkingDays + 1;
                                    // MESSAGE('Holiday =%1 Day of week %2',BaseCalendar.Date,BaseCalendar.Description);
                                    end;
                                end;
                                if LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.Reset;
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 6);
                                    if BaseCalender.Find('-')then begin
                                        NoOfWorkingDays:=NoOfWorkingDays + 1;
                                    // MESSAGE('SATURDAY =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                    end;
                                end;
                                if LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.Reset;
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 7);
                                    if BaseCalender.Find('-')then begin
                                        NoOfWorkingDays:=NoOfWorkingDays + 1;
                                    //  MESSAGE('Sunday =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                    end;
                                end;
                                if LeaveTypes."Off/Holidays Days Leave" then;
                            end;
                            NextWorkingDate:=CalcDate('1D', NextWorkingDate);
                        until NoOfWorkingDays = "Days Applied";
                        "End Date":=NextWorkingDate - 1;
                        "Resumption Date":=NextWorkingDate;
                    end;
                end;
                //New Joining Employees
                if "Date of Joining Company" > "Fiscal Start Date" then begin
                    if "Date of Joining Company" <> 0D then begin
                        NoofMonthsWorked:=0;
                        Nextmonth:="Date of Joining Company";
                        repeat Nextmonth:=CalcDate('1M', Nextmonth);
                            NoofMonthsWorked:=NoofMonthsWorked + 1;
                        until Nextmonth >= "Start Date";
                        NoofMonthsWorked:=NoofMonthsWorked - 1;
                        "No. of Months Worked":=NoofMonthsWorked;
                        if LeaveTypes.Get("Leave Code")then "Leave Earned to Date":=Round(((LeaveTypes.Days / 12) * NoofMonthsWorked), 1);
                        "Leave Entitlment":="Leave Earned to Date";
                        Validate("Leave Code");
                    end;
                end;
            end;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //"Approved To Date":="To Date";
                if xRec.Status <> Status::Open then Error('You cannot change a document an approved document');
                Validate("Start Date");
                Validate("Leave Code");
            end;
        }
        field(7; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Approved Days"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                days:="Approved Days";
            end;
        }
        field(9; "Approved Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Verified By Manager"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Verification Date":=Today;
            end;
        }
        field(11; "Verification Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Leave Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Being Processed,Approved,Rejected,Canceled';
            OptionMembers = "Being Processed", Approved, Rejected, Canceled;
        }
        field(13; "Approved End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Comments; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Taken; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Acrued Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Over used Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Leave Allowance Payable"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Yes, No;

            trigger OnValidate()
            begin
                HumanResSetup.Get;
                if "Leave Allowance Payable" = "Leave Allowance Payable"::Yes then if "Days Applied" < HumanResSetup."Qualification Days (Leave)" then Error('You can only be paid leave allowance if you take more or %1 Days', HumanResSetup."Qualification Days (Leave)");
            end;
        }
        field(20; Post; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(21; days; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(23; "No. series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Leave balance"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Resumption Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(28; "Leave Entitlment"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Total Leave Days Taken"; Decimal)
        {
            CalcFormula = Sum("Employee Leave Application"."Days Applied" WHERE(Status=CONST(Released), "Employee No"=FIELD("Employee No"), "Leave Code"=FIELD("Leave Code"), "Maturity Date"=FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(30; "Duties Taken Over By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then Error('You cannot change a document an approved document');
                if emp.Get("Duties Taken Over By")then Name:=EmpRec."First Name" + '' + EmpRec."Middle Name" + '' + EmpRec."Last Name";
            end;
        }
        field(31; Name; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Mobile No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Balance brought forward"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Leave Earned to Date"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Maturity Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Date of Joining Company"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Fiscal Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "No. of Months Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Annual Leave Entitlement Bal"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Recalled Days"; Decimal)
        {
            CalcFormula = Sum("Employee Off/Holidays"."No. of Off Days" WHERE("Employee No"=FIELD("Employee No"), "Maturity Date"=FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(41; "Off Days"; Decimal)
        {
            CalcFormula = Sum("Holidays_Off Days"."No. of Days" WHERE("Employee No."=FIELD("Employee No"), "Leave Type"=FIELD("Leave Code"), "Maturity Date"=FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(42; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(43; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Application No", "Employee No", "Line No")
        {
            SumIndexFields = days;
        }
        key(Key2; "Employee No", Status, "Leave Code", "Maturity Date")
        {
            SumIndexFields = "Days Applied", "Approved Days";
        }
        key(Key3; "Employee No", "Application No", "Maturity Date")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Post = true then Error('You cannot Rename the Record');
    end;
    trigger OnInsert()
    begin
        Status:=Status::Open;
        "Application Date":=Today;
        FindMaturityDate;
        "Maturity Date":=MaturityDate;
        "Fiscal Start Date":=FiscalStart;
    end;
    trigger OnRename()
    begin
        if Post = true then Error('You cannot Rename the Record');
    end;
    var "Employee Leaves": Record "Employee Leaves";
    LeavePlans: Record "Employee Leave Plan";
    PlanHeader: Record "Employee Leave Plan Header";
    BaseCalender: Record Date;
    CurDate: Date;
    LeaveTypes: Record "Leave Setup";
    DayApp: Decimal;
    Dayofweek: Integer;
    i: Integer;
    textholder: Text[30];
    emp: Record "Employee Master";
    leaveapp: Record "Employee Leave Plan";
    GeneralOptions: Record "Company Information";
    NoOfDays: Integer;
    BaseCalendar: Record "Base Calendar Change";
    yearend: Date;
    d: Date;
    d2: Integer;
    d3: Integer;
    d4: Integer;
    d1: Integer;
    HumanResSetup: Record "QuantumJumps HR Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    earn: Record Earnings;
    assmatrix: Record "Payroll Matrix";
    ecode: Code[10];
    ldated: Date;
    UserSertup: Record "User Setup";
    CalendarMgmt: Codeunit "AL Calendar Management";
    NextWorkingDate: Date;
    Description: Text[30];
    NoOfWorkingDays: Integer;
    LeaveAllowancePaid: Boolean;
    PayrollPeriod: Record "Payroll Period";
    PayPeriodStart: Date;
    EmpRec: Record Employee;
    MaturityDate: Date;
    EmpLeave: Record "Employee Leaves";
    NoofMonthsWorked: Integer;
    FiscalStart: Date;
    Nextmonth: Date;
    DimVal: Record "Dimension Value";
    QuantumJumpsUserSetup: Record "User Setup";
    procedure CreateLeaveAllowance(var LeaveApp: Record "Employee Leave Application")
    var
        HRSetup: Record "QuantumJumps HR Setup";
        AccPeriod: Record "Payroll Period";
        FiscalStart: Date;
        FiscalEnd: Date;
        ScaleBenefits: Record "Scale Benefits";
    begin
        if LeaveApp."Leave Allowance Payable" = LeaveApp."Leave Allowance Payable"::Yes then begin
            AccPeriod.Reset;
            AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
            AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
            if AccPeriod.Find('+')then FiscalStart:=AccPeriod."Starting Date";
            //MESSAGE('%1',FiscalStart);
            FiscalEnd:=CalcDate('1Y', FiscalStart) - 1;
            //MESSAGE('%1',FiscalEnd);
            assmatrix.Reset;
            assmatrix.SetRange(assmatrix."Payroll Period", FiscalStart, FiscalEnd);
            assmatrix.SetRange(assmatrix.Type, assmatrix.Type::Payment);
            assmatrix.SetRange(assmatrix.Code, HRSetup."Leave Allowance Code");
            if assmatrix.Find('-')then begin
                LeaveAllowancePaid:=true;
                Message('Leave allowance paid on %1', assmatrix."Payroll Period");
            end;
            if not LeaveAllowancePaid then begin
                if HRSetup.Get then begin
                    if "Days Applied" >= HRSetup."Qualification Days (Leave)" then begin
                        if emp.Get("Employee No")then begin
                            ScaleBenefits.Reset;
                            ScaleBenefits.SetRange(ScaleBenefits.Scale, emp.Scale);
                            ScaleBenefits.SetRange(ScaleBenefits.Level, emp.Level);
                            ScaleBenefits.SetRange(ScaleBenefits.Earning, HRSetup."Leave Allowance Code");
                            if ScaleBenefits.Find('-')then begin
                                PayrollPeriod.Reset;
                                PayrollPeriod.SetRange(PayrollPeriod."Close Pay", false);
                                if PayrollPeriod.Find('-')then PayPeriodStart:=PayrollPeriod."Starting Date";
                                assmatrix.Init;
                                assmatrix."Employee No":="Employee No";
                                assmatrix.Type:=assmatrix.Type::Payment;
                                assmatrix.Code:=HRSetup."Leave Allowance Code";
                                assmatrix.Validate(assmatrix.Code);
                                assmatrix."Payroll Period":=PayPeriodStart;
                                assmatrix.Amount:=ScaleBenefits.Amount;
                                if not assmatrix.Get(assmatrix."Employee No", assmatrix.Type, assmatrix.Code, assmatrix."Payroll Period")then assmatrix.Insert;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;
    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
        AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
        if AccPeriod.Find('+')then begin
            FiscalStart:=AccPeriod."Starting Date";
            MaturityDate:=CalcDate('1Y', AccPeriod."Starting Date") - 1;
        end;
    end;
}
