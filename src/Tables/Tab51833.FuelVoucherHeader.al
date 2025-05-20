table 51833 "Fuel Voucher Header"
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
        field(4; Posted; Boolean)
        {
        }
        field(5; "Posted By"; Code[50])
        {
        }
        field(6; "Posted Date"; Date)
        {
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
            /*Lines.RESET;
                Lines.SETRANGE("No.","No.");
                Lines.MODIFYALL("Global Dimension 1 Code","Global Dimension 1 Code");*/
            end;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
            /*Lines.RESET;
                Lines.SETRANGE("No.","No.");
                Lines.MODIFYALL("Global Dimension 2 Code","Global Dimension 2 Code");*/
            end;
        }
        field(9; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(10; "No. of Vouchers"; Integer)
        {
            CalcFormula = Count("Fuel Voucher Lines" WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
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
            MotorpoolSetup.TestField("Fuel Voucher Nos.");
            NoSeriesMgt.InitSeries(MotorpoolSetup."Fuel Voucher Nos.", xRec."No.", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        "Created Date":=Today;
    end;
    var MotorpoolSetup: Record "Motorpool Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
