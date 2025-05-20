pageextension 50002 "ExtUser Setup" extends "User Setup"
{
    layout
    {
        addafter("User ID")
        {
            field("Employee No."; Rec."Employee No.")
            {
                ApplicationArea = All;
            }
        }
        addafter("Register Time")
        {
            field(Payroll; Rec.Payroll)
            {
                Caption = 'Payroll Manager?';
                ApplicationArea = All;
            }
            field("HR Admin"; Rec."HR Admin")
            {
                ApplicationArea = All;
            }
        }
        addafter("User ID")
        {

            field("Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                ApplicationArea = All;

            }
            field("Global Dimension 2 Code"; "Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        addafter(PhoneNo)
        {
            field(Signature; Rec.Signature)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addfirst(Processing)
        {
            action(Card)
            {
                ApplicationArea = All;
                RunObject = page "User Setup Card";
                RunPageLink = "User ID" = field("User ID");
                RunPageMode = Edit;
                Image = Card;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
            }
        }
    }
}
