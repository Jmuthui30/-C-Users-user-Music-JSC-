page 51832 "Purch Requisition Header-Ap"
{
    // version THL- PRM 1.0
    Caption = 'Approved Purchase Requisition';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Status=CONST(Released), "PR Closed"=CONST(false), "Requisition Type"=CONST("Purchase Requisition"));

    layout
    {
        area(content)
        {
            group(General)
            {
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
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("No of Approvals"; Rec."No of Approvals")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Approvers; Rec.Approvers)
                {
                    Editable = false;
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    var
                        Entries: Record "Approval Entry";
                    begin
                        Entries.Reset();
                        Entries.SetRange("Table ID", 51800);
                        Entries.SetRange("Document No.", Rec."No.");
                        Entries.SetFilter(Status, '=%1', Entries.Status::Approved);
                        Page.RunModal(Page::"Custom Approval Entries", Entries);
                    end;
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
                field("Currency Code"; Rec."Currency Code")
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
                    Visible = false;
                }
                field("Amount Limit Description"; Rec."Amount Limit Description")
                {
                    ApplicationArea = All;
                    Visible = false;
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
            part(Control23; "Requisition Documents Subpage")
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
            action("View SharePoint Documents")
            {
                ApplicationArea = All;
                Image = ViewDocumentLine;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."SharePoint Link" = '' then Error('There is no link to documents uploaded in SharePoint. Please contact the SharePoint Administrator.')
                    else
                        HyperLink(Rec."SharePoint Link");
                end;
            }
            action("Make Order")
            {
                ApplicationArea = All;
                Image = MakeOrder;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PurchMgt.GenerateOrderFormRequisition(Rec);
                end;
            }
            action("Append to Order")
            {
                ApplicationArea = All;
                Image = Add;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PurchMgt.AppendRequisitionToOrder(Rec);
                end;
            }
            action("Receive Into Store")
            {
                ApplicationArea = All;
                Image = ResetStatus;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    StoresMgt.ReceiveReleasedPR(Rec);
                end;
            }
            action("Print Approved Shopping List")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51800, true, false, Rec);
                end;
            }
            action("Close Requisition")
            {
                ApplicationArea = All;
                Image = Cancel;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm('Are you sure you want to Cancel this Requisition?', false) = true then begin
                        Rec."PR Closed":=true;
                        Rec."PR Closed By":=Rec."PR Closed By"::Rejection;
                        Rec."Closed By":=UserId;
                        Rec."Closed Date":=Today;
                        Rec.Modify;
                        Lines.Reset;
                        Lines.SetRange("Requisition No", Rec."No.");
                        Lines.ModifyAll(Processed, true);
                    end;
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Requisition Type":=Rec."Requisition Type"::"Purchase Requisition";
    end;
    var StoresMgt: Codeunit "Stores Management";
    Text000: Label 'You are about to issue the store items to %1. Do you wish to continue?';
    PurchMgt: Codeunit "Purchases Management";
    PO: Record "Purchase Header";
    Lines: Record "Requisition Lines";
}
