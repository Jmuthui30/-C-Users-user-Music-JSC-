table 51603 "Employee Off/Holidays"
{
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if NAVEmp.Get("Employee No")then begin
                    "Employee Name":=NAVEmp."First Name" + ' ' + NAVEmp."Middle Name" + ' ' + NAVEmp."Last Name";
                    if Emp.Get("Employee No")then begin
                        if Emp."Contract Type" <> '' then "Contract No.":=Emp."Contract Type";
                    end;
                end;
            end;
        }
        field(2; "No."; Code[20])
        {
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Leave Recall Nos");
                    "No. Series":='';
                end;
            end;
        }
        field(3; Date; Date)
        {
        //The property 'ValidateTableRelation' can only be set if the property 'TableRelation' is set
        //ValidateTableRelation = false;
        }
        field(4; Approved; Boolean)
        {
            trigger OnValidate()
            begin
                "Leave Types".Reset;
                "Leave Types".SetRange("Leave Types"."Off/Holidays Days Leave", true);
                if "Leave Types".Find('-')then;
                "Employee Leave".Reset;
                "Employee Leave".SetRange("Employee Leave"."Employee No", "Employee No");
                "Employee Leave".SetRange("Employee Leave"."Leave Code", "Leave Types".Code);
                if "Employee Leave".Find('-')then;
                if Approved = true then begin
                    ;
                    "Employee Leave".Balance:="Employee Leave".Balance + 1;
                    "Employee Leave".Modify;
                end
                else
                begin
                    "Employee Leave".Balance:="Employee Leave".Balance - 1;
                    "Employee Leave".Modify;
                end;
            end;
        }
        field(5; "Leave Application"; Code[20])
        {
            TableRelation = "Employee Leave Application" WHERE(Status=CONST(Released), "Leave Code"=CONST('ANNUAL'), Recalled=CONST(false));

            trigger OnValidate()
            begin
                /*
                GeneralOptions.GET;
                IF LeaveApplication.GET("Leave Application") THEN
                BEGIN
                  NoOfDaysOff:=0;
                    "Leave Ending Date":=LeaveApplication."End Date";
                  IF LeaveApplication."End Date"<>0D THEN
                  BEGIN
                  NextDate:="Recall Date";
                  REPEAT
                  IF NOT CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code",NextDate,Description) THEN
                  NoOfDaysOff:=NoOfDaysOff+1;

                  NextDate:=CALCDATE('1D',NextDate);
                  UNTIL NextDate=LeaveApplication."End Date";
                  END;

                END;
                 "No. of Off Days":=NoOfDaysOff;
                                 */
                LStDate:=0D;
                LeaveApplication.Reset;
                if LeaveApplication.Get("Leave Application")then begin
                    //  NoOfDaysOff:=0;
                    "Leave Ending Date":=LeaveApplication."End Date";
                    "Employee No":=LeaveApplication."Employee No";
                    "Employee Name":=LeaveApplication.Name;
                    "Directorate Code":=LeaveApplication."Global Dimension 1 Code";
                    "Leave Code":=LeaveApplication."Leave Code";
                    LStDate:=LeaveApplication."Start Date";
                    DimensionsValue.Reset;
                    DimensionsValue.SetRange(DimensionsValue."Dimension Code", 'DEPARTMENT');
                    DimensionsValue.SetRange(DimensionsValue.Code, LeaveApplication."Global Dimension 1 Code");
                    if DimensionsValue.Find('-')then "Department Name":=DimensionsValue.Name;
                    DimensionsValue.Reset;
                    DimensionsValue.SetRange(DimensionsValue."Dimension Code", 'DIRECTORATE');
                    DimensionsValue.SetRange(DimensionsValue.Code, LeaveApplication."Global Dimension 1 Code");
                    if DimensionsValue.Find('-')then "Directorate Name":=DimensionsValue.Name;
                end;
            end;
        }
        field(6; "Recall Date"; Date)
        {
            Editable = false;

            trigger OnValidate()
            begin
                Validate("Leave Application");
            end;
        }
        field(7; "No. of Off Days"; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            begin
                LeaveApplication.Reset;
                LeaveApplication.SetRange(LeaveApplication."Application No", "Leave Application");
                if LeaveApplication.Find('-')then if LeaveApplication."Days Applied" < "No. of Off Days" then Error('The days you are trying to recall for %1 are more than the leave days applied they for', "Employee Name");
                Validate("Recalled From");
            end;
        }
        field(8; "Leave Ending Date"; Date)
        {
        }
        field(9; "Maturity Date"; Date)
        {
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; "Employee Name"; Text[50])
        {
        }
        field(12; "Recalled From"; Date)
        {
            NotBlank = false;

            trigger OnValidate()
            var
                startDate: Date;
            begin
                GeneralOptions.Get;
                if "Recalled From" <> 0D then d:="Recalled From";
                if LeaveApplication.Get("Leave Application")then startDate:=LeaveApplication."Start Date";
                if(d < startDate)then Error('You cannot Recall Leave before its Start Date');
                if(d > "Leave Ending Date")then Error('You cannot Recall Leave that have exceeded End Date');
                NotworkingDaysRecall:=0;
                FullDays:=Round("No. of Off Days", 1, '<');
                HalfDays:="No. of Off Days" - FullDays;
                if("No. of Off Days" <> 0) and ("No. of Off Days" >= 1)then begin
                    repeat if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code", d, Description)then NotworkingDaysRecall:=NotworkingDaysRecall + 1;
                        LeaveApplication.Reset;
                        if LeaveApplication.Get("Leave Application")then LeaveCode:=LeaveApplication."Leave Code";
                        if LeaveTypes.Get(LeaveCode)then begin
                            if LeaveTypes."Inclusive of Holidays" then begin
                                BaseCalendar.Reset;
                                BaseCalendar.SetRange(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code");
                                BaseCalendar.SetRange(BaseCalendar.Date, d);
                                BaseCalendar.SetRange(BaseCalendar.Nonworking, true);
                                BaseCalendar.SetRange(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                if BaseCalendar.Find('-')then begin
                                    NotworkingDaysRecall:=NotworkingDaysRecall + 1;
                                end;
                            end;
                            if LeaveTypes."Inclusive of Saturday" then begin
                                BaseCalender.Reset;
                                BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                BaseCalender.SetRange(BaseCalender."Period Start", d);
                                BaseCalender.SetRange(BaseCalender."Period No.", 6);
                                if BaseCalender.Find('-')then begin
                                    NotworkingDaysRecall:=NotworkingDaysRecall + 1;
                                // MESSAGE('SATURDAYS=%1',NotworkingDaysRecall);
                                //   END;
                                // MESSAGE('SATURDAY =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                end;
                            end;
                            if LeaveTypes."Inclusive of Sunday" then begin
                                BaseCalender.Reset;
                                BaseCalender.SetRange(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                BaseCalender.SetRange(BaseCalender."Period Start", d);
                                BaseCalender.SetRange(BaseCalender."Period No.", 7);
                                // BaseCalendar.SETRANGE(BaseCalendar.Nonworking,true);
                                if BaseCalender.Find('-')then begin
                                    NotworkingDaysRecall:=NotworkingDaysRecall + 1;
                                // MESSAGE('SUNDAYS=%1',NotworkingDaysRecall);
                                //MESSAGE('Sunday =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                end;
                            end;
                            if LeaveTypes."Off/Holidays Days Leave" then;
                        // MESSAGE('Off/Holidays Days Leave');
                        end;
                        d:=CalcDate('1D', d);
                    //  MESSAGE('NotworkingDaysRecall=%1',NotworkingDaysRecall);
                    //  MESSAGE('d=%1',FORMAT(d));
                    //NotworkingDaysRecall:=NotworkingDaysRecall+1;
                    until NotworkingDaysRecall = FullDays;
                    //  MESSAGE('NotworkingDaysRecall=%1',NotworkingDaysRecall);
                    // "No. of Off Days" :="No. of Off Days"-NotworkingDaysRecall;
                    // "No. of Off Days" :="No. of Off Days" + 1;
                    //  MESSAGE('No. of Off Days=%1',"No. of Off Days");
                    "Recalled To":=d - 1;
                // END;
                // END;
                end
                else if("No. of Off Days" <> 0) and ("No. of Off Days" < 1)then begin
                        "Recalled To":="Recalled From";
                    end;
                if "Recalled To" <> 0D then Validate("Recalled To");
            end;
        }
        field(13; "Recalled To"; Date)
        {
            Editable = false;
            NotBlank = false;

            trigger OnValidate()
            begin
                if("Recalled To" > "Leave Ending Date")then Error('You cannot Recall Leave that have exceeded End Date');
            /*
                
                
                IF ("Recalled To"="Recalled From") THEN
                   "No. of Off Days":=1
                
                ELSE
                  BEGIN
                
                 GeneralOptions.GET;
                //IF  "Recalled To">"Recall Date" THEN
                //ERROR('Recall end date is greater than recall start date');
                 IF LeaveApplication.GET("Leave Application") THEN
                 BEGIN
                   NoOfDaysOff:=1;
                     "Leave Ending Date":=LeaveApplication."End Date";
                   IF LeaveApplication."End Date"<>0D THEN
                   BEGIN
                   NextDate:="Recalled From";
                   REPEAT
                   IF NOT CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code",NextDate,Description) THEN
                   NoOfDaysOff:=NoOfDaysOff+1;
                
                   NextDate:=CALCDATE('1D',NextDate);
                 //  UNTIL NextDate=LeaveApplication."End Date";
                     UNTIL NextDate="Recalled To"; //By Isaac
                   END;
                
                 END;
                  "No. of Off Days":=NoOfDaysOff;
                END;
                 */
            end;
        }
        field(14; "Fiscal Start Date"; Date)
        {
        }
        field(15; "Recalled By"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if NAVEmp.Get("Recalled By")then begin
                    Name:=NAVEmp."First Name" + ' ' + NAVEmp."Middle Name" + ' ' + NAVEmp."Last Name";
                    //Name:=Emp."First Name"+' '  +Emp."Middle Name"+' '  + Emp."Last Name";
                    DimensionsValue.Reset();
                    DimensionsValue.SetRange(DimensionsValue."Dimension Code", 'DEPARTMENT');
                    DimensionsValue.SetRange(DimensionsValue.Code, NAVEmp."Global Dimension 1 Code");
                    if DimensionsValue.FindFirst()then "Head Of Department":=DimensionsValue.Name;
                end;
            end;
        }
        field(16; Name; Text[50])
        {
            Editable = false;
        }
        field(17; "Reason for Recall"; Text[130])
        {
        }
        field(18; "Head Of Department"; Text[100])
        {
            Editable = false;
        }
        field(19; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(20; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = '//Use 21';
        }
        field(22; "Department Name"; Text[80])
        {
        }
        field(23; "Contract No."; Code[10])
        {
        }
        field(24; "Directorate Code"; Code[10])
        {
        }
        field(25; "Directorate Name"; Text[80])
        {
        }
        field(26; Recalled; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Employee No", "Maturity Date")
        {
            SumIndexFields = "No. of Off Days";
        }
        key(Key3; "Employee No", "Contract No.")
        {
            SumIndexFields = "No. of Off Days";
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField(HumanResSetup."Leave Recall Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Leave Recall Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date:=Today;
        Status:=Status::Open;
        "Recall Date":=Today;
        FindMaturityDate;
        "Maturity Date":=MaturityDate;
        "Fiscal Start Date":=FiscalStart;
    end;
    trigger OnModify()
    begin
    //MESSAGE('You are modifying leave recall data for %1 are you sure you want to do this', "Employee Name");
    end;
    var NAVEmp: Record Employee;
    Emp: Record "Employee Master";
    "Leave Types": Record "Leave Setup";
    "Employee Leave": Record "Employee Leaves";
    LeaveApplication: Record "Employee Leave Application";
    DimensionsValue: Record "Dimension Value";
    GeneralOptions: Record "QuantumJumps HR Setup";
    d: Date;
    NotworkingDaysRecall: Integer;
    FullDays: Decimal;
    HalfDays: Decimal;
    CalendarMgmt: Codeunit "AL Calendar Management";
    Description: Text[30];
    LeaveCode: Code[30];
    LeaveTypes: Record "Leave Setup";
    BaseCalendar: Record "Base Calendar Change";
    BaseCalender: Record Date;
    HumanResSetup: Record "QuantumJumps HR Setup";
    FiscalStart: Date;
    MaturityDate: Date;
    NoSeriesMgt: Codeunit NoSeriesManagement;
    LStDate: Date;
    procedure FindMaturityDate()
    var
        AccPeriod: Record "Accounting Period";
    begin
        AccPeriod.Reset;
        AccPeriod.SetRange("Starting Date", 0D, Today);
        AccPeriod.SetRange("New Fiscal Year", true);
        if AccPeriod.Find('+')then begin
            if LeaveTypes.Get('ANNUAL')then begin
                if Format(LeaveTypes."Leave Fiscal Year Difference") <> '' then begin
                    FiscalStart:=CalcDate(Format(LeaveTypes."Leave Fiscal Year Difference"), AccPeriod."Starting Date");
                    MaturityDate:=CalcDate('1Y', FiscalStart) - 1;
                end
                else
                begin
                    FiscalStart:=AccPeriod."Starting Date";
                    MaturityDate:=CalcDate('1Y', FiscalStart) - 1;
                end;
            end;
        end;
    end;
    procedure AssitEdit(): Boolean begin
        HumanResSetup.Get;
        HumanResSetup.TestField("Leave Recall Nos");
        if NoSeriesMgt.SelectSeries(HumanResSetup."Leave Recall Nos", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
}
