page 51895 "Vehicle Service-Open"
{
    // version THL- PRM 1.0
    Caption = 'New Vehicle Service';
    CardPageID = "Vehicle Service Card-Open";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Vehicle Service Header";
    SourceTableView = WHERE(Posted=CONST(false));

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
                field("Vehicle Reg No."; Rec."Vehicle Reg No.")
                {
                    ApplicationArea = All;
                }
                field("Engine No."; Rec."Engine No.")
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
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field("Date & Time in"; Rec."Date & Time in")
                {
                    ApplicationArea = All;
                }
                field("Date & Time Out"; Rec."Date & Time Out")
                {
                    ApplicationArea = All;
                }
                field("Serviced at Km"; Rec."Serviced at Km")
                {
                    ApplicationArea = All;
                }
                field("Next Service Required"; Rec."Next Service Required")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; Rec."Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Mechanic No."; Rec."Mechanic No.")
                {
                    ApplicationArea = All;
                }
                field("Mechanic Name"; Rec."Mechanic Name")
                {
                    ApplicationArea = All;
                }
                field("Mechanic Comments"; Rec."Mechanic Comments")
                {
                    ApplicationArea = All;
                }
                field("Mechanic Date Signed"; Rec."Mechanic Date Signed")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
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
