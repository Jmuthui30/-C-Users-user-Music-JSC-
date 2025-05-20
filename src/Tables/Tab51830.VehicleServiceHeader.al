table 51830 "Vehicle Service Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Created Date"; Date)
        {
        }
        field(3; "Created By"; Code[50])
        {
        }
        field(4; "Vehicle Reg No."; Code[20])
        {
            TableRelation = Vehicle;

            trigger OnValidate()
            begin
                if Fleet.Get("Vehicle Reg No.")then begin
                    "Engine No.":=Fleet."Engine No.";
                    Make:=Fleet.Description;
                end;
            end;
        }
        field(5; "Engine No."; Code[20])
        {
        }
        field(6; Posted; Boolean)
        {
            trigger OnValidate()
            begin
                "Posted By":=UserId;
                "Posted Date":=Today;
            end;
        }
        field(7; "Posted Date"; Date)
        {
        }
        field(8; "Posted By"; Code[50])
        {
        }
        field(9; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(10; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("No.", "No.");
                Lines.ModifyAll("Global Dimension 1 Code", "Global Dimension 1 Code");
            end;
        }
        field(11; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                Lines.Reset;
                Lines.SetRange("No.", "No.");
                Lines.ModifyAll("Global Dimension 2 Code", "Global Dimension 2 Code");
            end;
        }
        field(12; Make; Text[30])
        {
        }
        field(13; "Date & Time in"; DateTime)
        {
        }
        field(14; "Date & Time Out"; DateTime)
        {
        }
        field(15; "Serviced at Km"; Decimal)
        {
        }
        field(16; "Next Service Required"; Decimal)
        {
        }
        field(17; "Total Cost"; Decimal)
        {
            CalcFormula = Sum("Vehicle Service Details".Amount WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(18; "Mechanic No."; Code[20])
        {
            TableRelation = Driver;

            trigger OnValidate()
            begin
                if Mechanics.Get("Mechanic No.")then "Mechanic Name":=Mechanics.Name;
            end;
        }
        field(19; "Mechanic Name"; Text[100])
        {
        }
        field(20; "Mechanic Comments"; Text[250])
        {
        }
        field(21; "Mechanic Date Signed"; Date)
        {
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
            MotorpoolSetup.Get;
            MotorpoolSetup.TestField("Vehicle Service Nos.");
            NoSeriesMgt.InitSeries(MotorpoolSetup."Vehicle Service Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        "Created Date":=Today;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    MotorpoolSetup: Record "Motorpool Setup";
    Lines: Record "Vehicle Fuel Details";
    Fleet: Record Vehicle;
    Mechanics: Record Driver;
}
