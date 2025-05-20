table 52123 "Supplementary Budget Request"
{
    DrillDownPageId = "Supplementary Budget Requests";
    LookupPageId = "Supplementary Budget Requests";

    fields
    {
        field(1; "No."; Code[20])
        {
            Editable = false;
        }
        field(2; "Created Date"; Date)
        {
            Editable = false;
        }
        field(3; "Created By"; Code[50])
        {
            Editable = false;
        }
        field(4; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(5; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(6; Effected; Boolean)
        {
            Editable = false;
        }
        field(7; "Effected By"; Code[50])
        {
            Editable = false;
        }
        field(8; "Effected Date"; Date)
        {
            Editable = false;
        }
        field(9; "Budget Name"; Code[10])
        {
            TableRelation = "G/L Budget Name";
            Caption = 'Budget';
        }
        field(10; "Description"; Text[80])
        {
            CalcFormula = Lookup("G/L Budget Name".Description WHERE(Name=FIELD("Budget Name")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(11; Amount; Decimal)
        {
            CalcFormula = Sum("Suppl. Budget Request Lines".Amount WHERE("Document No"=FIELD("No.")));
            FieldClass = FlowField;
            Editable = false;
        }
        field(12; "Document Date"; Date)
        {
        }
        field(13; "Budget Dimension 1 Code"; Code[20])
        {
            AccessByPermission = TableData Dimension=R;
            CaptionClass = GetCaptionClass(1);
            Caption = 'Budget Dimension 1 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 1 Code":=OnLookupDimCode(2, "Budget Dimension 1 Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 1 Code", "Budget Dimension 1 Code");
            end;
            trigger OnValidate()
            begin
                UpdateLinesDimensions;
            end;
        }
        field(14; "Budget Dimension 2 Code"; Code[20])
        {
            AccessByPermission = TableData Dimension=R;
            CaptionClass = GetCaptionClass(2);
            Caption = 'Budget Dimension 2 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 2 Code":=OnLookupDimCode(3, "Budget Dimension 2 Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 2 Code", "Budget Dimension 2 Code");
            end;
            trigger OnValidate()
            begin
                UpdateLinesDimensions;
            end;
        }
        field(15; "Budget Dimension 3 Code"; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination"=R;
            CaptionClass = GetCaptionClass(3);
            Caption = 'Budget Dimension 3 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 3 Code":=OnLookupDimCode(4, "Budget Dimension 3 Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 3 Code", "Budget Dimension 3 Code");
            end;
            trigger OnValidate()
            begin
                UpdateLinesDimensions;
            end;
        }
        field(16; "Budget Dimension 4 Code"; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination"=R;
            CaptionClass = GetCaptionClass(4);
            Caption = 'Budget Dimension 4 Code';

            trigger OnLookup()
            begin
                "Budget Dimension 4 Code":=OnLookupDimCode(5, "Budget Dimension 4 Code");
                ValidateDimValue(GLBudgetName."Budget Dimension 4 Code", "Budget Dimension 4 Code");
            end;
            trigger OnValidate()
            begin
                UpdateLinesDimensions;
            end;
        }
        field(17; Approvers; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(52123), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
            Editable = false;
        }
        field(18; "Pending Approvals Ext"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(52123), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
            Editable = false;
        }
        field(19; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                UpdateLinesDimensions;
            end;
        }
        field(20; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                UpdateLinesDimensions;
            end;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    var AdvanceFinSetup: Record "Advanced Finance Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Text001: Label '1,5,,Budget Dimension 1 Code';
    Text002: Label '1,5,,Budget Dimension 2 Code';
    Text003: Label '1,5,,Budget Dimension 3 Code';
    Text004: Label '1,5,,Budget Dimension 4 Code';
    GLBudgetName: Record "G/L Budget Name";
    Lines: Record "Suppl. Budget Request Lines";
    GLSetup: Record "General Ledger Setup";
    GLSetupRetrieved: Boolean;
    DimMgt: Codeunit DimensionManagement;
    trigger OnInsert()
    begin
        if "No." = '' then begin
            AdvanceFinSetup.Get;
            AdvanceFinSetup.TestField("Suppl. Budget Request Nos");
            NoSeriesMgt.InitSeries(AdvanceFinSetup."Suppl. Budget Request Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Created By":=UserId;
        "Created Date":=Today;
        Status:=Status::Open;
    end;
    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
    end;
    procedure GetCaptionClass(BudgetDimType: Integer): Text[250]begin
        if GetFilter("Budget Name") <> '' then begin
            GLBudgetName.SetFilter(Name, GetFilter("Budget Name"));
            if not GLBudgetName.FindFirst then Clear(GLBudgetName);
        end;
        case BudgetDimType of 1: begin
            if GLBudgetName."Budget Dimension 1 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 1 Code");
            exit(Text001);
        end;
        2: begin
            if GLBudgetName."Budget Dimension 2 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 2 Code");
            exit(Text002);
        end;
        3: begin
            if GLBudgetName."Budget Dimension 3 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 3 Code");
            exit(Text003);
        end;
        4: begin
            if GLBudgetName."Budget Dimension 4 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 4 Code");
            exit(Text004);
        end;
        end;
    end;
    local procedure UpdateLinesDimensions()
    begin
        Lines.Reset();
        Lines.SetRange("Document No", "No.");
        If Lines.FindSet()then begin
            repeat Lines."Budget Name":="Budget Name";
                Lines."Budget Dimension 1 Code":="Budget Dimension 1 Code";
                Lines."Budget Dimension 2 Code":="Budget Dimension 2 Code";
                Lines."Budget Dimension 3 Code":="Budget Dimension 3 Code";
                Lines."Budget Dimension 4 Code":="Budget Dimension 4 Code";
                Lines."Global Dimension 1 Code":="Global Dimension 1 Code";
                Lines."Global Dimension 2 Code":="Global Dimension 2 Code";
                Lines.Modify(true);
            until Lines.Next() = 0;
        end;
    end;
    local procedure OnLookupDimCode(DimOption: Option "Global Dimension 1", "Global Dimension 2", "Budget Dimension 1", "Budget Dimension 2", "Budget Dimension 3", "Budget Dimension 4"; DefaultValue: Code[20]): Code[20]var
        DimValue: Record "Dimension Value";
        DimValueList: Page "Dimension Value List";
    begin
        if DimOption in[DimOption::"Global Dimension 1", DimOption::"Global Dimension 2"]then GetGLSetup
        else if GLBudgetName.Name <> "Budget Name" then GLBudgetName.Get("Budget Name");
        case DimOption of DimOption::"Global Dimension 1": DimValue."Dimension Code":=GLSetup."Global Dimension 1 Code";
        DimOption::"Global Dimension 2": DimValue."Dimension Code":=GLSetup."Global Dimension 2 Code";
        DimOption::"Budget Dimension 1": DimValue."Dimension Code":=GLBudgetName."Budget Dimension 1 Code";
        DimOption::"Budget Dimension 2": DimValue."Dimension Code":=GLBudgetName."Budget Dimension 2 Code";
        DimOption::"Budget Dimension 3": DimValue."Dimension Code":=GLBudgetName."Budget Dimension 3 Code";
        DimOption::"Budget Dimension 4": DimValue."Dimension Code":=GLBudgetName."Budget Dimension 4 Code";
        end;
        DimValue.SetRange("Dimension Code", DimValue."Dimension Code");
        if DimValue.Get(DimValue."Dimension Code", DefaultValue)then;
        DimValueList.SetTableView(DimValue);
        DimValueList.SetRecord(DimValue);
        DimValueList.LookupMode:=true;
        if DimValueList.RunModal = ACTION::LookupOK then begin
            DimValueList.GetRecord(DimValue);
            exit(DimValue.Code);
        end;
        exit(DefaultValue);
    end;
    local procedure GetGLSetup()
    begin
        if not GLSetupRetrieved then begin
            GLSetup.Get();
            GLSetupRetrieved:=true;
        end;
    end;
    local procedure ValidateDimValue(DimCode: Code[20]; DimValueCode: Code[20])
    begin
        if not DimMgt.CheckDimValue(DimCode, DimValueCode)then Error(DimMgt.GetDimErr());
    end;
}
