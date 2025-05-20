pageextension 51434 "ExtBank Account Card" extends "Bank Account Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Posting)
        {
            group(Administration)
            {
                field("Tag Code"; Rec."Tag Code")
                {
                    ApplicationArea = All;
                }
                field("Tag Filter"; Rec."Tag Filter")
                {
                    ApplicationArea = All;
                }
                field("Custodial Payment Account"; Rec."Custodial Payment Account")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Minimum Float"; Rec."Minimum Float")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Petty Cash Holder"; Rec."Petty Cash Holder")
                {
                    ApplicationArea = All;
                }
                field("Account type"; Rec."Account type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
