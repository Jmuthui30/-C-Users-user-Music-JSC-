page 51735 "SS Company Documents Card"
{
    // version THL- HRM 1.0
    Caption = 'Company Documents';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Company Documents";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                }
            }
            part(Control8; "SS Company Document Subpage")
            {
                ApplicationArea = All;
                SubPageLink = "Document No."=FIELD("No."), "Table ID"=CONST(51636);
            }
        }
        area(factboxes)
        {
            systempart(Control7; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        if UserSetup.Get(UserId)then if not UserSetup."In Management" then Rec.SetRange(Rec."Visible To", Rec."Visible To"::"All Staff");
    end;
    var UserSetup: Record "User Setup";
}
