page 52011 "Commitment Register"
{
    Editable = false;
    PageType = List;
    SourceTable = "Commitment Register";

    layout
    {
        area(content)
        {
            repeater(Control11)
            {
                ShowCaption = false;

                field("Entry No"; Rec."Entry No")
                {
                    ApplicationArea = All;
                }
                field("Commitment Date"; Rec."Commitment Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Budget Line"; Rec."Budget Line")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Commitment Type"; Rec."Commitment Type")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Budget Year"; Rec."Budget Year")
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
