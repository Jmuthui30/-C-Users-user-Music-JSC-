page 51767 "SS Quantitative Response"
{
    // version THL- HRM 1.0
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Appraisal Details Quantitative";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Deliverable; Rec.Deliverable)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Marks Base"; Rec."Marks Base")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Score (Appraisee)"; Rec."Score (Appraisee)")
                {
                    ApplicationArea = All;
                }
                field("Score (Reviewer)"; Rec."Score (Reviewer)")
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
