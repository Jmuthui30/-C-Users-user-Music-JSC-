page 51632 "SS Appraisal Card - Closed"
{
    // version THL- HRM 1.0
    Caption = 'Closed Appraisal Form';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Performance Appraisal";
    SourceTableView = WHERE(Closed=CONST(true));

    layout
    {
        area(content)
        {
            group("Appraisee Details")
            {
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ApplicationArea = All;
                }
                field("Mobile No"; Rec."Mobile No")
                {
                    ApplicationArea = All;
                }
                field("Employment Date"; Rec."Employment Date")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 3 Code"; Rec."Global Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field(Manager; Rec.Manager)
                {
                    ApplicationArea = All;
                }
                field("Manager's Name"; Rec."Manager's Name")
                {
                    ApplicationArea = All;
                }
            }
            group("Appraisal Details")
            {
                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control18; Notes)
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Give Responses")
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Text000, false) = true then PerformanceMgt.RespondToQuestions(Rec)
                    else
                        Message(Text001);
                end;
            }
            action("Review Your Responses")
            {
                ApplicationArea = All;
                Image = TaskList;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Text000, false) = true then PerformanceMgt.RespondToQuestions(Rec)
                    else
                        Message(Text001);
                end;
            }
            action("Appraisal Form")
            {
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Commit;
                    Appraisal.Reset;
                    Appraisal.SetRange(Appraisal."Employee No", Rec."Employee No");
                    Appraisal.SetRange(Appraisal."Review Start Date", Rec."Review Start Date");
                    Appraisal.SetRange(Appraisal."Review End Date", Rec."Review End Date");
                    REPORT.Run(51616, true, false, Appraisal);
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.SetRange("Created By", UserId);
    end;
    var PerformanceMgt: Codeunit "Performance Management";
    Text000: Label 'You are about to give your responses to the appraisal questions. Kindly note that you cannot abort this process once you start. Do you wish to continue?';
    Text001: Label 'Aborted Successfully';
    Appraisal: Record "Appraisal Questions Entries";
}
