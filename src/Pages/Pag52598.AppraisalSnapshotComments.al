page 52598 "Appraisal Snapshot Comments"
{
    ApplicationArea = All;
    Caption = 'Appraisal Snapshot Comments';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Appraisal Snapshot Comment";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Section; Rec.Section)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appraisal comment section.';
                }
                field("Appraisee / Section Comment"; Rec."Appraisee / Section Comment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the captured section comment.';
                }
                field("Appraiser Comment"; Rec."Appraiser Comment")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the captured appraiser comment.';
                }
                field("Developmental Action"; Rec."Developmental Action")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the captured developmental action.';
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
