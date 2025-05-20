table 50030 "Products"
{
    Caption = 'Products';
    DataClassification = ToBeClassified;
    LookupPageId = "Products";
    DrillDownPageId = "Products";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(4; "Vendor Category Code"; Code[50])
        {
            DataClassification = CustomerContent;
            TableRelation = "Product Categories";
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; Blocked; Boolean)
        {
            Caption = 'Blocked';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Code", "Vendor Category Code")
        {
            Clustered = true;
        }
    }
}
