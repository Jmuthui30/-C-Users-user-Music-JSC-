page 51640 "Appraisee Question Response"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Appraisal Questions Entries";

    layout
    {
        area(content)
        {
            group("Appraisal Summary")
            {
                Editable = false;

                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Review Start Date"; Rec."Review Start Date")
                {
                    ApplicationArea = All;
                }
                field("Review End Date"; Rec."Review End Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Questions)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                    Editable = false;
                    MultiLine = true;
                }
                field("Question Type"; Rec."Question Type")
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
                field("Manager's Remarks"; Rec."Manager's Remarks")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Manager's Rating"; Rec."Manager's Rating")
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
