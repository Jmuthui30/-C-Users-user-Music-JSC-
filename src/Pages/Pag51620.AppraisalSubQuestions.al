page 51620 "Appraisal Sub-Questions"
{
    // version THL- HRM 1.0
    Caption = 'Appraisal Questions';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Appraisal Sub-Questions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub-Question No."; Rec."Sub-Question No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                }
                field("Question Type"; Rec."Question Type")
                {
                    ApplicationArea = All;
                }
                field("Sub-Question Instructions"; Rec."Sub-Question Instructions")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
    }
}
