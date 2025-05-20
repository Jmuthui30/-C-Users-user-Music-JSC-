table 51816 "Vehicle"
{
    // version THL- PRM 1.0
    DrillDownPageID = "Vehicle List";
    LookupPageID = "Vehicle List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; Description; Text[30])
        {
        }
        field(3; "Reg No."; Code[10])
        {
        }
        field(4; "ECN No."; Code[20])
        {
        }
        field(5; Manufacturer; Text[50])
        {
        }
        field(6; Movement; Integer)
        {
        }
        field(7; Model; Code[50])
        {
        }
        field(8; "Item ID"; Code[100])
        {
        }
        field(9; "Next Service Mileage"; Integer)
        {
        }
        field(10; "Insurance Expiry Date"; Date)
        {
        }
        field(11; "Part of Fleet"; Option)
        {
            OptionCaption = 'No,Yes';
            OptionMembers = No, Yes;
        }
        field(12; "Chasis No."; Code[30])
        {
        }
        field(13; "Engine No."; Code[30])
        {
        }
        field(14; "Date Of Manufacture"; Code[30])
        {
        }
        field(15; "Sitting Capacity"; Integer)
        {
        }
        field(16; "Fuel Type"; Option)
        {
            OptionMembers = " ", Petrol, Diesel, Other;
        }
        field(17; "Due For Service"; Boolean)
        {
        }
        field(18; "EDR Camera Serial No."; Code[50])
        {
        }
        field(19; "Years Used"; Decimal)
        {
        }
        field(20; "Kms Done"; Decimal)
        {
        }
        field(21; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(22; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(23; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(24; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(25; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(26; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,1,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(27; "Covered Mileage"; Decimal)
        {
            CalcFormula = Sum("Work Ticket Lines"."Distance Covered (KM)" WHERE(Vehicle=FIELD("No."), Date=FIELD("Date Filter"), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter")));
            FieldClass = FlowField;
        }
        field(28; "Vehicle Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = Vehicle;
        }
        field(29; "Raised By"; code[50])
        {
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if("No." = '')then begin
            MotorSetup.Get;
            MotorSetup.TestField("Vehicle Nos.");
            NoSeriesMgt.InitSeries(MotorSetup."Vehicle Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Raised By":=UserId;
    end;
    var MotorSetup: Record "Motorpool Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    procedure AssitEdit(): Boolean begin
        MotorSetup.Get;
        MotorSetup.TestField("Vehicle Nos.");
        if NoSeriesMgt.SelectSeries(MotorSetup."Vehicle Nos.", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
}
