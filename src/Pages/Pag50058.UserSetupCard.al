page 50058 "User Setup Card"
{
    ApplicationArea = All;
    Caption = 'User Setup Card';
    PageType = Card;
    SourceTable = "User Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("User ID"; Rec."User ID")
                {
                }
                field("Allow Posting From"; Rec."Allow Posting From")
                {
                }
                field("Allow Posting To"; Rec."Allow Posting To")
                {
                }
                field("Register Time"; Rec."Register Time")
                {
                }
                field("Salespers./Purch. Code"; Rec."Salespers./Purch. Code")
                {
                }
                field("Approver ID"; Rec."Approver ID")
                {
                }
                field(Substitute; Rec.Substitute)
                {
                }
                field("E-Mail"; Rec."E-Mail")
                {
                }
                field("Phone No."; Rec."Phone No.")
                {
                }
                field("Approval Administrator"; Rec."Approval Administrator")
                {
                }
                field("Employee No."; Rec."Employee No.")
                {
                }
                field(HOD; Rec.HOD)
                {
                }
                field("Immediate Supervisor"; Rec."Immediate Supervisor")
                {
                }
                field("Not Available"; Rec."Not Available")
                {
                }
                field("Full Name"; Rec."Full Name")
                {
                }
                field(Signature; Rec.Signature)
                {
                }
            }
        }
    }
}
