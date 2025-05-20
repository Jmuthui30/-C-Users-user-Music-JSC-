page 51627 "SS Sub-Sub Question Responses"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
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
                }
                field(Question; Rec.Question)
                {
                    ApplicationArea = All;
                }
                field("Further Explanation"; Rec."Further Explanation")
                {
                    ApplicationArea = All;
                }
                field(Response; Rec.Response)
                {
                    ApplicationArea = All;
                }
                field("Further Response"; Rec."Further Response")
                {
                    ApplicationArea = All;
                }
                field("My Rating"; Rec."My Rating")
                {
                    ApplicationArea = All;
                }
                field("Manager's Rating"; Rec."Manager's Rating")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Manager's Remarks"; Rec."Manager's Remarks")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
}
