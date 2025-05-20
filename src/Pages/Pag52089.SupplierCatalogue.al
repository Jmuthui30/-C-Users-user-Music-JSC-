page 52089 "Supplier Catalogue"
{
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Supplier Catalogue";
    SourceTableView = SORTING("Supplier ID", "Line No");

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Product Name"; Rec."Product Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    Caption = 'Specification';
                    ApplicationArea = All;
                }
                field("Product Catagory"; Rec."Product Catagory")
                {
                    ApplicationArea = All;
                }
                field(UoM; Rec.UoM)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
    var
}
