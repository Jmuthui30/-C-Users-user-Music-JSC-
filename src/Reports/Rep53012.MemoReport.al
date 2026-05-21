report 53012 "Memo Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSRS/Imprest Memo Report.rdl';

    dataset
    {
        dataitem("Imprest Memo Header"; "Imprest Memo Header")
        {
            column(CompInfoLogo; CompInfo.Picture)
            { }
            column(CompInfoName; CompInfo.Name) { }
            column(CompInfoAddress; CompInfo.Address) { }

            column(No_; "No.")
            {

            }
            column(To; "To")
            { }
            column(From_Title; "From Title")
            { }
            column(Recipient_Title; "Recipient Title") { }
            column(From; From) { }
            column(Date; Date) { }
            column(Subject; Subject) { }
            column(Message_body; "Message body") { }
            column(Message_body_1; "Message body 1") { }
            column(Recipient_Name; "Recipient Name") { }
            column(Sender_Name; "Sender Name") { }
            column(Total_Days_in_the_Field; "Total Days in the Field") { }
            //Approval flow
            column(PreparedBy; GetUserName(Approver[1]))
            {
            }
            column(DatePrepared; ApproverDate[1])
            {
            }
            column(PreparedBy_Signature; UserSetup.Signature)
            {
            }
            column(ExaminedBy; GetUserName(Approver[2]))
            {
            }
            column(DateApproved; ApproverDate[2])
            {
            }
            column(ExaminedBy_Signature; UserSetup1.Signature)
            {
            }
            column(VBC; GetUserName(Approver[3]))
            {
            }
            column(VBCDate; ApproverDate[3])
            {
            }
            column(VBC_Signature; UserSetup2.Signature)
            {
            }
            column(Authorizer; GetUserName(Approver[4]))
            {
            }
            column(DateAuthorized; ApproverDate[4])
            {
            }
            column(Authorizer_Signature; UserSetup3.Signature)
            {
            }
            dataitem("Imprest Memo Lines"; "Imprest Memo Lines")
            {
                DataItemLink = "No." = field("No.");
                column(Account_No_; "Account No.") { }
                column(Name; Name) { }
                column(Title; Title) { }
                column(Amount; Amount) { }
                column(Other_Costs; "Other Costs") { }
                column(Description; Description) { }
                column(No_of_Days; "Total Days in the Field") { }

            }

            trigger OnAfterGetRecord()
            begin
                RunLine := RunLine + 1;
                //Get sender ID even before approval sent
                Approver[1] := "Created By";
                ApproverDate[1] := CreateDateTime(Date, Time);
                if UserSetup.Get(Approver[1]) then
                    UserSetup.CalcFields(Signature);
                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", Database::Payments);
                ApprovalEntries.SetRange("Document No.", "No.");
                ApprovalEntries.SetRange(Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then
                    repeat
                        if ApprovalEntries."Sequence No." = 1 then begin
                            Approver[2] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[2] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup1.Get(Approver[2]) then
                                UserSetup1.CalcFields(Signature);
                        end;
                        if ApprovalEntries."Sequence No." = 2 then begin
                            Approver[3] := ApprovalEntries."Last Modified By User ID";
                            ApproverDate[3] := ApprovalEntries."Last Date-Time Modified";
                            if UserSetup2.Get(Approver[3]) then
                                UserSetup2.CalcFields(Signature);
                        end;

                    until ApprovalEntries.Next() = 0;

                if Posted then begin
                    Approver[4] := "Posted By";
                    ApproverDate[4] := CreateDateTime(Date, Time);
                    if UserSetup3.Get(Approver[4]) then
                        UserSetup3.CalcFields(Signature);
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
                // group(GroupName)
                // {
                //     field(Name; SourceExpression)
                //     {

                //     }
                // }
            }
        }

        actions
        {
            // area(processing)
            // {
            //     action(LayoutName)
            //     {

            //     }
            // }
        }

    }

    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        myInt: Integer;
        CompInfo: Record "Company Information";
        CompanyInfo: Record "Company Information";
        BudgetLine: Integer;
        MemoLine: Integer;
        RunLine: Integer;
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        ApproverDate: array[10] of DateTime;
        Approver: array[10] of Code[50];
        ApprovalEntries: Record "Approval Entry";



    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  //EXIT(Users."Full Name");
        //  EXIT(Users."User Name");
        exit(UserCode);
    end;
}