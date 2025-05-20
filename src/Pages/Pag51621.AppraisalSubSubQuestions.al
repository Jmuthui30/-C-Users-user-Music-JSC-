page 51621 "Appraisal Sub-Sub Questions"
{
    // version THL- HRM 1.0
    CardPageID = "Appraisal Sub Question Card";
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Appraisal Sub-Sub-Questions";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub-Sub Question No."; Rec."Sub-Sub Question No.")
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
            }
        }
    }
    actions
    {
    }
}
