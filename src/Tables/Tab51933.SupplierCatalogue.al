table 51933 "Supplier Catalogue"
{
    DataClassification = CustomerContent;
    DrillDownPageID = "Supplier Catalogue";
    LookupPageID = "Supplier Catalogue";

    fields
    {
        field(1; "Supplier ID"; Code[20])
        {
        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Product Name"; text[30])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Description"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(5; UoM; code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure";
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Product Catagory"; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Supplier Category";
        }
    }
    keys
    {
        key("PK"; "Supplier ID", "Line No")
        {
        }
    }
    var myInt: Integer;
    trigger OnInsert()
    begin
    end;
    trigger OnModify()
    begin
    end;
    trigger OnDelete()
    begin
    end;
    trigger OnRename()
    begin
    end;
}
