page 51641 "Sub Question Responses"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Appraisal SubQuestions Entries";

    layout
    {
        area(content)
        {
            group(Questions)
            {
                Editable = false;

                field("Main Question No."; Rec."Main Question No.")
                {
                    ApplicationArea = All;
                }
                field("Sub-Question No."; Rec."Sub-Question No.")
                {
                    ApplicationArea = All;
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Question Type"; Rec."Question Type")
                {
                    ApplicationArea = All;
                }
                field("Sub-Question Instructions"; Rec."Sub-Question Instructions")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Responses)
            {
                field(Response; Rec.Response)
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Further Response"; Rec."Further Response")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("My Rating"; Rec."My Rating")
                {
                    ApplicationArea = All;
                    Caption = 'Appraisee''s Self Rating';
                    Editable = false;
                }
                field("Manager's Rating"; Rec."Manager's Rating")
                {
                    ApplicationArea = All;
                }
                field("Manager's Remarks"; Rec."Manager's Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
            }
        }
    }
    actions
    {
    }
}
