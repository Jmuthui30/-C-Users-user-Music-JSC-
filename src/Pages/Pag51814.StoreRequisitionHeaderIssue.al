page 51814 "Store Requisition Header-Issue"
{
    // version THL- PRM 1.0
    Caption = 'Issued Store Requisition';
    PageType = Card;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE("Requisition Type"=FILTER("Store Requisition"|"S_Store Requisition"|"J_Store Requisition"), Status=CONST(Archived));

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
                    Visible = false;
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
                }
                field("Location Code"; Rec."Location Code")
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
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec."Requisition Type":=Rec."Requisition Type"::"Store Requisition";
    end;
}
