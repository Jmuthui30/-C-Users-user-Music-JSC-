page 52074 "Interview Criteria Header"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE("Interview Conducted"=CONST(false), "Shortlisting Conducted"=const(true), Approved=CONST(true));

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
                }
                field(Positions; Rec.Positions)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Interview Committee"; Rec."Interview Committee")
                {
                    ApplicationArea = All;
                }
                field("Interview Commitee Name"; Rec."Interview Commitee Name")
                {
                    ApplicationArea = All;
                }
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
            }
            field(Control2;'')
            {
                ApplicationArea = All;
                CaptionClass = Text19055415;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(Control15; "Interview Stage")
            {
                ApplicationArea = All;
                SubPageLink = "Vacancy No."=FIELD("No."), "Stage Code"=FIELD(Stage);
            }
            field(Control16;'')
            {
                ApplicationArea = All;
                CaptionClass = Text19055416;
                ShowCaption = false;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(Applicants; "Applicants to Interview")
            {
                ApplicationArea = All;
                SubPageLink = "Vacancy No."=FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(AssignInterviewers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Assign Interviewers';
                Image = CreateRating;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RecruitmentMgnt.AssignInterviewers(Rec);
                end;
            }
            separator(Separator13)
            {
            }
            action(GetQualified)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Get Qualified';
                Image = EmployeeAgreement;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RecruitmentMgnt.GetQualifiedInterviewees(Rec);
                end;
            }
            action(Re_Shortlist)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Re-Shortlist';
                Image = Replan;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(StrSubstNo(Text000, Rec."No."), false) = true then RecruitmentMgnt.Re_Shortlist(Rec)
                    else
                    begin
                        exit;
                    end;
                end;
            }
            action(Close_Interview)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Interviews';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RecruitmentMgnt.CloseInterview(Rec);
                end;
            }
            separator(Separator11)
            {
            }
        }
    }
    var Text000: Label 'You are about to re-shortlist for %1, Are you sure you wish to continue?';
    Text19055415: Label 'Qualified Applicants';
    Text19055416: Label 'All Interviewees';
    RecruitmentMgnt: Codeunit "Recruitment Management";
}
