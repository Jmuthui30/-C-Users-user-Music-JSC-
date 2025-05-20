page 50034 "Product Categories"
{
    ApplicationArea = All;
    Caption = 'Product Categories';
    PageType = ListPart;
    SourceTable = "Product Categories";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Category Code field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
            }
        }
    }
}
