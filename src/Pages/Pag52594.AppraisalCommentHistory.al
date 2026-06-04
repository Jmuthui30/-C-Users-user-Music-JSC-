page 52594 "Appraisal Comment History"
{
    ApplicationArea = All;
    Caption = 'Appraisal Comment History';
    Editable = false;
    PageType = List;
    SourceTable = "Appraisal Comments";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Review Period Code"; Rec."Review Period Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quarterly review period for this comment.';
                }
                field(Person; Rec.Person)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal section for this comment.';
                }
                field("Comments on Performance"; Rec."Comments on Performance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the comment text.';
                }
                field("Comments On Supervisor"; Rec."Comments On Supervisor")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supervisor-related comment text.';
                }
                field("Developmental Action"; Rec."Developmental Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the developmental action linked to this comment.';
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the comment date.';
                }
            }
        }
    }
}
