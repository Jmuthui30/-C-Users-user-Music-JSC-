page 52191 "Budget User Roles"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Budget Users";
    Caption = 'User Budget Roles';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(UserName; Rec.UserName)
                {
                    ApplicationArea = All;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
            }
            part(Control; "User Budget Roles")
            {
                SubPageLink = "User ID"=field(UserName);
                ApplicationArea = All;
            }
        }
    }
}
