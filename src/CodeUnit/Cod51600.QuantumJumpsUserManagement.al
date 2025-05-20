codeunit 51600 "QuantumJumps User Management"
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
    // ***********************
    trigger OnRun()
    begin
    end;
    var QuantumJumpsUser: Record "User Setup";
    QuantumJumpsUser2: Record "User Setup";
    Text000: Label 'Please apply the other setups to %1';
    /*
        [EventSubscriber(ObjectType::Table, 91, 'OnAfterInsertEvent', '', false, false)]
        procedure InsertQuantumJumpsUserSetup(var Rec: Record "User Setup"; RunTrigger: Boolean)
        begin
            QuantumJumpsUser.Init;
            QuantumJumpsUser."User ID" := Rec."User ID";
            if not QuantumJumpsUser2.Get(Rec."User ID") then
                QuantumJumpsUser.Insert;
            Message(Text000, Rec."User ID");
            //PAGE.Run(Page::"QuantumJumps User Setup", QuantumJumpsUser);
        end;
        */
    procedure LookupUserID(var UserName: Code[50])
    var
        SID: Guid;
    begin
        LookupUser(UserName, SID);
    end;
    procedure LookupUser(var UserName: Code[50]; var SID: Guid): Boolean var
        User: Record User;
    begin
        User.Reset;
        User.SetCurrentKey("User Name");
        User."User Name":=UserName;
        if User.Find('=><')then;
        if PAGE.RunModal(PAGE::Users, User) = ACTION::LookupOK then begin
            UserName:=User."User Name";
            SID:=User."User Security ID";
            exit(true);
        end;
        exit(false);
    end;
}
