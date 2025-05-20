table 51887 "Supplier Category"
{
    LookupPageId = "Supplier Category";
    DrillDownPageId = "Supplier Category";

    fields
    {
        field(1; "Category Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Vendor Posting Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Vendor Posting Group";
        }
        field(4; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            begin
            /*IF xRec."Gen. Bus. Posting Group" <> "Gen. Bus. Posting Group" THEN
                  IF GenBusPostingGrp.ValidateVatBusPostingGroup(GenBusPostingGrp,"Gen. Bus. Posting Group") THEN
                    VALIDATE("VAT Bus. Posting Group",GenBusPostingGrp."Def. VAT Bus. Posting Group");*/
            end;
        }
        field(5; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            DataClassification = ToBeClassified;
            TableRelation = "VAT Business Posting Group";
        }
        field(6; "No. Prequalified"; Integer)
        {
            CalcFormula = Count("Prequalified Suppliers" WHERE(Category=FIELD("Category Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Year Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(8; "Is Special Group"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Category Code")
        {
        }
    }
    fieldgroups
    {
    }
}
