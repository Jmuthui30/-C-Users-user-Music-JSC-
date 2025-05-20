page 52190 "Budget Users"
{
    PageType = List;
    Caption = 'Users Budget Roles';
    CardPageId = "Budget User Roles";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    ModifyAllowed = false;
    SourceTable = "Budget Users";

    layout
    {
        area(Content)
        {
            repeater(General)
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
        }
    }
}
