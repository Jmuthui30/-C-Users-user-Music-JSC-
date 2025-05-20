page 52036 "Appraiser and Appraisee Comm"
{
    PageType = ListPart;
    SourceTable = "Appraisal Lines";
    SourceTableView = WHERE("Appraisal Heading Type"=FILTER("Core Values"|"Core Competencies"|"Managerial and Supervisory"));

    layout
    {
        area(content)
        {
            repeater(Control3)
            {
                ShowCaption = false;

                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Appraiser's Comments"; Rec."Appraiser's Comments")
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
