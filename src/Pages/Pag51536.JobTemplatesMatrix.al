page 51536 "Job Templates Matrix"
{
    PageType = ListPart;
    SourceTable = "Job Templates Matrix";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Job Levels"; Rec."Job Levels")
                {
                    Visible = Rec.Type = Rec.Type::Skills;
                    ApplicationArea = All;
                }
            }
        }
    }
}
