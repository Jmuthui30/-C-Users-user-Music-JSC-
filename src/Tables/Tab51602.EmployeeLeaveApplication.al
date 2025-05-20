table 51602 "Employee Leave Application"
{
    // version THL- HRM 1.0
    DataCaptionFields = "Application No", Name, "Leave Code";
    DrillDownPageID = "All Emp Leave Applications";
    LookupPageID = "All Emp Leave Applications";

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Rec.Validate("Leave Code");
                if NAVemp.Get("Employee No") then begin
                    Name := Format(NAVemp.Title) + ' ' + NAVemp."First Name" + ' ' + NAVemp."Middle Name" + ' ' + NAVemp."Last Name";
                    NAVemp.TestField("Employment Date");
                    // NAVemp.TestField("Mobile Phone No.");
                    //  Message('empl date is %1', NAVemp."Employment Date");
                    "Date of Joining Company" := NAVemp."Employment Date";
                    "Mobile No" := NAVemp."Mobile Phone No.";
                    Gender := NAVemp.Gender;
                    "Leave Plan" := LeavePlanHeader."Application No";
                    // Message('emp is %1', LeavePlanHeader."Employee No");
                end;
                CheckLeavePlan;
                if EmpRec.Get("Employee No") then begin
                    "Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                    "Global Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
                end;
            end;
        }
        field(2; "Application No"; Code[20])
        {
            NotBlank = false;

            trigger OnValidate()
            begin
                "Application Date" := Today;
                if "Application No" <> xRec."Application No" then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Leave Application Nos");
                    "No. series" := '';
                end;
            end;
        }
        field(3; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Setup" where(Status = const(Active));

            trigger OnValidate()
            var
                HRLeaveTypes: Record "Leave Setup";
                HREmp: Record Employee;
            begin
                Rec.Reset();
                Validate(Gender);
                //if xRec.Status <> Status::Open then Error('You cannot change an already approved document');
                HRLeaveTypes.RESET;
                HRLeaveTypes.SETRANGE(HRLeaveTypes.Code, Rec."Leave Code");
                if HRLeaveTypes.Find('-') then begin
                    HREmp.RESET;
                    HREmp.SETRANGE(HREmp."No.", "Employee No");
                    HREmp.SETRANGE(HREmp.Gender, Gender);
                    HREmp.SETRANGE(HREmp.Gender, HRLeaveTypes.Gender);
                    if HREmp.Find('-') then
                        exit
                    else if HRLeaveTypes.Gender <> HRLeaveTypes.Gender::Both then begin
                        // if ((HRLeaveTypes.Gender = HRLeaveTypes.Gender::Female) and (HREmp.Gender = HREmp.Gender::Male)) or ((HRLeaveTypes.Gender = HRLeaveTypes.Gender::Male) and (HREmp.Gender = HREmp.Gender::Female)) then
                        if (HREmp.Gender::Male = HRLeaveTypes.Gender::Female) or (HREmp.Gender::Female = HRLeaveTypes.Gender::Male) then // if (HREmp.Gender::Female <> HRLeaveTypes.Gender::Female) and HRLeaveTypes."Annual Leave" <> false //or (HREmp.Gender = HRLeaveTypes.Gender::Male) 
                            ERROR('This leave type is restricted to the ' + FORMAT(HRLeaveTypes.Gender) + ' gender');
                    end;
                    // Message('gender is%1', HREmp.Gender);
                end;
                // Checking Leave Plan
                //Message('mjk is %1', "Employee No");

                LeavePlanHeader.Reset;
                LeavePlanHeader.SetRange(LeavePlanHeader."Employee No", "Employee No");
                //  if Rec.Get("Employee No") then begin
                if LeavePlanHeader.Find('-') then begin
                    // 
                    if Rec.Find('=') then begin
                        Message('Emp1 no is %1', Rec."Employee No");
                    end
                    else begin
                        Message('Emp no is %1', LeavePlanHeader."Employee No");
                    end;
                end;
                FindMaturityDate;
                if NAVemp.Get("Employee No") then begin
                    if LeaveTypes.Get("Leave Code") then begin
                        if LeaveTypes."Annual Leave" = false then begin
                            // Message('mjk1');
                            if LeaveTypes.Gender::Female <> NAVemp.Gender::Male then begin
                                //      Message('mjk2');
                                //if NAVemp.Gender = NAVemp.Gender::Male then
                                Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
                            end;
                            /*if LeaveTypes.Gender = LeaveTypes.Gender::Male then begin
                                if NAVemp.Gender = NAVemp.Gender::Female then
                                    Error('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
                            end;*/
                            "Leave Entitlment" := LeaveTypes.Days;
                            AdvanceDays := LeaveTypes."Advance Notice(Days)";
                        end
                        else if LeaveTypes."Annual Leave" = true then begin
                            emp.Reset;
                            if emp.Get("Employee No") then begin
                                if LeaveTypes."Eligible Staff" = LeaveTypes."Eligible Staff"::Permanent then begin
                                    EmployeePosting.Reset;
                                    if EmployeePosting.Find('-') then begin
                                        if (EmployeePosting.Permanent = false) and (EmployeePosting.Secondment = false) then begin
                                            if (emp."Employee Group" = EmployeePosting.Code) then Error('%1 can only be assigned to Permanent members of staff', LeaveTypes.Description);
                                        end;
                                    end;
                                end;

                                if ("Date of Joining Company" <> 0D) and ("Date of Joining Company" > "Fiscal Start Date") then begin


                                    NoofMonthsWorked := 0;
                                    Nextmonth := "Date of Joining Company";
                                    repeat
                                        Nextmonth := CalcDate('1M', Nextmonth);
                                        NoofMonthsWorked := "Application Date" - "Date of Joining Company";
                                    until Nextmonth >= "Maturity Date";
                                    NoofMonthsWorked := NoofMonthsWorked - 1;
                                    "No. of Months Worked" := NoofMonthsWorked;
                                    if LeaveTypes.Get("Leave Code") then
                                        if LeaveTypes."Annual Leave" then begin
                                            "Leave Earned to Date" := Round((NoofMonthsWorked / 30 * 2.5), 0.5);
                                        end;

                                    Message('"Leave Entitlment"; no is %1', "Leave Entitlment");


                                    FindMaturityDate;
                                    "Leave Entitlment" := ("Maturity Date" - "Date of Joining Company") / 30 * 2.5;
                                    AdvanceDays := LeaveTypes."Advance Notice(Days)";
                                    EmpLeave.Reset;
                                    EmpLeave."Leave Code" := "Leave Code";
                                    EmpLeave."Maturity Date" := "Maturity Date";
                                    EmpLeave."Employee No" := "Employee No";
                                    EmpLeave.Entitlement := "Leave Entitlment";
                                    Gender := Gender;
                                    // EmpLeave.Balance:="Leave balance";
                                    // EmpLeave."Balance Brought Forward";
                                    if not EmpLeave.Get("Employee No", "Leave Code", "Maturity Date", Gender) then EmpLeave.Insert;
                                end;

                                if ("Date of Joining Company" <> 0D) and ("Date of Joining Company" <= "Fiscal Start Date") then //"Leave Earned to Date"=0
                                      begin

                                    if LeaveTypes."Eligible Staff" = LeaveTypes."Eligible Staff"::Permanent then begin
                                        EmpLeave.Reset;
                                        //Message('Date of Joining Company is %1', "Date of Joining Company");
                                        Message('mjk12');
                                        if EmpLeave.Get("Employee No", "Leave Code", "Maturity Date") then begin
                                            if LeaveTypes."Annual Leave" then begin
                                                "Leave Earned to Date" := Round((("Application Date" - "Fiscal Start Date") / 30 * (LeaveTypes.Days / 12)), 0.5);
                                            end;
                                            Message('mjk1');
                                            "Leave Entitlment" := LeaveTypes.Days;
                                            "Leave balance" := EmpLeave.Balance;
                                            AdvanceDays := LeaveTypes."Advance Notice(Days)";
                                            "Balance brought forward" := EmpLeave."Balance Brought Forward";
                                        end;
                                    end
                                    else if LeaveTypes."Eligible Staff" = LeaveTypes."Eligible Staff"::"Temporary" then begin
                                        "Leave Earned to Date" := Round((("Application Date" - "Fiscal Start Date") / 30 * (LeaveTypes.Days / 12)), 0.5);
                                        "Leave Entitlment" := LeaveTypes.Days;
                                    end;
                                    //+EmpLeave."Balance Brought Forward"
                                end
                                else if "Leave Earned to Date" <> 0 then begin
                                    FindMaturityDate;
                                    //"Leave Entitlment":=LeaveTypes.Days;
                                    //"Leave Entitlment" := ("Start Date"-EmployeeRec."Employment Date")/*2.5;
                                    "Leave Entitlment" := Round((("Maturity Date" - "Date of Joining Company") / 30 * (LeaveTypes.Days / 12)), 1);
                                    AdvanceDays := LeaveTypes."Advance Notice(Days)";
                                end;
                            end;
                        end;
                    end;
                    if LeaveTypes."Annual Leave" then begin
                        CalcFields("Total Leave Days Taken", "Recalled Days", "Off Days");
                        "Leave balance" := ("Leave Entitlment" + "Balance brought forward" + "Recalled Days" + "Off Days") - ("Total Leave Days Taken" + "Days Absent");
                    end
                    else begin
                        CalcFields("Total Leave Days Taken", "Recalled Days", "Off Days");
                        "Leave balance" := ("Leave Entitlment" + "Off Days") - ("Total Leave Days Taken" + "Days Absent");
                    end;
                    "Date of Joining Company" := NAVemp."Employment Date";
                end;
            end;
        }
        field(4; "Days Applied"; Decimal)
        {
            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then Error('You cannot change an already approved document');
                if PowerApps = true then Validate("Leave Code");
                "Annual Leave Entitlement Bal" := "Leave balance" - "Days Applied";
                if LeaveTypes.Get("Leave Code") then begin
                    if LeaveTypes."Reserved Days" <> 0 then begin
                        if ("Leave balance" < LeaveTypes."Reserved Days") or ("Leave balance" = LeaveTypes."Reserved Days") then Error('You have exhasted the leave days you can take because %1 days are reserved.', LeaveTypes."Reserved Days");
                        if "Leave balance" - "Days Absent" < LeaveTypes."Reserved Days" then Error('You can only take %1 days because %2 days are reserved.', "Leave balance" - LeaveTypes."Reserved Days", LeaveTypes."Reserved Days");
                    end;
                end;
                if "Start Date" <> 0D then Validate("Start Date");
            end;
        }
        field(5; "Start Date"; Date)
        {
            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then Error('You cannot change an already approved document');
                if ((EmpRec."Global Dimension 1 Code" = '00101') OR (EmpRec."Global Dimension 1 Code" = '00105')) then
                    CCBaseCalendar := true
                else
                    CCBaseCalendar := false;
                FullDays := Round("Days Applied", 1, '<');
                HalfDays := "Days Applied" - FullDays;
                //Check Notice Days
                if LeaveTypes.Get("Leave Code") then begin
                    if LeaveTypes."Advance Notice(Days)" > 0 then begin
                        if CalcDate(Format(LeaveTypes."Advance Notice(Days)") + 'D', "Application Date") > "Start Date" then Error('You must give atleast %1 days notice before the start of your leave!. The earliest day you can start your leave is %2', LeaveTypes."Advance Notice(Days)", CalcDate(Format(LeaveTypes."Advance Notice(Days)") + 'D', "Application Date"));
                    end;
                end;
                //
                "Resumption Date" := "Start Date";
                GeneralOptions.Get;
                GeneralOptions.Get;
                NoOfWorkingDays := 0;
                if ("Days Applied" <> 0) and ("Days Applied" >= 1) then begin
                    if "Start Date" <> 0D then begin
                        // IF "Days Applied" = FullDays THEN BEGIN
                        NextWorkingDate := "Start Date";
                        repeat
                            if CCBaseCalendar = false then begin
                                if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code", NextWorkingDate, Description) then NoOfWorkingDays := NoOfWorkingDays + 1;
                            end
                            else if CCBaseCalendar = true then begin
                                if not CalendarMgmt.CheckDateStatus(GeneralOptions."CC Base Calendar Code", NextWorkingDate, Description) then NoOfWorkingDays := NoOfWorkingDays + 1;
                            end;
                            if LeaveTypes.Get("Leave Code") then begin
                                if LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.Reset;
                                    if CCBaseCalendar = false then
                                        BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code")
                                    else
                                        BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", GeneralOptions."CC Base Calendar Code");
                                    BaseCalendar.SetRange(BaseCalendar.Date, NextWorkingDate);
                                    BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.Find('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                        // MESSAGE('Holiday =%1 Day of week %2',BaseCalendar.Date,BaseCalendar.Description);
                                    end;
                                end;
                                if LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.Reset;
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 6);
                                    if BaseCalender.Find('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                        // MESSAGE('SATURDAY =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                    end;
                                end;
                                if LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.Reset;
                                    BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SetRange(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SetRange(BaseCalender."Period No.", 7);
                                    if BaseCalender.Find('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                        //  MESSAGE('Sunday =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                    end;
                                end;
                                if LeaveTypes."Off/Holidays Days Leave" then;
                            end;
                            NextWorkingDate := CalcDate('1D', NextWorkingDate);
                        until NoOfWorkingDays = FullDays;
                        "End Date" := NextWorkingDate - 1;
                        "Resumption Date" := NextWorkingDate;
                        // END;
                    end;
                end
                else if ("Days Applied" <> 0) and ("Days Applied" < 1) then begin
                    "End Date" := "Start Date";
                    "Resumption Date" := "Start Date";
                end;
                //serem
                //check if the date that the person is supposed to report back is a working day or not
                //get base calendar to use
                HumanResSetup.Reset();
                HumanResSetup.Get();
                HumanResSetup.TestField(HumanResSetup."Base Calendar Code");
                HumanResSetup.TestField(HumanResSetup."CC Base Calendar Code");
                NonWorkingDay := false;
                if "Start Date" <> 0D then begin
                    while NonWorkingDay = false do begin
                        if CCBaseCalendar = false then
                            NonWorkingDay := CalendarMgmt.CheckDateStatus(HumanResSetup."Base Calendar Code", "Resumption Date", Dsptn)
                        else
                            NonWorkingDay := CalendarMgmt.CheckDateStatus(HumanResSetup."CC Base Calendar Code", "Resumption Date", Dsptn);
                        if NonWorkingDay then begin
                            NonWorkingDay := false;
                            "Resumption Date" := CalcDate('1D', "Resumption Date");
                        end
                        else begin
                            NonWorkingDay := true;
                        end;
                    end;
                end;
                LeaveTypes.Get("Leave Code");
                if LeaveTypes."Annual Leave" = true then begin
                    //New Joining Employees
                    if emp.Get("Employee No") then begin
                        //IF (emp."Employee Group"='PERMANENT') OR (emp."Employee Group"='DG')
                        // AND (emp."Employment Date">"Fiscal Start Date")
                        // THEN BEGIN
                        if ("Date of Joining Company" > "Fiscal Start Date") then begin
                            if "Date of Joining Company" <> 0D then begin
                                NoofMonthsWorked := 0;
                                Nextmonth := "Date of Joining Company";
                                repeat
                                    Nextmonth := CalcDate('1M', Nextmonth);
                                    NoofMonthsWorked := NoofMonthsWorked + 1;
                                until Nextmonth >= "Start Date";
                                NoofMonthsWorked := NoofMonthsWorked - 1;
                                "No. of Months Worked" := NoofMonthsWorked;
                                if LeaveTypes.Get("Leave Code") then "Leave Earned to Date" := Round(((LeaveTypes.Days / 12) * NoofMonthsWorked), 1);
                                //"Leave Entitlment":="Leave Earned to Date";
                                Validate("Leave Code");
                            end;
                        end;
                        //END;
                    end;
                end;
                HumanResSetup.Reset();
                HumanResSetup.Get();
                HumanResSetup.TestField(HumanResSetup."Base Calendar Code");
                HumanResSetup.TestField(HumanResSetup."CC Base Calendar Code");
                NonWorkingDay := false;
                if "Start Date" <> 0D then begin
                    while NonWorkingDay = false do begin
                        if CCBaseCalendar = false then
                            NonWorkingDay := CalendarMgmt.CheckDateStatus(HumanResSetup."Base Calendar Code", "End Date", Dsptn)
                        else
                            NonWorkingDay := CalendarMgmt.CheckDateStatus(HumanResSetup."CC Base Calendar Code", "Resumption Date", Dsptn);
                        if NonWorkingDay then begin
                            NonWorkingDay := false;
                            "Resumption Date" := CalcDate('1D', "Resumption Date");
                            "End Date" := CalcDate('1D', "End Date");
                        end
                        else begin
                            NonWorkingDay := true;
                        end;
                    end;
                end;
                BeginDate := 0D;
                LeaveTypes.Reset;
                LeaveTypes.Init;
                if LeaveTypes.Get("Leave Code") then begin
                    TodaysDate := Today;
                    BeginDate := TodaysDate + LeaveTypes."Advance Notice(Days)";
                    //MESSAGE(FORMAT("Start Date"));
                    AdvanceDays := LeaveTypes."Advance Notice(Days)";
                    //MESSAGE(FORMAT(AdvanceDays));
                    if "Start Date" < BeginDate then Error('You can only be allowed to apply for leave after ' + Format(LeaveTypes."Advance Notice(Days)") + ' days');
                end;
            end;
        }
        field(6; "End Date"; Date)
        {
            trigger OnValidate()
            begin
                //"Approved To Date":="To Date";
                if xRec.Status <> Status::Open then Error('You cannot change an approved document');
                if "Start Date" <> 0D then Validate("Start Date");
                Validate("Leave Code");
            end;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(8; "Approved Days"; Decimal)
        {
            trigger OnValidate()
            begin
                days := "Approved Days";
            end;
        }
        field(9; "Approved Start Date"; Date)
        {
        }
        field(10; "Verified By Manager"; Boolean)
        {
            trigger OnValidate()
            begin
                "Verification Date" := Today;
            end;
        }
        field(11; "Verification Date"; Date)
        {
        }
        field(12; "Leave Status"; Option)
        {
            OptionCaption = 'Being Processed,Approved,Rejected,Canceled';
            OptionMembers = "Being Processed",Approved,Rejected,Canceled;

            trigger OnValidate()
            begin
                if ("Leave Status" = "Leave Status"::Approved) and (xRec."Leave Status" <> "Leave Status"::Approved) then begin
                    ;
                    "Approval Date" := Today;
                    "Approved Days" := xRec."Days Applied";
                    //MODIFY;
                    LeaveTypes.Get("Leave Code");
                    if LeaveTypes."Annual Leave" = true then begin
                        "Employee Leaves".Reset;
                        "Employee Leaves".SetRange("Employee Leaves"."Employee No", "Employee No");
                        "Employee Leaves".SetRange("Employee Leaves"."Leave Code", "Leave Code");
                        if "Employee Leaves".Find('-') then begin
                            "Employee Leaves".Balance := "Employee Leaves".Balance - "Approved Days";
                            "Employee Leaves".Modify;
                        end;
                    end
                    else if ("Leave Status" <> "Leave Status"::Approved) and (xRec."Leave Status" = "Leave Status"::Approved) then begin
                        "Approval Date" := Today;
                        //"Approved Days" := 0;
                        "Employee Leaves".Reset;
                        "Employee Leaves".SetRange("Employee Leaves"."Employee No", "Employee No");
                        "Employee Leaves".SetRange("Employee Leaves"."Leave Code", "Leave Code");
                        if "Employee Leaves".Find('-') then;
                        "Employee Leaves".Balance := "Employee Leaves".Balance + "Approved Days";
                        "Employee Leaves".Validate("Employee Leaves".Balance);
                        "Employee Leaves".Modify;
                    end;
                end;
            end;
        }
        field(13; "Approved End Date"; Date)
        {
        }
        field(14; "Approval Date"; Date)
        {
        }
        field(15; Comments; Text[250])
        {
        }
        field(16; Taken; Boolean)
        {
        }
        field(17; "Acrued Days"; Decimal)
        {
        }
        field(18; "Over used Days"; Decimal)
        {
        }
        field(19; "Leave Allowance Payable"; Option)
        {
            OptionMembers = " ",Yes,No;

            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then Error('You cannot edit the document. Kindly reject for the originator to correct');
                HumanResSetup.Get;
                if "Leave Allowance Payable" = "Leave Allowance Payable"::Yes then begin
                    //Check if not Annual Leave
                    if LeaveTypes.Get("Leave Code") then if (not LeaveTypes."Annual Leave") and ("Leave Code" <> 'MATERNITY') then Error('Leave Allowance is only Payable on Annual Leave or Maternity Leave.');
                    if emp.Get("Employee No") then // BEGIN
                        if (emp."Employee Group" = 'CONTRACT') or (emp."Employee Group" = 'INTERN') then Error('Temporary Employees are not paid leave allowance');
                    leaveapp.Reset;
                    leaveapp.SetRange(leaveapp."Employee No", "Employee No");
                    leaveapp.SetRange(leaveapp."Maturity Date", "Maturity Date");
                    leaveapp.SetRange(leaveapp.Status, leaveapp.Status::Released);
                    leaveapp.SetRange(leaveapp."Leave Allowance Payable", leaveapp."Leave Allowance Payable"::Yes);
                    if leaveapp.Find('-') then Error('Leave allowance has already been paid in leave application %1. Please contact FINCON if your account has not been credited.', leaveapp."Application No");
                    AccPeriod.Reset;
                    AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
                    AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
                    if AccPeriod.Find('+') then FiscalStart := AccPeriod."Starting Date";
                    // MESSAGE('YEAR START %1',FiscalStart);
                    FiscalEnd := CalcDate('1Y', FiscalStart) - 1;
                    //  MESSAGE('YEAR END%1',FiscalEnd);
                    assmatrix.Reset;
                    assmatrix.SetRange(assmatrix."Payroll Period", FiscalStart, FiscalEnd);
                    assmatrix.SetRange(assmatrix."Employee No", leaveapp."Employee No");
                    assmatrix.SetRange(assmatrix.Type, assmatrix.Type::Payment);
                    assmatrix.SetRange(assmatrix.Code, HumanResSetup."Leave Allowance Code");
                    if assmatrix.Find('-') then begin
                        LeaveAllowancePaid := true;
                        Error('Leave allowance has already been paid in %1', assmatrix."Payroll Period");
                    end;
                    if "Days Applied" < HumanResSetup."Qualification Days (Leave)" then Error('You can only be paid leave allowance if you take %1 or more Days', HumanResSetup."Qualification Days (Leave)");
                end;
            end;
        }
        field(20; Post; Boolean)
        {
        }
        field(21; days; Decimal)
        {
        }
        field(23; "No. series"; Code[10])
        {
        }
        field(24; "Leave balance"; Decimal)
        {
        }
        field(25; "Resumption Date"; Date)
        {
        }
        field(26; Name; Text[50])
        {
        }
        field(27; Status; Enum "Document Status")
        {
            Editable = false;

            trigger OnValidate()
            begin
                if Rec.Status = Rec.Status::Released then begin
                    HRCommunicationMngt.LeaveRelieverNotification(Rec);
                    HRCommunicationMngt.LeaveEmployeeNotification(Rec);
                    HRCommunicationMngt.HRLeaveNotification(Rec);
                end;
            end;
        }
        field(28; "Leave Entitlment"; Decimal)
        {
        }
        field(29; "Total Leave Days Taken"; Decimal)
        {
            CalcFormula = Sum("Employee Leave Application"."Days Applied" WHERE(Status = CONST(Released), "Employee No" = FIELD("Employee No"), "Leave Code" = FIELD("Leave Code"), "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(30; "Duties Taken Over By"; Code[30])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if xRec.Status <> Status::Open then Error('You cannot change an already approved document');
                if "Duties Taken Over By" = "Employee No" then Error('You cannot select your own ID in this field');
                NAVemp.Reset;
                if NAVemp.Get("Duties Taken Over By") then begin
                    NAVemp.TestField("Company E-Mail");
                    "Reliever Name" := NAVemp.FullName();
                end;
            end;
        }
        field(31; "Reliever Name"; Text[50])
        {
            Editable = false;
        }
        field(32; "Mobile No"; Code[20])
        {
            Editable = false;
        }
        field(33; "Balance brought forward"; Decimal)
        {
        }
        field(34; "Leave Earned to Date"; Decimal)
        {
        }
        field(35; "Maturity Date"; Date)
        {
        }
        field(36; "Date of Joining Company"; Date)
        {
        }
        field(37; "Fiscal Start Date"; Date)
        {
        }
        field(38; "No. of Months Worked"; Decimal)
        {
        }
        field(39; "Annual Leave Entitlement Bal"; Decimal)
        {
        }
        field(40; "Recalled Days"; Decimal)
        {
            CalcFormula = Sum("Employee Off/Holidays"."No. of Off Days" WHERE("Employee No" = FIELD("Employee No"), "Maturity Date" = FIELD("Maturity Date"), "Leave Code" = FIELD("Leave Code")));
            FieldClass = FlowField;
        }
        field(41; "Off Days"; Decimal)
        {
            CalcFormula = Sum("Holidays_Off Days"."No. of Days" WHERE("Employee No." = FIELD("Employee No"), "Leave Type" = FIELD("Leave Code"), "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(42; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                /*PurchaseReqDet.RESET;
                    PurchaseReqDet.SETRANGE(PurchaseReqDet."Requistion No.","Requisition No.");

                    IF PurchaseReqDet.FIND('-') THEN  BEGIN
                    REPEAT
                    PurchaseReqDet."Global Dimension 2 Code":="Global Dimension 2 Code";
                    PurchaseReqDet.MODIFY;
                    UNTIL PurchaseReqDet.NEXT=0;
                     END;*/
            end;
        }
        field(43; "User ID"; Code[30])
        {
        }
        field(44; "No of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = CONST(69132), "Document No." = FIELD("Application No")));
            FieldClass = FlowField;
        }
        field(45; "Days Absent"; Decimal)
        {
            CalcFormula = Sum("Employee Absentism"."No. of  Days Absent" WHERE("Employee No" = FIELD("Employee No"), "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(46; "Contract No."; Integer)
        {
        }
        field(47; "Pending Approver"; Code[30])
        {
            CalcFormula = Lookup("Approval Entry"."Approver ID" WHERE("Document No." = FIELD("Application No"), Status = CONST(Open)));
            FieldClass = FlowField;
        }
        field(48; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                /*PurchaseReqDet.RESET;
                    PurchaseReqDet.SETRANGE(PurchaseReqDet."Requistion No.","Requisition No.");

                    IF PurchaseReqDet.FIND('-') THEN BEGIN
                    REPEAT
                    PurchaseReqDet."Global Dimension 1 Code":="Global Dimension 1 Code";
                    PurchaseReqDet.MODIFY;
                    UNTIL PurchaseReqDet.NEXT=0;
                    END;

                    PurchaseReqDet.VALIDATE(PurchaseReqDet."No."); */
            end;
        }
        field(49; "Global Dimension 2 Name"; Text[50])
        {
            CaptionClass = '1,1,2';
        }
        field(50; "Global Dimension 1 Name"; Text[50])
        {
            CaptionClass = '1,1,1';
        }
        field(51; "No. of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = CONST(51511234), "Document No." = FIELD("Application No")));
            FieldClass = FlowField;
        }
        field(52; AdvanceDays; Decimal)
        {
        }
        field(53; TodaysDate; Date)
        {
        }
        field(54; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(55; "HR Created"; Boolean)
        {
        }
        field(56; "Leave Allowance Paid"; Decimal)
        {
        }
        field(57; Reason; Text[250])
        {
            trigger OnValidate()
            begin
                Validate("Leave Code");
            end;
        }
        field(58; "SharePoint Link"; Text[250])
        {
        }
        field(59; "Approver ID"; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UserApprovalSetup.Reset;
                UserApprovalSetup.SetRange("User ID", "Approver ID");
                if UserApprovalSetup.FindFirst then "Approver Email" := UserApprovalSetup."E-Mail";
            end;
        }
        field(60; "Requestor Email"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                UserId: Code[20];
            begin
                UserApprovalSetup.Reset;
                UserApprovalSetup.SetRange("E-Mail", "Requestor Email");
                if UserApprovalSetup.FindFirst then begin
                    "Approver ID" := UserApprovalSetup."Approver ID";
                    Validate("Approver ID");
                    UserId := UserApprovalSetup."User ID";
                    //"User ID" := UserApprovalSetup."User ID";
                end;
                UserSertup.Reset;
                UserSertup.SetRange("User ID", UserId);
                if UserSertup.FindFirst then begin
                    "Employee No" := UserSertup."Employee No.";
                    Validate("Employee No");
                end;
            end;
        }
        field(61; "Approver Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(62; PowerApps; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; Recalled; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "HOD Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "SSP Created"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Alternative Email Address"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(71; "Alternative Phone No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Alternative Phone Number';
        }
        field(72; Gender; Enum "Employee Gender")
        {
            Editable = false;
        }
        field(73; "Leave Plan"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Application No")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Post = true then Error(Text001);
        if Status <> Status::Open then Error(Text002);
    end;

    trigger OnInsert()
    begin
        if "Application No" = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Leave Application Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Leave Application Nos", xRec."No. series", 0D, "Application No", "No. series");
        end;
        "Application Date" := Today;
        if ((not "HR Created") and (not "HOD Created") and (not "SSP Created")) then begin
            if UserSertup.Get(UserId) then begin
                "Employee No" := UserSertup."Employee No.";
                Validate("Employee No");
            end;
            "User ID" := UserId;
            if EmpRec.Get("Employee No") then begin
                "Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                "Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                "Global Dimension 3 Code" := EmpRec."Global Dimension 3 Code";
            end;
            if NAVemp.Get("Employee No") then begin
                "Mobile No" := NAVemp."Mobile Phone No.";
                "Date of Joining Company" := NAVemp."Employment Date";
                //ssss
            end;
        end;
        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
        Status := Status::Open;
    end;

    trigger OnModify()
    begin
        /*IF Post=TRUE THEN
             ERROR(Text000);*/
    end;

    trigger OnRename()
    begin
        if Post = true then Error(Text003);
    end;

    var
        NAVemp: Record Employee;
        HumanResSetup: Record "QuantumJumps HR Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        LeaveTypes: Record "Leave Setup";
        EmployeePosting: Record "Employee Groups";
        emp: Record "Employee Master";
        NoofMonthsWorked: Integer;
        Nextmonth: Date;
        EmpLeave: Record "Employee Leaves";
        FullDays: Decimal;
        HalfDays: Decimal;
        GeneralOptions: Record "QuantumJumps HR Setup";
        NoOfWorkingDays: Integer;
        NextWorkingDate: Date;
        CalendarMgmt: Codeunit "AL Calendar Management";
        Description: Text[30];
        BaseCalendar: Record "Base Calendar Change";
        BaseCalender: Record Date;
        NonWorkingDay: Boolean;
        Dsptn: Text[30];
        BeginDate: Date;
        "Employee Leaves": Record "Employee Leaves";
        leaveapp: Record "Employee Leave Application";
        AccPeriod: Record "Accounting Period";
        FiscalStart: Date;
        FiscalEnd: Date;
        assmatrix: Record "Payroll Matrix";
        LeaveAllowancePaid: Boolean;
        UserSertup: Record "User Setup";
        EmpRec: Record "Employee Master";
        MaturityDate: Date;
        UserApprovalSetup: Record "User Setup";
        LeavePlanHeader: Record "Employee Leave Plan Header";
        HRCommunicationMngt: Codeunit "HR Communication Management";
        CCBaseCalendar: Boolean;
        Text000: Label 'You cannot Modify the Record';
        Text001: Label 'You cannot Delete the Record';
        Text002: Label 'You cannot delete a document that is already approved or pending approval';
        Text003: Label 'You cannot Rename the Record';

    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+') then begin
            if LeaveTypes.Get('ANNUAL') then begin
                Message('accperiod is %1', AccPeriod."Starting Date");
                if Format(LeaveTypes."Leave Fiscal Year Difference") <> '' then begin
                    FiscalStart := CalcDate(Format(LeaveTypes."Leave Fiscal Year Difference"), AccPeriod."Starting Date");
                    MaturityDate := CalcDate('1Y', FiscalStart) - 1;
                end
                else begin
                    FiscalStart := AccPeriod."Starting Date";
                    MaturityDate := CalcDate('1Y', FiscalStart) - 1;
                end;
            end;
        end;
    end;
    // Check for Leave Plan
    procedure CheckLeavePlan()
    var
        LeavePlanHeader: Record "Employee Leave Plan Header";
    begin
        LeavePlanHeader.Reset();
        LeavePlanHeader.SetRange("Employee No", Rec."Employee No");
        // LeavePlanHeader.SetRange("Fiscal Start Date", Rec."Fiscal Start Date");
        // LeavePlanHeader.SetRange("Maturity Date", Rec."Maturity Date");
        if LeavePlanHeader.FindFirst() then begin
            if LeavePlanHeader.Status = Status::Released then begin
                "Leave Plan" := LeavePlanHeader."Application No";
                // Message('Leave plan no is %1', LeavePlanHeader."Application No")
            end
            else
                Error('Your Leave plan must be approved to apply');
        end
        else
            Error('You must have a plan before applying for a leave');
    end;
}
