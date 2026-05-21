

report 51244 "Expenditure Requisition Form"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RequisitionForm;

    dataset
    {
        dataitem("Imprest Memo Header"; "Imprest Memo Header")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyAddress; CompanyInfo.Address)
            {
            }
            column(CompanyAddress2; CompanyInfo."Address 2")
            {
            }
            column(CompanyPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo.City)
            {
            }
            column(CompanyPhone; CompanyInfo."Phone No.")
            {
            }
            column(CompanyFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyWebsite; CompanyInfo."Home Page")
            {
            }

            column(No_; "No.")
            {
            }
            column(Date; Date) { }
            column(From; From) { }
            column(To; "To") { }
            column(Purpose; Purpose) { }
            column(Created_By; "Created By") { }
            column(RunLine; RunLine)
            {

            }
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
            column(Budget_Sub_Head_Code; "Budget Sub-Head Code")
            {
            }
            column(Work_Plan_Activity_Description; "Work Plan Activity Description")
            {
            }

            //Imprest Budget Analysis
            dataitem("Imprest Budget Analysis"; "Imprest Budget Analysis")
            {
                DataItemLink = "Memo No." = FIELD("No.");

                column(Memo_No_; "Memo No.") { }
                column(Budget_Line; "Budget Line") { }
                column(Description; Description) { }
                column(Amount_on_Budget; "Amount on Budget") { }
                column(Committed_Amount; "Committed Amount") { }
                column(Amount_Required; "Amount Required") { }
                column(Available_Balance; "Available Balance") { }
                column(Budget_Availability; "Budget Availability") { }
                column(BudgetLine; BudgetLine)
                { }
                trigger OnAfterGetRecord()
                begin
                    BudgetLine := BudgetLine + 1;
                end;

            }
            dataitem("Imprest Memo Lines"; "Imprest Memo Lines")
            {
                DataItemLink = "No." = FIELD("No.");
                column(No_Line; "No.") { }
                column(Type; Type) { }
                column(Account_No_; "Account No.") { }
                column(Name; Name) { }

                column(Amount; Amount) { }
                column(MemoLine; MemoLine) { }
                trigger OnAfterGetRecord()
                begin
                    MemoLine := MemoLine + 1;
                end;


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
                    // if ApprovalEntries."Sequence No." = 3 then begin
                    //     Approver[4] := ApprovalEntries."Last Modified By User ID";
                    //     ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                    //     if UserSetup3.Get(Approver[4]) then
                    //         UserSetup3.CalcFields(Signature);
                    // end;
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
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {

                    // }
                }
            }
        }

        actions
        {
            area(processing)
            {
                // action(LayoutName)
                // {

                // }
            }
        }
    }

    rendering
    {
        layout(RequisitionForm)
        {
            //  applicationArea = All;
            Type = RDLC;

            LayoutFile = './Finance src/report_layout/RequisitionForm.rdl';
        }
    }

    var
        myInt: Integer;
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);

    end;

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