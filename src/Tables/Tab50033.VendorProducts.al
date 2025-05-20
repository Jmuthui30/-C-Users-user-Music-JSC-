table 50033 "Vendor Products"
{
    Caption = 'Vendor Products';
    DataClassification = ToBeClassified;
    LookupPageId = "Vendor Products";
    DrillDownPageId = "Vendor Products";

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
        }
        /*field(3; "Category Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Product Categories";

            trigger OnValidate()
            var
                VProductCat: Record "Product Categories";
            begin
                VProductCat.Reset();
                VProductCat.SetRange(Code, Rec."Category Code");
                if VProductCat.FindSet() then
                    "Category Name" := VProductCat.Name;
            end;
        }
        field(8; "Category Name"; Text[250])
        {
            DataClassification = CustomerContent;
        }*/
        field(7; "Product Code"; Code[50])
        {
            DataClassification = CustomerContent;
            //TableRelation = "Products".Code where("Vendor Category Code" = field("Category Code"));
            TableRelation = Products;

            trigger OnValidate()
            var
                VendorProduct: Record "Products";
            begin
                VendorProduct.Reset();
                VendorProduct.SetRange(Code, Rec."Product Code");
                // VendorProduct.SetRange("Vendor Category Code", Rec."Category Code");
                if VendorProduct.FindSet()then "Product Name":=VendorProduct.Name;
            end;
        }
        field(9; "Product Name"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Vendor No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
