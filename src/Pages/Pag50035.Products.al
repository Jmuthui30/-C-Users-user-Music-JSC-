page 50035 "Products"
{
    ApplicationArea = All;
    Caption = 'Products';
    PageType = List;
    SourceTable = "Products";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Category Code"; Rec."Vendor Category Code")
                {
                    ToolTip = 'Specifies the value of the Vendor Category Code field.';
                }
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
            }
        }
    }
}
