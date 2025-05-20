report 51615 "Excuse Duty"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Excuse Duty.rdlc';
    Caption = 'Staff On Excuse Duty';

    dataset
    {
        dataitem("Employee Absence"; "Employee Absence")
        {
            RequestFilterFields = "From Date", "To Date", "Cause of Absence Code";

            column(Logo; CompInfo.Picture)
            {
            }
            column(SN; SN)
            {
            }
            column(Name; Name)
            {
            }
            column(Department; Dept)
            {
            }
            column(Location; Location)
            {
            }
            column(NoOfDays; "Employee Absence".Quantity)
            {
            }
            column(Date; "Employee Absence"."From Date")
            {
            }
            column(DateApproved; "Employee Absence"."From Date")
            {
            }
            column(NameOfHospital; NameOfHospital)
            {
            }
            column(HMOHospital; HMOHospital)
            {
            }
            column(StaffIDNo; "Employee Absence"."Employee No.")
            {
            }
            column(Grade; GradeLevel)
            {
            }
            column(Period; Period)
            {
            }
            column(Casualleave; "Employee Absence"."Quantity (Base)")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if Emp.Get("Employee Absence"."Employee No.")then Name:=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                if OurEmp.Get("Employee Absence"."Employee No.")then begin
                    if OurEmp.Level <> '' then GradeLevel:=OurEmp.Scale + ' - ' + OurEmp.Level
                    else
                        GradeLevel:=OurEmp.Scale;
                    if DimensionValue.Get('DEPARTMENT', OurEmp."Global Dimension 1 Code")then Dept:=DimensionValue.Name;
                    if DimensionValue.Get('BRANCH', OurEmp."Global Dimension 2 Code")then Location:=DimensionValue.Name;
                end;
                if Hospitals.Get("Employee Absence"."Entry No.")then begin
                    NameOfHospital:=Hospitals."Hospital Visited";
                    if Hospitals."Is a HMO Hospital?" then HMOHospital:='Yes'
                    else
                        HMOHospital:='No';
                end;
                SN:=SN + 1;
            end;
            trigger OnPreDataItem()
            begin
                SN:=0;
            end;
        }
    }
    requestpage
    {
        layout
        {
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
        CompInfo.Get;
        CompInfo.CalcFields(Picture);
    end;
    var CompInfo: Record "Company Information";
    SN: Integer;
    GradeLevel: Text;
    OurEmp: Record "Employee Master";
    Location: Text;
    Dept: Text;
    DimensionValue: Record "Dimension Value";
    Period: Text;
    Hospitals: Record "Excuse Duty Hospitals";
    Name: Text;
    Emp: Record Employee;
    NameOfHospital: Text;
    HMOHospital: Text;
}
