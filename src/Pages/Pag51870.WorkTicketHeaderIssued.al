page 51870 "Work Ticket Header-Issued"
{
    // version THL- PRM 1.0
    Caption = 'Issued Work Ticket';
    PageType = Card;
    SourceTable = "Work Ticket Header";
    //SourceTableView = WHERE(Status=CONST(Issued));
    SourceTableView = WHERE(Status=CONST(Committed));

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = false;

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
            group("Ticket Symmary")
            {
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
            }
            action("Close Ticket")
            {
                ApplicationArea = All;
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.CalcFields("Total Distance Covered (Km)");
                    if Rec."Total Distance Covered (Km)" = 0 then Error('Distance covered should be more than 0 Km.');
                    Rec.CalcFields("Dim One Missing");
                    if Rec."Dim One Missing" then Error('You have not captured all dimensions on the lines');
                    Rec.CalcFields("Dim Two Missing");
                    if Rec."Dim Two Missing" then Error('You have not captured all dimensions on the lines');
                    if Confirm('You are about to close this work ticket. Do you want to continue?', false) = true then begin
                        //Status := Status::Closed;
                        Rec.Status:=Rec.Status::Fulfilled;
                        Rec.Modify;
                        Message('Work Ticket Closed.');
                    end;
                end;
            }
            action("Cancel Ticket")
            {
                ApplicationArea = All;
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('You are about to cancel this work ticket. Do you want to continue?', false) = true then begin
                        //Status := Status::Canceled;
                        Rec.Status:=Rec.Status::Archived;
                        Rec.Modify;
                        Message('Work Ticket Canceled.');
                    end;
                end;
            }
        }
    }
}
