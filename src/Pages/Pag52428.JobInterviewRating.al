page 52428 "Job Interview Rating"
{
    ApplicationArea = All;
    Caption = 'Job Interview Rating';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Job Interview Rating";

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
}
