table 51807 "RFQ Vendors"
{
    fields
    {
        field(1; "RFQ No"; Code[20])
        {
        }
        field(2; "Vendor No"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Suppliers.Get("Vendor No")then Name:=Suppliers.Name;
                //Ibrahim Wasiu
                Competency:=Suppliers.Competency;
                Capacity:=Suppliers.Capacity;
                Commitment:=Suppliers.Commitment;
                Control:=Suppliers.Control;
                "Cash Resources":=Suppliers."Cash Resources";
                Cost:=Suppliers.Cost;
                Consistency:=Suppliers.Consistency;
                //
                if rfq.Get("RFQ No")then "Requisition No.":=rfq."Requisition No.";
            end;
        }
        field(3; Name; Text[50])
        {
        }
        field(4; "Quote No"; Code[20])
        {
        }
        field(5; Total; Decimal)
        {
            CalcFormula = Sum("Purchase Line".Amount WHERE("Document No."=FIELD("Quote No"), "Buy-from Vendor No."=FIELD("Vendor No")));
            FieldClass = FlowField;
        }
        field(6; "Requisition No."; Code[20])
        {
        }
        //Ibrahim Wasiu
        field(7; Competency; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; Capacity; Decimal)
        {
            DataClassification = CustomerContent;
            TableRelation = "Vendor Rating";
        }
        field(9; Commitment; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(10; Control; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(11; "Cash Resources"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(12; Cost; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; Consistency; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; Status; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Unread, Read;
        }
        field(15; "Vendor Application No"; Code[20])
        {
            TableRelation = Vendor."Vendor Application No.";

            trigger OnValidate()
            begin
                if Suppliers.Get("Vendor Application No")then "Vendor Application No":="Vendor Application No";
            end;
        }
    }
    keys
    {
        key(Key1; "RFQ No", "Vendor No")
        {
        }
    }
    fieldgroups
    {
    }
    var Suppliers: Record Vendor;
    rfq: Record "RFQ Header";
}
