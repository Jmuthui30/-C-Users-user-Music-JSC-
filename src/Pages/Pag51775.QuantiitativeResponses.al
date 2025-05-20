page 51775 "Quantiitative Responses"
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
                field(Score; Rec.Score)
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
