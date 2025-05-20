page 50039 "Vendor Products"
{
    ApplicationArea = All;
    Caption = 'Vendor Products';
    PageType = ListPart;
    SourceTable = "Vendor Products";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                /*field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field("Category Name"; Rec."Category Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }*/
                field("Product Code"; Rec."Product Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Product Code field.';
                }
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
            }
        }
    }
}
