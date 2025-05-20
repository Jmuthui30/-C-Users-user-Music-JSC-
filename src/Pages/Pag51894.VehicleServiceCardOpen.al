page 51894 "Vehicle Service Card-Open"
{
    // version THL- PRM 1.0
    Caption = 'New Vehicle Service';
    PageType = Card;
    SourceTable = "Vehicle Service Header";
    SourceTableView = WHERE(Posted=CONST(false));

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
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Vehicle Reg No."; Rec."Vehicle Reg No.")
                {
                    ApplicationArea = All;
                }
                field("Engine No."; Rec."Engine No.")
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
                    Editable = false;
                }
            }
            part(Control23; "Service Details")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
                UpdatePropagation = Both;
            }
            group(Audit)
            {
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
        area(factboxes)
        {
            systempart(Control22; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Submit)
            {
                ApplicationArea = All;
                Image = Start;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Global Dimension 2 Code");
                    if Confirm('Do you wish to submit these service details?', false) = true then begin
                        Lines.Reset;
                        Lines.SetRange("No.", Rec."No.");
                        Lines.ModifyAll(Posted, true, true);
                        //
                        Rec.Validate(Posted, true);
                        Rec.Modify;
                        Message('Record Submitted.');
                    end;
                end;
            }
        }
    }
    var Lines: Record "Vehicle Service Details";
}
