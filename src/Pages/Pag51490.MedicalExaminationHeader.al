page 51490 "Medical Examination Header"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = WHERE("Medical Examonation Conducted"=CONST(false), "Interview Conducted"=const(true), Approved=CONST(true));

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
                field("Stage Code"; Rec."Stage Code")
                {
                    ApplicationArea = All;
                }
            }
            part(Applicants; "Applicants to Examine")
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
            action("Notify Candidates")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Notify Candidates';
                Image = SendAsPDF;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                end;
            }
            action(Close_Medication_Examination)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Close Medication Examination';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    RecruitmentMgnt.CloseMediacalExamination(Rec);
                end;
            }
        }
    }
    var RecruitmentMgnt: Codeunit "Recruitment Management";
}
