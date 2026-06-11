page 52599 "Appraisal Snapshot Outcomes"
{
    ApplicationArea = All;
    Caption = 'Appraisal Snapshot Outcomes';
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Appraisal Snapshot Outcome";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Outcome No."; Rec."Outcome No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the outcome number.';
                }
                field("Outcome Type"; Rec."Outcome Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the outcome type.';
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the outcome subject.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the outcome status.';
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the issue date.';
                }
                field("Issued By"; Rec."Issued By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the issuing user.';
                }
                field(Rating; Rec.Rating)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the rating captured on the outcome.';
                }
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the grade captured on the outcome.';
                }
            }
        }
    }
}
