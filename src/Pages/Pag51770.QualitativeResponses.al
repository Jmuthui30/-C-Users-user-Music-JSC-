page 51770 "Qualitative Responses"
{
    // version THL- HRM 1.0
    PageType = ListPart;
    SourceTable = "Appraisal Qualitative Details";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Focus Area"; Rec."Focus Area")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Deliverable; Rec.Deliverable)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Maximum Score"; Rec."Maximum Score")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Score/Rating"; Rec."Score/Rating")
                {
                    ApplicationArea = All;
                }
                field("Reviewer's Comments"; Rec."Reviewer's Comments")
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
