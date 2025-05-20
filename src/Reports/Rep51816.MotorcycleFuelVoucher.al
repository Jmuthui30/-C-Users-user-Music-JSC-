report 51816 "Motorcycle Fuel Voucher"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Motorcycle Fuel Voucher.rdlc';

    dataset
    {
        dataitem("Fuel Voucher Lines"; "Fuel Voucher Lines")
        {
            DataItemTableView = WHERE("Type of Voucher"=CONST("Motor-cycle Fuel Voucher"));

            column(Logo; CompInfo.Picture)
            {
            }
            column(Logo2; CompInfo.Picture2)
            {
            }
            column(CompName; UpperCase(CompName))
            {
            }
            column(CompAddress; UpperCase(CompAddress))
            {
            }
            column(CompAddress2; UpperCase(CompAddressTwo))
            {
            }
            column(CompCity; UpperCase(CompCity))
            {
            }
            column(CompPhone; CompPhone)
            {
            }
            column(CompCountry; CompInfo."Country/Region Code")
            {
            }
            column(VoucherNo; "Fuel Voucher Lines"."Voucher No.")
            {
            }
            column(Station; UpperCase("Fuel Voucher Lines"."Station Name"))
            {
            }
            column(StationAddress; UpperCase(StationAddress))
            {
            }
            column(PrintedBy; UserId)
            {
            }
            column(PrintedDateTime; CurrentDateTime)
            {
            }
            trigger OnAfterGetRecord()
            begin
                StationAddress:='';
                if Header.Get("Fuel Voucher Lines"."No.")then if Header."Global Dimension 2 Code" = 'KISUMU' then begin
                        CompName:=CompInfo."Branch Name";
                        CompAddress:=CompInfo."Branch Address";
                        CompAddressTwo:=CompInfo."Branch Address 2";
                        CompCity:=CompInfo."Branch City";
                        CompPhone:=CompInfo."Branch Phone No.";
                    end;
                if Stations.Get("Fuel Voucher Lines".Station)then StationAddress:=Stations.Address;
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
        CompInfo.CalcFields(Picture2);
        CompName:=CompInfo.Name;
        CompAddress:=CompInfo.Address;
        CompAddressTwo:=CompInfo."Address 2";
        CompCity:=CompInfo.City;
        CompPhone:=CompInfo."Phone No.";
    end;
    var CompInfo: Record "Company Information";
    CompName: Text;
    CompAddress: Text;
    CompAddressTwo: Text;
    CompCity: Text;
    CompPhone: Text;
    Header: Record "Fuel Voucher Header";
    StationAddress: Text;
    Stations: Record "Fuel Voucher Stations";
}
