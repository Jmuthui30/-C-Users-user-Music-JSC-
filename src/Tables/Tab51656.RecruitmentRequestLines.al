table 51656 "Recruitment Request Lines"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Position; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs";

            trigger OnValidate()
            begin
                if Pos.Get(Position)then begin
                    Description:=Pos.Name;
                    "Approved Positions":=Pos."Vacant Posistions";
                    Pos.CalcFields("Occupied Position");
                    "Occupied Positions":=Pos."Occupied Position";
                    "Vacant Positions":="Approved Positions" - "Occupied Positions";
                    "Global Dimension 1 Code":=Pos."Dimension 1";
                    "Global Dimension 2 Code":=Pos."Dimension 2";
                    "Global Dimension 3 Code":=Pos."Dimension 3";
                end;
            end;
        }
        field(4; Description; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Approved Positions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Occupied Positions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Vacant Positions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Required Positions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(11; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(12; "Expected Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; Reason; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Advertisement Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(21; "Advertisement Close Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(22; "Closed"; Boolean)
        {
            DataClassification = CustomerContent;
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
    var Pos: Record "Company Jobs";
}
