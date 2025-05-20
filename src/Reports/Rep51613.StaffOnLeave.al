report 51613 "Staff On Leave"
{
    // version THL- HRM 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Staff On Leave.rdlc';
    Caption = 'Staff Who Have Proceeded on Leave';

    dataset
    {
        dataitem("Employee Leave Application"; "Employee Leave Application")
        {
            DataItemTableView = WHERE(Status=CONST(Released));
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
            column(Casualleave; Casualleave)
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
                Period:=Format("Employee Leave Application"."Start Date") + ' - ' + Format("Employee Leave Application"."End Date");
                if "Employee Leave Application"."Leave Code" = 'CASUAL' then Casualleave:='Yes'
                else
                    Casualleave:='No';
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
    Casualleave: Text;
}
