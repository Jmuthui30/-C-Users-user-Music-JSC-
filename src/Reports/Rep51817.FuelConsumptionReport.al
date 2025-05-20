report 51817 "Fuel Consumption Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Fuel Consumption Report.rdlc';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Vehicle Fuel Details"; "Vehicle Fuel Details")
        {
            DataItemTableView = WHERE(Posted=CONST(true));
            RequestFilterFields = "Fuel Date", "Vehicle No.", "Receipt No.", "Driver No.", "Station No.", "Global Dimension 2 Code", "Fuel Voucher No.", "Fueled On", "Fuel Card/LPO No.";

            column(ReportFilters; "Vehicle Fuel Details".GetFilters)
            {
            }
            column(SN; SN)
            {
            }
            column(ID; "Vehicle Fuel Details"."No.")
            {
            }
            column(FuelDate; "Vehicle Fuel Details"."Fuel Date")
            {
            }
            column(ReceiptNo; "Vehicle Fuel Details"."Receipt No.")
            {
            }
            column(Vehicle; "Vehicle Fuel Details"."Vehicle No." + ' - ' + "Vehicle Fuel Details".Description)
            {
            }
            column(FueledOn; "Vehicle Fuel Details"."Fueled On")
            {
            }
            column(FuelCardLPONo; "Vehicle Fuel Details"."Fuel Card/LPO No.")
            {
            }
            column(FuelVoucherNo; "Vehicle Fuel Details"."Fuel Voucher No.")
            {
            }
            column(UnitCost; "Vehicle Fuel Details"."Unit Cost")
            {
            }
            column(Capacity; "Vehicle Fuel Details"."Fuel Capacity")
            {
            }
            column(FuelCost; "Vehicle Fuel Details"."Fuel Cost")
            {
            }
            column(Driver; "Vehicle Fuel Details"."Driver Name")
            {
            }
            column(Mileage; "Vehicle Fuel Details".Mileage)
            {
            }
            column(Station; "Vehicle Fuel Details"."Station Name")
            {
            }
            column(Site; "Vehicle Fuel Details"."Global Dimension 2 Code")
            {
            }
            column(Project; "Vehicle Fuel Details"."Global Dimension 1 Code")
            {
            }
            trigger OnAfterGetRecord()
            begin
                SN:=SN + 1;
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
}
