page 51638 "Appraisal Card - Closed"
{
    // version THL- HRM 1.0
    Caption = 'Closed Appraisal Form';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Performance Appraisal";
    SourceTableView = WHERE(Closed=CONST(true), Archived=CONST(false));

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
            action("View Responses")
            {
                ApplicationArea = All;
                Image = Suggest;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Confirm(Text000, false) = true then PerformanceMgt.ReviewAppraiseeResponses(Rec)
                    else
                        Message(Text001);
                end;
            }
            action("Appraisal Form")
            {
                ApplicationArea = All;
                Image = "Report";
                Promoted = true;
                PromotedIsBig = true;
                PromotedOnly = true;

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
            action("Section A: Quantitative Deliverables")
            {
                ApplicationArea = All;
                Caption = 'Section A: Quantitative Deliverables';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Quanitative Deliverables Respo";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section B: Qualitative Deliverables")
            {
                ApplicationArea = All;
                Caption = 'Section B: Qualitative Deliverables';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Qualitative Deliverables Other";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section C: Adherence to Company Culture")
            {
                ApplicationArea = All;
                Caption = 'Section C: Adherence to Company Culture';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Section C Responses";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section D: Personal development (E-Learning)")
            {
                ApplicationArea = All;
                Caption = 'Section D: Personal development (E-Learning)';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Section D Responses";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action("Section E: Other Essential Information")
            {
                ApplicationArea = All;
                Caption = 'Section E: Other Essential Information';
                Image = "1099Form";
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Page "Section E Responses";
                RunPageLink = "Employee No"=FIELD("Employee No"), "Review Start Date"=FIELD("Review Start Date"), "Review End Date"=FIELD("Review End Date");
                RunPageOnRec = true;
            }
            action(Archive)
            {
                ApplicationArea = All;
                Image = Archive;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    PerformanceMgt.ArchiveAppraisalForm(Rec);
                end;
            }
        }
    }
    var PerformanceMgt: Codeunit "Performance Management";
    Text000: Label 'You are about to view responses to the appraisal questions. Kindly note that you cannot abort this process once you start. Do you wish to continue?';
    Text001: Label 'Aborted Successfully';
    Appraisal: Record "Appraisal Questions Entries";
}
