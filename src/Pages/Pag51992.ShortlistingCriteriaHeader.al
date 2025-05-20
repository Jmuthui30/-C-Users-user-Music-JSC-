page 51992 "Shortlisting Criteria Header"
{
    DeleteAllowed = false;
    Caption = 'Recruitment Criteria';
    InsertAllowed = true;
    ModifyAllowed = true;
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE("Interview Conducted" = CONST(false), Approved = CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                    // Editable = true;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Positions; Rec.Positions)
                {
                    ApplicationArea = All;
                }
            }
            field(Control2; '')
            {
                ApplicationArea = All;
                CaptionClass = Text19055415;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(KPA; "Shortlisting Criteria")
            {
                ApplicationArea = All;
                SubPageLink = "Vacancy No." = FIELD("No."), "Job ID" = FIELD("Job ID");
            }
        }
    }
    actions
    {
    }
    var
        Text19055415: Label 'Shortlisting Criteria';
}
