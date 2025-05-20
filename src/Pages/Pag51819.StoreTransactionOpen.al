page 51819 "Store Transaction-Open"
{
    // version THL- PRM 1.0
    Caption = 'New Store Transaction';
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Store Transaction Header";
    SourceTableView = WHERE(Posted=CONST(false));

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Transaction; Rec.Transaction)
                {
                    ApplicationArea = All;
                    Editable = false;
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
        area(processing)
        {
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    StoresMgt.PostStoreTransaction(Rec);
                end;
            }
        }
    }
    var StoresMgt: Codeunit "Stores Management";
}
