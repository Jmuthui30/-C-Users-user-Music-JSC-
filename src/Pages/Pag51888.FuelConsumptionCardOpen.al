page 51888 "Fuel Consumption Card-Open"
{
    // version THL- PRM 1.0
    Caption = 'New Vehicle Fuel Consumption';
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Vehicle Fuel Header";
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
            action(Submit)
            {
                ApplicationArea = All;
                Image = Start;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Global Dimension 2 Code");
                    if Confirm('Do you wish to submit these fuel consupmtion details?', false) = true then begin
                        Lines.Reset;
                        Lines.SetRange("No.", Rec."No.");
                        Lines.ModifyAll(Posted, true, true);
                        Lines.Reset;
                        Lines.SetRange("No.", Rec."No.");
                        Lines.SetRange("Fueled On", Lines."Fueled On"::"Fuel Card");
                        Lines.SetFilter("Fuel Card/LPO No.", '<>%1', '');
                        if Lines.FindSet then begin
                            repeat OldEntries.Reset;
                                if OldEntries.FindLast then EntryNo:=OldEntries."Entry No." + 1
                                else
                                    EntryNo:=1;
                                Entries.Init;
                                Entries."Entry No.":=EntryNo;
                                Entries."Card No":=Lines."Fuel Card/LPO No.";
                                Entries.Date:=Lines."Fuel Date";
                                Entries."Transaction Type":=Entries."Transaction Type"::Consumption;
                                Entries.Amount:=-1 * Lines."Fuel Cost";
                                Entries.USERID:=UserId;
                                if Lines."Fuel Cost" <> 0 then Entries.Insert;
                            until Lines.Next = 0;
                        end;
                        //
                        //
                        //
                        Rec.Validate(Posted, true);
                        Rec.Modify;
                        Message('Record Submitted.');
                    end;
                end;
            }
        }
    }
    var Lines: Record "Vehicle Fuel Details";
    OldEntries: Record "Fuel Card Entries";
    EntryNo: Integer;
    Entries: Record "Fuel Card Entries";
}
