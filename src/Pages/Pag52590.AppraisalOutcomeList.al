page 52590 "Appraisal Outcome List"
{
    ApplicationArea = All;
    Caption = 'Appraisal Outcomes';
    CardPageId = "Appraisal Outcome Card";
    PageType = List;
    SourceTable = "Appraisal Outcome";
    UsageCategory = Lists;

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
                field("Appraisal No."; Rec."Appraisal No.")
                {
                    ApplicationArea = All;
                }
                field("Outcome Type"; Rec."Outcome Type")
                {
                    ApplicationArea = All;
                }
                field("Employee No."; Rec."Employee No.")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Appraisal Period"; Rec."Appraisal Period")
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
            }
        }
    }
}
