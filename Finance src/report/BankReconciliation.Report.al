report 51044 "Bank Reconciliation"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/BankReconciliation.rdlc';
    ApplicationArea = Basic, Suite;
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Bank Reconciliation Report';

    dataset
    {
        dataitem("Bank Account Statement"; "Bank Account Statement")
        {
            column(BankAccountNo; "Bank Account Statement"."Bank Account No.")
            {
            }
            column(BankName; BankName)
            {
            }
            column(StatementNo; "Bank Account Statement"."Statement No.")
            {
            }
            column(StatementEndingBalance; "Bank Account Statement"."Statement Ending Balance")
            {
            }
            column(StatementDate; "Bank Account Statement"."Statement Date")
            {
            }
            column(BalanceLastStatement; "Bank Account Statement"."Balance Last Statement")
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
            dataitem("Bank Account Statement Line"; "Bank Account Statement Line")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No."),
                "Statement No." = FIELD("Statement No.");
                DataItemTableView = WHERE("Statement Amount" = FILTER(<> 0));
                column(DocumentNo_BankAccountStatementLine; "Bank Account Statement Line"."Document No.")
                {
                }
                column(TransactionDate_BankAccountStatementLine; "Bank Account Statement Line"."Transaction Date")
                {
                }
                column(Description_BankAccountStatementLine; "Bank Account Statement Line".Description)
                {
                }
                column(StatementAmount_BankAccountStatementLine; "Bank Account Statement Line"."Statement Amount")
                {
                }
                column(Difference_BankAccountStatementLine; "Bank Account Statement Line".Difference)
                {
                }
                column(AppliedAmount_BankAccountStatementLine; "Bank Account Statement Line"."Applied Amount")
                {
                }
                column(Type_BankAccountStatementLine; "Bank Account Statement Line".Type)
                {
                }
                column(AppliedEntries_BankAccountStatementLine; "Bank Account Statement Line"."Applied Entries")
                {
                }
                column(ValueDate_BankAccountStatementLine; "Bank Account Statement Line"."Value Date")
                {
                }
                column(CheckNo_BankAccountStatementLine; "Bank Account Statement Line"."Check No.")
                {
                }
            }
            dataitem("Bank Account Ledger Entry"; "Bank Account Ledger Entry")
            {
                DataItemLink = "Bank Account No." = FIELD("Bank Account No.");
                DataItemTableView = WHERE("Statement Status" = CONST(Open), Reversed = filter(false));
                // Reversed=CONST(No), Entry No.=FILTER(<>12774));
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
                IF Bank.GET("Bank Account Statement"."Bank Account No.") THEN BEGIN
                    BankName := Bank.Name;
                    StatementEndDate := "Bank Account Statement"."Statement Date";
                    Bank.SETRANGE("Date Filter", 0D, "Bank Account Statement"."Statement Date");
                    Bank.CALCFIELDS("Net Change");
                    CashbookBalance := Bank."Net Change";
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
        CompInfo: Record "Company Information";

        BankName: Text;
        StatementEndDate: Date;
     
        CashbookBalance: Decimal;
        ApprovalEntries: Record "Approval Entry";
        FirstApprover: Code[50];
        FirstApproverDate: DateTime;
        i: Integer;
        SecondApprover: Code[50];
        SecondApproverDate: DateTime;
        ThirdApprover: Code[50];
        ThirdApproverDate: DateTime;
        FourthApprover: Code[50];
        FourthApproverDate: DateTime;
        UserSetup: Record "User Setup";
        UserRecApp1: Record "User Setup";
        UserRecApp2: Record "User Setup";
        UserRecApp3: Record "User Setup";
        UserRecApp4: Record "User Setup";
}

