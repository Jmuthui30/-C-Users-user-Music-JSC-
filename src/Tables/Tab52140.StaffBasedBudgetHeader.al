table 52140 "Staff Based Budget Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Budget; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; Description; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Global Dimension 1 Code"; Code[20])
        {
            Editable = false;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                StaffBasedBudget.Reset();
                StaffBasedBudget.SetRange(Budget, Budget);
                StaffBasedBudget.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
                if StaffBasedBudget.FindFirst()then Error(StrSubstNo(Text000, "Global Dimension 1 Code"));
            end;
        }
        field(5; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(6; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(7; Amount; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Staff Based Budget".Amount WHERE(Budget=field(Budget), Department=field("Global Dimension 1 Code")));
        }
        field(8; Status;Enum "Document Status")
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            begin
                StaffBasedLines.Reset();
                StaffBasedLines.SetRange(Budget, Budget);
                StaffBasedLines.SetRange(Department, "Global Dimension 1 Code");
                If StaffBasedLines.FindSet()then begin
                    repeat StaffBasedLines.Status:=Status;
                        StaffBasedLines.Modify(true);
                    until StaffBasedLines.Next() = 0;
                end;
            end;
        }
        field(9; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(10; "Created Date"; Date)
        {
            Editable = false;
        }
        field(11; "No. Series"; Code[11])
        {
            TableRelation = "No. Series";
        }
        field(12; "Reference Date"; Date)
        {
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; Budget, "Global Dimension 1 Code")
        {
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            AdvancedFinanceSetup.TestField("Staff Based Budget");
            NoSeriesMgt.InitSeries(AdvancedFinanceSetup."Staff Based Budget", xRec."No. Series", 0D, "No.", "No. Series");
            "Created Date":=Today;
            "Created By":=UserId;
        end;
    end;
    var AdvancedFinanceSetup: Record "Advanced Finance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    StaffBasedBudget: Record "Staff Based Budget Header";
    StaffBasedLines: Record "Staff Based Budget";
    Text000: Label 'The Staff Based Budget for % have already been Created!';
}
