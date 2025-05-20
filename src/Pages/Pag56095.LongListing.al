page 56095 "Long Listing"
{
    SourceTable = "Recruitment Needs";
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;
    DelayedInsert = false;
    SourceTableView = WHERE("Shortlisting Conducted"=const(false), Approved=CONST(true));

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
                field("No. Of Applicants"; Rec."No. Of Applicants")
                {
                    ApplicationArea = All;
                // TableRelation = Applicant."Job ID";
                // LookupPageId = "Applicant List-All";
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
                field(Score; Rec.Score)
                {
                    ApplicationArea = All;
                }
                field("Preferred Gender"; Rec."Preferred Gender")
                {
                    ApplicationArea = All;
                }
                field("Min. Years of Experience"; Rec."Min. Years of Experience")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Age Limit"; Rec."Age Limit")
                {
                    ApplicationArea = All;
                }
            }
            group("Shortlisting")
            {
                part(shortlist; "Shortlisting Criteria")
                {
                    Editable = Rec.Status = Rec.Status::Open;
                    ApplicationArea = All;
                    SubPageLink = "Vacancy No."=FIELD("No.");
                }
                part(LonglistedApplicants; "Applicants")
                {
                    ApplicationArea = All;
                    Caption = 'Longlisted Candidates';
                    SubPageLink = "Vacancy No."=FIELD("No."); //, //Status = const("Long Listed");
                //Visible = Rec.Type = Rec.Type::"Long List";
                }
            }
            group(Track)
            {
                field("Created By"; UserId)
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
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
                        // IF Applicants.GET(CurrPage.LonglistedApplicants.PAGE) THEN
                        PAGE.RunModal(51984, Applicants);
                    end;
                }
            }
        }
        area(processing)
        {
            action("Long list")
            {
                ApplicationArea = All;
                Caption = 'Long list';
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecruitmentMgnt.Shortlisting(Rec);
                end;
            }
            action("Close Longlisting")
            {
                ApplicationArea = All;
                Caption = 'Close Longlisting';
                Image = Close;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    RecruitmentMgnt.Closeshortlisting(Rec);
                end;
            }
            action("Longlist Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Caption = 'Long-List Report';
                Image = Report2;
                RunObject = report 52203;
            }
        }
    }
    var RecruitmentMgnt: Codeunit "Recruitment Management";
    Text19078293: Label 'Long Listing';
    Text19057439: Label 'Long Listed Candidates';
    Applicants: Record Applicant;
}
