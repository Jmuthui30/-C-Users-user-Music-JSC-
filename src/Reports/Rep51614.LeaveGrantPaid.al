report 51614 "Leave Grant Paid"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Leave Grant Paid.rdlc';
    Caption = 'Staff Paid Leave Grant in the period';

    dataset
    {
        dataitem("Employee Leave Application"; "Employee Leave Application")
        {
            DataItemTableView = WHERE(Status=CONST(Released), "Leave Allowance Payable"=CONST(Yes));
            RequestFilterFields = "Start Date", "End Date", "Application Date", "Leave Code", "Resumption Date";

            column(Logo; CompInfo.Picture)
            {
            }
            column(SN; SN)
            {
            }
            column(Name; "Employee Leave Application".Name)
            {
            }
            column(StaffIDNo; "Employee Leave Application"."Employee No")
            {
            }
            column(Grade; GradeLevel)
            {
            }
            column(Department; Dept)
            {
            }
            column(Location; Location)
            {
            }
            column(Period; Period)
            {
            }
            column(NoOfDays; "Employee Leave Application"."Days Applied")
            {
            }
            column(Casualleave; "Employee Leave Application"."Leave Allowance Paid")
            {
            }
            trigger OnAfterGetRecord()
            begin
                if OurEmp.Get("Employee Leave Application"."Employee No")then begin
                    if OurEmp.Level <> '' then GradeLevel:=OurEmp.Scale + ' - ' + OurEmp.Level
                    else
                        GradeLevel:=OurEmp.Scale;
                    if DimensionValue.Get('DEPARTMENT', OurEmp."Global Dimension 1 Code")then Dept:=DimensionValue.Name;
                    if DimensionValue.Get('BRANCH', OurEmp."Global Dimension 2 Code")then Location:=DimensionValue.Name;
                end;
                Period:=Format(Date2DMY("Employee Leave Application"."Start Date", 3));
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
}
