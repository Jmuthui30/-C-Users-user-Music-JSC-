page 51517 "Bal Score Preview Periods"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bal Score Preview Periods";
    Caption = 'Appraisal Review Periods';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Preview Period Type"; Rec."Preview Period Type")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Review Sequence"; Rec."Review Sequence")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the order of the review period. Periods after the final review period are ignored.';
                }
                field("Quarter No."; Rec."Quarter No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the review number represented by this period. It is copied from the review sequence.';
                }
                field("Final Review Period"; Rec."Final Review Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this is the final review period. Only one review period can be final.';
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the suggested or manually entered start date of this review period.';
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the suggested or manually entered end date of this review period.';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the manually entered due date for completing this review period.';
                }
                field(Closed; Rec.Closed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether this quarterly review period is closed.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Initialize Quarterly Periods")
            {
                ApplicationArea = All;
                Caption = 'Initialize Quarterly Periods';
                Image = CreateLinesFromJob;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Creates or completes Q1 to Q4 appraisal review periods with the correct sequence and legacy period type values.';

                trigger OnAction()
                begin
                    BalScoreCardMgt.EnsureQuarterlyPreviewPeriods();
                    CurrPage.Update(false);
                end;
            }
            action("Suggest Dates")
            {
                ApplicationArea = All;
                Caption = 'Suggest Dates';
                Image = Suggest;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Suggests start and end dates from the active appraisal period. Due dates are not changed.';

                trigger OnAction()
                begin
                    BalScoreCardMgt.SuggestReviewPeriodDatesFromActivePlan();
                    CurrPage.Update(false);
                end;
            }
        }
    }

    var
        BalScoreCardMgt: Codeunit "Bal Score Card Mngt.";
}
