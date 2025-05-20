codeunit 51604 "Internal Memo Manager"
{
    // version THL- HRM 1.0
    // Author     : Vincent Okoth
    // Upgraded By : Henry Ngari
    // Year: 2021
    // 
    // THL OBJECT RANGES:
    // ***********************
    // Basic Finance: 50000 - 50010 (Bundled with Starter Pack)
    // QuantumJumps Payroll:  51423 - 51499 = 76
    // Advanced Finance: 52100 - 52199 = 99
    // QuantumJumps HR: 51600 - 51799 = 199
    // QuantumJumps Procumement: 51800 - 51899 = 99
    // ***********************
    // EasyPFA: 51900 - 52099 = 199
    // Investment: 52100 - 52199 = 99
    // DynamicsHMIS: 52200 - 52299 = 99
    // EasyProperty: 52300 - 52399 = 99
    // Insurance: 61423 - 61622 = 199
    // Sacco:   61623 - 62422 = ***
    // ********************************************
    trigger OnRun()
    begin
    end;
    var Text000: Label 'Memo has been posted.';
    Text001: Label 'You are about to post this memo. Do you wish to continue?';
    Text002: Label 'Memo has been recalled.';
    Text003: Label 'You are about to recall this memo. Do you wish to continue?';
    Text004: Label 'Memo has been archived.';
    Text005: Label 'You are about to archive this memo. Do you wish to continue?';
    MemoSetup: Record "Internal Memo Setup";
    CommunicationMgt: Codeunit "HR Communication Management";
    procedure PostMemo(var InternalMemo: Record "Internal Memo")
    begin
        if Confirm(Text001, false) = true then begin
            InternalMemo.TestField(Memo);
            InternalMemo.TestField("To");
            InternalMemo.TestField(From);
            InternalMemo.TestField(Date);
            InternalMemo.Posted:=true;
            InternalMemo."Posted By":=UserId;
            InternalMemo.Modify;
            MemoSetup.Get;
            if MemoSetup."Activate Email Notification" then CommunicationMgt.SendMemoEmail(InternalMemo);
            Message(Text000);
        end;
    end;
    procedure RecallMemo(var InternalMemo: Record "Internal Memo")
    begin
        if Confirm(Text003, false) = true then begin
            InternalMemo.TestField(Memo);
            InternalMemo.TestField("To");
            InternalMemo.TestField(From);
            InternalMemo.TestField(Date);
            InternalMemo.Posted:=false;
            InternalMemo."Posted By":=UserId;
            InternalMemo.Modify;
            Message(Text002);
        end;
    end;
    procedure ArchiveMemo(var InternalMemo: Record "Internal Memo")
    begin
        if Confirm(Text005, false) = true then begin
            InternalMemo.TestField(Memo);
            InternalMemo.TestField("To");
            InternalMemo.TestField(From);
            InternalMemo.TestField(Date);
            InternalMemo.TestField(Posted, true);
            InternalMemo.Archived:=true;
            InternalMemo."Archived By":=UserId;
            InternalMemo.Modify;
            Message(Text004);
        end;
    end;
}
