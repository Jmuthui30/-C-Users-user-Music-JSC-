table 51889 "Procurement Request"
{
    fields
    {
        field(1; No; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; Title; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Requisition No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Requisition Header";
        }
        field(4; "Procurement Plan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan";
        }
        field(5; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Created By"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; Procurementtype; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "No.Series"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Process Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Direct, RFQ, RFP, Tender;
        }
        field(10; ProcurementPlanItem; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Plan"."Plan Item No" WHERE("Plan Year"=FIELD("Procurement Plan No"));
        }
        field(11; Category; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";
        }
        field(12; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));
        }
        field(13; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));
        }
        field(14; TenderOpeningDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Tender Status"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionMembers = " ", Open, Clossed;
        }
        field(16; TenderClosingDate; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(18; Addedum; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; SiteView; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = New, Archived;
        }
    }
    keys
    {
        key(Key1; No)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if No = '' then begin
            if "Process Type" = "Process Type"::RFQ then begin
                PurchSetup.Get;
                PurchSetup.TestField(PurchSetup."Request for Quotation Nos.");
                NoSeriesMgt.InitSeries(PurchSetup."Request for Quotation Nos.", xRec."No.Series", 0D, No, "No.Series");
            //NoSeriesMgt.InitSeries(SalesSetup."File Movement Numbers",xRec."File Movement Code",0D,"File Movement Code","No. Series");
            end;
            if "Process Type" = "Process Type"::RFP then begin
                PurchSetup.Get;
                PurchSetup.TestField(PurchSetup."Request for Proposals Nos.");
                NoSeriesMgt.InitSeries(PurchSetup."Request for Proposals Nos.", xRec."No.Series", 0D, No, "No.Series");
            //NoSeriesMgt.InitSeries(SalesSetup."File Movement Numbers",xRec."File Movement Code",0D,"File Movement Code","No. Series");
            end;
            if "Process Type" = "Process Type"::Tender then begin
                PurchSetup.Get;
                PurchSetup.TestField(PurchSetup."Tenders Nos");
                NoSeriesMgt.InitSeries(PurchSetup."Tenders Nos", xRec."No.Series", 0D, No, "No.Series");
            //NoSeriesMgt.InitSeries(SalesSetup."File Movement Numbers",xRec."File Movement Code",0D,"File Movement Code","No. Series");
            end;
        end;
        "Creation Date":=Today;
        "Created By":=UserId;
    end;
    var PurchSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
}
