page 51873 "Work Tickets-Closed"
{
    // version THL- PRM 1.0
    Caption = 'Closed Work Tickets';
    CardPageID = "Work Ticket Header-Closed";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Work Ticket Header";
    //SourceTableView = WHERE(Status = CONST(Closed));
    SourceTableView = WHERE(Status=CONST(Fulfilled));

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
                field(Vehicle; Rec.Vehicle)
                {
                    ApplicationArea = All;
                }
                field("Issued Date"; Rec."Issued Date")
                {
                    ApplicationArea = All;
                }
                field("Closed Date"; Rec."Closed Date")
                {
                    ApplicationArea = All;
                }
                field("Authorising Officer"; Rec."Authorising Officer")
                {
                    ApplicationArea = All;
                }
                field("Authorising Officer Name"; Rec."Authorising Officer Name")
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
                field(Status; Rec.Status)
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
