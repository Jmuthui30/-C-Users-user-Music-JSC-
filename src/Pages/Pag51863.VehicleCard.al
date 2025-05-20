page 51863 "Vehicle Card"
{
    // version THL- PRM 1.0
    PageType = Card;
    SourceTable = Vehicle;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Reg No."; Rec."Reg No.")
                {
                    ApplicationArea = All;
                }
                field("ECN No."; Rec."ECN No.")
                {
                    ApplicationArea = All;
                }
                field(Manufacturer; Rec.Manufacturer)
                {
                    ApplicationArea = All;
                }
                field(Movement; Rec.Movement)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field("Item ID"; Rec."Item ID")
                {
                    ApplicationArea = All;
                }
                field("Next Service Mileage"; Rec."Next Service Mileage")
                {
                    ApplicationArea = All;
                }
                field("Insurance Expiry Date"; Rec."Insurance Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Part of Fleet"; Rec."Part of Fleet")
                {
                    ApplicationArea = All;
                }
                field("Chasis No."; Rec."Chasis No.")
                {
                    ApplicationArea = All;
                }
                field("Engine No."; Rec."Engine No.")
                {
                    ApplicationArea = All;
                }
                field("Date Of Manufacture"; Rec."Date Of Manufacture")
                {
                    ApplicationArea = All;
                }
                field("Sitting Capacity"; Rec."Sitting Capacity")
                {
                    ApplicationArea = All;
                }
                field("Fuel Type"; Rec."Fuel Type")
                {
                    ApplicationArea = All;
                }
                field("Due For Service"; Rec."Due For Service")
                {
                    ApplicationArea = All;
                }
                field("EDR Camera Serial No."; Rec."EDR Camera Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Years Used"; Rec."Years Used")
                {
                    ApplicationArea = All;
                }
                field("Kms Done"; Rec."Kms Done")
                {
                    ApplicationArea = All;
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
        area(factboxes)
        {
            systempart(Control26; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
