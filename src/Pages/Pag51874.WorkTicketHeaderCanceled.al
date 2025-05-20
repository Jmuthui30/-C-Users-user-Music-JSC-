page 51874 "Work Ticket Header-Canceled"
{
    // version THL- PRM 1.0
    Caption = 'Canceled Work Ticket';
    PageType = Card;
    SourceTable = "Work Ticket Header";
    //SourceTableView = WHERE(Status = CONST(Canceled));
    SourceTableView = WHERE(Status=CONST(Archived));

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
                field("Total Distance Covered (Km)"; Rec."Total Distance Covered (Km)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Cost of Fuel"; Rec."Total Cost of Fuel")
                {
                    ApplicationArea = All;
                }
                field("Cost of Fuel per Km"; Rec."Cost of Fuel per Km")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control14; "Work Ticket Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control13; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Allocated Drivers")
            {
                ApplicationArea = All;
                Image = AllocatedCapacity;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Work Ticket Drivers";
                RunPageLink = "No."=FIELD("No."), Vehicle=FIELD(Vehicle);
                RunPageOnRec = true;
            }
        }
    }
}
