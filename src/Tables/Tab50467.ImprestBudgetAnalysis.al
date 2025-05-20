table 50467 "Imprest Budget Analysis"
{
    Caption = 'Imprest Budget Analysis';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Imprest Budget Analysis";
    LookupPageId = "Imprest Budget Analysis";

    fields
    {
        field(1; "Memo No."; Code[20])
        {
            Caption = 'Memo No.';
        }
        field(2; "Budget Line"; Code[20])
        {
            Caption = 'Budget Line';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(4; "Amount on Budget"; Decimal)
        {
            Caption = 'Amount on Budget';
            FieldClass = FlowField;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No."=FIELD("Budget Line"), "Budget Name"=FIELD("Budget Code"), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Code"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Code")));
            editable = false;
        }
        field(5; "Committed Amount"; Decimal)
        {
            Caption = 'Committed Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Commitment Entries"."Committed Amount" where("Account"=FIELD("Budget Line"), "Global Dimension 1"=FIELD("Global Dimension 1 Code"), "Global Dimension 2"=FIELD("Global Dimension 2 Code")));
            editable = false;
        }
        field(6; "Available Balance"; Decimal)
        {
            Caption = 'Available Balance';
        }
        field(7; "Amount Required"; Decimal)
        {
            Caption = 'Amount Required';
        }
        field(8; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(9; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(10; "Budget Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Budget Period Start"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Budget Period End"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Budget Date Filter"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Budget Availability"; Option)
        {
            OptionMembers = Insufficient, Sufficient;
        }
    }
    keys
    {
        key(PK; "Memo No.", "Budget Line")
        {
            Clustered = true;
        }
    }
}
