table 58136 "Budget Category Dist. Lines"
{
    DrillDownPageID = "Budget Category Dist. Lines";
    LookupPageID = "Budget Category Dist. Lines";

    fields
    {
        field(1; Budget; Code[20])
        {
        }
        field(2; "Business Unit"; Option)
        {
            OptionCaption = 'IT,ADMIN';
            OptionMembers = IT,ADMIN;
        }
        field(3; "Category Code"; Code[10])
        {
            TableRelation = "Budget Category" WHERE("Business Unit" = FIELD("Business Unit"), Inactive = CONST(false));

            trigger OnValidate()
            begin
                if Category.Get("Category Code") then begin
                    "Category Description" := Category.Description;
                    Type := Category.Type;
                end;
                /*IF Header.GET(Budget) THEN
                      "Business Unit" := Header."Business Unit";*/
            end;
        }
        field(4; "Category Description"; Text[100])
        {
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Department';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                GLSetup.Get;
                GLSetup.TestField("Global Dimension 1 Code");
                if DimValue.Get(GLSetup."Global Dimension 1 Code", "Global Dimension 1 Code") then "Unit Name" := DimValue.Name;
            end;
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            begin
                GLSetup.Get;
                GLSetup.TestField("Global Dimension 2 Code");
                if DimValue.Get(GLSetup."Global Dimension 2 Code", "Global Dimension 2 Code") then Branch := DimValue.Name;
            end;
        }
        field(7; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            begin
                GLSetup.Get;
                GLSetup.TestField("Shortcut Dimension 3 Code");
                if DimValue.Get(GLSetup."Shortcut Dimension 3 Code", "Global Dimension 3 Code") then "Strategic Initiative" := DimValue.Name;
            end;
        }
        field(8; "Budget Amount"; Decimal)
        {
        }
        field(9; "Actual Amount"; Decimal)
        {
            // CalcFormula = Sum("Purch. Inv. Line"."Amount Including VAT" WHERE("Budget Category" = FIELD("Category Code"),
            //                                                                    "Posting Date" = FIELD("Date Filter"),
            //                                                                    "Shortcut Dimension 1 Code" = FIELD("Global Dimension 1 Code")));
            Editable = false;
            //FieldClass = FlowField;
        }
        field(10; "Commitment Amount"; Decimal)
        {
            // CalcFormula = Sum("Commitment Entries"."Committed Amount" WHERE( = FIELD(Budget),
            //                                                                  "Budget Category" = FIELD("Category Code"),
            //                                                                  "Global Dimension 1" = FIELD("Global Dimension 1 Code")));
            Editable = false;
            //FieldClass = FlowField;
            FieldClass = Normal;
        }
        field(11; "Available Balance"; Decimal)
        {
        }
        field(12; "Unit Name"; Text[50])
        {
        }
        field(13; Branch; Text[50])
        {
        }
        field(14; "Strategic Initiative"; Text[50])
        {
        }
        field(15; "Total Category Budget"; Decimal)
        {
            CalcFormula = Sum("Budget Category Dist. Lines"."Budget Amount" WHERE(Budget = FIELD(Budget), "Business Unit" = FIELD("Business Unit"), "Category Code" = FIELD("Category Code")));
            FieldClass = FlowField;
        }
        field(16; Type; Option)
        {
            OptionCaption = 'CAPEX,OPEX';
            OptionMembers = CAPEX,OPEX;
        }
        field(17; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
    }
    keys
    {
        key(Key1; Budget, "Category Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Global Dimension 3 Code")
        {
        }
    }
    fieldgroups
    {
    }
    var
        DimValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        Category: Record "Budget Category";
        Header: Record "Budget Category Dist. Header";
}
