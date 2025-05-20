page 52028 "Grade Matrix"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Appraisal Grades";
    SourceTableView = SORTING(Points)ORDER(Descending);

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Grade; Rec.Grade)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Points; Rec.Points)
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
