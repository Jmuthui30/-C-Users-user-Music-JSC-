page 52596 "Appraisal Review Snapshot Card"
{
    ApplicationArea = All;
    Caption = 'Appraisal Review Snapshot Card';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Card;
    SourceTable = "Appraisal Review Snapshot";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Period Under Review';

                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal document for this snapshot.';
                }
                field("Appraisal Period"; Rec."Appraisal Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal period.';
                }
                field("Period Start"; Rec."Period Start")
                {
                    ApplicationArea = All;
                    Caption = 'From';
                    ToolTip = 'Specifies the appraisal period start date.';
                }
                field("Period End"; Rec."Period End")
                {
                    ApplicationArea = All;
                    Caption = 'To';
                    ToolTip = 'Specifies the appraisal period end date.';
                }
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    Caption = 'Review Period';
                    ToolTip = 'Specifies the review period frozen in this snapshot.';
                }
                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                    Caption = 'Review From';
                    ToolTip = 'Specifies the review period start date.';
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                    Caption = 'Review To';
                    ToolTip = 'Specifies the review period end date.';
                }
                field("Snapshot Date-Time"; Rec."Snapshot Date-Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the review period snapshot was created.';
                }
                field("Snapshot By"; Rec."Snapshot By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the user who created the review period snapshot.';
                }
            }
            group("Personal Details")
            {
                Caption = 'Personal Details';

                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee No.';
                    ToolTip = 'Specifies the appraisee number.';
                }
                field("Appraisee Name"; Rec."Appraisee Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee name.';
                }
                field("Appraisee Job Title"; Rec."Appraisee Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisee job title.';
                }
                field("Job Group"; Rec."Job Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the job group.';
                }
                field("Directorate Code"; Rec."Directorate Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the directorate code captured for this review.';
                }
                field("Directorate Name"; Rec."Directorate Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the directorate name captured for this review.';
                }
            }
            group(Appraiser)
            {
                Caption = 'Appraiser';

                field("Appraiser No."; Rec."Appraiser No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser number.';
                }
                field("Appraiser ID"; Rec."Appraiser ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser user ID.';
                }
                field("Appraiser Name"; Rec."Appraiser Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser name.';
                }
                field("Appraiser Job Title"; Rec."Appraiser Job Title")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraiser job title.';
                }
            }
            group("Performance Score")
            {
                Caption = 'Performance Score';

                field("Total Weighting"; Rec."Total Weighting")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the total weighting captured in this snapshot.';
                }
                field("Current Review Score"; Rec."Current Review Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the score captured for this review period.';
                }
                field("Total Review Score"; Rec."Total Review Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the cumulative review score at the time of this snapshot.';
                }
                field("Performance Grade"; Rec."Performance Grade")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the performance grade captured in this snapshot.';
                }
                field("Appraisee Agreed"; Rec."Appraisee Agreed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the appraisee agreed at the time of this snapshot.';
                }
                field("Appraiser Agreed"; Rec."Appraiser Agreed")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether the appraiser agreed at the time of this snapshot.';
                }
            }
            part(Lines; "Appraisal Snapshot Lines")
            {
                ApplicationArea = All;
                Caption = 'Appraisal Goals';
                SubPageLink = "Appraisal No." = field("Appraisal No."),
                              "Review Period Code" = field("Review Period Code");
            }
            part(Comments; "Appraisal Snapshot Comments")
            {
                ApplicationArea = All;
                Caption = 'Review Comments';
                SubPageLink = "Appraisal No." = field("Appraisal No."),
                              "Review Period Code" = field("Review Period Code");
            }
            part(Outcomes; "Appraisal Snapshot Outcomes")
            {
                ApplicationArea = All;
                Caption = 'Appraisal Outcomes';
                SubPageLink = "Appraisal No." = field("Appraisal No."),
                              "Review Period Code" = field("Review Period Code");
            }
        }
    }
}
