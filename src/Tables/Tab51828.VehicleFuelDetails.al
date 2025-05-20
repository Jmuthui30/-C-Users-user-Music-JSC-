table 51828 "Vehicle Fuel Details"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Fuel Date"; Date)
        {
        }
        field(4; "Vehicle No."; Code[10])
        {
            TableRelation = Vehicle;

            trigger OnValidate()
            begin
                if Fleet.Get("Vehicle No.")then Description:=Fleet.Description;
                if Header.Get("No.")then begin
                    "Global Dimension 2 Code":=Header."Global Dimension 2 Code";
                    "Global Dimension 1 Code":=Header."Global Dimension 1 Code";
                end;
            end;
        }
        field(5; Description; Text[30])
        {
        }
        field(6; "Receipt No."; Code[20])
        {
        }
        field(7; "Unit Cost"; Decimal)
        {
            trigger OnValidate()
            begin
                "Fuel Cost":=Round("Unit Cost" * "Fuel Capacity", 0.01);
            end;
        }
        field(8; "Fuel Capacity"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Unit Cost");
            end;
        }
        field(9; "Fuel Cost"; Decimal)
        {
            Editable = false;
        }
        field(10; "Driver No."; Code[20])
        {
            TableRelation = Driver;

            trigger OnValidate()
            begin
                if Drivers.Get("Driver No.")then "Driver Name":=Drivers.Name;
            end;
        }
        field(11; "Driver Name"; Text[100])
        {
        }
        field(12; Mileage; Decimal)
        {
        }
        field(13; "Station No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Stations.Get("Station No.")then "Station Name":=Stations.Name;
            end;
        }
        field(14; "Station Name"; Text[50])
        {
        }
        field(15; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(16; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(17; Posted; Boolean)
        {
            trigger OnValidate()
            begin
                "Posted By":=UserId;
                "Posted Date":=Today;
            end;
        }
        field(18; "Posted Date"; Date)
        {
        }
        field(19; "Posted By"; Code[50])
        {
        }
        field(20; "Fuel Voucher No."; Code[10])
        {
        }
        field(21; "Fuel Card/LPO No."; Code[20])
        {
            trigger OnLookup()
            begin
                if "Fueled On" = "Fueled On"::"Fuel Card" then begin
                    FuelCards.Reset;
                    FuelCards.SetRange(Status, FuelCards.Status::Active);
                    if PAGE.RunModal(51905, FuelCards) = ACTION::LookupOK then "Fuel Card/LPO No.":=FuelCards."Card No.";
                end
                else if "Fueled On" = "Fueled On"::LPO then begin
                        LPOs.Reset;
                        LPOs.SetRange("Document Type", LPOs."Document Type"::Order);
                        if PAGE.RunModal(9307, LPOs) = ACTION::LookupOK then "Fuel Card/LPO No.":=LPOs."No.";
                    end;
            end;
        }
        field(22; "Fueled On"; Option)
        {
            OptionCaption = 'Fuel Card,LPO';
            OptionMembers = "Fuel Card", LPO;
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
        }
        key(Key2; "Vehicle No.", "Fuel Date")
        {
            SumIndexFields = "Fuel Cost", "Fuel Capacity";
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if Header.Get("No.")then begin
            "Global Dimension 2 Code":=Header."Global Dimension 2 Code";
            "Global Dimension 1 Code":=Header."Global Dimension 1 Code";
        end;
    end;
    var Fleet: Record Vehicle;
    Drivers: Record Driver;
    Stations: Record Vendor;
    Header: Record "Vehicle Fuel Header";
    FuelCards: Record "Fuel Card";
    LPOs: Record "Purchase Header";
}
