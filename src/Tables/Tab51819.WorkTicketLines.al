table 51819 "Work Ticket Lines"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Work Ticket Entries";
    LookupPageID = "Work Ticket Entries";

    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
        }
        field(3; Vehicle; Code[20])
        {
            TableRelation = Vehicle;
        }
        field(4; Date; Date)
        {
            trigger OnValidate()
            begin
                if Header.Get("No.")then begin
                    if Header."Global Dimension 2 Code" <> '' then "Global Dimension 2 Code":=Header."Global Dimension 2 Code";
                end;
            end;
        }
        field(5; Driver; Code[20])
        {
            trigger OnLookup()
            begin
                TicketDrivers.Reset;
                TicketDrivers.SetRange("No.", "No.");
                if PAGE.RunModal(51869, TicketDrivers) = ACTION::LookupOK then Validate(Driver, TicketDrivers."Driver No.");
            end;
            trigger OnValidate()
            begin
                if Drivers.Get(Driver)then "Driver Name":=Drivers.Name;
            end;
        }
        field(6; Details; Text[250])
        {
        }
        field(7; "Time Out"; Time)
        {
        }
        field(8; "Time In"; Time)
        {
        }
        field(9; "Odometer Reading at Start (KM)"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("Odometer Reading at End (KM)");
            end;
        }
        field(10; "Odometer Reading at End (KM)"; Decimal)
        {
            trigger OnValidate()
            begin
                if "Odometer Reading at Start (KM)" <> 0 then "Distance Covered (KM)":="Odometer Reading at End (KM)" - "Odometer Reading at Start (KM)"
                else
                    "Distance Covered (KM)":=0;
            end;
        }
        field(11; "Distance Covered (KM)"; Decimal)
        {
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(14; Status; Option)
        {
            OptionCaption = 'Open,Issued,Closed,Canceled';
            OptionMembers = Open, Issued, Closed, Canceled;
        }
        field(15; "Cost of Fuel (KES)"; Decimal)
        {
        }
        field(16; "Driver Name"; Text[100])
        {
        }
    }
    keys
    {
        key(Key1; "No.", "Line No")
        {
        }
    }
    fieldgroups
    {
    }
    var Drivers: Record Driver;
    TicketDrivers: Record "Work Ticket Drivers";
    Header: Record "Work Ticket Header";
}
