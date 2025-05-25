report 51002 "Petty Cash Vouchers"
{
    ApplicationArea = All;
    Caption = 'Petty Cash Voucher';
    DefaultRenderingLayout = PettyCash2;
    UsageCategory = None;
    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = where("Payment Type" = const("Petty Cash"));
            PrintOnlyIfDetail = false;
            RequestFilterFields = "No.", Date, "Cheque No", Payee;

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
            column(No_Payments; Payments."No.")
            {
            }
            column(Confirm_Receipt_Date_Time; "Confirm Receipt Date-Time")
            {
            }
            column(DestinationName_Payments; Payments."Payment Narration")
            {
            }
            column(Date_Payments; Payments.Date)
            {
            }
            column(PaymentsNarration; Payments."Payment Narration")
            {
            }
            column(BankName_Payments; Payments."Bank Name")
            {
            }
            column(PayMode_Payments; Payments."Pay Mode")
            {
            }
            column(ChequeNo_Payments; Payments."Cheque No")
            {
            }
            column(ChequeDate_Payments; Payments."Cheque Date")
            {
            }
            column(Payee_Payments; Payments.Payee)
            {
            }
            column(Onbehalfof_Payments; Payments."On behalf of")
            {
            }
            column(CreatedBy_Payments; Payments."Created By")
            {
            }
            column(Posted_Payments; Payments.Posted)
            {
            }
            column(PostedBy_Payments; Payments."Posted By")
            {
            }
            column(PostedDate_Payments; Payments."Posted Date")
            {
            }
            column(GlobalDimension1Code_Payments; Payments."Shortcut Dimension 1 Code")
            {
            }
            column(GlobalDimension2Code_Payments; Payments."Shortcut Dimension 2 Code")
            {
            }
            column(TimePosted_Payments; Payments."Time Posted")
            {
            }
            column(TotalAmount_Payments; Payments."Total Amount")
            {
            }
            column(PayingBankAccount_Payments; Payments."Paying Bank Account")
            {
            }
            column(PayingBankName_Payments; GetBankDetails(Payments."Paying Bank Account"))
            {
            }
            column(Status_Payments; Payments.Status)
            {
            }
            column(PaymentType_Payments; Payments."Payment Type")
            {
            }
            column(Currency_Payments; Payments.Currency)
            {
            }
            column(NoSeries_Payments; Payments."No. Series")
            {
            }
            column(AccountType_Payments; Payments."Account Type")
            {
            }
            column(AccountNo_Payments; Payments."Account No.")
            {
            }
            column(AccountName_Payments; Payments."Account Name")
            {
            }
            column(ImprestAmount_Payments; Payments."Imprest Amount")
            {
            }
            column(Surrendered_Payments; Payments.Surrendered)
            {
            }
            column(AppliesToDocNo_Payments; Payments."Applies- To Doc No.")
            {
            }
            column(PettyCashAmount_Payments; Payments."Petty Cash Amount")
            {
            }
            column(ImprestSurrenderDate_Payments; Payments."Surrender Date")
            {
            }
            column(DateFilter_Payments; Payments."Date Filter")
            {
            }
            column(StaffNo_Payments; Payments."Staff No.")
            {
            }
            column(DateofProject_Payments; Payments."Date of Project")
            {
            }
            column(DateofCompletion_Payments; Payments."Date of Completion")
            {
            }
            column(DueDate_Payments; Payments."Due Date")
            {
            }
            column(NoofDays_Payments; Payments."No of Days")
            {
            }
            column(Destination_Payments; Payments.Destination)
            {
            }
            column(PayeeTxt; Payments.Payee)
            {
            }
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
            column(Number_In_Words; NumberText[1])
            {
            }
            column(ImprestBankName_Payments; CustomerBank.Name)
            {
            }
            column(ImprestBankBranchName_Payments; CustomerBank."Bank Branch No.")
            {
            }
            column(ImprestBankAccountNo_Payments; CustomerBank."Bank Account No.")
            {
            }
            column(Dim1; GLSetup."Global Dimension 1 Code")
            {
            }
            column(Dim2; GLSetup."Global Dimension 2 Code")
            {
            }
            column(Dim3; GLSetup."Shortcut Dimension 3 Code")
            {
            }
            column(Dim4; GLSetup."Shortcut Dimension 4 Code")
            {
            }
            column(Dim5; GLSetup."Shortcut Dimension 5 Code")
            {
            }
            column(Dim6; GLSetup."Shortcut Dimension 6 Code")
            {
            }
            column(Dim7; GLSetup."Shortcut Dimension 7 Code")
            {
            }
            column(MultiDonor; Payments."Multi-Donor")
            {
            }
            column(PaymentTxt; PaymentTxt)
            {
            }
            column(HeaderDimValueName_1; HeaderDimValueCode[1])
            {
            }
            column(HeaderDimValueName_2; HeaderDimValueCode[2])
            {
            }
            column(HeaderDimValueName_3; HeaderDimValueCode[3])
            {
            }
            column(HeaderDimValueName_4; HeaderDimValueCode[4])
            {
            }
            column(HeaderDimValueName_5; HeaderDimValueCode[5])
            {
            }
            column(HeaderDimValueName_6; HeaderDimValueCode[6])
            {
            }
            column(HeaderDimValueName_7; HeaderDimValueCode[7])
            {
            }
            column(HeaderDimValueName_8; HeaderDimValueCode[8])
            {
            }
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = field("No.");
                DataItemTableView = sorting(No, "Line No");

                column(No_PVLines; "Payment Lines".No)
                {
                }
                column(LineNo_PVLines; "Payment Lines"."Line No")
                {
                }
                column(AccountType_PVLines; "Payment Lines"."Account Type")
                {
                }
                column(AccountNo_PVLines; "Payment Lines"."Account No")
                {
                }
                column(AccountName_PVLines; "Payment Lines"."Account Name")
                {
                }
                column(Description_PVLines; "Payment Lines".Description)
                {
                }
                column(Amount_PVLines; "Payment Lines".Amount)
                {
                }
                column(AmountLCY_PVLines; "Payment Lines"."Amount (LCY)")
                {
                }
                column(AppliestoDocNo_PVLines; "Payment Lines"."Applies-to Doc. No.")
                {
                }
                column(GlobalDimension1Code_PVLines; "Payment Lines"."Shortcut Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_PVLines; "Payment Lines"."Shortcut Dimension 2 Code")
                {
                }
                column(ActualSpent_PVLines; "Payment Lines"."Actual Spent")
                {
                }
                column(RemainingAmount_PVLines; "Payment Lines"."Remaining Amount")
                {
                }
                column(Committed_PVLines; "Payment Lines".Committed)
                {
                }
                column(Purpose_PVLines; "Payment Lines".Purpose)
                {
                }
                column(ExpenditureType_PaymentLines; "Payment Lines"."Expenditure Type")
                {
                }
                column(DimValueName_1; DimValueName[1])
                {
                }
                column(DimValueName_2; DimValueName[2])
                {
                }
                column(DimValueName_3; DimValueName[3])
                {
                }
                column(DimValueName_4; DimValueName[4])
                {
                }
                column(DimValueName_5; DimValueName[5])
                {
                }
                column(DimValueName_6; DimValueName[6])
                {
                }
                column(DimValueName_7; DimValueName[7])
                {
                }
                column(DimValueName_8; DimValueName[8])
                {
                }
                column(MultiDonor_Fund; MultiDonor_Fund)
                {
                }
                column(MultiDonor_Theme; MultiDonor_Theme)
                {
                }

                trigger OnPreDataItem()
                begin
                    MultiDonor_Fund := '';
                    MultiDonor_Theme := '';
                end;

                trigger OnAfterGetRecord()
                begin
                    //Dimension Values
                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueCode[1] := DimSetEntry."Dimension Value Code";
                        DimValueName[1] := DimSetEntry."Dimension Value Name";
                        if Payments."Multi-Donor" then
                            if MultiDonor_Fund = '' then
                                MultiDonor_Fund := DimValueName[1]
                            else
                                MultiDonor_Fund := MultiDonor_Fund + ', ' + DimValueName[1];
                    end;

                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[2] := DimSetEntry."Dimension Value Name";
                        if Payments."Multi-Donor" then
                            if MultiDonor_Theme = '' then
                                MultiDonor_Theme := DimValueName[2]
                            else
                                MultiDonor_Theme := MultiDonor_Theme + ', ' + DimValueName[2];
                    end;

                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[3] := DimSetEntry."Dimension Value Name";
                    end;

                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[4] := DimSetEntry."Dimension Value Name";
                    end;

                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[5] := DimSetEntry."Dimension Value Name";
                    end;

                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[6] := DimSetEntry."Dimension Value Name";
                    end;

                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 7 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[7] := DimSetEntry."Dimension Value Name";
                    end;

                    DimSetEntry.Reset();
                    DimSetEntry.SetRange("Dimension Set ID", "Payment Lines"."Dimension Set ID");
                    DimSetEntry.SetRange("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
                    if DimSetEntry.FindFirst() then begin
                        DimSetEntry.CalcFields("Dimension Value Name");
                        DimValueName[8] := DimSetEntry."Dimension Value Name";
                    end;
                    //
                end;
            }

            trigger OnAfterGetRecord()
            begin

                PaymentMgt.InitTextVariable();
                PaymentMgt.FormatNoText(NumberText, Payments."Petty Cash Amount", CopyStr(Currency, 1, 10));

                // //Requsitioned By
                // Approver[1]:=Payments."Account Name";
                // IF UserSetup.GET(Approver[1]) THEN
                //    UserSetup.CALCFIELDS(Signature);

                //Get sender ID even before approval sent
                Approver[1] := Payments."Created By";
                ApproverDate[1] := CreateDateTime(Payments.Date, Payments."Time Inserted");
                if UserSetup.Get(Approver[1]) then
                    UserSetup.CalcFields(Signature);

                ApprovalEntries.Reset();
                ApprovalEntries.SetCurrentKey("Sequence No.");
                ApprovalEntries.SetRange("Table ID", Database::Payments);
                ApprovalEntries.SetRange("Document No.", Payments."No.");
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
                    /*if ApprovalEntries."Sequence No." = 3 then begin
                        Approver[4] := ApprovalEntries."Last Modified By User ID";
                        ApproverDate[4] := ApprovalEntries."Last Date-Time Modified";
                        if UserSetup3.Get(Approver[4]) then
                            UserSetup3.CalcFields(Signature);
                    end;*/
                    until ApprovalEntries.Next() = 0;

                if Posted then begin
                    Approver[4] := "Posted By";
                    ApproverDate[4] := CreateDateTime("Payment Release Date", "Time Posted");
                    if UserSetup3.Get(Approver[4]) then
                        UserSetup3.CalcFields(Signature);
                end;

                //Get Header Dimensions
                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 1 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[1] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[1] := DimSetEntry."Dimension Value Name";
                end;

                DimSetEntry.Reset();
                DimSetEntry.SetRange("Dimension Set ID", Payments."Dimension Set ID");
                DimSetEntry.SetRange("Dimension Code", GLSetup."Global Dimension 2 Code");
                if DimSetEntry.FindFirst() then begin
                    DimSetEntry.CalcFields("Dimension Value Name");
                    HeaderDimValueCode[2] := DimSetEntry."Dimension Value Code";
                    HeaderDimValueName[2] := DimSetEntry."Dimension Value Name";
                end;
            end;
        }
    }
    rendering
    {
        layout(PettyCash1)
        {
            Caption = 'Petty Cash Voucher';
            Type = RDLC;
            LayoutFile = './src/report_layout/PettyCashVoucher.rdl';
        }
        layout(PettyCash2)
        {
            Caption = 'Petty Cash Voucher';
            Type = RDLC;
            LayoutFile = './src/report_layout/PettyCash.rdl';
        }

        layout(PettyCash3)
        {
            Caption = 'Petty Cash Voucher';
            Type = RDLC;
            LayoutFile = './src/report_layout/CashAdvance.rdl';
        }
    }

    var
        ApprovalEntries: Record "Approval Entry";
        CashMgt: Record "Cash Management Setups";
        CompanyInfo: Record "Company Information";
        CustomerBank: Record "Customer Bank Account";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        PaymentMgt: Codeunit "Payments Management";
        DimValueCode: array[8] of Code[20];
        HeaderDimValueCode: array[8] of Code[20];
        Approver: array[10] of Code[50];
        ApproverDate: array[10] of DateTime;
        DimValueName: array[8] of Text;
        HeaderDimValueName: array[8] of Text;
        MultiDonor_Fund: Text;
        MultiDonor_Theme: Text;
        NumberText: array[2] of Text;
        PaymentTxt: Text;

    trigger OnPreReport()
    begin
        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        GLSetup.Get();
        CashMgt.Get();
    end;

    local procedure GetUserName(UserCode: Code[50]): Text
    begin
        // Users.RESET;
        // Users.SETRANGE("User Name",UserCode);
        // IF Users.FINDFIRST THEN
        //  EXIT(Users."Full Name");
        exit(UserCode);
    end;

    local procedure GetBankDetails(PayingBankCode: Code[20]): Text
    var
        BankAccount: Record "Bank Account";
    begin
        if BankAccount.Get(PayingBankCode) then
            exit(BankAccount.Name)
        else
            exit(PayingBankCode);
    end;
}
