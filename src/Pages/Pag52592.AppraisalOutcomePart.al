page 52592 "Appraisal Outcome Part"
{
    ApplicationArea = All;
    Caption = 'Appraisal Outcomes';
    CardPageId = "Appraisal Outcome Card";
    PageType = ListPart;
    SourceTable = "Appraisal Outcome";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Outcome No."; Rec."Outcome No.")
                {
                    ApplicationArea = All;
                }
                field("Outcome Type"; Rec."Outcome Type")
                {
                    ApplicationArea = All;
                }
                field(Subject; Rec.Subject)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Issue Date"; Rec."Issue Date")
                {
                    ApplicationArea = All;
                }
                field("Issued By"; Rec."Issued By")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
