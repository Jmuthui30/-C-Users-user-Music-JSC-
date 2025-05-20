page 51928 "SS Admins Card"
{
    DataCaptionExpression = Rec."User ID";
    DelayedInsert = true;
    PageType = Card;
    SourceTable = Admins;
    SourceTableView = WHERE("Shortcut Dimension 1 Code"=FILTER('ELD'|'WTD'|'DD'|'WSD'));

    layout
    {
        area(content)
        {
            group(General)
            {
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    DrillDown = false;
                    Editable = false;
                    ToolTip = 'Specifies the user ID of a user who is using Database Server Authentication to log on to Business Central.';

                    trigger OnAssistEdit()
                    var
                        UserPersonalization: Record "User Personalization";
                        UserMgt: Codeunit "User Management";
                        SID: Guid;
                        UserID: Code[50];
                    begin
                    /*
                        UserMgt.LookupUser(UserID,SID);
                        
                        IF (SID <> "User SID") AND NOT ISNULLGUID(SID) THEN BEGIN
                          IF Admins.GET(SID) THEN BEGIN
                            Admins.CALCFIELDS("User ID");
                            ERROR(Text000,TABLECAPTION,Admins."User ID");
                          END;
                        
                          VALIDATE("User SID",SID);
                          CALCFIELDS("User ID");
                        
                          CurrPage.UPDATE;
                        END;
                        */
                    end;
                }
                field("Full Name"; Rec."Full Name")
                {
                    ApplicationArea = All;
                    Editable = false;
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
        Rec.SetRange(Rec."User ID", UserId);
    end;
    var Text000: Label '%1 %2 already exists.', Comment = 'User Personalization User1 already exists.';
    Admins: Record Admins;
}
