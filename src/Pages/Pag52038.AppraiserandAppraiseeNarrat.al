page 52038 "Appraiser and Appraisee Narrat"
{
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    SourceTableView = WHERE("Appraisal Heading Type"=FILTER("Annual Appraisal"|"Mid-year Appraisal"|" "));

    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                ShowCaption = false;

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
    actions
    {
    }
}
