report 51444 "Time Sheet Entries"
{
    // version THL- Payroll 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Time Sheet Entries.rdlc';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = WHERE(Status=CONST(Active));
            RequestFilterFields = "No.";

            column(Logo; CompInfo.Picture)
            {
            }
            column(EmplNo; Employee."No.")
            {
            }
            column(FirstName; Employee."First Name")
            {
            }
            column(MiddleName; Employee."Middle Name")
            {
            }
            column(LastName; Employee."Last Name")
            {
            }
            column(ResourceNo; Employee."Resource No.")
            {
            }
            column(TotalHours; Hours)
            {
            }
            column(Month; Month)
            {
            }
            column(RequiredHours; RequiredHours)
            {
            }
            column(Deviation; Deviation)
            {
            }
            column(HourlyRate; HourlyRate)
            {
            }
            column(TotalValue; TotalValue)
            {
            }
            trigger OnAfterGetRecord()
            begin
                Hours:=0;
                Deviation:=0;
                HourlyRate:=0;
                TotalValue:=0;
                if Emp.Get(Employee."No.")then if Emp."Employee Group" = 'PARTNER' then CurrReport.Skip;
                if SkipNonProjectStaff then if Employee."Resource No." = '' then CurrReport.Skip;
                //ERROR(STRSUBSTNO(Text001,Employee."First Name"+' '+Employee."Last Name"));
                Timesheet.Reset;
                Timesheet.SetRange("Resource No.", Employee."Resource No.");
                Timesheet.SetRange("Submitted Exists", true);
                Timesheet.SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                if Timesheet.Find('-')then begin
                    repeat Timesheet.CalcFields(Quantity);
                        Hours:=Hours + Timesheet.Quantity;
                    until Timesheet.Next = 0;
                end;
                PayrollSetup.Get;
                if PayrollSetup."Working Hours" <> 0 then RequiredHours:=PayrollSetup."Working Hours" * 20;
                Deviation:=Hours - RequiredHours;
                Emp.Reset;
                Emp.SetRange("No.", Employee."No.");
                Emp.SetFilter("Pay Period Filter", '%1', CalcDate('-1M', Month));
                if Emp.FindFirst then begin
                    Emp.CalcFields("Total Allowances", "Employer Costs");
                    HourlyRate:=Round((Emp."Total Allowances" + Abs(Emp."Employer Costs")) / RequiredHours, 0.01);
                end;
                TotalValue:=Deviation * HourlyRate;
                if SendToPayroll then begin
                    PayrollSetup.Get;
                    if TotalValue < 0 then PayrollMgt.InsertDeductionPayrollEntry(Employee."No.", PayrollSetup."Time Sheet Penalty Code", TotalValue);
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
                field(Month; Month)
                {
                    ApplicationArea = All;
                    Caption = 'Pay Period';
                    TableRelation = "Payroll Period";
                }
                field(SkipNonProjectStaff; SkipNonProjectStaff)
                {
                    ApplicationArea = All;
                    Caption = 'Skip Non Project Staff?';
                }
                field(SendToPayroll; SendToPayroll)
                {
                    ApplicationArea = All;
                    Caption = 'Send to Payroll?';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        if Month = 0D then Error(Text000);
        StartDate:=Month;
        EndDate:=CalcDate('1M', StartDate - 1);
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;
    var Month: Date;
    CompInfo: Record "Company Information";
    StartDate: Date;
    EndDate: Date;
    Text000: Label 'You must select a payroll period';
    Timesheet: Record "Time Sheet Header";
    Text001: Label '%1 has not been mapped to a resource card';
    Hours: Decimal;
    Emp: Record "Employee Master";
    PayrollSetup: Record "QuantumJumps Payroll Setup";
    RequiredHours: Decimal;
    Deviation: Decimal;
    HourlyRate: Decimal;
    TotalValue: Decimal;
    SkipNonProjectStaff: Boolean;
    SendToPayroll: Boolean;
    PayrollMgt: Codeunit "Payroll Calculator";
}
