pageextension 51435 "Ser. Item Wrk. Subform Ext" extends "Service Item Worksheet Subform"
{
    layout
    {
        // Add changes to page layout here
        addbefore(Type)
        {
            field(Status; Rec.Status)
            {
                Editable = false;
                ApplicationArea = All;
            }
            field("Store Req. Status"; Rec."Store Req. Status")
            {
                Editable = false;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        // Add changes to page actions here
        addbefore("Insert Ext. Texts")
        {
            action(Post)
            {
                ApplicationArea = Service;
                Caption = 'Post';
                Image = Post;

                trigger OnAction()
                var
                    ServLine: Record "Service Line";
                    TempServLine: Record "Service Line" temporary;
                    ServPostYesNo: Codeunit "Service-Post (Yes/No)";
                begin
                    /*IF CONFIRM('Do you want to Post? '+Rec."No.",TRUE) THEN BEGIN
                    IF Rec.Type = Rec.Type::Item THEN
                      OEE_Requisitions."Create Service Store Requisition"(Rec)
                    ELSE
                      IF Rec.Type = Rec.Type::Resource THEN
                        OEE_Requisitions."Post Service Resource"(Rec);

                    IF Rec.Type = Rec.Type::Item THEN
                      MESSAGE('Service Store Requisition have been Created')
                    ELSE
                      IF Rec.Type = Rec.Type::Resource THEN
                        MESSAGE('Resource have been Posted');
                    END ELSE BEGIN
                      EXIT;
                    END;
                    */
                    //CurrPage.SETSELECTIONFILTER(Rec);
                    Clear(ServLine);
                    Rec.Modify(true);
                    CurrPage.SaveRecord;
                    CurrPage.SetSelectionFilter(ServLine);
                    if ServLine.FindFirst then repeat Rec.TestField(Status, Rec.Status::Released);
                            Rec.TestField("Qty. to Ship");
                            TempServLine.Init;
                            TempServLine:=ServLine;
                            TempServLine.Insert;
                        until ServLine.Next = 0
                    else
                        exit;
                    ServHeader.Get(Rec."Document Type", Rec."Document No.");
                    Clear(ServPostYesNo);
                    ServPostYesNo.PostDocumentWithLines(ServHeader, TempServLine);
                    ServLine.SetRange("Document Type", ServHeader."Document Type");
                    ServLine.SetRange("Document No.", ServHeader."No.");
                    if not ServLine.Find('-')then begin
                        Rec.Reset;
                        CurrPage.Close;
                    end
                    else
                        CurrPage.Update;
                end;
            }
            action(Preview)
            {
                ApplicationArea = Service;
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                var
                    ServLine: Record "Service Line";
                    TempServLine: Record "Service Line" temporary;
                    ServPostYesNo: Codeunit "Service-Post (Yes/No)";
                begin
                    Clear(ServLine);
                    CurrPage.SaveRecord;
                    CurrPage.SetSelectionFilter(ServLine);
                    if ServLine.FindFirst then repeat TempServLine.Init;
                            TempServLine:=ServLine;
                            if TempServLine.Insert then;
                        until Rec.Next = 0
                    else
                        exit;
                    ServHeader.Get(Rec."Document Type", Rec."Document No.");
                    ServPostYesNo.PreviewDocumentWithLines(ServHeader, TempServLine);
                end;
            }
            action("Store Requisition Request")
            {
                ApplicationArea = Service;
                Caption = 'Store Requisition Request';
                Image = Purchase;
                ToolTip = 'Store Requisition Request';

                trigger OnAction()
                var
                    Counter: Integer;
                    DocNo: Code[20];
                    Global1: Code[20];
                    Global2: Code[20];
                    "ServiceOrderNo.": Code[20];
                    ServiceItemNo: Code[20];
                    ServiceOrderDesc: Text[50];
                    Location: Code[20];
                begin
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindFirst then begin
                        Global1:=ServiceLine."Shortcut Dimension 1 Code";
                        Global2:=ServiceLine."Shortcut Dimension 2 Code";
                        Location:=ServiceLine."Location Code";
                        "ServiceOrderNo.":=ServiceLine."Document No.";
                        ServiceItemNo:=ServiceLine."Service Item No.";
                        ServHeader.Reset;
                        ServHeader.SetRange("No.", ServiceLine."Document No.");
                        if ServHeader.FindFirst then ServiceOrderDesc:=CopyStr(ServHeader.Description, 1, 100);
                    end;
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat ServiceLine.TestField(Status, ServiceLine.Status::Released);
                            ServiceLine.TestField(Type, ServiceLine.Type::Item);
                            ServiceLine.TestField("Store Req. Status", false);
                            ServiceLine.TestField("Location Code");
                        until ServiceLine.Next = 0;
                    end;
                    //Creating Store Requisition Header
                    ProcurementSetup.Get;
                    RequisitionHeader.Init;
                    RequisitionHeader.Status:=RequisitionHeader.Status::Released;
                    RequisitionHeader."Requisition Type":=RequisitionHeader."Requisition Type"::"S_Store Requisition";
                    RequisitionHeader."Global Dimension 1 Code":=Global1;
                    RequisitionHeader.Validate("Global Dimension 1 Code");
                    RequisitionHeader."Global Dimension 2 Code":=Global2;
                    RequisitionHeader.Validate("Global Dimension 2 Code");
                    RequisitionHeader."Location Code":=Location;
                    RequisitionHeader.Validate("Location Code");
                    RequisitionHeader."Service Order No.":="ServiceOrderNo.";
                    RequisitionHeader."Service Item No.":=ServiceItemNo;
                    RequisitionHeader."Service Order Desc.":=ServiceOrderDesc;
                    RequisitionHeader."Raised by":=UserId;
                    RequisitionHeader."Document Type":=RequisitionHeader."Document Type"::"Store Requisition";
                    if QuantumJumpsUserSetup.Get(UserId)then begin
                        QuantumJumpsUserSetup.TestField("Employee No.");
                        RequisitionHeader."Employee Code":=QuantumJumpsUserSetup."Employee No.";
                        if Employee.Get(QuantumJumpsUserSetup."Employee No.")then RequisitionHeader."Employee Name":=Employee.Name;
                    end;
                    RequisitionHeader.Insert(true);
                    DocNo:=RequisitionHeader."No.";
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat //Do your action here
                            if ServiceLine.Type = ServiceLine.Type::Item then begin
                                // Updating Store Requisition Lines
                                Counter:=Counter + 1000;
                                RequisitionLines.Init;
                                RequisitionLines."Requisition No":=DocNo;
                                RequisitionLines."Line No":=Counter;
                                RequisitionLines.Status:=RequisitionLines.Status::Open;
                                RequisitionLines.Type:=RequisitionLines.Type::Item;
                                RequisitionLines.No:=ServiceLine."No.";
                                RequisitionLines.Description:=ServiceLine.Description;
                                RequisitionLines."Unit of Measure":=ServiceLine."Unit of Measure Code";
                                RequisitionLines."Location Code":=ServiceLine."Location Code";
                                RequisitionLines.Validate("Location Code");
                                RequisitionLines.Quantity:=ServiceLine.Quantity;
                                RequisitionLines."Quantity Approved":=ServiceLine.Quantity;
                                RequisitionLines.Validate(Quantity);
                                RequisitionLines."Service Order No":=ServiceLine."Document No.";
                                RequisitionLines.Validate("Service Order No");
                                RequisitionLines."Service Item Line No.":=ServiceLine."Line No.";
                                RequisitionLines.Validate("Service Item Line No.");
                                RequisitionLines."Unit Price":=ServiceLine."Unit Price";
                                if Item.Get(ServiceLine."No.")then begin
                                    RequisitionLines.Amount:=ServiceLine.Quantity * Item."Unit Cost";
                                    RequisitionLines."Quantity in Store":=Item.Inventory;
                                end;
                                RequisitionLines."Global Dimension 1 Code":=ServiceLine."Shortcut Dimension 1 Code";
                                RequisitionLines.Validate("Global Dimension 1 Code");
                                RequisitionLines."Global Dimension 2 Code":=ServiceLine."Shortcut Dimension 2 Code";
                                RequisitionLines.Insert(true);
                                // Update The service Order Lines
                                ServiceLine."Qty. to Ship":=0;
                                ServiceLine."Qty. to Invoice":=0;
                                ServiceLine."Issuing Status":=false;
                                ServiceLine."Store Req. Status":=true;
                                ServiceLine.Modify;
                            end;
                        until ServiceLine.Next = 0;
                        DocNo:='';
                        "ServiceOrderNo.":='';
                        ServiceItemNo:='';
                        ServiceOrderDesc:='';
                    end;
                    Message(StrSubstNo(Text000, RequisitionHeader."No."));
                    Page.Run(Page::"SS Store Requisition Header-Ap", RequisitionHeader);
                end;
            }
            action("Send For Approval")
            {
                ApplicationArea = Service;
                Caption = 'Send For Approval';
                Image = SendApprovalRequest;
                ToolTip = 'Send For Approval Request';

                trigger OnAction()
                begin
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat //Do your action here
                            ServiceLine.TestField(Status, ServiceLine.Status::Open);
                            ServiceLine.TestField("Shortcut Dimension 1 Code");
                            ServiceLine.TestField("Line Amount");
                        until ServiceLine.Next = 0;
                    end;
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat //Do your action here
                            ApprovalsMgmt.OnSendServiceWorkSheetForApproval(ServiceLine);
                        until ServiceLine.Next = 0;
                    end;
                end;
            }
            action("Cancel Approval Request")
            {
                ApplicationArea = Service;
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                ToolTip = 'Cancel Send For Approval Request';

                trigger OnAction()
                begin
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat //Do your action here
                            Rec.TestField(Status, Rec.Status::"Pending Approval");
                        until ServiceLine.Next = 0;
                    end;
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat //Do your action here
                            ApprovalsMgmt.OnCancelServiceWorkSheetApprovalRequest(ServiceLine);
                        until ServiceLine.Next = 0;
                    end;
                end;
            }
            action("Re-Open")
            {
                Image = ReOpen;
                ApplicationArea = All;

                //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                //PromotedIsBig = true;
                trigger OnAction()
                begin
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat //Do your action here
                            ServiceLine.TestField(Status, ServiceLine.Status::Released);
                        until ServiceLine.Next = 0;
                    end;
                    ServiceLine.CopyFilters(Rec);
                    CurrPage.SetSelectionFilter(ServiceLine);
                    if ServiceLine.FindSet then begin
                        repeat //Do your action here
                            ServiceLine.Status:=ServiceLine.Status::Open;
                            ServiceLine.Modify(true);
                            Message('Worksheet Line No ' + Format(ServiceLine."Line No.") + ' for ' + ServiceLine.Description + ' have been Reopened');
                        until ServiceLine.Next = 0;
                    end;
                end;
            }
            action("Approval Set Up")
            {
                Image = ApprovalSetup;
                RunObject = Page "Self Service Approval Setup";
                ApplicationArea = All;
            }
            group("Manual Approval")
            {
                Caption = 'Release';
                Visible = NOT OpenApprovalEntriesExistForCurrUser;

                action(Release)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&lease';
                    Image = ReleaseDoc;
                    ShortCutKey = 'Ctrl+F9';

                    trigger OnAction()
                    var
                        ReleaseServDoc: Codeunit "Release Service Worksheet";
                    begin
                        ReleaseServDoc.PerformManualRelease(Rec);
                    end;
                }
                action(Reopen)
                {
                    ApplicationArea = Suite;
                    Caption = 'Re&open';
                    Enabled = Rec.Status <> Rec.Status::Open;
                    Image = ReOpen;

                    trigger OnAction()
                    var
                        ReleaseServDoc: Codeunit "Release Service Worksheet";
                        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
                    begin
                        ReleaseServDoc.PerformManualReopen(Rec);
                        WorkflowWebhookMgt.FindAndCancel(Rec.RecordId);
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
    end;
    var OEE_Requisitions: Codeunit OEERequisitions;
    ServHeader: Record "Service Header";
    ServiceLine: Record "Service Line";
    ApprovalsMgmt: Codeunit "Approvals Mgmt. Ext";
    RequisitionHeader: Record "Requisition Header";
    ProcurementSetup: Record "Procurement Setup";
    RequisitionLines: Record "Requisition Lines";
    QuantumJumpsUserSetup: Record "User Setup";
    Employee: Record Resource;
    Item: Record Item;
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    CanCancelApprovalForRecord: Boolean;
    CanRequestApprovalForFlow: Boolean;
    CanCancelApprovalForFlow: Boolean;
    Text000: Label 'Service Store Requisition %1 have been Created';
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(Rec.RecordId, CanRequestApprovalForFlow, CanCancelApprovalForFlow);
    end;
}
