page 52060 "PR Store Requisition Header-Op"
{
    // version THL- PRM 1.0
    Caption = 'Create Store Requisition for Employee';
    PromotedActionCategories = 'New,Process,Report,Approve,Release,Request Approval,Workflow,Attachments';
    PageType = Card;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Status=CONST(Open), "Requisition Type"=CONST("Store Requisition"), "PR Created"=CONST(true));

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
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = All;
                }
                field("Requested For"; Rec."Requested For")
                {
                    ApplicationArea = All;
                }
                field("Raised by"; Rec."Raised by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Pending Approvals"; Rec."Pending Approvals")
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
                        Entries.SetFilter(Status, '%1|%2', Entries.Status::Open, Entries.Status::Created);
                        Page.RunModal(Page::"Custom Approval Entries", Entries);
                    end;
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            group("Requisition Details")
            {
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
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
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;
                Visible = false;

                trigger OnAction()
                begin
                    Rec.TestField("Global Dimension 1 Code");
                    RequisitionLines.Reset;
                    RequisitionLines.SetRange("Requisition No", Rec."No.");
                    if RequisitionLines.FindSet then RequisitionLines.TestField(Quantity);
                    RequisitionLines.TestField(No);
                    ApprovalsMgt.OnSendRequisitionForApproval(Rec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category4;

                trigger OnAction()
                var
                    Text001: Label 'Are you sure you want to approve this Request';
                begin
                    Rec.TestField("Global Dimension 1 Code");
                    RequisitionLines.Reset;
                    RequisitionLines.SetRange("Requisition No", Rec."No.");
                    if RequisitionLines.FindSet then RequisitionLines.TestField(Quantity);
                    RequisitionLines.TestField(No);
                    If Confirm(Text001, false) = True then begin
                        Rec.Status:=Rec.Status::Released;
                        Rec.Modify;
                        Message('You Request have been Approved');
                    end;
                end;
            }
            action("Approval Set Up")
            {
                ApplicationArea = All;
                Visible = false;
                Image = ApprovalSetup;
                RunObject = Page "Self Service Approval Setup";
            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Requisition Type":=Rec."Requisition Type"::"Store Requisition";
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."PR Created":=true;
        Rec."Requisition Type":=Rec."Requisition Type"::"Store Requisition";
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Raised by", UserId);
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    RequisitionLines: Record "Requisition Lines";
}
