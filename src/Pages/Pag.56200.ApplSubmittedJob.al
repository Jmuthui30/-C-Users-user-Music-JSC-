page 56200 "Applicant Submitted Job"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    editable = false;
    SourceTable = "Applicant Submitted Job";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job code"; "Job code")
                {
                    ApplicationArea = All;
                }
                field("Job Title"; "Job Title")
                {
                    ApplicationArea = All;
                }
                field("Applicant Name"; "Applicant Name")
                {
                    ApplicationArea = All;
                }
                field(IDNO; IDNO)
                {
                    ApplicationArea = All;
                }
                // field()
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(update)

            {
                Promoted = true;
                Image = View;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = report "update Job Appl.";
                RunPageMode = View;
                Caption = 'UpDate Job Submitted.';

            }
        }
    }
}