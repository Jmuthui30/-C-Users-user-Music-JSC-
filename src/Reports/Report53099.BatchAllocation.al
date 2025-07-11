report 53099 "Batch Allocation"
{
    Caption = 'ReportName';
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Leave Adjustment Line"; "Leave Adjustment Line")
        {
            column(No_; "No.")
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
                    // field(Name; SourceExpression)
                    // {
                    //     ApplicationArea = All;

                    // }
                }
            }
        }
    }
}