report 51602 "Leave Balance new"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Leave Balance.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = where(Status = const(Active));
            RequestFilterFields = "No.";

            column(No_Employee; Employee."No.")
            {
            }
            column(Name; Name)
            {
            }
            column(Balance_B_FCaptionLbl; Balance_B_FCaptionLbl)
            {
            }
            column(BalanceCaptionLbl; BalanceCaptionLbl)
            {
            }
            column(NameCaptionLbl; NameCaptionLbl)
            {
            }
            column(EntitlmentCaptionLbl; EntitlmentCaptionLbl)
            {
            }
            column(Days_TakenCaptionLbl; Days_TakenCaptionLbl)
            {
            }
            column(Days_RecalledCaptionLbl; Days_RecalledCaptionLbl)
            {
            }
            column(Days_AbsentCaptionLbl; Days_AbsentCaptionLbl)
            {
            }
            column(ANNUAL_LEAVE_BALANCE_CaptionLbl; ANNUAL_LEAVE_BALANCE_CaptionLbl)
            {
            }
            column(BalanceBF; BalanceBF)
            {
            }
            column(Entitlement; Entitlement)
            {
            }
            column(TotalRecalls; TotalRecalls)
            {
            }
            column(TotalAbsence; TotalAbsence)
            {
            }
            column(TotalTaken; TotalTaken)
            {
            }
            column(Balance; Balance)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column(DateFilter; StrSubstNo('AS AT %1', DateFilter))
            {
            }
            trigger OnAfterGetRecord()
            begin
                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                //Balance Brought Forward;
                BalanceBF := 0;
                Entitlement := 0;
                if Leavefilter = 'ANNUAL' then begin
                    EmployeeLeaves.Reset;
                    EmployeeLeaves.SetRange("Employee No", "No.");
                    EmployeeLeaves.SetFilter("Maturity Date", '>%1', DateFilter);
                    EmployeeLeaves.SetRange(EmployeeLeaves."Leave Code", Leavefilter);
                    if EmployeeLeaves.Find('+') then begin
                        BalanceBF := EmployeeLeaves."Balance Brought Forward";
                        Entitlement := EmployeeLeaves.Entitlement;
                        EndDate := EmployeeLeaves."Maturity Date";
                        StartDate := CalcDate('-1Y', EmployeeLeaves."Maturity Date") + 1;
                        //  MESSAGE('Entitlement=%1',Entitlement);
                    end
                    else begin
                        AcctPeriod.Reset;
                        AcctPeriod.SetRange(AcctPeriod."Starting Date", 0D, Today);
                        AcctPeriod.SetRange(AcctPeriod."New Fiscal Year", true);
                        if AcctPeriod.Find('-') then begin
                            StartingDate := AcctPeriod."Starting Date";
                            Employee.TestField("Employment Date");
                            if Employee."Employment Date" > AcctPeriod."Starting Date" then Entitlement := Round(((MaturityDateFilter - Employee."Employment Date") / 30) * 2.5, 0.1);
                            EmployeeLeaves.Init;
                            EmployeeLeaves."Leave Code" := Leavefilter;
                            EmployeeLeaves."Employee No" := "No.";
                            EmployeeLeaves.Entitlement := Entitlement;
                            EmployeeLeaves."Maturity Date" := MaturityDateFilter;
                            if not EmployeeLeaves.Get(EmployeeLeaves."Employee No", EmployeeLeaves."Leave Code", EmployeeLeaves."Maturity Date") then EmployeeLeaves.Insert;
                        end;
                    end;
                end;
                if Leavefilter <> 'ANNUAL' then begin
                    EmployeeLeaves.Reset;
                    EmployeeLeaves.SetRange("Employee No", "No.");
                    EmployeeLeaves.SetFilter("Maturity Date", '>1%', DateFilter);
                    if EmployeeLeaves.Find('+') then begin
                        EndDate := EmployeeLeaves."Maturity Date";
                        StartDate := CalcDate('-1Y', EmployeeLeaves."Maturity Date") + 1;
                    end;
                end;
                TotalTaken := 0;
                EmpLeaveApps.Reset;
                EmpLeaveApps.SetRange("Employee No", "No.");
                EmpLeaveApps.SetRange("Maturity Date", EndDate);
                EmpLeaveApps.SetRange("Leave Code", Leavefilter);
                if EmpLeaveApps.Find('-') then begin
                    repeat
                        TotalTaken := TotalTaken + EmpLeaveApps."Days Applied";
                    until EmpLeaveApps.Next = 0;
                end;
                TotalRecalls := 0;
                if Leavefilter = 'ANNUAL' then begin
                    Recalls.Reset;
                    Recalls.SetRange("Employee No", "No.");
                    Recalls.SetRange("Maturity Date", EndDate);
                    Recalls.SetFilter(Recalls."Recalled To", '<=%1', DateFilter);
                    Recalls.CalcSums(Recalls."No. of Off Days");
                    TotalRecalls := Recalls."No. of Off Days";
                    Absences.Reset;
                    Absences.SetRange("Employee No", "No.");
                    Absences.SetRange("Maturity Date", EndDate);
                    Absences.SetFilter(Absences."Absent To", '<=%1', DateFilter);
                    Absences.CalcSums(Absences."No. of  Days Absent");
                    TotalAbsence := Absences."No. of  Days Absent";
                    Balance := BalanceBF + Entitlement - TotalTaken + TotalRecalls - TotalAbsence;
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
                field("Date Filter"; DateFilter)
                {
                    ApplicationArea = All;
                }
                field(LeaveFilter; Leavefilter)
                {
                    ApplicationArea = All;
                    TableRelation = "Leave Period"."Leave Period Code";
                    trigger OnLookup(var Text: Text): Boolean
                    begin
                    end;
                }
                field(MaturityDateFilter; MaturityDateFilter)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
        //Label  'ANNUAL LEAVE BALANCE';
    }
    trigger OnPreReport()
    begin
        AcctPeriod.Reset;
        AcctPeriod.SetRange(AcctPeriod."Starting Date", 0D, Today);
        AcctPeriod.SetRange(AcctPeriod."New Fiscal Year", true);
        if AcctPeriod.Find('+') then MaturityDateFilter := CalcDate('1Y', AcctPeriod."Starting Date") - 1;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        Emp: Record Employee;
        Name: Text[50];
        // AcctPeriod: Record "Accounting Period";
        AcctPeriod: Record "Payroll Period";
        AccPeriod: Record "Payroll Period";
        MaturityDateFilter: Date;
        CompanyInfo: Record "Company Information";
        EmpLeaveApps: Record "Leave Application";
        TotalTaken: Decimal;
        Recalls: Record "Employee Off/Holidays";
        TotalRecalls: Decimal;
        Absences: Record "Employee Absentism";
        TotalAbsence: Decimal;
        ANNUAL_LEAVE_BALANCE_CaptionLbl: Label 'ANNUAL LEAVE BALANCE ';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Staff_No_CaptionLbl: Label 'Staff No.';
        NameCaptionLbl: Label 'Name';
        Balance_B_FCaptionLbl: Label 'Balance B/F';
        BalanceCaptionLbl: Label 'Balance';
        EntitlmentCaptionLbl: Label 'Entitlment';
        Days_TakenCaptionLbl: Label 'Days Taken';
        Days_RecalledCaptionLbl: Label 'Days Recalled';
        Days_AbsentCaptionLbl: Label 'Days Absent';
        BalanceBF: Decimal;
        Entitlement: Decimal;
        EmployeeLeaves: Record "Employee Leaves";
        Balance: Decimal;
        DateFilter: Date;
        StartDate: Date;
        EndDate: Date;
        Leavefilter: Code[30];
        LeaveTypes: Record "Leave Setup";
        StartingDate: Date;
        OurEmp: Record "Employee Master";
        ApplicationDate: Date;
}
