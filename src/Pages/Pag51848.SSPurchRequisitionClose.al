page 51848 "SS Purch Requisition-Close"
{
    // version THL- PRM 1.0
    Caption = 'Fulfilled Purchase Requisition';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE("PR Closed"=CONST(true), "Requisition Type"=CONST("Purchase Requisition"));

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
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Raised by"; Rec."Raised by")
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
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Quantity Requested"; Rec."Quantity Requested")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Requisition Details")
            {
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Requested For"; Rec."Requested For")
                {
                    ApplicationArea = All;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = All;
                }
                field("Needed By Date"; Rec."Needed By Date")
                {
                    ApplicationArea = All;
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                }
            }
            part(Control16; "SS Requisition Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Requisition No"=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control15; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Open PO")
            {
                ApplicationArea = All;
                Image = "Order";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."PO Generated Directly" then begin
                        PO.Reset;
                        PO.SetRange("Document Type", PO."Document Type"::Order);
                        PO.SetRange("No.", Rec."PO Number");
                        PAGE.Run(50, PO);
                    end
                    else
                        Error('A PO has not been created from this Requisition!');
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Requisition Type":=Rec."Requisition Type"::"Store Requisition";
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Raised by", UserId);
    end;
    var PO: Record "Purchase Header";
}
