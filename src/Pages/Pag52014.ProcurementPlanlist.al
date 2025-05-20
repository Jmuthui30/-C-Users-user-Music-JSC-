page 52014 "Procurement Plan list"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Procurement Plan";

    layout
    {
        area(content)
        {
            repeater(Control8)
            {
                ShowCaption = false;

                field("Plan Item No"; Rec."Plan Item No")
                {
                    ApplicationArea = All;
                }
                field("Procurement Type"; Rec."Procurement Type")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Estimated Cost"; Rec."Estimated Cost")
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
