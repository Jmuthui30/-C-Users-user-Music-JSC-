page 52609 "Appr. Planning Review Hist."
{
    ApplicationArea = All;
    Caption = 'Appraisal Planning Review History';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Appraisal Planning Review";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Action At"; Rec."Action At")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the action occurred.';
                }
                field(Action; Rec.Action)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the action.';
                }
                field("Action By"; Rec."Action By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who performed the action.';
                }
                field("Status Before"; Rec."Status Before")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status before the action.';
                }
                field("Status After"; Rec."Status After")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status after the action.';
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies action comments.';
                }
            }
        }
    }
}
