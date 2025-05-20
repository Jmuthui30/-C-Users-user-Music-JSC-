page 51822 "Store Transaction-Posted"
{
    // version THL- PRM 1.0
    Caption = 'Posted Store Transaction';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Store Transaction Header";
    SourceTableView = WHERE(Posted=CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field(Transaction; Rec.Transaction)
                {
                    ApplicationArea = All;
                }
            }
            part(Control12; "Store Transaction Lines")
            {
                ApplicationArea = All;
                SubPageLink = "No."=FIELD("No.");
            }
        }
        area(factboxes)
        {
            systempart(Control11; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    var StoresMgt: Codeunit "Stores Management";
}
