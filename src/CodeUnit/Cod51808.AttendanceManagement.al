codeunit 51808 "Attendance - Management"
{
    // Author : Henry Ngari
    // Year: 2021
    trigger OnRun()
    begin
    end;
    var temp_ClientEmployeeMaster: Record "temp_Client Employee Master" temporary;
    ClientEmployeeMaster: Record "Client Employee Master";
    temp_Employee: Record temp_Employee;
    Employee: Record Employee;
    Admins: Record Admins;
    Division: Code[20];
    PayrollAttendanceEntries: Record "Payroll Attendance Entries";
    ExternalEmployeesLeave: Record "External Employees Leave";
    AttendanceWorksheetLines: Record "Attendance Worksheet Lines";
    procedure "Post Daily Present Attendance"()
    var
        Post: Boolean;
    begin
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Document No.", Format(Today));
        PayrollAttendanceEntries.SetRange("Normal Day", true);
        PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Normal_Day);
        if PayrollAttendanceEntries.FindSet then Post:=false
        else
            Post:=true;
        if(Post = true)then begin
            PostExternalEmployeeDailyAttendance;
            PostInternalEmployeeDailyAttendance;
        end
        else
        begin
            exit;
        end;
    end;
    procedure "Post Sunday Reliefs"()
    var
        Post: Boolean;
        DaysOfWeek: Integer;
    begin
        DaysOfWeek:=Date2DWY(Today, 1);
        if(DaysOfWeek = 7)then begin
            PostExternalEmployeeSundayRelief;
            PostInternalEmployeeSundayRelief;
        end
        else
        begin
            exit;
        end;
    end;
    procedure "Post External Employees Special Days"(EmployeeNo: Code[20]; Type: Option " ", Relief, Sunday; Date: Date)
    var
        LineNo: Integer;
        EmployeeName: Text[50];
        Pno: Code[20];
        Dimension: Code[20];
        DayOfWeek: Integer;
    begin
        if EmployeeNo = '' then Error('Specify Employee No.')
        else if Type = Type::" " then Error('Specify Type')
            else if Date = 0D then Error('Specify Working Date');
        if Type = Type::Sunday then begin
            DayOfWeek:=Date2DWY(Date, 1);
            if DayOfWeek <> 7 then Error('Working Day must be a Sunday');
        end;
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Employee No.", EmployeeNo);
        PayrollAttendanceEntries.SetRange(Leave, true);
        PayrollAttendanceEntries.SetRange("Working Date", Date);
        if PayrollAttendanceEntries.FindFirst then Error(EmployeeNo + ' is on Leave');
        LineNo:=1000;
        if ClientEmployeeMaster.Get(EmployeeNo)then begin
            EmployeeName:=ClientEmployeeMaster."First Name" + ' ' + ClientEmployeeMaster."Middle Name" + ' ' + ClientEmployeeMaster."Last Name";
            Pno:=ClientEmployeeMaster."Payroll No.";
            Dimension:=ClientEmployeeMaster."Global Dimension 1 Code";
        end;
        if Confirm('Are you sure you want to Post ' + Format(Type) + ' For ' + EmployeeNo, true)then begin
            OverwriteAllEntries(EmployeeNo, Date);
            PayrollAttendanceEntries.Init;
            PayrollAttendanceEntries."Document No.":=Format(Date);
            PayrollAttendanceEntries."Line No":=LineNo;
            PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
            if Type = Type::Relief then begin
                PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Relief;
                PayrollAttendanceEntries.Relief:=true;
            end
            else if Type = Type::Sunday then begin
                    PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Normal_Day;
                    PayrollAttendanceEntries.Sunday:=true;
                end;
            PayrollAttendanceEntries."Working Date":=Date;
            PayrollAttendanceEntries."Employee No.":=EmployeeNo;
            PayrollAttendanceEntries."Employee Name":=EmployeeName;
            PayrollAttendanceEntries."P/No.":=Pno;
            PayrollAttendanceEntries."Posting Date":=Today;
            PayrollAttendanceEntries."Shortcut Dimension 1 Code":=Dimension;
            PayrollAttendanceEntries."Posted By":=UserId;
            PayrollAttendanceEntries.Posted:=true;
            PayrollAttendanceEntries.Insert(true);
            Message(Format(Type) + ' For ' + EmployeeNo + ' have been Posted');
        end
        else
        begin
            exit;
        end;
        EmployeeName:='';
        Pno:='';
        Dimension:='';
        DayOfWeek:=0;
    end;
    procedure "Post Internal Employee Routines"(AttendanceWorksheetHeader: Record "Attendance Worksheet Header")
    var
        LineNo: Integer;
        EmployeeName: Text[50];
        Pno: Code[20];
        Dimension: Code[20];
        DaysOfWeek: Integer;
    begin
        if Confirm('Are you sure you want to Post ' + AttendanceWorksheetHeader."No.", true)then begin
            LineNo:=1000;
            AttendanceWorksheetLines.Reset;
            AttendanceWorksheetLines.SetRange("Document No.", AttendanceWorksheetHeader."No.");
            AttendanceWorksheetLines.SetRange(Posted, false);
            if AttendanceWorksheetLines.FindSet then repeat begin
                    if ClientEmployeeMaster.Get(AttendanceWorksheetLines."No.")then begin
                        EmployeeName:=ClientEmployeeMaster."First Name" + ' ' + ClientEmployeeMaster."Middle Name" + ' ' + ClientEmployeeMaster."Last Name";
                        Pno:=ClientEmployeeMaster."Payroll No.";
                        Dimension:=ClientEmployeeMaster."Global Dimension 1 Code";
                    end;
                    PayrollAttendanceEntries.Reset;
                    PayrollAttendanceEntries.SetRange("Employee No.", AttendanceWorksheetLines."No.");
                    PayrollAttendanceEntries.SetRange(Leave, true);
                    PayrollAttendanceEntries.SetRange("Working Date", AttendanceWorksheetLines."Working Date");
                    if PayrollAttendanceEntries.FindFirst then Error(EmployeeName + ' is on Leave');
                    DaysOfWeek:=Date2DWY(AttendanceWorksheetLines."Working Date", 1);
                    OverwriteAllEntries(AttendanceWorksheetLines."No.", AttendanceWorksheetLines."Working Date");
                    if AttendanceWorksheetLines."Posting Type" = AttendanceWorksheetLines."Posting Type"::Absent then begin
                        PayrollAttendanceEntries.Init;
                        PayrollAttendanceEntries."Document No.":=AttendanceWorksheetHeader."No.";
                        PayrollAttendanceEntries."Line No":=LineNo;
                        PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
                        PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Absent;
                        PayrollAttendanceEntries."Working Date":=AttendanceWorksheetLines."Working Date";
                        PayrollAttendanceEntries."Employee No.":=AttendanceWorksheetLines."No.";
                        PayrollAttendanceEntries."Employee Name":=EmployeeName;
                        PayrollAttendanceEntries."P/No.":=Pno;
                        PayrollAttendanceEntries."Posting Date":=Today;
                        PayrollAttendanceEntries."Shortcut Dimension 1 Code":=AttendanceWorksheetHeader."Shortcut Dimension 1 Code";
                        PayrollAttendanceEntries.Validate("Shortcut Dimension 1 Code");
                        PayrollAttendanceEntries.Reason:=AttendanceWorksheetLines.Reason;
                        if DaysOfWeek = 7 then PayrollAttendanceEntries.Sunday:=true;
                        PayrollAttendanceEntries.Absent:=true;
                        PayrollAttendanceEntries."Posted By":=UserId;
                        PayrollAttendanceEntries.Posted:=true;
                        PayrollAttendanceEntries.Insert(true);
                    end
                    else if AttendanceWorksheetLines."Posting Type" = AttendanceWorksheetLines."Posting Type"::Late then begin
                            PayrollAttendanceEntries.Init;
                            PayrollAttendanceEntries."Document No.":=AttendanceWorksheetHeader."No.";
                            PayrollAttendanceEntries."Line No":=LineNo;
                            PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
                            PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Late;
                            PayrollAttendanceEntries."Working Date":=AttendanceWorksheetLines."Working Date";
                            PayrollAttendanceEntries."Employee No.":=AttendanceWorksheetLines."No.";
                            PayrollAttendanceEntries."Employee Name":=EmployeeName;
                            PayrollAttendanceEntries."P/No.":=Pno;
                            PayrollAttendanceEntries."Posting Date":=Today;
                            PayrollAttendanceEntries."Shortcut Dimension 1 Code":=AttendanceWorksheetHeader."Shortcut Dimension 1 Code";
                            PayrollAttendanceEntries.Validate("Shortcut Dimension 1 Code");
                            PayrollAttendanceEntries.Reason:=AttendanceWorksheetLines.Reason;
                            if DaysOfWeek = 7 then PayrollAttendanceEntries.Sunday:=true;
                            PayrollAttendanceEntries.Late:=true;
                            PayrollAttendanceEntries.Hours:=AttendanceWorksheetLines.Hours;
                            PayrollAttendanceEntries."Posted By":=UserId;
                            PayrollAttendanceEntries.Posted:=true;
                            PayrollAttendanceEntries.Insert(true);
                        end
                        else if AttendanceWorksheetLines."Posting Type" = AttendanceWorksheetLines."Posting Type"::Overtime then begin
                                PayrollAttendanceEntries.Init;
                                PayrollAttendanceEntries."Document No.":=AttendanceWorksheetHeader."No.";
                                PayrollAttendanceEntries."Line No":=LineNo;
                                PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
                                PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Overtime;
                                PayrollAttendanceEntries."Working Date":=AttendanceWorksheetLines."Working Date";
                                PayrollAttendanceEntries."Employee No.":=AttendanceWorksheetLines."No.";
                                PayrollAttendanceEntries."Employee Name":=EmployeeName;
                                PayrollAttendanceEntries."P/No.":=Pno;
                                PayrollAttendanceEntries."Posting Date":=Today;
                                if DaysOfWeek = 7 then PayrollAttendanceEntries.Sunday:=true;
                                PayrollAttendanceEntries."Shortcut Dimension 1 Code":=AttendanceWorksheetHeader."Shortcut Dimension 1 Code";
                                PayrollAttendanceEntries.Validate("Shortcut Dimension 1 Code");
                                PayrollAttendanceEntries.Reason:=AttendanceWorksheetLines.Reason;
                                PayrollAttendanceEntries.Hours:=AttendanceWorksheetLines.Hours;
                                if AttendanceWorksheetLines."Special Overtime" = true then begin
                                    PayrollAttendanceEntries."Special Overtime":=true;
                                end
                                else if AttendanceWorksheetLines."Normal Overtime" = true then begin
                                        PayrollAttendanceEntries."Normal Overtime":=true;
                                    end;
                                PayrollAttendanceEntries."Posted By":=UserId;
                                PayrollAttendanceEntries.Posted:=true;
                                PayrollAttendanceEntries.Insert(true);
                            end;
                end;
                    AttendanceWorksheetLines.Posted:=true;
                    AttendanceWorksheetLines.Modify(true);
                    LineNo:=LineNo + 100;
                    EmployeeName:='';
                    Pno:='';
                    Dimension:='';
                until AttendanceWorksheetLines.Next = 0;
            Message(AttendanceWorksheetHeader."No." + ' have been posted');
        end
        else
        begin
            exit;
        end;
    end;
    procedure "Post External Employees Leaves"("EmployeeNo.": Code[10]; "Leave Type": Option " ", "Sick Off", "Sick Leave", Marternity, Parternity, Annual, "Unpaid Leave"; Start_date: Date; End_date: Date)
    var
        LineNo: Integer;
        datediff: Decimal;
        working_date: Date;
        EmployeeName: Text[50];
        Pno: Code[20];
        Dimension: Code[20];
        Gender: Code[20];
        annual_days: Decimal;
        days_taken: Decimal;
        days_diff: Decimal;
        weekend_diff: Decimal;
    begin
        if "EmployeeNo." = '' then Error('Specify Employee No.')
        else if "Leave Type" = "Leave Type"::" " then Error('Specify Leave Type')
            else if "Leave Type" = "Leave Type"::"Sick Leave" then Error(Format("Leave Type") + ' Is not applicable Please Select Sick Off')
                else if Start_date = 0D then Error('Specify Start Date')
                    else if End_date = 0D then Error('Specify End Date');
        if Start_date > End_date then Error('Start Date cant be greater than End Date');
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Employee No.", "EmployeeNo.");
        PayrollAttendanceEntries.SetRange(Leave, true);
        PayrollAttendanceEntries.SetFilter("Working Date", '%1..%2', Start_date, End_date);
        if PayrollAttendanceEntries.FindSet then Error("EmployeeNo." + ' is on another Leave');
        datediff:=(End_date - Start_date) + 1;
        working_date:=Start_date;
        datediff:=(End_date - Start_date) + 1;
        working_date:=Start_date;
        if ClientEmployeeMaster.Get("EmployeeNo.")then begin
            EmployeeName:=ClientEmployeeMaster."First Name" + ' ' + ClientEmployeeMaster."Middle Name" + ' ' + ClientEmployeeMaster."Last Name";
            Pno:=ClientEmployeeMaster."Payroll No.";
            Dimension:=ClientEmployeeMaster."Global Dimension 1 Code";
            annual_days:=ClientEmployeeMaster."Annual Leave Days Enttitled";
            ClientEmployeeMaster.CalcFields("Annual Days Taken");
            days_taken:=ClientEmployeeMaster."Annual Days Taken";
            days_diff:=annual_days - days_taken;
            if ClientEmployeeMaster.Gender = ClientEmployeeMaster.Gender::Female then Gender:='Female'
            else if ClientEmployeeMaster.Gender = ClientEmployeeMaster.Gender::Male then Gender:='Male'
                else if ClientEmployeeMaster.Gender = ClientEmployeeMaster.Gender::" " then Error(EmployeeName + ' gender is not Setup, Please Contact HR or Admin');
            if((("Leave Type" = "Leave Type"::Marternity) or ("Leave Type" = "Leave Type"::Parternity)) and (ClientEmployeeMaster."Marital Status" <> ClientEmployeeMaster."Marital Status"::Married))then Error(EmployeeName + ' Is SINGLE hence not entitled to Leave Type ' + Format("Leave Type"));
        end;
        if(("Leave Type" = "Leave Type"::Marternity) and (Gender = 'MALE'))then Error(EmployeeName + 'is not entitled to Leave Type ' + Format("Leave Type"))
        else if(("Leave Type" = "Leave Type"::Parternity) and (Gender = 'FEMALE'))then Error(EmployeeName + 'is not entitled to Leave Type ' + Format("Leave Type"));
        if "Leave Type" = "Leave Type"::Annual then begin
            if datediff > days_diff then Error('Days requested exceeds annual Leave Balance, Leave Balance is ' + Format(days_diff));
        end;
        if "Leave Type" = "Leave Type"::Parternity then begin
            if datediff > 14 then Error('Maximum days for ' + Format("Leave Type") + ' is 14 Days');
        end;
        if "Leave Type" = "Leave Type"::Marternity then begin
            if datediff > 90 then Error('Maximum days for ' + Format("Leave Type") + ' is 90 Days');
        end;
        if Confirm('Are you sure you want to Post ' + Format(datediff) + ' ' + Format("Leave Type") + ' Days' + ' For ' + "EmployeeNo.", true)then begin
            ExternalEmployeesLeave.Init;
            ExternalEmployeesLeave."Employee No.":="EmployeeNo.";
            ExternalEmployeesLeave."Employee Name":=EmployeeName;
            ExternalEmployeesLeave."Start Date":=Start_date;
            ExternalEmployeesLeave."End Date":=End_date;
            if "Leave Type" <> "Leave Type"::Annual then ExternalEmployeesLeave."Other Leave Days":=datediff;
            if "Leave Type" = "Leave Type"::Annual then ExternalEmployeesLeave."Leave Type":=ExternalEmployeesLeave."Leave Type"::Annual
            else if "Leave Type" = "Leave Type"::Marternity then ExternalEmployeesLeave."Leave Type":=ExternalEmployeesLeave."Leave Type"::Marternity
                else if "Leave Type" = "Leave Type"::Parternity then ExternalEmployeesLeave."Leave Type":=ExternalEmployeesLeave."Leave Type"::Parternity
                    else if "Leave Type" = "Leave Type"::"Sick Leave" then ExternalEmployeesLeave."Leave Type":=ExternalEmployeesLeave."Leave Type"::"Sick Leave"
                        else if "Leave Type" = "Leave Type"::"Sick Off" then ExternalEmployeesLeave."Leave Type":=ExternalEmployeesLeave."Leave Type"::"Sick Off"
                            else if "Leave Type" = "Leave Type"::"Unpaid Leave" then ExternalEmployeesLeave."Leave Type":=ExternalEmployeesLeave."Leave Type"::"Unpaid Leave";
            ExternalEmployeesLeave."Posting Date":=Today;
            ExternalEmployeesLeave."Posted By":=UserId;
            ExternalEmployeesLeave.Insert(true);
            repeat OverwriteAllEntries("EmployeeNo.", working_date);
                PayrollAttendanceEntries.Init;
                PayrollAttendanceEntries."Document No.":=ExternalEmployeesLeave.No;
                PayrollAttendanceEntries."Line No":=LineNo + 1000;
                PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
                if "Leave Type" = "Leave Type"::Annual then PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Annual
                else if "Leave Type" = "Leave Type"::Marternity then PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Marternity
                    else if "Leave Type" = "Leave Type"::Parternity then PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Parternity
                        else if "Leave Type" = "Leave Type"::"Sick Leave" then PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::"Sick Leave"
                            else if "Leave Type" = "Leave Type"::"Sick Off" then begin
                                    PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::"Sick Off";
                                    SickOffOverwriter("EmployeeNo.", working_date);
                                end
                                else if "Leave Type" = "Leave Type"::"Unpaid Leave" then PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::"Unpaid Leave";
                PayrollAttendanceEntries."Working Date":=working_date;
                PayrollAttendanceEntries."Employee No.":="EmployeeNo.";
                PayrollAttendanceEntries."Employee Name":=EmployeeName;
                PayrollAttendanceEntries."P/No.":=Pno;
                PayrollAttendanceEntries."Posting Date":=Today;
                PayrollAttendanceEntries."Shortcut Dimension 1 Code":=Dimension;
                PayrollAttendanceEntries.Leave:=true;
                PayrollAttendanceEntries."Posted By":=UserId;
                PayrollAttendanceEntries.Posted:=true;
                PayrollAttendanceEntries.Insert(true);
                working_date:=working_date + 1;
                datediff:=datediff - 1;
            until datediff = 0;
            Message('Leave No. ' + ExternalEmployeesLeave.No + ' For ' + "EmployeeNo." + ' ' + Format("Leave Type") + ' have been Posted');
        end
        else
        begin
            exit;
        end;
        EmployeeName:='';
        Pno:='';
        Dimension:='';
        Gender:='';
        annual_days:=0;
        days_taken:=0;
        days_diff:=0;
    end;
    procedure "Post External Employees Holiday"(docNo: Code[20]; start_date: Date; end_date: Date)
    var
        LineNo: Integer;
        datediff: Integer;
        working_date: Date;
    begin
        if docNo = '' then Error('Specify Document No.')
        else if start_date = 0D then Error('Specify Start Date')
            else if end_date = 0D then Error('Specify End Date');
        if start_date > end_date then Error('Start Date cant be greater than End Date');
        GetExternalEmployeesPerDivision;
        datediff:=(end_date - start_date) + 1;
        working_date:=start_date;
        LineNo:=1000;
        if Confirm('Are you sure you want to Post ' + docNo + 'For ' + Format(datediff) + ' Days ?', true)then begin
            repeat if temp_ClientEmployeeMaster.FindSet then repeat OverwriteAllEntries(temp_ClientEmployeeMaster."No.", working_date);
                        PayrollAttendanceEntries.Init;
                        PayrollAttendanceEntries."Document No.":=docNo;
                        PayrollAttendanceEntries."Line No":=LineNo;
                        PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
                        PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Holiday;
                        PayrollAttendanceEntries."Working Date":=working_date;
                        PayrollAttendanceEntries."Employee No.":=temp_ClientEmployeeMaster."No.";
                        PayrollAttendanceEntries."Employee Name":=temp_ClientEmployeeMaster."First Name" + ' ' + temp_ClientEmployeeMaster."Middle Name" + ' ' + temp_ClientEmployeeMaster."Last Name";
                        PayrollAttendanceEntries."P/No.":=temp_ClientEmployeeMaster."Payroll No.";
                        PayrollAttendanceEntries."Posting Date":=Today;
                        PayrollAttendanceEntries."Shortcut Dimension 1 Code":=temp_ClientEmployeeMaster."Global Dimension 1 Code";
                        PayrollAttendanceEntries.Holiday:=true;
                        PayrollAttendanceEntries."Posted By":=UserId;
                        PayrollAttendanceEntries.Posted:=true;
                        PayrollAttendanceEntries.Insert(true);
                        LineNo:=LineNo + 100;
                    until temp_ClientEmployeeMaster.Next = 0;
                working_date:=working_date + 1;
                datediff:=datediff - 1;
            until datediff = 0;
            temp_ClientEmployeeMaster.DeleteAll;
            Message(docNo + ' ' + 'Holiday Posted');
        end
        else
        begin
            exit;
        end;
    end;
    procedure "Post Internal Employees Holiday"(docNo: Code[20]; start_date: Date; end_date: Date)
    var
        LineNo: Integer;
        datediff: Integer;
        working_date: Date;
    begin
        if docNo = '' then Error('Specify Document No.')
        else if start_date = 0D then Error('Specify Start Date')
            else if end_date = 0D then Error('Specify End Date');
        if start_date > end_date then Error('Start Date cant be greater than End Date');
        GetInternalEmployees;
        datediff:=(end_date - start_date) + 1;
        working_date:=start_date;
        LineNo:=1000;
        if Confirm('Are you sure you want to Post ' + docNo + '? For ' + Format(datediff) + ' Days', true)then begin
            repeat if temp_Employee.FindSet then repeat OverwriteAllEntries(temp_Employee."No.", working_date);
                        PayrollAttendanceEntries.Init;
                        PayrollAttendanceEntries."Document No.":=docNo;
                        PayrollAttendanceEntries."Line No":=LineNo;
                        PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::Management;
                        PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Holiday;
                        PayrollAttendanceEntries."Working Date":=working_date;
                        PayrollAttendanceEntries."Employee No.":=temp_Employee."No.";
                        PayrollAttendanceEntries."Employee Name":=temp_Employee."First Name" + ' ' + temp_Employee."Middle Name" + ' ' + temp_Employee."Last Name";
                        PayrollAttendanceEntries."Shortcut Dimension 1 Code":=temp_Employee."Global Dimension 1 Code";
                        PayrollAttendanceEntries."Posting Date":=Today;
                        PayrollAttendanceEntries.Holiday:=true;
                        PayrollAttendanceEntries."Posted By":=UserId;
                        PayrollAttendanceEntries.Posted:=true;
                        PayrollAttendanceEntries.Insert(true);
                        LineNo:=LineNo + 100;
                    until temp_Employee.Next = 0;
                working_date:=working_date + 1;
                datediff:=datediff - 1;
            until datediff = 0;
            temp_Employee.DeleteAll;
            Message(docNo + ' ' + 'Holiday Posted');
        end
        else
        begin
            exit;
        end;
    end;
    local procedure GetExternalEmployeesPerDivision()
    begin
        Admins.Reset;
        Admins.SetRange("User ID", UserId);
        if Admins.FindFirst then Division:=Admins."Shortcut Dimension 1 Code";
        ClientEmployeeMaster.Reset;
        ClientEmployeeMaster.SetRange(Status, ClientEmployeeMaster.Status::Active);
        ClientEmployeeMaster.SetFilter("Payroll No.", '<>%1', ' ');
        ClientEmployeeMaster.SetFilter("Global Dimension 1 Code", '<>%1', ' ');
        ClientEmployeeMaster.SetRange("Global Dimension 1 Code", Division);
        if ClientEmployeeMaster.FindSet(false, false)then repeat temp_ClientEmployeeMaster.TransferFields(ClientEmployeeMaster);
                temp_ClientEmployeeMaster.Insert(true);
            until ClientEmployeeMaster.Next = 0;
        Division:='';
    end;
    local procedure GetExternalEmployeesAll()
    begin
        ClientEmployeeMaster.Reset;
        ClientEmployeeMaster.SetFilter("Payroll No.", '<>%1', ' ');
        ClientEmployeeMaster.SetFilter("Global Dimension 1 Code", '<>%1', ' ');
        ClientEmployeeMaster.SetRange(Status, ClientEmployeeMaster.Status::Active);
        if ClientEmployeeMaster.FindSet(false, false)then repeat temp_ClientEmployeeMaster.TransferFields(ClientEmployeeMaster);
                temp_ClientEmployeeMaster.Insert(true);
            until ClientEmployeeMaster.Next = 0;
    end;
    local procedure GetInternalEmployees()
    begin
        Employee.Reset;
        Employee.SetRange(Status, Employee.Status::Active);
        if Employee.FindSet(false, false)then repeat temp_Employee.TransferFields(Employee);
                temp_Employee.Insert(true);
            until Employee.Next = 0;
    end;
    local procedure PostExternalEmployeeSundayRelief()
    var
        LineNo: Integer;
        Relief: Boolean;
        Post: Boolean;
    begin
        GetExternalEmployeesAll;
        LineNo:=1000;
        if temp_ClientEmployeeMaster.FindSet then repeat Relief:=true;
                Post:=false;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetRange("Employee No.", temp_ClientEmployeeMaster."No.");
                PayrollAttendanceEntries.SetRange("Working Date", WorkDate);
                if PayrollAttendanceEntries.FindFirst then begin
                    if((PayrollAttendanceEntries."Posting Type" = PayrollAttendanceEntries."Posting Type"::Normal_Day) and (PayrollAttendanceEntries.Sunday = true))then Relief:=false;
                end;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetRange("Document No.", Format(Today));
                PayrollAttendanceEntries.SetRange("Working Date", Today);
                PayrollAttendanceEntries.SetRange("Employee No.", temp_ClientEmployeeMaster."No.");
                if PayrollAttendanceEntries.FindFirst then Post:=false
                else
                    Post:=true;
                PayrollAttendanceEntries.Init;
                PayrollAttendanceEntries."Document No.":=Format(Today);
                PayrollAttendanceEntries."Line No":=LineNo;
                PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
                PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Relief;
                PayrollAttendanceEntries."Working Date":=Today;
                PayrollAttendanceEntries."Employee No.":=temp_ClientEmployeeMaster."No.";
                PayrollAttendanceEntries."Employee Name":=temp_ClientEmployeeMaster."First Name" + ' ' + temp_ClientEmployeeMaster."Middle Name" + ' ' + temp_ClientEmployeeMaster."Last Name";
                PayrollAttendanceEntries."P/No.":=temp_ClientEmployeeMaster."Payroll No.";
                PayrollAttendanceEntries."Posting Date":=Today;
                PayrollAttendanceEntries."Shortcut Dimension 1 Code":=temp_ClientEmployeeMaster."Global Dimension 1 Code";
                PayrollAttendanceEntries.Relief:=true;
                PayrollAttendanceEntries.Sunday:=true;
                PayrollAttendanceEntries."Posted By":='SYSTEM';
                PayrollAttendanceEntries.Posted:=true;
                if((Relief = true) and (Post = true))then PayrollAttendanceEntries.Insert(true);
                LineNo:=LineNo + 100;
                OverwriteAnnuaLeaveDate(temp_ClientEmployeeMaster."No.", Today);
            until temp_ClientEmployeeMaster.Next = 0;
        temp_ClientEmployeeMaster.DeleteAll;
    end;
    local procedure PostInternalEmployeeSundayRelief()
    var
        LineNo: Integer;
        Post: Boolean;
    begin
        GetInternalEmployees;
        LineNo:=1000;
        if temp_Employee.FindSet then repeat PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetRange("Document No.", Format(Today));
                PayrollAttendanceEntries.SetRange("Working Date", Today);
                PayrollAttendanceEntries.SetRange("Employee No.", temp_Employee."No.");
                if PayrollAttendanceEntries.FindFirst then Post:=false
                else
                    Post:=true;
                PayrollAttendanceEntries.Init;
                PayrollAttendanceEntries."Document No.":=Format(Today);
                PayrollAttendanceEntries."Line No":=LineNo;
                PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::Management;
                PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Relief;
                PayrollAttendanceEntries."Working Date":=Today;
                PayrollAttendanceEntries."Employee No.":=temp_Employee."No.";
                PayrollAttendanceEntries."Employee Name":=temp_Employee."First Name" + ' ' + temp_Employee."Middle Name" + ' ' + temp_Employee."Last Name";
                PayrollAttendanceEntries."Shortcut Dimension 1 Code":=temp_Employee."Global Dimension 1 Code";
                PayrollAttendanceEntries."Posting Date":=Today;
                PayrollAttendanceEntries.Relief:=true;
                PayrollAttendanceEntries.Sunday:=true;
                PayrollAttendanceEntries."Posted By":='SYSTEM';
                PayrollAttendanceEntries.Posted:=true;
                if(Post = true)then PayrollAttendanceEntries.Insert(true);
                LineNo:=LineNo + 100;
            until temp_Employee.Next = 0;
        temp_Employee.DeleteAll;
    end;
    local procedure PostExternalEmployeeDailyAttendance()
    var
        LineNo: Integer;
        DayOfWeek: Integer;
        Present: Boolean;
    begin
        GetExternalEmployeesAll;
        LineNo:=1000;
        DayOfWeek:=Date2DWY(Today, 1);
        if temp_ClientEmployeeMaster.FindSet then repeat Present:=true;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetRange("Employee No.", temp_ClientEmployeeMaster."No.");
                PayrollAttendanceEntries.SetRange("Working Date", Today);
                if PayrollAttendanceEntries.FindFirst then begin
                    if((PayrollAttendanceEntries.Leave = true) or (PayrollAttendanceEntries.Absent = true) or (PayrollAttendanceEntries.Holiday = true) or (PayrollAttendanceEntries.Relief = true))then Present:=false;
                end;
                PayrollAttendanceEntries.Init;
                PayrollAttendanceEntries."Document No.":=Format(Today);
                PayrollAttendanceEntries."Line No":=LineNo;
                PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::External;
                PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Normal_Day;
                PayrollAttendanceEntries."Working Date":=Today;
                PayrollAttendanceEntries."Employee No.":=temp_ClientEmployeeMaster."No.";
                PayrollAttendanceEntries."Employee Name":=temp_ClientEmployeeMaster."First Name" + ' ' + temp_ClientEmployeeMaster."Middle Name" + ' ' + temp_ClientEmployeeMaster."Last Name";
                PayrollAttendanceEntries."P/No.":=temp_ClientEmployeeMaster."Payroll No.";
                PayrollAttendanceEntries."Posting Date":=Today;
                PayrollAttendanceEntries."Shortcut Dimension 1 Code":=temp_ClientEmployeeMaster."Global Dimension 1 Code";
                PayrollAttendanceEntries."Normal Day":=true;
                PayrollAttendanceEntries."Posted By":='SYSTEM';
                PayrollAttendanceEntries.Posted:=true;
                if((DayOfWeek <> 7) and (Present = true))then PayrollAttendanceEntries.Insert(true);
                LineNo:=LineNo + 100;
            until temp_ClientEmployeeMaster.Next = 0;
        temp_ClientEmployeeMaster.DeleteAll;
    end;
    local procedure PostInternalEmployeeDailyAttendance()
    var
        LineNo: Integer;
        DayOfWeek: Integer;
        Present: Boolean;
    begin
        GetInternalEmployees;
        LineNo:=1000;
        DayOfWeek:=Date2DWY(Today, 1);
        if temp_Employee.FindSet then repeat Present:=true;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetRange("Employee No.", temp_Employee."No.");
                PayrollAttendanceEntries.SetRange("Working Date", Today);
                if PayrollAttendanceEntries.FindFirst then begin
                    if((PayrollAttendanceEntries.Leave = true) or (PayrollAttendanceEntries.Absent = true) or (PayrollAttendanceEntries.Holiday = true))then Present:=false;
                end;
                PayrollAttendanceEntries.Init;
                PayrollAttendanceEntries."Document No.":=Format(Today);
                PayrollAttendanceEntries."Line No":=LineNo;
                PayrollAttendanceEntries.Type:=PayrollAttendanceEntries.Type::Management;
                PayrollAttendanceEntries."Posting Type":=PayrollAttendanceEntries."Posting Type"::Normal_Day;
                PayrollAttendanceEntries."Working Date":=Today;
                PayrollAttendanceEntries."Employee No.":=temp_Employee."No.";
                PayrollAttendanceEntries."Employee Name":=temp_Employee."First Name" + ' ' + temp_Employee."Middle Name" + ' ' + temp_Employee."Last Name";
                PayrollAttendanceEntries."Shortcut Dimension 1 Code":=temp_Employee."Global Dimension 1 Code";
                PayrollAttendanceEntries."Posting Date":=Today;
                PayrollAttendanceEntries."Normal Day":=true;
                PayrollAttendanceEntries."Posted By":='SYSTEM';
                PayrollAttendanceEntries.Posted:=true;
                if((DayOfWeek <> 7) and (Present = true))then PayrollAttendanceEntries.Insert(true);
                LineNo:=LineNo + 100;
            until temp_Employee.Next = 0;
        temp_Employee.DeleteAll;
    end;
    local procedure OverwriteAllEntries(No: Code[20]; My_WorkingDate: Date)
    var
        "Employee No": Code[20];
        WorkingDate: Date;
    begin
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Employee No.", No);
        PayrollAttendanceEntries.SetRange("Working Date", My_WorkingDate);
        if PayrollAttendanceEntries.FindFirst then PayrollAttendanceEntries.Delete;
    end;
    local procedure OverwriteSundaysRelief(No: Code[20]; My_WorkingDate: Date)
    var
        "Employee No": Code[20];
        WorkingDate: Date;
    begin
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Relief);
        PayrollAttendanceEntries.SetRange("Employee No.", No);
        PayrollAttendanceEntries.SetRange("Working Date", My_WorkingDate);
        if PayrollAttendanceEntries.FindSet then repeat PayrollAttendanceEntries.Delete;
            until PayrollAttendanceEntries.Next = 0;
    end;
    local procedure OverwriteHolidayDate(No: Code[20]; My_WorkingDate: Date)
    var
        "Employee No": Code[20];
        WorkingDate: Date;
    begin
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Holiday);
        PayrollAttendanceEntries.SetRange("Employee No.", No);
        PayrollAttendanceEntries.SetRange("Working Date", My_WorkingDate);
        if PayrollAttendanceEntries.FindSet then repeat PayrollAttendanceEntries.Delete;
            until PayrollAttendanceEntries.Next = 0;
    end;
    local procedure OverwriteAnnuaLeaveDate(No: Code[20]; My_WorkingDate: Date)
    var
        "Employee No": Code[20];
        WorkingDate: Date;
    begin
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetFilter("Posting Type", '%1|%2', PayrollAttendanceEntries."Posting Type"::Annual, PayrollAttendanceEntries."Posting Type"::"Unpaid Leave");
        PayrollAttendanceEntries.SetRange("Employee No.", No);
        PayrollAttendanceEntries.SetRange("Working Date", My_WorkingDate);
        if PayrollAttendanceEntries.FindSet then repeat PayrollAttendanceEntries.Delete;
            until PayrollAttendanceEntries.Next = 0;
    end;
    local procedure SickOffOverwriter(No: Code[20]; My_WorkingDate: Date)
    var
        "Employee No": Code[20];
        WorkingDate: Date;
    begin
        PayrollAttendanceEntries.Reset;
        PayrollAttendanceEntries.SetRange("Employee No.", No);
        PayrollAttendanceEntries.SetRange("Working Date", My_WorkingDate);
        if PayrollAttendanceEntries.FindSet then repeat PayrollAttendanceEntries.Delete;
            until PayrollAttendanceEntries.Next = 0;
    end;
}
