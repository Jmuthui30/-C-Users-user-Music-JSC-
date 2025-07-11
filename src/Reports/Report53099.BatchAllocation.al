report 53099 "Batch Allocation"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Batch_Allocation;

    dataset
    {
        dataitem("Leave Adjustment Header"; "Leave Adjustment Header")
        {
            column(Leave_Adjustments_No_; "Leave Adjustments No.")
            {

            }
            trigger OnAfterGetRecord()
            begin
            end;
        }
    }

    requestpage
    {
        AboutTitle = 'Teaching tip title';
        AboutText = 'Teaching tip content';
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                    field(LeavePeriod; LeavePeriod)
                    {
                        ApplicationArea = All;
                        Caption = 'Leave Period';
                        TableRelation = "Leave Period" where(closed = const(false));
                    }
                    field(LeaveType; LeaveType)
                    {
                        TableRelation = "Leave Type".Code;
                        Caption = 'Leave Type';

                    }
                    field(TransactionType; TransactionType)
                    {
                        Caption = 'Transaction Type';

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(LayoutName)
                {

                }
            }
        }
    }

    rendering
    {
        layout(Batch_Allocation)
        {
            Type = RDLC;
            LayoutFile = './Reports/SSRS/BATCHALLOCATION.RDLC';
        }
    }

    var
        myInt: Integer;
        TransactionType: Enum "Leave Transaction Type";
        LeaveType: Code[100];
        LeavePeriod: Code[100];
}