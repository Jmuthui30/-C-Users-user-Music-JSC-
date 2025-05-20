table 50043 "Consolidated R. Plan Lines"
{
    Caption = 'Consolidated Recruitment Plan Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var
                ConsolidatedPlan: Record "Consolidated Recruitment Plan";
            begin
                if ConsolidatedPlan.Get("Document No.")then begin
                    "Fiscal Year":=ConsolidatedPlan."Fiscal Year";
                end;
            end;
        }
        field(2; "Line No."; Integer)
        {
            Editable = false;
        }
        field(3; "Job ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Jobs";
        }
        field(4; "Plan No"; Code[20])
        {
            TableRelation = "Recruitment Plan"."No.";
            Editable = false;
        }
        field(5; "Job Title"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            var
                DimValue: Record "Dimension Value";
            begin
                Clear("Department Name");
                GenLedSetup.Get;
                if DimValue.Get(GenLedSetup."Global Dimension 1 Code", "Global Dimension 1 Code")then "Department Name":=DimValue.Name;
            end;
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(8; "Department Name"; Text[50])
        {
            Editable = false;
        }
        field(9; "Grade"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No of Posts"; Integer)
        {
            BlankZero = true;
        }
        field(11; "Position Reporting to Code"; Code[20])
        {
            TableRelation = "Company Jobs";
        }
        field(12; "Occupied Positions"; Integer)
        {
            Editable = false;
        }
        field(13; "Vacant Positions"; Integer)
        {
            Editable = false;
        }
        field(14; "Position Reporting to Name"; Text[250])
        {
            Editable = false;
        }
        field(15; "Required Positions"; Integer)
        {
            trigger OnValidate();
            begin
                IF "Required Positions" > "Vacant Positions" THEN BEGIN
                    ERROR('Required positions exceeds the total number of vacant positions by [ %1 ]', format("Vacant Positions" - "Required Positions"));
                END;
                IF "Required Positions" <= 0 THEN BEGIN
                    ERROR('Required positions cannot be Less Than or Equal to Zero');
                END;
            end;
        }
        field(16; "Fiscal Year"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Document No.", "Job ID", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Job ID", "Job Title")
        {
        }
    }
    var GenLedSetup: Record "General Ledger Setup";
}
