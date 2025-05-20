page 50004 "Update My Status"
{
    ApplicationArea = All;
    Caption = 'Update My Status';
    PageType = Card;
    SourceTable = "User Setup";
    InsertAllowed = true;
    DeleteAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("User ID"; Rec."User ID")
                {
                    Editable = false;
                }
                field("Approver ID"; Rec."Approver ID")
                {
                    Editable = false;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    Editable = false;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    Editable = false;
                }
                field(Signature; Rec.Signature)
                {
                // Editable = false;
                }
                field("Not Available"; Rec."Not Available")
                {
                }
                field("Date Not Available"; Rec."Date Not Available")
                {
                }
            }
        }
    }
    trigger OnInit()
    begin
        Rec.SetRange("User ID", UserId);
    end;
    trigger OnOpenPage()
    begin
        Rec.SetRange("User ID", UserId);
    end;
    trigger OnAfterGetCurrRecord()
    begin
        Rec.SetRange("User ID", UserId);
    end;
    trigger OnAfterGetRecord()
    begin
        Rec.SetRange("User ID", UserId);
    end;
}
