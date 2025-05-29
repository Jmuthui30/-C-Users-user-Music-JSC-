codeunit 51605 "HR Communication Management"
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

    var
        CompInfo: Record "Company Information";
        EmpNav: Record Employee;
        Documents: Record Document;
        Attachments: Record Attachment;
        FileMgt: Codeunit "File Management";
        MemoSetup: Record "Internal Memo Setup";
        HRSetup: Record "QuantumJumps HR Setup";
        LeaveSetup: Record "Leave Setup";
        Mail: Codeunit "Email Message";
        Email: Codeunit Email;
        Body: Text;
        UserSetup: Record "User Setup";

    procedure SendMemoEmail(var InternalMemo: Record "Internal Memo")
    begin
        CompInfo.Get;
        MemoSetup.Get;
        CompInfo.Get;
        InternalMemo.TestField(InternalMemo.Subject);
        InternalMemo.TestField(InternalMemo."Group Email");
        InternalMemo.TestField(InternalMemo."Group Name");
        Body := 'Dear ' + InternalMemo."Group Name";
        Body += '<br><br>';
        Body += InternalMemo.Memo;
        Body += '<br><br>';
        Body += 'NB: The system reference for this Memo on Microsoft Dynamics NAV Self Service is ' + InternalMemo."No.";
        Body += '<br><br>';
        Body += 'For any queries kindly do not hesitate to contact the undersigned.';
        Body += '<br><br>';
        Body += 'Thank you.';
        Body += '<br><br>';
        Body += 'Yours Sincerely,';
        Body += '<br><br>';
        Body += '<b>Business Central Notification System<b>';
        Body += '<br>';
        Body += CompInfo.Name;
        Body += '<br>';
        Mail.Create(InternalMemo."Group Email", InternalMemo.Subject, Body, true);
        // email.OpenInEditorModally(mail)
        Email.Send(Mail);
    end;

    procedure SendImprestMemoEmail(var InternalMemo: Record "Imprest Memo Header")
    var
        Lines: Record "Imprest Memo Lines";
        BCLink: Text;
        ImprestHeader: Record "Imprest Header";
    begin
        CompInfo.Get;
        // ImprestHeader.Reset();
        // ImprestHeader.SetRange(Status, ImprestHeader.Status::Open);
        // ImprestHeader.FindSet();
        //MemoSetup.Get;
        //CompInfo.Get;
        BCLink := '<a href=' + GETURL(CURRENTCLIENTTYPE, COMPANYNAME, ObjectType::Page, 52103, ImprestHeader, true) + '>' + 'Business Central</a>';
        Lines.Reset();
        Lines.SetRange("No.", InternalMemo."No.");
        Lines.SetFilter(Email, '<>%1', '');
        if Lines.FindFirst() then begin
            repeat
                InternalMemo.TestField(InternalMemo.Subject);
                Lines.TestField(Email);
                Lines.TestField(Name);
                if Lines.Type = Lines.Type::Staff then begin //Staff
                    Body := 'Dear ' + Lines.Name;
                    Body += '<br><br>';
                    Body += 'You have been nominated for an event through the Memo ' + InternalMemo."No." + '.';
                    Body += '<br><br>';
                    Body += 'Please go to ' + BCLink + ' and create an imprest request for the same and seek relevant approval to attend.';
                    Body += '<br><br>';
                    Body += 'NB: The system reference for this Memo on Microsoft Dynamics Self Service is ' + InternalMemo."No.";
                    Body += '<br><br>';
                    Body += 'For any queries kindly do not hesitate to contact the undersigned.';
                    Body += '<br><br>';
                    Body += 'Thank you.';
                    Body += '<br><br>';
                    Body += 'Yours Sincerely,';
                    Body += '<br><br>';
                    Body += '<b>Business Central Notification System<b>';
                    Body += '<br>';
                    Body += CompInfo.Name;
                    Body += '<br>';
                    Mail.Create(Lines.Email, InternalMemo.Subject, Body, true);
                    // email.OpenInEditorModally(mail)
                    Email.Send(Mail);
                end
                else begin //Expert
                    Body := 'Dear ' + Lines.Name;
                    Body += '<br><br>';
                    Body += 'You have been nominated for an event by ' + CompInfo.Name + ' as an expert through the Memo ' + InternalMemo."No." + '.';
                    Body += '<br><br>';
                    Body += 'Please prepare and plan to attend.';
                    Body += '<br><br>';
                    Body += 'For any queries kindly do not hesitate to contact the undersigned.';
                    Body += '<br><br>';
                    Body += 'Thank you.';
                    Body += '<br><br>';
                    Body += 'Yours Sincerely,';
                    Body += '<br><br>';
                    Body += '<b>Business Central Notification System<b>';
                    Body += '<br>';
                    Body += CompInfo.Name;
                    Body += '<br>';
                    Mail.Create(Lines.Email, InternalMemo.Subject, Body, true);
                    // email.OpenInEditorModally(mail)
                    Email.Send(Mail);
                end;
            until Lines.Next() = 0;
        end;
    end;

    procedure HRLeaveNotification(var LeaveApp: Record "Employee Leave Application")
    begin
        if LeaveSetup.Get(LeaveApp."Leave Code") then begin
            if LeaveSetup."Notify on Application" then begin
                LeaveSetup.TestField("Email Address");
                CompInfo.Get;
                Body += 'Hello,';
                Body += '<br><br>';
                Body += 'This is to bring to your notice that' + ' ' + LeaveApp.Name + ' ' + 'has applied for ' + LeaveApp."Leave Code" + ' ' + 'leave.';
                Body += '<br><br>';
                Body += 'He/she intends to take ' + Format(LeaveApp."Days Applied") + ' ' + 'day(s) beginning ' + Format(LeaveApp."Start Date", 0, 4) + ' ' + 'to resume on ' + Format(LeaveApp."Resumption Date", 0, 4) + '.';
                Body += '<br><br>';
                Body += 'Should you have any reservations, kindly contact the direct approvers involved.';
                Body += '<br><br>';
                Body += 'Thank you.';
                Body += '<br><br>';
                Body += 'Yours Sincerely,';
                Body += '<br><br>';
                Body += '<b>Business Central Notification System<b>';
                Body += '<br>';
                Body += CompInfo.Name;
                Body += '<br>';
                Mail.Create(LeaveSetup."Email Address", 'NOTICE OF LEAVE APPLICATION', Body, true);
                Email.Send(Mail);
            end;
        end;
    end;

    procedure LeaveRelieverNotification(var LeaveApp: Record "Employee Leave Application")
    begin
        LeaveApp.TestField(LeaveApp."Duties Taken Over By");
        CompInfo.Get;
        if EmpNav.Get(LeaveApp."Duties Taken Over By") then begin
            EmpNav.TestField(EmpNav."Company E-Mail");
            Body += 'Hello,';
            Body += '<br><br>';
            Body += 'This is to bring to your notice that you have been selected as the Reliever of ' + ' ' + LeaveApp.Name + ' ' + 'has applied for ' + LeaveApp."Leave Code" + ' ' + 'leave.';
            Body += '<br><br>';
            Body += 'He/she intends to take ' + Format(LeaveApp."Days Applied") + ' ' + 'day(s) beginning ' + Format(LeaveApp."Start Date", 0, 4) + ' ' + 'to resume on ' + Format(LeaveApp."Resumption Date", 0, 4) + '.';
            Body += '<br><br>';
            Body += 'Should you have any Concern, kindly contact the direct approvers involved.';
            Body += '<br><br>';
            Body += 'Thank you.';
            Body += '<br><br>';
            Body += 'Yours Sincerely,';
            Body += '<br><br>';
            Body += '<b>Business Central Notification System<b>';
            Body += '<br>';
            Body += CompInfo.Name;
            Body += '<br>';
            Mail.Create(EmpNav."Company E-Mail", 'NOTICE OF RELIEVER SELECTION', Body, true);
            Email.Send(Mail);
        end;
    end;

    procedure LeaveEmployeeNotification(var LeaveApp: Record "Employee Leave Application")
    begin
        LeaveApp.TestField(LeaveApp."Duties Taken Over By");
        CompInfo.Get;
        if EmpNav.Get(LeaveApp."Duties Taken Over By") then begin
            EmpNav.TestField(EmpNav."Company E-Mail");
            Body += 'Hello,';
            Body += '<br><br>';
            Body += 'This is to bring to your notice that your' + LeaveApp."Leave Code" + ' ' + 'leave has been approved to start from ' + ' ' + format(LeaveApp."Start Date") + ' ' + 'end on ' + format(LeaveApp."End Date") + ' ' + '.';
            Body += '<br><br>';
            Body += 'You are expected to resume duties on ' + ' ' + Format(LeaveApp."Resumption Date", 0, 4) + '.';
            Body += '<br><br>';
            Body += 'Should you have any Concern, kindly contact the direct approvers involved.';
            Body += '<br><br>';
            Body += 'Thank you.';
            Body += '<br><br>';
            Body += 'Yours Sincerely,';
            Body += '<br><br>';
            Body += '<b>Business Central Notification System<b>';
            Body += '<br>';
            Body += CompInfo.Name;
            Body += '<br>';
            Mail.Create(EmpNav."E-Mail", 'NOTICE OF EMPLOYEE', Body, true);
            Email.Send(Mail);
        end;
    end;
}
