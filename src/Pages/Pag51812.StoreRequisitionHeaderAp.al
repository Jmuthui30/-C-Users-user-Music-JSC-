page 51812 "Store Requisition Header-Ap"
{
    // version THL- PRM 1.0
    Caption = 'Approved Store Requisition';
    InsertAllowed = false;
    DeleteAllowed = false;
    //Editable = false;
    PageType = Card;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Status=CONST(Released), Issued=CONST(false), "Requisition Type"=FILTER("Store Requisition"|"S_Store Requisition"|"J_Store Requisition"));

    layout
    {
        area(content)
        {
            group(General)
            {
                //Editable = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Code"; Rec."Employee Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Requisition Date"; Rec."Requisition Date")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                field("Raised by"; Rec."Raised by")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                    Visible = false;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Service Order Desc."; Rec."Service Order Desc.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                    Visible = false;
                }
                field("Store Req. Qty. Requested"; Rec."Store Req. Qty. Requested")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Store Req. Qty. Issued"; Rec."Store Req. Qty. Issued")
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
                    Editable = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
            part(Control16; "SS  Requisition Lines Approved")
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
            action("Store Item Email")
            {
                ApplicationArea = All;
                Caption = 'Store Item - Email';
                Image = ElectronicDoc;
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    StoresMgt.EmailStoreRequisition(Rec);
                end;
            }
            action(Issue)
            {
                ApplicationArea = All;
                Image = ResetStatus;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(StrSubstNo(Text000, Rec."Employee Name"), false) = true then begin
                        if Rec."Requisition Type" = Rec."Requisition Type"::"J_Store Requisition" then OEE_Requisitions."Post Job Store Requisition"(Rec)
                        else if Rec."Requisition Type" = Rec."Requisition Type"::"S_Store Requisition" then OEE_Requisitions."Post Service Store Requisition"(Rec)
                            else
                                StoresMgt.IssueStoreItems(Rec);
                        CurrPage.Update(true);
                    end;
                end;
            }
            action(Print)
            {
                ApplicationArea = Suite;
                Caption = 'Print';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'Prepare to print the document. A report request window for the document opens where you can specify what to include on the print-out.';

                trigger OnAction()
                var
                    LinesInstructionMgt: Codeunit "Lines Instruction Mgt.";
                begin
                    Rec.Reset;
                    Rec.SetRange("No.", Rec."No.");
                    REPORT.Run(51821, true, false, Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        RequisitionHeader.Reset;
        RequisitionHeader.SetRange("No.", Rec."No.");
        if RequisitionHeader.FindFirst then begin
            RequisitionHeader.CalcFields("Store Req. Qty. Issued");
            RequisitionHeader.CalcFields("Store Req. Qty. Requested");
            if(RequisitionHeader."Store Req. Qty. Issued" = RequisitionHeader."Store Req. Qty. Requested") and (RequisitionHeader."Store Req. Qty. Requested" <> 0) and (RequisitionHeader."Store Req. Qty. Issued" <> 0)then begin
                RequisitionHeader.Status:=RequisitionHeader.Status::Archived;
                RequisitionHeader.Issued:=true;
                RequisitionHeader.Received:=true;
                RequisitionHeader."Received Date":=WorkDate;
                RequisitionHeader.Modify;
            end;
        end;
    end;
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Requisition Type":=Rec."Requisition Type"::"Store Requisition";
    end;
    var StoresMgt: Codeunit "Stores Management";
    Text000: Label 'You are about to issue the store items to %1. Do you wish to continue?';
    OEE_Requisitions: Codeunit 51805;
    RequisitionHeader: Record "Requisition Header";
}
