report 50013 "Generate OB Journal"
{
    // version THL-Basic Fin 1.0
    // 999999
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Generate OB Journal.rdlc';

    dataset
    {
        dataitem("Opening Balances"; "Opening Balances")
        {
            trigger OnAfterGetRecord()
            begin
                //Post Bank entries
                LineNo:=LineNo + 1000;
                GenJnLine.Init;
                GenJnLine."Journal Template Name":='GENERAL';
                GenJnLine."Journal Batch Name":='OPENING';
                GenJnLine."Line No.":=LineNo;
                if "Opening Balances".Type = 'Bank Account' then GenJnLine."Account Type":=GenJnLine."Account Type"::"Bank Account"
                else if "Opening Balances".Type = 'Customer' then GenJnLine."Account Type":=GenJnLine."Account Type"::Customer
                    else if "Opening Balances".Type = 'G/L Account' then GenJnLine."Account Type":=GenJnLine."Account Type"::"G/L Account"
                        else if "Opening Balances".Type = 'Vendor' then GenJnLine."Account Type":=GenJnLine."Account Type"::Vendor;
                GenJnLine."Account No.":="Opening Balances"."Account No.";
                GenJnLine."Posting Date":=DMY2Date(1, 1, 2017);
                GenJnLine."Document No.":='OPENING';
                GenJnLine.Description:="Opening Balances".Name;
                if "Opening Balances".Debit <> 0 then GenJnLine.Amount:="Opening Balances".Debit;
                if "Opening Balances".Credit <> 0 then GenJnLine.Amount:=-1 * "Opening Balances".Credit;
                GenJnLine.Validate(GenJnLine.Amount);
                GenJnLine."Bal. Account Type":=GenJnLine."Bal. Account Type"::"G/L Account";
                GenJnLine."Bal. Account No.":='999999';
                //GenJnLine."Currency Code":=RptHeader."Currency Code";
                if GenJnLine.Amount <> 0 then GenJnLine.Insert;
            end;
            trigger OnPreDataItem()
            begin
                // Delete Lines Present on the General Journal Line
                GenJnLine.Reset;
                GenJnLine.SetRange(GenJnLine."Journal Template Name", 'GENERAL');
                GenJnLine.SetRange(GenJnLine."Journal Batch Name", 'OPENING');
                GenJnLine.DeleteAll;
                Batch.Init;
                Batch."Journal Template Name":='GENERAL';
                Batch.Name:='OPENING';
                if not Batch.Get('GENERAL', 'OPENING')then Batch.Insert;
                LineNo:=10000;
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
    trigger OnPostReport()
    begin
        Message('COMPLETE');
    end;
    var GenJnLine: Record "Gen. Journal Line";
    Batch: Record "Gen. Journal Batch";
    LineNo: Integer;
}
