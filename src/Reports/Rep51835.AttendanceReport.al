report 51835 "Attendance Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Attendance Report.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Payroll Attendance Entries"; "Payroll Attendance Entries")
        {
            DataItemTableView = WHERE("Document No."=FILTER(<>' '));
            RequestFilterFields = Type, "Working Date", "Posting Type", "Shortcut Dimension 1 Code";

            column(Type; "Payroll Attendance Entries".Type)
            {
            IncludeCaption = true;
            }
            column(Posting_Type; "Payroll Attendance Entries"."Posting Type")
            {
            IncludeCaption = true;
            }
            column(Working_Date; Format("Payroll Attendance Entries"."Working Date"))
            {
            }
            column(EmployeeNo; "Payroll Attendance Entries"."Employee No.")
            {
            }
            column(EmployeeName; "Payroll Attendance Entries"."Employee Name")
            {
            }
            column(PayrollNo; "Payroll Attendance Entries"."P/No.")
            {
            }
            column(PostingDate; "Payroll Attendance Entries"."Posting Date")
            {
            }
            column(Division; "Payroll Attendance Entries"."Shortcut Dimension 1 Code")
            {
            }
            column(Reason; "Payroll Attendance Entries".Reason)
            {
            }
            column(LineNo; LineNo)
            {
            }
            column(Status; Status)
            {
            }
            column(HolidayOT; HolidayOT)
            {
            }
            column(NormalOT; NormalOT)
            {
            }
            column(AbsentDays; AbsentDays)
            {
            }
            column(AbsentHours; AbsentHours)
            {
            }
            column(DaysWorked; DaysWorked)
            {
            }
            column(Bonus; Bonus)
            {
            }
            column(Logo; CompanyInfo.Picture)
            {
            }
            column(CompanyLogoPosition; CompanyLogoPosition)
            {
            }
            column(CompanyAddress1; CompanyAddr[1])
            {
            }
            column(CompanyAddress2; CompanyAddr[2])
            {
            }
            column(CompanyAddress3; CompanyAddr[3])
            {
            }
            column(CompanyAddress4; CompanyAddr[4])
            {
            }
            column(CompanyAddress5; CompanyAddr[5])
            {
            }
            column(CompanyAddress6; CompanyAddr[6])
            {
            }
            trigger OnAfterGetRecord()
            var
                remaininghours: Decimal;
                DayOfWeek: Decimal;
            begin
                AttendanceDateFilter:="Payroll Attendance Entries".GetFilter("Working Date");
                AttendancePostingTypeFilter:="Payroll Attendance Entries".GetFilter("Posting Type");
                AbsentHours:=0;
                AbsentDays:=0;
                DaysWorked:=0;
                NormalOT:=0;
                HolidayOT:=0;
                Status:='';
                if(("Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Overtime) or ("Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Late) or ("Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Normal_Day))then Status:='P'
                else if(("Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Annual) or ("Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Marternity) or ("Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Parternity))then Status:='L'
                    else if("Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::"Unpaid Leave")then Status:='UL'
                        else if "Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Absent then Status:='A'
                            else if "Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Holiday then Status:='H'
                                else if "Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::"Sick Off" then Status:='SO'
                                    else if "Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Relief then Status:='R';
                /*
                IF "Payroll Attendance Entries"."Posting Type" = "Payroll Attendance Entries"."Posting Type"::Late THEN BEGIN
                  DayOfWeek := DATE2DWY("Payroll Attendance Entries"."Working Date", 1);
                  IF (DayOfWeek <> 6) OR (DayOfWeek <> 7) THEN
                    remaininghours := 6 - "Payroll Attendance Entries".Hours
                  ELSE
                  remaininghours := 8 - "Payroll Attendance Entries".Hours;
                 Status := 'P';
                END;
                */
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetFilter("Working Date", AttendanceDateFilter);
                PayrollAttendanceEntries.SetFilter("Posting Type", AttendancePostingTypeFilter);
                PayrollAttendanceEntries.SetRange("Employee No.", "Payroll Attendance Entries"."Employee No.");
                PayrollAttendanceEntries.SetFilter("Posting Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9', PayrollAttendanceEntries."Posting Type"::Normal_Day, PayrollAttendanceEntries."Posting Type"::Late, PayrollAttendanceEntries."Posting Type"::Holiday, PayrollAttendanceEntries."Posting Type"::Overtime, PayrollAttendanceEntries."Posting Type"::Relief, PayrollAttendanceEntries."Posting Type"::Annual, PayrollAttendanceEntries."Posting Type"::"Sick Off", PayrollAttendanceEntries."Posting Type"::Parternity, PayrollAttendanceEntries."Posting Type"::Marternity);
                if PayrollAttendanceEntries.FindSet then DaysWorked:=PayrollAttendanceEntries.Count;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetFilter("Working Date", AttendanceDateFilter);
                PayrollAttendanceEntries.SetFilter("Posting Type", AttendancePostingTypeFilter);
                PayrollAttendanceEntries.SetRange("Employee No.", "Payroll Attendance Entries"."Employee No.");
                PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Absent);
                if PayrollAttendanceEntries.FindSet then AbsentDays:=PayrollAttendanceEntries.Count;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetFilter("Working Date", AttendanceDateFilter);
                PayrollAttendanceEntries.SetFilter("Posting Type", AttendancePostingTypeFilter);
                PayrollAttendanceEntries.SetRange("Employee No.", "Payroll Attendance Entries"."Employee No.");
                PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Late);
                PayrollAttendanceEntries.SetRange(Late, true);
                if PayrollAttendanceEntries.FindSet then begin
                    PayrollAttendanceEntries.CalcSums(Hours);
                    AbsentHours:=PayrollAttendanceEntries.Hours;
                end;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetFilter("Working Date", AttendanceDateFilter);
                PayrollAttendanceEntries.SetFilter("Posting Type", AttendancePostingTypeFilter);
                PayrollAttendanceEntries.SetRange("Employee No.", "Payroll Attendance Entries"."Employee No.");
                PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Overtime);
                PayrollAttendanceEntries.SetRange("Special Overtime", true);
                if PayrollAttendanceEntries.FindSet then begin
                    PayrollAttendanceEntries.CalcSums(Hours);
                    HolidayOT:=PayrollAttendanceEntries.Hours;
                end;
                PayrollAttendanceEntries.Reset;
                PayrollAttendanceEntries.SetFilter("Working Date", AttendanceDateFilter);
                PayrollAttendanceEntries.SetFilter("Posting Type", AttendancePostingTypeFilter);
                PayrollAttendanceEntries.SetRange("Employee No.", "Payroll Attendance Entries"."Employee No.");
                PayrollAttendanceEntries.SetRange("Posting Type", PayrollAttendanceEntries."Posting Type"::Overtime);
                PayrollAttendanceEntries.SetRange("Normal Overtime", true);
                if PayrollAttendanceEntries.FindSet then begin
                    PayrollAttendanceEntries.CalcSums(Hours);
                    NormalOT:=PayrollAttendanceEntries.Hours;
                end;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnInitReport()
    begin
        CompanyInfo.Get;
        ServiceSetup.Get;
        FormatDocument.SetLogoPosition(ServiceSetup."Logo Position on Documents", CompanyInfo1, CompanyInfo2, CompanyInfo3);
    end;
    trigger OnPreReport()
    begin
        CompanyInfo.CalcFields(Picture);
        CompanyInfo.CalcFields(Picture2);
        FormatAddr.Company(CompanyAddr, CompanyInfo);
    end;
    var CompanyInfo: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    CompanyInfo3: Record "Company Information";
    CompanyAddr: array[8]of Text[50];
    FormatAddr: Codeunit 365;
    CompanyLogoPosition: Integer;
    ServiceSetup: Record "Service Mgt. Setup";
    FormatDocument: Codeunit 368;
    Status: Code[10];
    DaysWorked: Integer;
    DaysWorked1: Integer;
    DaysWorked2: Integer;
    DaysWorked3: Integer;
    HolidayOT: Decimal;
    NormalOT: Decimal;
    AbsentDays: Integer;
    AbsentHours: Decimal;
    Bonus: Decimal;
    AttendanceDateFilter: Text[50];
    AttendancePostingTypeFilter: Text[50];
    PayrollAttendanceEntries: Record "Payroll Attendance Entries";
    LineNo: Integer;
}
