table 50029 "Product Categories"
{
    Caption = 'Product Categories';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Product Categories";
    LookupPageId = "Product Categories";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Category Code';
            DataClassification = CustomerContent;
        }
        field(3; Name; Text[250])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}
