report 53052 "close Portal Jobs"
{
    //Caption = 'ReportName';
    UsageCategory = Administration;
    ApplicationArea = All;
    Caption = 'Close Portal Jobs';
    RDLCLayout = './Reports/SSRS/job closed.rdl';

    dataset
    {
        dataitem("Recruitment Needs"; "Recruitment Needs")
        {


            trigger OnAfterGetRecord()
            begin
                repeat
                    if "End Date" = WorkDate() then begin
                        "Submitted To Portal" := false;
                        "Advertisement Close Date" := Today;
                        "Advertisment Status" := "Advertisment Status"::Closed;
                        "Advertisement Status" := "Advertisement Status"::Closed;
                        Status := Status::Archived;
                        Modify();
                    end;
                until "Recruitment Needs".Next = 0;
            end;
            //RecruitmentNeeds.Status::Closed
            //RecruitmentNeeds."Advertisement Status"::Closed
            // RecruitmentNeeds."Advertisment Status"::Closed
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }
    }
}