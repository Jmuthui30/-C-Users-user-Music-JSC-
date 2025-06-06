page 51914 "Service Worksheet Subform -App"
{
    // version NAVW113.00
    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    LinksAllowed = false;
    MultipleNewLines = false;
    PageType = ListPart;
    SourceTable = "Service Line";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;

                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the service line.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';

                    trigger OnValidate()
                    begin
                        NoOnAfterValidate;
                    end;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the item is a catalog item.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description of an item, resource, cost, or a standard text on the line.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a code for the type of work performed by the resource registered on this line.';
                    Visible = false;
                }
                /*field(Reserve;Reserve)
                {
                    ApplicationArea = Reservation;
                    ToolTip = 'Specifies whether a reservation can be made for items on this line.';
                    Visible = false;
                }*/
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the inventory location from where the items on the line should be taken and where they should be registered.';

                    trigger OnValidate()
                    var
                        Item: Record Item;
                    begin
                        IF(Rec."Location Code" <> '') AND (Rec.Type = Rec.Type::Item)THEN IF Item.GET(Rec."No.")THEN Item.TESTFIELD(Type, Item.Type::Inventory);
                        LocationCodeOnAfterValidate;
                    end;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of item units, resource hours, cost on the service line.';

                    trigger OnValidate()
                    begin
                        QuantityOnAfterValidate;
                    end;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how many item units on this line have been reserved.';
                    Visible = false;
                }
                field("Fault Reason Code"; Rec."Fault Reason Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the fault reason for this service line.';
                }
                field("Fault Area Code"; Rec."Fault Area Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the fault area associated with this line.';
                }
                field("Symptom Code"; Rec."Symptom Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the symptom associated with this line.';
                }
                field("Fault Code"; Rec."Fault Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the fault associated with this line.';
                }
                field("Resolution Code"; Rec."Resolution Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code of the resolution associated with this line.';
                }
                field("Serv. Price Adjmt. Gr. Code"; Rec."Serv. Price Adjmt. Gr. Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the service price adjustment group code that applies to this line.';
                    Visible = false;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the price of one unit of the item or resource. You can enter a price manually or have it entered according to the Price/Profit Calculation field on the related card.';
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the discount defined for a particular group, item, or combination of the two.';
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the discount amount that is granted for the item on the line.';
                }
                field("Line Discount Type"; Rec."Line Discount Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of the line discount assigned to this line.';
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of products on the worksheet line.';
                }
                field("Exclude Warranty"; Rec."Exclude Warranty")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the warranty discount is excluded on this line.';
                }
                field("Exclude Contract Discount"; Rec."Exclude Contract Discount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that the contract discount is excluded for the item, resource, or cost on this line.';
                }
                field(Warranty; Rec.Warranty)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies that a warranty discount is available on this line of type Item or Resource.';
                }
                field("Warranty Disc. %"; Rec."Warranty Disc. %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the percentage of the warranty discount that is valid for the items or resources on this line.';
                    Visible = false;
                }
                field("Contract No."; Rec."Contract No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the contract, if the service order originated from a service contract.';
                }
                field("Contract Disc. %"; Rec."Contract Disc. %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contract discount percentage that is valid for the items, resources, and costs on this line.';
                    Visible = false;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT percentage used to calculate Amount Including VAT on this line.';
                    Visible = false;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the amount that serves as a base for calculating the Amount Including VAT field.';
                    Visible = false;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the net amount, including VAT, for this line.';
                    Visible = false;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor''s or customer''s trade type to link transactions made for this business partner with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item''s product type to link transactions made for this item with the appropriate general ledger account according to the general posting setup.';
                    Visible = false;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT specification of the involved customer or vendor to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the VAT specification of the involved item or resource to link transactions made for this record with the appropriate general ledger account according to the VAT posting setup.';
                    Visible = false;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when the service line should be posted.';
                    Visible = false;

                    trigger OnValidate()
                    begin
                        PostingDateOnAfterValidate;
                    end;
                }
                field("Planned Delivery Date"; Rec."Planned Delivery Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the planned date that the shipment will be delivered at the customer''s address. If the customer requests a delivery date, the program calculates whether the items will be available for delivery on this date. If the items are available, the planned delivery date will be the same as the requested delivery date. If not, the program calculates the date that the items are available for delivery and enters this date in the Planned Delivery Date field.';
                }
                field("Needed by Date"; Rec."Needed by Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date when you require the item to be available for a service order.';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 1, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for Shortcut Dimension 2, which is one of two global dimension codes that you set up in the General Ledger Setup window.';
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3), "Dimension Value Type"=CONST(Standard), Blocked=filter('No'));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4), "Dimension Value Type"=CONST(Standard), Blocked=filter('No'));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5), "Dimension Value Type"=CONST(Standard), Blocked=FILTER('No'));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(6), "Dimension Value Type"=CONST(Standard), Blocked=FILTER('No'));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(7), "Dimension Value Type"=CONST(Standard));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = All;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(8), "Dimension Value Type"=CONST(Standard));
                    Visible = false;

                    trigger OnValidate()
                    begin
                        Rec.ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(Approve)
                {
                    ApplicationArea = All;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';

                    //Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = All;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;

                    //Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = All;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;

                    // Visible = OpenApprovalEntriesExistForCurrUser;
                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(Rec.RecordId);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = All;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = Page "Approval Comments";
                    RunPageLink = "Document No."=FIELD("No.");
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction()
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
                action("Insert Ext. Texts")
                {
                    AccessByPermission = TableData "Extended Text Header"=R;
                    ApplicationArea = All;
                    Caption = 'Insert &Ext. Texts';
                    Image = Text;
                    ToolTip = 'Insert the extended item description that is set up for the item that is being processed on the line.';

                    trigger OnAction()
                    begin
                        InsertExtendedText(TRUE);
                    end;
                }
                action("Insert Starting Fee")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Starting Fee';
                    Image = InsertStartingFee;
                    ToolTip = 'Add a general starting fee for the service order.';

                    trigger OnAction()
                    begin
                        InsertStartFee;
                    end;
                }
                action("Insert Travel Fee")
                {
                    ApplicationArea = All;
                    Caption = 'Insert &Travel Fee';
                    Image = InsertTravelFee;
                    ToolTip = 'Add a general travel fee for the service order.';

                    trigger OnAction()
                    begin
                        InsertTravelFee;
                    end;
                }
                action(Reserve)
                {
                    ApplicationArea = All;
                    Caption = 'Reserve';
                    Image = Reserve;
                    ToolTip = 'Reserve items for the selected line.';

                    trigger OnAction()
                    begin
                        Rec.FIND;
                        Rec.ShowReservation;
                    end;
                }
                action("Order Tracking")
                {
                    ApplicationArea = All;
                    Caption = 'Order Tracking';
                    Image = OrderTracking;
                    ToolTip = 'Tracks the connection of a supply to its corresponding demand. This can help you find the original demand that created a specific production order or purchase order.';

                    trigger OnAction()
                    begin
                        Rec.FIND;
                        Rec.ShowTracking;
                    end;
                }
                action("&Catalog Items")
                {
                    AccessByPermission = TableData "Nonstock Item"=R;
                    ApplicationArea = All;
                    Caption = '&Catalog Items';
                    Image = NonStockItem;
                    ToolTip = 'View the list of items that you do not carry in inventory. ';

                    trigger OnAction()
                    begin
                        Rec.ShowNonstock;
                    end;
                }
            }
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                group("Item Availability by")
                {
                    Caption = 'Item Availability by';
                    Image = ItemAvailability;

                    action("Event")
                    {
                        ApplicationArea = All;
                        Caption = 'Event';
                        Image = "Event";
                        ToolTip = 'View how the actual and the projected available balance of an item will develop over time according to supply and demand events.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromServLine(Rec, ItemAvailFormsMgt.ByEvent);
                        end;
                    }
                    action(Period)
                    {
                        ApplicationArea = All;
                        Caption = 'Period';
                        Image = Period;
                        ToolTip = 'View the projected quantity of the item over time according to time periods, such as day, week, or month.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromServLine(Rec, ItemAvailFormsMgt.ByPeriod);
                        end;
                    }
                    action(Variant)
                    {
                        ApplicationArea = All;
                        Caption = 'Variant';
                        Image = ItemVariant;
                        ToolTip = 'View or edit the item''s variants. Instead of setting up each color of an item as a separate item, you can set up the various colors as variants of the item.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromServLine(Rec, ItemAvailFormsMgt.ByVariant);
                        end;
                    }
                    action(Location)
                    {
                        AccessByPermission = TableData Location=R;
                        ApplicationArea = All;
                        Caption = 'Location';
                        Image = Warehouse;
                        ToolTip = 'View the actual and projected quantity of the item per location.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromServLine(Rec, ItemAvailFormsMgt.ByLocation);
                        end;
                    }
                    action("BOM Level")
                    {
                        ApplicationArea = All;
                        Caption = 'BOM Level';
                        Image = BOMLevel;
                        ToolTip = 'View availability figures for items on bills of materials that show how many units of a parent item you can make based on the availability of child items.';

                        trigger OnAction()
                        begin
                            ItemAvailFormsMgt.ShowItemAvailFromServLine(Rec, ItemAvailFormsMgt.ByBOM);
                        end;
                    }
                }
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension=R;
                    ApplicationArea = All;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    ShortCutKey = 'Shift+Ctrl+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions;
                    end;
                }
                action("Select Item Substitution")
                {
                    AccessByPermission = TableData "Item Substitution"=R;
                    ApplicationArea = All;
                    Caption = 'Select Item Substitution';
                    Image = SelectItemSubstitution;
                    ToolTip = 'Select another item that has been set up to be traded instead of the original item if it is unavailable.';

                    trigger OnAction()
                    begin
                        SelectItemSubstitution;
                    end;
                }
                action("&Fault/Resol. Codes Relationships")
                {
                    ApplicationArea = All;
                    Caption = '&Fault/Resol. Codes Relationships';
                    Image = FaultDefault;
                    ToolTip = 'View or edit the relationships between fault codes, including the fault, fault area, and symptom codes, as well as resolution codes and service item groups. It displays the existing combinations of these codes for the service item group of the service item from which you accessed the window and the number of occurrences for each one.';

                    trigger OnAction()
                    begin
                        SelectFaultResolutionCode;
                    end;
                }
                action("Item &Tracking Lines")
                {
                    ApplicationArea = All;
                    Caption = 'Item &Tracking Lines';
                    Image = ItemTrackingLines;
                    ShortCutKey = 'Shift+Ctrl+I';
                    ToolTip = 'View or edit serial numbers and lot numbers that are assigned to the item on the document or journal line.';

                    trigger OnAction()
                    begin
                        Rec.OpenItemTrackingLines;
                    end;
                }
                action("Order &Promising Line")
                {
                    AccessByPermission = TableData "Order Promising Line"=R;
                    ApplicationArea = All;
                    Caption = 'Order &Promising Line';
                    ToolTip = 'View the calculated delivery date.';

                    trigger OnAction()
                    begin
                        Rec.ShowOrderPromisingLine;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
    end;
    trigger OnDeleteRecord(): Boolean var
        ReserveServLine: Codeunit "Service Line-Reserve";
    begin
        IF(Rec.Quantity <> 0) AND Rec.ItemExists(Rec."No.")THEN BEGIN
            COMMIT;
            IF NOT ReserveServLine.DeleteLineConfirm(Rec)THEN EXIT(FALSE);
            ReserveServLine.DeleteLine(Rec);
        END;
    end;
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        Rec."Line No.":=Rec.GetNextLineNo(xRec, BelowxRec);
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.Type:=xRec.Type;
        CLEAR(ShortcutDimCode);
        Rec.VALIDATE("Service Item Line No.", ServItemLineNo);
    end;
    var Text000: Label 'You cannot open the window because %1 is %2 in the %3 table.';
    ServMgtSetup: Record "Service Mgt. Setup";
    ItemAvailFormsMgt: Codeunit "Item Availability Forms Mgt";
    ServItemLineNo: Integer;
    ShortcutDimCode: array[8]of Code[20];
    OEE_Requisitions: Codeunit 51805;
    ServHeader: Record "Service Header";
    ServiceLine: Record "Service Line";
    OpenApprovalEntriesExistForCurrUser: Boolean;
    OpenApprovalEntriesExist: Boolean;
    ShowWorkflowStatus: Boolean;
    CanCancelApprovalForRecord: Boolean;
    DocumentIsPosted: Boolean;
    ApprovalsMgt: Codeunit "Approvals Mgmt.";
    [Scope('Cloud')]
    procedure SetValues(TempServItemLineNo: Integer)
    begin
        ServItemLineNo:=TempServItemLineNo;
        Rec.SETFILTER("Service Item Line No.", '=%1|=%2', 0, ServItemLineNo);
    end;
    local procedure InsertStartFee()
    var
        ServOrderMgt: Codeunit ServOrderManagement;
    begin
        CLEAR(ServOrderMgt);
        IF ServOrderMgt.InsertServCost(Rec, 1, TRUE)THEN CurrPage.UPDATE;
    end;
    local procedure InsertTravelFee()
    var
        ServOrderMgt: Codeunit ServOrderManagement;
    begin
        CLEAR(ServOrderMgt);
        IF ServOrderMgt.InsertServCost(Rec, 0, TRUE)THEN CurrPage.UPDATE;
    end;
    local procedure InsertExtendedText(Unconditionally: Boolean)
    var
        TransferExtendedText: Codeunit "Transfer Extended Text";
    begin
        OnBeforeInsertExtendedText(Rec);
        IF TransferExtendedText.ServCheckIfAnyExtText(Rec, Unconditionally)THEN BEGIN
            CurrPage.SAVERECORD;
            TransferExtendedText.InsertServExtText(Rec);
        END;
        IF TransferExtendedText.MakeUpdate THEN CurrPage.UPDATE;
    end;
    local procedure ShowReservationEntries()
    begin
        Rec.ShowReservationEntries(TRUE);
    end;
    local procedure SelectFaultResolutionCode()
    var
        ServItemLine: Record "Service Item Line";
        FaultResolutionRelation: Page "Fault/Resol. Cod. Relationship";
    begin
        ServMgtSetup.GET;
        CASE ServMgtSetup."Fault Reporting Level" OF ServMgtSetup."Fault Reporting Level"::None: ERROR(Text000, ServMgtSetup.FIELDCAPTION("Fault Reporting Level"), ServMgtSetup."Fault Reporting Level", ServMgtSetup.TABLECAPTION);
        END;
        ServItemLine.GET(Rec."Document Type", Rec."Document No.", Rec."Service Item Line No.");
        CLEAR(FaultResolutionRelation);
        FaultResolutionRelation.SetDocument(DATABASE::"Service Line", Rec."Document Type", Rec."Document No.", Rec."Line No.");
        FaultResolutionRelation.SetFilters(Rec."Symptom Code", Rec."Fault Code", Rec."Fault Area Code", ServItemLine."Service Item Group Code");
        FaultResolutionRelation.RUNMODAL;
        CurrPage.UPDATE(FALSE);
    end;
    local procedure SelectItemSubstitution()
    begin
        Rec.ShowItemSub;
        Rec.MODIFY;
    end;
    local procedure NoOnAfterValidate()
    begin
        InsertExtendedText(FALSE);
        IF(Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) AND (Rec."No." <> xRec."No.")THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;
    local procedure LocationCodeOnAfterValidate()
    begin
        IF(Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) AND (Rec."Location Code" <> xRec."Location Code")THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;
    local procedure QuantityOnAfterValidate()
    begin
        IF Rec.Type = Rec.Type::Item THEN CASE Rec.Reserve OF Rec.Reserve::Always: BEGIN
                CurrPage.SAVERECORD;
                Rec.AutoReserve;
                CurrPage.UPDATE(FALSE);
            END;
            Rec.Reserve::Optional: IF(Rec.Quantity < xRec.Quantity) AND (xRec.Quantity > 0)THEN BEGIN
                    CurrPage.SAVERECORD;
                    CurrPage.UPDATE(FALSE);
                END;
            END;
    end;
    local procedure PostingDateOnAfterValidate()
    begin
        IF(Rec.Reserve = Rec.Reserve::Always) AND (Rec."Outstanding Qty. (Base)" <> 0) AND (Rec."Posting Date" <> xRec."Posting Date")THEN BEGIN
            CurrPage.SAVERECORD;
            Rec.AutoReserve;
            CurrPage.UPDATE(FALSE);
        END;
    end;
    [IntegrationEvent(false, false)]
    local procedure OnBeforeInsertExtendedText(var ServiceLine: Record "Service Line")
    begin
    end;
    local procedure SetControlAppearance()
    var
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
    begin
        OpenApprovalEntriesExistForCurrUser:=ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(Rec.RecordId);
        OpenApprovalEntriesExist:=ApprovalsMgmt.HasOpenApprovalEntries(Rec.RecordId);
        CanCancelApprovalForRecord:=ApprovalsMgmt.CanCancelApprovalForRecord(Rec.RecordId);
    end;
}
