report 51818 "Service Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Service Report.rdlc';

    dataset
    {
        dataitem("Vehicle Service Details"; "Vehicle Service Details")
        {
            DataItemTableView = WHERE(Posted=CONST(true));
            RequestFilterFields = "Service & Check Code", "Posted Date";

            column(ReportFilters; "Vehicle Service Details".GetFilters)
            {
            }
            column(SN; SN)
            {
            }
            column(ID; "Vehicle Service Details"."No.")
            {
            }
            column(RegNoAndMake; RegNoAndMake)
            {
            }
            column(Service; "Vehicle Service Details"."Service & Check")
            {
            }
            column(NextService; NextService)
            {
            }
            column(DateTimeIn; Header."Date & Time in")
            {
            }
            column(DateTimeOut; Header."Date & Time Out")
            {
            }
            column(GarageMechanic; Header."Mechanic Name")
            {
            }
            column(DateServiced; DT2Date(Header."Date & Time in"))
            {
            }
            column(Cost; "Vehicle Service Details".Amount)
            {
            }
            column(Details; "Vehicle Service Details"."Service Details")
            {
            }
            trigger OnAfterGetRecord()
            begin
                RegNoAndMake:='';
                NextService:=0;
                SN:=SN + 1;
                if Header.Get("Vehicle Service Details"."No.")then begin
                    RegNoAndMake:=Header."Vehicle Reg No." + ' - ' + Header.Make;
                    NextService:=Header."Next Service Required";
                end;
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
    trigger OnPostReport()
    begin
        SN:=0;
    end;
    var SN: Integer;
    RegNoAndMake: Text;
    Header: Record "Vehicle Service Header";
    NextService: Decimal;
}
