page 51892 "Fuel Consumption-Closed"
{
    // version THL- PRM 1.0
    Caption = 'Vehicle Fuel Consumption History';
    CardPageID = "Fuel Consumption Card-Closed";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Vehicle Fuel Header";
    SourceTableView = WHERE(Posted=CONST(true));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
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
                    Importance = Additional;
                    Visible = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Total Fuel Capacity"; Rec."Total Fuel Capacity")
                {
                    ApplicationArea = All;
                }
                field("Total Fuel Cost"; Rec."Total Fuel Cost")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(reporting)
        {
            action("Fuel Consumption Report")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Fuel Consumption Report";
            }
        }
    }
}
