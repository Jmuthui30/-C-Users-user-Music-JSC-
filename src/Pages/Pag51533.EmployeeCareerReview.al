page 51533 "Employee Career Review"
{
    //AutoSplitKey = true;
    Caption = 'Career Plan Reviewers Comments';
    PageType = Card;
    SourceTable = "HR_Employee Career Reviewer";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Eligible for Nomination"; Rec."Eligible for Nomination")
                {
                    ApplicationArea = All;
                }
                field("Nomination for Progression"; Rec."Nomination for Progression")
                {
                    ApplicationArea = All;
                }
                field("Cause for Nomination"; Rec."Cause for Nomination")
                {
                    ApplicationArea = All;
                }
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Reason for Nomination"; Rec."Reason for Nomination")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetRecord()
    begin
    end;
}
