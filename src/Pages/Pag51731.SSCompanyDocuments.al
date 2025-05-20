page 51731 "SS Company Documents"
{
    // version THL- HRM 1.0
    Caption = 'Company Documents';
    CardPageID = "SS Company Documents Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Company Documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Name"; Rec."Document Name")
                {
                    ApplicationArea = All;
                }
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
