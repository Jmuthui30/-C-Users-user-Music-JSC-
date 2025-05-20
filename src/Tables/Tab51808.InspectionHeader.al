table 51808 "Inspection Header"
{
    fields
    {
        field(1; No; Code[20])
        {
        }
        field(2; "Created By"; Code[50])
        {
        }
        field(3; "LPO No"; Code[20])
        {
        }
        field(4; "Supplier No."; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Supplier.Get("Supplier No.")then "Supplier Name":=Supplier.Name;
            end;
        }
        field(5; "Supplier Name"; Text[50])
        {
        }
        field(6; Date; Date)
        {
        }
        field(7; "RFQ No."; Code[20])
        {
        }
        field(8; "RFQ Date"; Date)
        {
        }
        field(9; "LPO Date"; Date)
        {
        }
        field(10; "Total Value"; Decimal)
        {
            CalcFormula = Sum("Inspection Lines"."Total Cost" WHERE("No."=FIELD(No)));
            FieldClass = FlowField;
        }
        field(11; "Invoice No."; Code[20])
        {
        }
        field(12; "D Note No."; Code[20])
        {
        }
        field(13; "Completion/Delivery Date"; Date)
        {
        }
        field(14; "No. Series"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(15; "Reviewed By"; Text[50])
        {
        }
        field(51800; Description; Text[250])
        {
            DataClassification = ToBeClassified;
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
        if(No = '')then begin
            PurchaseSetup.Get;
            PurchaseSetup.TestField("Inspection Nos.");
            NoSeriesMgt.InitSeries(PurchaseSetup."Inspection Nos.", xRec.No, 0D, No, "No. Series");
        end;
        Date:=Today;
        "Created By":=UserId;
        "Completion/Delivery Date":=Today;
        "Reviewed By":=PurchaseSetup."Inspection Reviewer";
    end;
    var PurchaseSetup: Record "Procurement Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    Supplier: Record Vendor;
}
