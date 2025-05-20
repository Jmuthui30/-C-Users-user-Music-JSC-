table 51827 "Vehicle Fuel Header"
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
        field(4; "Total Fuel Capacity"; Decimal)
        {
            CalcFormula = Sum("Vehicle Fuel Details"."Fuel Capacity" WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(5; "Total Fuel Cost"; Decimal)
        {
            CalcFormula = Sum("Vehicle Fuel Details"."Fuel Cost" WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
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
            MotorpoolSetup.TestField("Fuel Card Nos.");
            NoSeriesMgt.InitSeries(MotorpoolSetup."Fuel Card Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        "Created Date":=Today;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    MotorpoolSetup: Record "Motorpool Setup";
    Lines: Record "Vehicle Fuel Details";
}
