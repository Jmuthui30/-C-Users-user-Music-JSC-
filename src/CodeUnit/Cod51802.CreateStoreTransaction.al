codeunit 51802 "Create Store Transaction"
{
    // version THL- PRM 1.0
    trigger OnRun()
    begin
        CreateBatch;
    end;
    var Header: Record "Store Transaction Header";
    Lines: Record "Store Transaction Lines";
    Selection: Integer;
    CreatingText: Label 'Receive,Issue,Transfer';
    Text000: Label 'You are about to create a new store transaction, Do you want to continue?';
    local procedure CreateBatch()
    begin
        if Confirm(Text000, false) = true then begin
            Selection:=StrMenu(CreatingText, 1);
            //Insert Header
            Header.Init;
            if Selection = 1 then begin
                Header.Transaction:=Header.Transaction::Receive;
                Header.Insert(true);
            end
            else if Selection = 2 then begin
                    Header.Transaction:=Header.Transaction::Issue;
                    Header.Insert(true);
                end
                else
                begin
                    Header.Transaction:=Header.Transaction::Transfer;
                    Header.Insert(true);
                end;
            PAGE.Run(51819, Header);
        end;
    end;
}
