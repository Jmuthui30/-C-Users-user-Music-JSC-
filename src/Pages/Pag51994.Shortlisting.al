page 51994 "Shortlisting"
{
    SourceTable = "Recruitment Needs";
    PageType = Card;
    InsertAllowed = false;
    DelayedInsert = false;
    SourceTableView = WHERE("Shortlisting Conducted"=const(true), Approved=CONST(true));

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Job ID"; Rec."Job ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Positions; Rec.Positions)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Qualified; Rec.Qualified)
                {
                    ApplicationArea = All;
                }
                field("No Filter"; Rec."No Filter")
                {
                    ApplicationArea = All;
                    Caption = 'Position Filter';
                    Visible = false;
                }
                field(Stage; Rec.Stage)
                {
                    ApplicationArea = All;
                    Caption = 'Stage Filter';
                    Visible = false;
                }
                field(Control4;'')
                {
                    ApplicationArea = All;
                    CaptionClass = Text19078293;
                    ShowCaption = false;
                    Style = Strong;
                    StyleExpr = TRUE;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
            }
            part(Shortlisted; "Stage Shortlist")
            {
                ApplicationArea = All;
                SubPageLink = "Vacancy No."=FIELD("No."), "Stage Code"=FIELD(Stage), Qualified=FIELD(Qualified), Position=FIELD("No Filter");
            }
            field(Control1;'')
            {
                ApplicationArea = All;
                CaptionClass = Text19057439;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Applicant)
            {
                Caption = 'Applicant';

                action("Applicants Card")
                {
                    ApplicationArea = All;
                    Caption = 'Applicants Card';
                    Image = PersonInCharge;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        //IF Applicants.GET(CurrPage.Shortlisted.PAGE.) THEN
                        PAGE.RunModal(51984, Applicants);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Short list")
            {
                ApplicationArea = All;
                Caption = 'Short list';
                Image = Approve;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecruitmentMgnt.Shortlisting(Rec);
                end;
            }
            action("Close Shortlisting")
            {
                ApplicationArea = All;
                Caption = 'Close Shortlisting';
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecruitmentMgnt.CloseShortlisting(Rec);
                end;
            }
        }
    }
    var RecruitmentMgnt: Codeunit "Recruitment Management";
    Text19078293: Label 'Short Listing';
    Text19057439: Label 'Short Listed Candidates';
    Applicants: Record Applicant;
}
