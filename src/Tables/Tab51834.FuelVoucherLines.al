table 51834 "Fuel Voucher Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Type of Voucher"; Option)
        {
            OptionCaption = ' ,Bulk Fuel Voucher,Vehicle Fuel Voucher,Motor-cycle Fuel Voucher';
            OptionMembers = " ", "Bulk Fuel Voucher", "Vehicle Fuel Voucher", "Motor-cycle Fuel Voucher";
        }
        field(4; Station; Code[20])
        {
            TableRelation = "Fuel Voucher Stations";

            trigger OnValidate()
            begin
                if Stations.Get(Station)then begin
                    "Station Name":=Stations.Name;
                    if "Type of Voucher" = "Type of Voucher"::" " then Error('Please specify type of voucher.')
                    else if "Type of Voucher" = "Type of Voucher"::"Bulk Fuel Voucher" then "Voucher No.":=NoseriesMgt.GetNextNo(Stations."Bulk Fuel Voucher Nos.", Today, true)
                        else if "Type of Voucher" = "Type of Voucher"::"Motor-cycle Fuel Voucher" then "Voucher No.":=NoseriesMgt.GetNextNo(Stations."Motorcycle Fuel Voucher Nos.", Today, true)
                            else if "Type of Voucher" = "Type of Voucher"::"Vehicle Fuel Voucher" then "Voucher No.":=NoseriesMgt.GetNextNo(Stations."Vehicle Fuel Voucher Nos.", Today, true);
                end;
            end;
        }
        field(5; "Station Name"; Text[100])
        {
        }
        field(6; "Voucher No."; Code[20])
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
    }
    fieldgroups
    {
    }
    var Stations: Record "Fuel Voucher Stations";
    NoseriesMgt: Codeunit NoSeriesManagement;
}
