page 51891 "Fuel Consumption Card-Closed"
{
    // version THL- PRM 1.0
    Caption = 'Vehicle Fuel Consumption History';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Vehicle Fuel Header";
    SourceTableView = WHERE(Posted=CONST(true));

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
                    Importance = Additional;
                    Visible = false;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Fuel Capacity"; Rec."Total Fuel Capacity")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Total Fuel Cost"; Rec."Total Fuel Cost")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control10; "Fuel Consumption Details")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            systempart(Control9; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Recall)
            {
                ApplicationArea = All;
                Image = Undo;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Do you wish to recall these fuel consupmtion details?', false) = true then begin
                        Lines.Reset;
                        Lines.SetRange("No.", Rec."No.");
                        Lines.ModifyAll(Posted, false, true);
                        //
                        Rec.Validate(Posted, false);
                        Rec.Modify;
                        Message('Record Recalled.');
                    end;
                end;
            }
        }
    }
    var Lines: Record "Vehicle Fuel Details";
}
