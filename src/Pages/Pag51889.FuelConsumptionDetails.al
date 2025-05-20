page 51889 "Fuel Consumption Details"
{
    // version THL- PRM 1.0
    AutoSplitKey = true;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Vehicle Fuel Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Fuel Date"; Rec."Fuel Date")
                {
                    ApplicationArea = All;
                }
                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Fuel Voucher No."; Rec."Fuel Voucher No.")
                {
                    ApplicationArea = All;
                }
                field("Fueled On"; Rec."Fueled On")
                {
                    ApplicationArea = All;
                }
                field("Fuel Card/LPO No."; Rec."Fuel Card/LPO No.")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Fuel Capacity"; Rec."Fuel Capacity")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Fuel Cost"; Rec."Fuel Cost")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update(true);
                    end;
                }
                field("Driver No."; Rec."Driver No.")
                {
                    ApplicationArea = All;
                }
                field("Driver Name"; Rec."Driver Name")
                {
                    ApplicationArea = All;
                }
                field(Mileage; Rec.Mileage)
                {
                    ApplicationArea = All;
                }
                field("Station No."; Rec."Station No.")
                {
                    ApplicationArea = All;
                }
                field("Station Name"; Rec."Station Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
    }
}
