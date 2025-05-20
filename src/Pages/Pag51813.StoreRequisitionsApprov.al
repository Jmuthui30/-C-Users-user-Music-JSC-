page 51813 "Store Requisitions - Approv"
{
    // version THL- PRM 1.0
    Caption = 'Procurement Store Req. Approved';
    CardPageID = "Store Requisition Header-Ap";
    PageType = List;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE(Status=CONST(Released), Issued=CONST(false), "Requisition Type"=FILTER("Store Requisition"|"S_Store Requisition"|"J_Store Requisition"));

    layout
    {
        area(content)
        {
            repeater(General)
            {
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
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                }
                field("Requisition Date"; Rec."Requisition Date")
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Job Description"; Rec."Job Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Service Order No."; Rec."Service Order No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Service Item No."; Rec."Service Item No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Service Order Desc."; Rec."Service Order Desc.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
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
            group("<Action23>")
            {
                Caption = '<Action23>';
            }
            action("Store Issue")
            {
                ApplicationArea = Suite;
                Caption = 'Store Issue';
                Ellipsis = true;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
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
            action(Print)
            {
                ApplicationArea = Suite;
                Caption = 'Print';
                Image = PrintReport;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    Rec.Reset();
                    Rec.SetRange("No.", Rec."No.");
                    Report.Run(51821, true, false, Rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        quantity: Integer;
        Issued: Integer;
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
    var RequisitionHeader: Record "Requisition Header";
}
