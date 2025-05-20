page 52058 "PR Purch Requisition Header-Op"
{
    // version THL- PRM 1.0
    Caption = 'Create Purchase Requisition for Employee';
    PageType = Card;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Status=CONST(Open), "Requisition Type"=CONST("Purchase Requisition"), "PR Created"=CONST(true));

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
                field("Requested By"; Rec."Employee Name")
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
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter a code for the location where you want the items to be placed when they are received.';
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the title of the purchase request''s.';
                    //ShowMandatory = true;
                    //Importance = Promoted;
                    Visible = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the reason of the purchase request''s.';
                    ShowMandatory = true;
                    Importance = Promoted;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    ToolTip = 'Enter the description/ brief of the purchase request''s.';
                    //ShowMandatory = true;
                    //Importance = Promoted;
                    Visible = false;
                }
                field("Raised by"; Rec."Raised by")
                {
                    ApplicationArea = All;
                }
                field("Requested For"; Rec."Requested For")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = All;
                }
                field("Needed By Date"; Rec."Needed By Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter when the related purchase request is needed.';
                }
                field("Expiration Date"; Rec."Expiration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter when the related purchase request end date to be.';
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Enter the currency of amounts on the purchase request document.';
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
                    ToolTip = 'Specifies whether the record is open, waiting to be approved, invoiced for prepayment, or released to the next stage of processing.';
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'View the total amount of the line';
                }
                field("Amount Limit Code"; Rec."Amount Limit Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'View the amount limit code';
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
                UpdatePropagation = Both;
            }
        }
        area(factboxes)
        {
            part(Control9; "Requisition Documents Subpage")
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
            action("Attach Documents")
            {
                ApplicationArea = All;
                Image = Attach;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Requisition Documents";
                RunPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51800);
            }
            action("Send Approval Request")
            {
                ApplicationArea = All;
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //TestField(Title);
                    //TestField(Description);
                    Rec.TestField(Reason);
                    Rec.CalcFields("Empty No.");
                    if Rec."Empty No." = true then Error('The No. must be filled on the lines.');
                    if(Rec."Global Dimension 1 Code" = '')then Error('The Department Code cannot be blank for requisition %1', Rec."No.");
                    Lines.Reset;
                    Lines.SetRange("Requisition No", Rec."No.");
                    if Lines.FindSet then repeat if(Lines.Type = Lines.Type::Item) and (Lines.Description = '')then Error('The Item Status of the selected item cannot be inactive for requisition line %1', Lines."Line No");
                            Lines.TestField(Quantity);
                            //PurchMgt.ProcurementCheck(Rec);
                            if(Lines."Global Dimension 1 Code" = '')then Error('The Department Code cannot be blank for requisition line %1', Lines."Line No");
                        until Lines.Next = 0;
                    ApprovalsMgt.OnSendRequisitionForApproval(Rec);
                end;
            }
            action(Approve)
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Text001: Label 'Are you sure you want to approve this Request';
                begin
                    Rec.CalcFields("Empty No.");
                    if Rec."Empty No." = true then Error('The No. must be filled on the lines.');
                    if(Rec."Global Dimension 1 Code" = '')then Error('The Department Code cannot be blank for requisition %1', Rec."No.");
                    Lines.Reset;
                    Lines.SetRange("Requisition No", Rec."No.");
                    if Lines.FindSet then repeat Lines.TestField(Quantity);
                            if(Lines."Global Dimension 1 Code" = '')then Error('The Department Code cannot be blank for requisition %1', Lines."Line No");
                        until Lines.Next = 0;
                    If Confirm(Text001, false) = True then begin
                        Rec.Status:=Rec.Status::Released;
                        Rec.Modify;
                        Message('You Request have been Approved');
                    end;
                end;
            }
            action(Print)
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(Report::"Purchase Requisition", true, false, Rec);
                end;
            }
            action("Copy From Other PR Details")
            {
                ApplicationArea = All;
                Image = CopyDocument;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PurchMgt.CopyRequisitionDetails(Rec);
                end;
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."PR Created":=true;
        Rec."Requisition Type":=Rec."Requisition Type"::"Purchase Requisition";
        Rec.Status:=Rec.Status::Open;
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("Raised by", UserId);
    end;
    var ApprovalsMgt: Codeunit "Approvals Mgmt. Ext";
    PurchMgt: Codeunit "Purchases Management";
    Lines: Record "Requisition Lines";
    ItemRec: Record item;
}
