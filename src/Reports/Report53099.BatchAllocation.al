report 53099 "Batch Allocation"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = Batch_Allocation;

    dataset
    {
        dataitem("Leave Bal Adjustment Header"; "Leave Bal Adjustment Header")
        {
            column(Code; Code)
            {

            }

            trigger OnAfterGetRecord()
            begin

                Init();
                leaveAdjustmentLine."Header No." := Code;

                leaveAdjustmentLine."Staff No." := Employee."No.";
                leaveAdjustmentLine."Employee Name" := Employee.Name;
                leaveAdjustmentLine."Leave Period" := LeavePeriod;
                leaveAdjustmentLine."Leave Code" := LeaveType;
                leaveAdjustmentLine."Transaction Type" := TransactionType;
                leaveAdjustmentLine."Leave Adj Entry Type" := leaveAdjustmentLine."Leave Adj Entry Type"::Positive;
                leaveAdjustmentLine.Validate("Staff No.");
                LeaveLedger.Reset();
                LeaveLedger.SetRange(LeaveLedger."Staff No.", leaveAdjustmentLine."Staff No.");
                LeaveLedger.SetRange(LeaveLedger."Leave Type", leaveAdjustmentLine."Leave Code");
                LeaveLedger.SetRange(LeaveLedger."Leave Period Code", leaveAdjustmentLine."Leave Period");
                if LeaveLedger.Find('-') then begin
                    LeaveLedger.CalcSums("No. of days", "Balance Brought Forward");
                    leaveAdjustmentLine.CurrentEntitlement := LeaveLedger."No. of days";
                    leaveAdjustmentLine.CurrentBalFoward := LeaveLedger."Balance Brought Forward";
                end;
                AccPeriod.Reset();
                AccPeriod.SetRange(AccPeriod."Starting Date", 0D, Today);
                AccPeriod.SetRange(AccPeriod."New Fiscal Year", true);
                if AccPeriod.Find('+') then
                    MaturityDate := CalcDate('1Y', AccPeriod."Starting Date") - 1;
                leaveAdjustmentLine."Maturity Date" := MaturityDate;
                leaveAdjustmentLine."New Entitlement" := EntitlementAdjustment;
                leaveAdjustmentLine.Insert();

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
                        ApplicationArea = All;
                    }
                    field(TransactionType; TransactionType)
                    {
                        Caption = 'Transaction Type';
                        ApplicationArea = All;

                    }
                    field(EntitlementAdjustment; EntitlementAdjustment)
                    {
                        Caption = 'Entitlement Adjustment';
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Entitlement Adjustment field';
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
                    ApplicationArea = All;
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
        LeaveAdjustmentsNo: Code[20];
        leaveAdjustmentLine: Record "Leave Bal Adjustment Lines";
        Employee: Record Employee;
        HRMgnt: Codeunit "HR Management";
        LeaveLedger: Record "HR Leave Ledger Entries";
        AccPeriod: Record "Accounting Period";
        MaturityDate: Date;
        EntitlementAdjustment: Decimal;
}