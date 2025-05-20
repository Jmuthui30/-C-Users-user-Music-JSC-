page 52072 "Interviewers Marks Allocation"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = Interview;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Interviewer; Rec.Interviewer)
                {
                    ApplicationArea = All;
                }
                field("Interviewer Name"; Rec."Interviewer Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Marks; Rec.Marks)
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
