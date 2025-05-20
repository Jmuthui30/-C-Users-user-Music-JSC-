page 51642 "Sub-Sub Question Responses"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Sub SubQuestions Entries";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Sub-Sub Question No."; Rec."Sub-Sub Question No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Response; Rec.Response)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Further Response"; Rec."Further Response")
                {
                    ApplicationArea = All;
                    Editable = false;
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
                }
            }
        }
    }
    actions
    {
    }
}
