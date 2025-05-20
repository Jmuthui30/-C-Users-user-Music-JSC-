page 50025 "Commitment Entries"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Commitment Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Commitment No"; Rec."Commitment No")
                {
                    ApplicationArea = All;
                }
                field("Commitment Date"; Rec."Commitment Date")
                {
                    ApplicationArea = All;
                }
                field("Commitment Type"; Rec."Commitment Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Committed Amount"; Rec."Committed Amount")
                {
                    ApplicationArea = All;
                }
                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1"; Rec."Global Dimension 1")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2"; Rec."Global Dimension 2")
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
