page 52033 "Appraisal Category"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Appraisal Category";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Appraissal Category"; Rec."Appraissal Category")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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
