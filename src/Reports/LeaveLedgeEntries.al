report 50700 "Leave Ledger Entries"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = leaveL;

    dataset
    {
        dataitem(leaveLedgerEntries; "HR Leave Ledger Entries")
        {
            DataItemTableView = sorting("Entry No.") where(Closed = const(false));
            RequestFilterFields = "Leave Period", "Staff No.", "Leave Type", "Transaction Type", "Leave Entry Type";

            column(entryNo; "Entry No.")
            {
            }
            column(leavePeriod; "Leave Period")
            {
            }
            column(staffNo; "Staff No.")
            {
            }
            column(staffName; "Staff Name")
            {
            }
            column(leaveDate; "Leave Date")
            {
            }
            column(leaveEntryType; "Leave Entry Type")
            {
            }
            column(leaveApprovalDate; "Leave Approval Date")
            {
            }
            column(documentNo; "Document No.")
            {
            }
            column(noOfDays; "No. of days")
            {
            }
            column(leaveType; "Leave Type")
            {
            }
            column(leaveBalance; Entitlement)
            {
            }
            column(carryForward; "Carry Forward")
            {
            }
            column(varcarryForward; VarCarryForward)
            {
            }
            trigger OnAfterGetRecord()
            begin
                myInt += 1;
                // Entitlement := 0;
                varleaveLedgerEntries.Reset();
                VarLeaveLedgerEntries.SetRange("Staff No.", "Staff No.");
                varLeaveLedgerEntries.SetRange("Leave Period Code", '2026/2027');
                // varLeaveLedgerEntries.SetRange(varLeaveLedgerEntries."Leave Type", 'ANNUAL LEAVE');
                if VarLeaveLedgerEntries.Findset() then begin
                    repeat
                        if varLeaveLedgerEntries."Leave Type" = 'ANNUAL LEAVE' then
                            varLeaveLedgerEntries."No. of days" := varleaveLedgerEntries.Entitlement;
                        varleaveLedgerEntries.Modify();


                    until VarLeaveLedgerEntries.Next() = 0;
                end;

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

            }
        }

        actions
        {

        }
    }

    rendering
    {
        layout(leaveL)
        {
            Type = rdlc;
            LayoutFile = './Reports/SSRS/leaveLedgerEntries.rdlc';
        }
    }

    var
        myInt: Integer;
        VarLeaveBal: decimal;
        VarCarryForward: decimal;
        VarLeaveLedgerEntries: Record "HR Leave Ledger Entries";
}