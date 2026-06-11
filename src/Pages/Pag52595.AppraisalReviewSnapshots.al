page 52595 "Appraisal Review Snapshots"
{
    ApplicationArea = All;
    Caption = 'Appraisal Review Snapshots';
    CardPageId = "Appraisal Review Snapshot Card";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Appraisal Review Snapshot";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal document for this snapshot.';
                }
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the review period frozen in this snapshot.';
                }
                field("Review Period Name"; Rec."Review Period Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the review period name.';
                }
                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the review period start date.';
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the review period end date.';
                }
                field("Current Review Score"; Rec."Current Review Score")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the score captured for this review period.';
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
        }
    }
}
