page 51837 "RFQ Lines"
{
    // version THL- PRM 1.0
    PageType = ListPart;
    SourceTable = "RFQ Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the line type.';
                }
                field(No; Rec.No)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the number of a general ledger account, item, or fixed asset, depending on what you selected in the Type field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter a description of the entry of the product to be purchased.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the unit of measure.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the number of units of the item specified on the line.';
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the cost of one unit of the selected item or fixed asset.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the amount that is granted for the item on the line.';
                }
                field("Store of Delivery"; Rec."Store of Delivery")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the quantity of items that will be added to store.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
