page 51826 "SS Purch Requisition Header-Pe"
{
    // version THL- PRM 1.0
    Caption = 'Purchase Requisition Pending Approval';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Status=CONST("Pending Approval"), "Requisition Type"=CONST("Purchase Requisition"));

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
                    Editable = false;
                }
                field("Requested By"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                    Importance = Additional;
                }
                field(Reason; Rec.Reason)
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
                field("No of Approvals"; Rec."No of Approvals")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount Limit Code"; Rec."Amount Limit Code")
                {
                    ApplicationArea = All;
                }
                field("Amount Limit Description"; Rec."Amount Limit Description")
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
            part(Control20; "Requisition Documents Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51800);
            }
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
            action("Cancel Approval Request")
            {
                ApplicationArea = All;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.TestField("Raised by", UserId);
                    ApprovalsMgt.OnCancelRequisitionApprovalRequest(Rec);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Requisition Type":=Rec."Requisition Type"::"Purchase Requisition";
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Raised by", UserId);
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
}
