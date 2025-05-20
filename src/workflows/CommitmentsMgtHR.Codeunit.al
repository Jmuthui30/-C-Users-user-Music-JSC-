codeunit 52010 "Commitments Mgt HR"
{
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
        HasGotGLSetup: Boolean;
        GLSetupShortcutDimCode: array[8] of Code[20];



    local procedure LineCommitted(var CommittmentNo: Code[20]; var No: Code[20]; var LineNo: Integer) Exists: Boolean
    var
        Committed: Record "Commitment Entries";
    begin
        //Modified by Brian
        // Exists:=FALSE;
        // Committed.RESET;
        // Committed.SETRANGE(Committed."Commitment No",CommittmentNo);
        // Committed.SETRANGE(Committed.No,No);
        // Committed.SETRANGE(Committed."Line No.",LineNo);
        // Committed.SETFILTER(Committed."Commitment Type",'%1|%2',Committed."Commitment Type"::Commitment,Committed."Commitment Type"::"Commitment Reversal");
        // IF Committed.FIND('-') THEN
        //  BEGIN
        //    Committed.CALCSUMS("Committed Amount");
        //    IF Committed."Committed Amount"=0 THEN
        //      Exists:=FALSE
        //    ELSE
        //      Exists:=TRUE;
        //  END;

        Exists := false;
        Committed.Reset();
        Committed.SetRange(Committed."Commitment No", CommittmentNo);
        Committed.SetRange(Committed."Document No", No);
        Committed.SetRange(Committed."Line No.", LineNo);
        if Committed.Find('-') then
            Exists := true;
    end;

    procedure FetchDimValue(DimSetID: Integer; var ShortcutDimCode: array[8] of Code[20]; var DimValueName: array[8] of Text)
    var
        DimSetEntry: Record "Dimension Set Entry";
        i: Integer;
    begin
        GetGLSetup();
        for i := 1 to 8 do begin
            ShortcutDimCode[i] := '';
            if GLSetupShortcutDimCode[i] <> '' then
                if DimSetEntry.Get(DimSetID, GLSetupShortcutDimCode[i]) then begin
                    DimSetEntry.CalcFields("Dimension Name", "Dimension Value Name");
                    ShortcutDimCode[i] := DimSetEntry."Dimension Value Code";
                    DimValueName[i] := DimSetEntry."Dimension Value Name";
                end;
        end;
    end;

    local procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        if not HasGotGLSetup then begin
            GLSetup.Get();
            GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
            GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
            GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
            GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
            GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
            GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
            GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
            GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
            HasGotGLSetup := true;
        end;
    end;

    local procedure IsAccountVotebookEntry(GLAccount: Code[20]): Boolean
    var
        CashManagementSetups: Record "General Ledger Setup";
    begin
        /* GLAccountRec.Reset();
        GLAccountRec.SetRange("No.", GLAccount);
        if GLAccountRec.FindFirst() then
            if GLAccountRec."Votebook Entry" then
                exit(true)
            else
                exit(false); */
        CashManagementSetups.Get();
        // exit(CashManagementSetups."Check For Commitments");
    end;
}



