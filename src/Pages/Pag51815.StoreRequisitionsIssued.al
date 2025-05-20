page 51815 "Store Requisitions - Issued"
{
    // version THL- PRM 1.0
    Caption = 'Issued Store Requisition';
    CardPageID = "Store Requisition Header-Issue";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = History;
    SourceTable = "Requisition Header";
    SourceTableView = WHERE("Requisition Type"=FILTER("Store Requisition"|"S_Store Requisition"|"J_Store Requisition"), Status=CONST(Archived));

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
                field("Reason Code"; Rec."Reason Code")
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
    }
}
