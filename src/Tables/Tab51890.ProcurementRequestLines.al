table 51890 "Procurement Request Lines"
{
    fields
    {
        field(1; "Requisition No"; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ReqHeader.Get("Requisition No")then begin
                    "Procurement Plan":=ReqHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
                end;
            end;
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if ReqHeader.Get("Requisition No")then begin
                    "Procurement Plan":=ReqHeader."Procurement Plan";
                    "Shortcut Dimension 1 Code":=ReqHeader."Global Dimension 1 Code";
                end;
            end;
        }
        field(3; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "G/L Account", Item, , "Fixed Asset";
        }
        field(4; No; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF(Type=CONST("G/L Account"))"G/L Account"
            ELSE IF(Type=CONST(Item))Item
            ELSE IF(Type=CONST("Fixed Asset"))"Fixed Asset";
        }
        field(5; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Unit of Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Unit of Measure";
        }
        field(8; "Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Amount:=Quantity * "Unit Price";
            end;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Procurement Plan"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(11; "Procurement Plan Item"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan"."Plan Item No" WHERE("Plan Year"=FIELD("Procurement Plan"), "Department Code"=FIELD("Shortcut Dimension 1 Code"));

            trigger OnValidate()
            begin
                if ProcurementPlan.Get("Procurement Plan", "Shortcut Dimension 1 Code", "Procurement Plan Item")then begin
                    if ProcurementPlan."Procurement Type" = ProcurementPlan."Procurement Type"::Goods then begin
                        Type:=Type::Item;
                    end;
                    /*
                    IF ProcurementPlan."Procurement Type"=ProcurementPlan."Procurement Type"::Goods THEN
                    BEGIN
                     Type:=Type::"Fixed Asset";
                    END;
                     */
                    if ProcurementPlan."Procurement Type" <> ProcurementPlan."Procurement Type"::Goods then begin
                        Type:=Type::"G/L Account";
                        No:=ProcurementPlan."Source of Funds";
                    end;
                    "Budget Line":=ProcurementPlan."Source of Funds";
                    Description:=ProcurementPlan."Item Description";
                end;
            end;
        }
        field(12; "Budget Line"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(14; "Amount LCY"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; Select; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Request Generated"; Boolean)
        {
        }
        field(17; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));
        }
    }
    keys
    {
        key(Key1; "Requisition No")
        {
        }
    }
    fieldgroups
    {
    }
    var ReqHeader: Record "Requisition Header";
    ProcurementPlan: Record "Procurement Plan";
}
