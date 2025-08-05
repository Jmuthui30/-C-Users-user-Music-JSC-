report 50040 "Archived Recruitment Request"
{
    ApplicationArea = All;
    Caption = 'Archived Recruitment Requests';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/ArchivedRecRequests.rdl';
    dataset
    {
        dataitem(RecruitmentNeeds; "Recruitment Needs")
        {
            DataItemTableView = where (Status = filter(Archived|Closed));
            column(Description; Description)
            {

            }
            column(Positions; Positions)
            {

            }
            column(Submitted_jobs_Count; "Submitted jobs Count")
            {

            }
            column(Start_Date; "Start Date")
            {

            }
            column(End_Date; "End Date")
            {

            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
}
