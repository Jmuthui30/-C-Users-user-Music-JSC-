page 51957 "Disciplinary Remarks"
{
    PageType = List;
    SourceTable = "Disciplinary Remarks";

    layout
    {
        area(content)
        {
            repeater(Control4)
            {
                ShowCaption = false;

                field(Remark; Rec.Remark)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
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
