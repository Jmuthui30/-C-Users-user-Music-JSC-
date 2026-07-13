report 50701 "Leave Ledger Entrs"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = leaveL;

    dataset
    {
        dataitem(Employee; Employee)
        {
            // DataItemTableView = sorting("No.") where( = const(''));
            requestfilterfields = "No.";
            column(EmployeeNo; Employee."No.")
            {
            }
            column(EmployeeName; Employee.FullName())
            {
            }
            column(varbalance; VarLeaveBal)
            {
            }
            column(leaveEntitlement; LeaveEntitlement)
            {
            }
            column(leaveBalance; LeaveBalance)
            {
            }
            column(leaveApplied; Abs(LeaveApplied))
            {
            }
            trigger OnAfterGetRecord()
            begin
                VarLeaveBal := 0;
                LeaveEntitlement := 0;
                LeaveBalance := 0;
                LeaveApplied := 0;
                VarLeaveLedgerEntries.Reset();
                VarLeaveLedgerEntries.SetRange("Staff No.", Employee."No.");
                varLeaveLedgerEntries.SetRange("Leave Period Code", '2025/2026');
                varLeaveLedgerEntries.SetRange(closed, true);


                if VarLeaveLedgerEntries.Findset() then begin
                    repeat
                        if VarLeaveLedgerEntries."Leave Entry Type" = VarLeaveLedgerEntries."Leave Entry Type"::Positive then begin
                            LeaveEntitlement := LeaveEntitlement + VarLeaveLedgerEntries."No. of days";
                        end;
                        if VarLeaveLedgerEntries."Leave Entry Type" = VarLeaveLedgerEntries."Leave Entry Type"::Negative then begin
                            LeaveApplied := LeaveApplied + VarLeaveLedgerEntries."No. of days";
                        end;
                    until VarLeaveLedgerEntries.Next() = 0;
                end;
                leaveBalance := leaveEntitlement + LeaveApplied;
                // varLeaveLedgerEntries.VarCarryForward := 0;
                VarLeaveLedgerEntries.Reset();
                VarLeaveLedgerEntries.SetRange("Staff No.", Employee."No.");
                varLeaveLedgerEntries.SetRange("Leave Period Code", '2026/2027');
                // varLeaveLedgerEntries.SetRange(varLeaveLedgerEntries."Leave Type", 'ANNUAL LEAVE');
                if VarLeaveLedgerEntries.Findset() then begin
                    repeat
                        if varLeaveLedgerEntries."Leave Type" = 'ANNUAL LEAVE' then
                            if leaveBalance > 15 then
                                varleaveLedgerEntries.VarCarryForward := 15
                            else
                                varleaveLedgerEntries.VarCarryForward := leaveEntitlement + LeaveApplied;
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
            LayoutFile = './Reports/SSRS/leaveLedgerE.rdlc';
        }
    }

    var
        myInt: Integer;
        VarLeaveBal: decimal;
        VarCarryForward: decimal;
        LeaveEntitlement: decimal;
        LeaveBalance: decimal;
        LeaveApplied: decimal;
        LeaveApproved: decimal;
        VarLeaveLedgerEntries: Record "HR Leave Ledger Entries";
        LeaveLedgerEntries: Record "HR Leave Ledger Entries";
}