report 51043 "Bank Reconciliation Test Rep"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/BankReconciliationTestRep.rdlc';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Bank Acc. Reconciliation"; "Bank Acc. Reconciliation")
        {
            RequestFilterFields = "Bank Account No.", "Statement No.";
            column(BankAccountNo; "Bank Acc. Reconciliation"."Bank Account No.")
            {
            }
            column(BankName; BankName)
            {
            }
            column(StatementNo; "Bank Acc. Reconciliation"."Statement No.")
            {
            }
            column(StatementEndingBalance; "Bank Acc. Reconciliation"."Statement Ending Balance")
            {
            }
            column(StatementDate; "Bank Acc. Reconciliation"."Statement Date")
            {
            }
            column(BalanceLastStatement; "Bank Acc. Reconciliation"."Balance Last Statement")
            {
            }
            column(CashbookBalance; CashbookBalance)
            {
            }
            column(PeriodEnding; STRSUBSTNO('PERIOD ENDING %1', FORMAT("Statement Date", 0, '<Day,2> <Month Text> <Year4>')))
            {
            }
            column(Comp_Logo; CompInfo.Picture)
            {
            }
            column(CompInfo_Name; CompInfo.Name)
            {
            }
            dataitem("Bank Acc. Reconciliation Line"; "Bank Acc. Reconciliation Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."), "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Statement Amount" = FILTER(<> 0));
                column(DocumentNo_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Transaction Date")
                {
                }
                column(Description_BankAccountStatementLine; "Bank Acc. Reconciliation Line".Description)
                {
                }
                column(StatementAmount_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Statement Amount")
                {
                }
                column(Difference_BankAccountStatementLine; "Bank Acc. Reconciliation Line".Difference)
                {
                }
                column(AppliedAmount_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Applied Amount")
                {
                }
                // column(Type_BankAccountStatementLine;"Bank Acc. Reconciliation Line".Type)
                // {
                // }
                column(AppliedEntries_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Applied Entries")
                {
                }
                column(ValueDate_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Value Date")
                {
                }
                column(CheckNo_BankAccountStatementLine; "Bank Acc. Reconciliation Line"."Check No.")
                {
                }
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = WHERE("Statement Status" = CONST(Open), Reversed = filter(false) /*"Entry No."=FILTER(<>12774)*/);
                column(BankAccountNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Bank Account No.")
                {
                }
                column(PostingDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Posting Date")
                {
                }
                column(DocumentNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Document No.")
                {
                }
                column(Description_BankAccountLedgerEntry; "Bank Account Ledger Entry".Description)
                {
                }
                column(Amount_BankAccountLedgerEntry; "Bank Account Ledger Entry".Amount)
                {
                }
                column(RemainingAmount_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Remaining Amount")
                {
                }
                column(AmountLCY_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Amount (LCY)")
                {
                }
                column(Open_BankAccountLedgerEntry; "Bank Account Ledger Entry".Open)
                {
                }
                column(ClosedbyEntryNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Closed by Entry No.")
                {
                }
                column(ClosedatDate_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Closed at Date")
                {
                }
                column(StatementStatus_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement Status")
                {
                }
                column(StatementNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement No.")
                {
                }
                column(StatementLineNo_BankAccountLedgerEntry; "Bank Account Ledger Entry"."Statement Line No.")
                {
                }

                trigger OnPreDataItem()
                begin
                    "Bank Account Ledger Entry".SETRANGE("Posting Date", 0D, StatementEndDate);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);
                IF Bank.GET("Bank Acc. Reconciliation"."Bank Account No.") THEN BEGIN
                    BankName := Bank.Name;
                    StatementEndDate := "Bank Acc. Reconciliation"."Statement Date";
                    Bank.SETRANGE("Date Filter", 0D, "Bank Acc. Reconciliation"."Statement Date");
                    Bank.CALCFIELDS("Net Change");
                    CashbookBalance := Bank."Net Change";
                    MESSAGE('cb balance is %1', CashbookBalance);
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Bank: Record "Bank Account";
        BankName: Text;
        StatementEndDate: Date;
        StatementNo: Integer;
        BankAccNo: Code[20];
        CashbookBalance: Decimal;
        CompInfo: Record "Company Information";
        StatementCashDifference: Decimal;
}

