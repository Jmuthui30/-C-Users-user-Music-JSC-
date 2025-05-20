report 50015 "Create FA Journal"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Create FA Journal.rdlc';

    dataset
    {
        dataitem("FA Opening Balances"; "FA Opening Balances")
        {
            trigger OnAfterGetRecord()
            begin
                //Post Bank entries
                LineNo:=LineNo + 1000;
                FAJnlLine.Init;
                FAJnlLine."Journal Template Name":='ASSET';
                FAJnlLine."Journal Batch Name":='OPENING';
                FAJnlLine."Line No.":=LineNo;
                FAJnlLine."FA Posting Date":=DMY2Date(1, 1, 2017);
                FAJnlLine."Document No.":='OPENING';
                FAJnlLine.Validate("FA No.", "FA Opening Balances"."FA No.");
                FAJnlLine.Description:='Aquisition Cost';
                FAJnlLine.Amount:="FA Opening Balances"."Total Cost";
                FAJnlLine.Validate(FAJnlLine.Amount);
                if FAJnlLine.Amount <> 0 then FAJnlLine.Insert;
            end;
            trigger OnPreDataItem()
            begin
                // Delete Lines Present on the FAeral Journal Line
                FAJnlLine.Reset;
                FAJnlLine.SetRange(FAJnlLine."Journal Template Name", 'ASSET');
                FAJnlLine.SetRange(FAJnlLine."Journal Batch Name", 'OPENING');
                FAJnlLine.DeleteAll;
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
        Message('Complete');
    end;
    var FAJnlLine: Record "FA Journal Line";
    LineNo: Integer;
}
