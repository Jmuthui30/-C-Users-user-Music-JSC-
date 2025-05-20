page 51927 "SS Admins List"
{
    //ApplicationArea = Basic,Suite;
    CardPageID = "SS Admins Card";
    Editable = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Admins;
    SourceTableView = WHERE("Shortcut Dimension 1 Code"=FILTER('ELD'|'WTD'|'DD'|'WSD'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                    DrillDown = false;

                    trigger OnAssistEdit()
                    var
                        UserPersonalization: Record "User Personalization";
                        UserMgt: Codeunit "User Management";
                        SID: Guid;
                        UserID: Code[50];
                    begin
                    end;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control8; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Control9; MyNotes)
            {
                ApplicationArea = All;
            }
            systempart(Control10; Links)
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
        Rec.SetRange("User ID", UserId);
    end;
    var ConfPersMgt: Codeunit "Conf./Personalization Mgt.";
    ProfileID: Code[30];
    Text000: Label '%1 %2 already exists.', Comment = 'User Personalization User1 already exists.';
}
