table 50032 Certificate
{
    Caption = 'Certificate';
    DataClassification = ToBeClassified;
    LookupPageId = Certificates;
    DrillDownPageId = Certificates;

    fields
    {
        field(1; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
        }
        field(2; "Certificate Type";Enum CertficateType)
        {
            Caption = 'Certificate Type';
            DataClassification = CustomerContent;
        }
        field(3; "Category Code"; Code[20])
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
                if VProductCat.FindSet()then "Category Name":=VProductCat.Name;
            end;
        }
        field(8; "Category Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Registration No."; Code[50])
        {
            Caption = 'Registration No.';
            DataClassification = CustomerContent;
        }
        field(5; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
        }
        field(10; "Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Certificate Attachment"; Text[250])
        {
            Caption = 'Certificate Attachment';
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
        }
        /*field(7; "Product Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Products".Code where("Vendor Category Code" = field("Category Code"));

            trigger OnValidate()
            var
                VendorProduct: Record "Products";
            begin
                VendorProduct.Reset();
                VendorProduct.SetRange(Code, Rec."Product Code");
                VendorProduct.SetRange("Vendor Category Code", Rec."Category Code");
                if VendorProduct.FindSet() then
                    "Product Name" := VendorProduct.Name;
            end;
        }

        field(9; "Product Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Editable = false;


        }*/
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
