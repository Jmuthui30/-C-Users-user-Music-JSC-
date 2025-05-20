page 51768 "Quantitative Response"
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
                    ApplicationArea = All;
                    Editable = false;
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
                    Editable = false;
                }
                field("Score (Reviewer)"; Rec."Score (Reviewer)")
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
