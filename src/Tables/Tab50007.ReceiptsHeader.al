table 50007 "Receipts Header"
{
    // version THL-Basic Fin 1.0
    DrillDownPageID = "Receipts";
    LookupPageID = "Receipts";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;

            trigger OnValidate()
            begin
                GLSetup.Get;
                if "No." <> xRec."No." then begin
                    NoSeriesMgt.TestManual(GLSetup."Receipt Nos");
                end;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Pay Mode"; Code[20])
        {
            TableRelation = "Pay Mode";
        }
        field(4; "Cheque No"; Code[20])
        {
        }
        field(5; "Cheque Date"; Date)
        {
        }
        field(6; Amount; Decimal)
        {
            CalcFormula = Sum("Receipt Lines".Amount WHERE("Receipt No."=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Amount(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(8; "Bank Code"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(9; "Received From"; Text[70])
        {
        }
        field(10; "On Behalf Of"; Text[70])
        {
        }
        field(11; Cashier; Code[50])
        {
            Editable = false;
        }
        field(12; Posted; Boolean)
        {
            Editable = false;
        }
        field(13; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(14; "Posted Time"; Time)
        {
            Editable = false;
        }
        field(15; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(16; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(17; "Currency Code"; Code[20])
        {
            TableRelation = Currency;
        }
        field(18; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(19; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(20; Status; Option)
        {
            Editable = false;
            OptionCaption = 'Open,Pending Approval,Pending Prepayment,Released,,,Closed';
            OptionMembers = Open, "Pending Approval", "Pending Prepayment", Released, , , Closed;
        }
        field(21; "Receipt Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Advance';
            OptionMembers = Normal, Advance;
        }
        field(22; Description; Text[100])
        {
            DataClassification = ToBeClassified;
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
        GLSetup.Get;
        if "No." = '' then begin
            GLSetup.TestField("Receipt Nos");
            NoSeriesMgt.InitSeries(GLSetup."Receipt Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Cashier:=UserId;
    end;
    var NoSeriesMgt: Codeunit NoSeriesManagement;
    GLSetup: Record "Cash Management Setup";
}
