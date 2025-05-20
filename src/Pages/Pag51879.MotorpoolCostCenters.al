page 51879 "Motorpool Cost Centers"
{
    // version THL- PRM 1.0
    DeleteAllowed = false;
    Editable = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Motorpool Cost Centers";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Cost Center Mileage"; Rec."Cost Center Mileage")
                {
                    ApplicationArea = All;
                }
                field("Total Mileage"; Rec."Total Mileage")
                {
                    ApplicationArea = All;
                }
                field("Cost Center No. of Staff"; Rec."Cost Center No. of Staff")
                {
                    ApplicationArea = All;
                }
                field("Total No. of Staff"; Rec."Total No. of Staff")
                {
                    ApplicationArea = All;
                }
                field("Cost Center Office Space"; Rec."Cost Center Office Space")
                {
                    ApplicationArea = All;
                }
                field("Total Office Space"; Rec."Total Office Space")
                {
                    ApplicationArea = All;
                }
                field("Cost Ctr Electronic Footprint"; Rec."Cost Ctr Electronic Footprint")
                {
                    ApplicationArea = All;
                }
                field("Total Electronic Footprint"; Rec."Total Electronic Footprint")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control12; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
}
