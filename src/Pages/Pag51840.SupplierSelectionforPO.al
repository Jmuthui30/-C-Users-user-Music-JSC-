page 51840 "Supplier Selection for PO"
{
    // version THL- PRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Requisition Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Requisition Type"; Rec."Requisition Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                    Caption = 'Requested By';
                    Editable = false;
                }
                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Supplier No"; Rec."Supplier No")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
