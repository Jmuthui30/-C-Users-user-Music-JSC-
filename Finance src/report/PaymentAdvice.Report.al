report 51033 "Payment Advice"
{
    ApplicationArea = All;
    Caption = 'Payment Advice';
    DefaultLayout = RDLC;
    RDLCLayout = './src/report_layout/PaymentAdvice.rdl';

    dataset
    {
        dataitem(Payments; Payments)
        {
            DataItemTableView = where("Payment Type" = filter("Payment Voucher" | Imprest));
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
            column(Date_Payments; Payments.Date)
            {
            }
            column(PaymentsNarration; Payments."Payment Narration")
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
            column(BankName_Payments; Payments."Bank Name")
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
            column(DateFilter_Payments; Payments."Date Filter")
            {
            }
            column(PayeePIN_Payments; Payments."Payee PIN")
            {
            }
            column(TotalVATAmount_Payments; Payments."Total VAT Amount")
            {
            }
            column(TotalWitholdingTaxAmount_Payments; Payments."Total Witholding Tax Amount")
            {
            }
            column(TotalNetAmount_Payments; Payments."Total Net Amount")
            {
            }
            column(TotalRetentionAmount_Payments; Payments."Total Retention Amount")
            {
            }
            column(TotalWitholdingVATTax_Payments; Payments."Total Witholding VAT Tax")
            {
            }
            column(Number_In_Words; NumberText[1])
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
            column(Vendor_Bank_Code; VendorBank.Code)
            {
            }
            column(Venodor_Bank_Account; VendorBank."Bank Account No.")
            {
            }
            column(Vendor_Bank; VendorBank.Name)
            {
            }
            column(Bank_Branch; VendorBank."Bank Branch No.")
            {
            }
            // column(Bank_Name; VendorBank."Bank Name")
            // {
            // }
            column(Branch_Name; VendorBank."Bank Branch Name")
            {
            }
            column(SWIFT_Code; VendorBank."SWIFT Code")
            {
            }
            column(PayeeTxt; PayeeTxt)
            {
            }
            column(ShortcutDimension1Code_Payments; PaymentLine."Shortcut Dimension 1 Code")
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
            column(Counter; Counter)
            {
            }
            column(PinNo; PinNo)
            {
            }
            column(VendAcNo; VendAcNo)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(BankName; BankName)
            {
            }
            column(SwiftCode; SwiftCode)
            {
            }
            column(BranchCode; BranchCode)
            {
            }
            column(Branch; Branch)
            {
            }
            column(VendAddress; VendAddress)
            {
            }
            column(ISOCert; ISOCert)
            {
            }
            column(ChequePayment; ChequePayment)
            {
            }
            dataitem("Payment Lines"; "Payment Lines")
            {
                DataItemLink = No = field("No.");

                column(No_PVLines; "Payment Lines".No)
                {
                }
                column(LineNo_PVLines; "Payment Lines"."Line No")
                {
                }
                column(Date_PVLines; "Payment Lines".Date)
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
                column(Posted_PVLines; "Payment Lines".Posted)
                {
                }
                column(PostedDate_PVLines; "Payment Lines"."Posted Date")
                {
                }
                column(PostedTime_PVLines; "Payment Lines"."Posted Time")
                {
                }
                column(GlobalDimension1Code_PVLines; "Payment Lines"."Shortcut Dimension 1 Code")
                {
                }
                column(GlobalDimension2Code_PVLines; "Payment Lines"."Shortcut Dimension 2 Code")
                {
                }
                column(AppliestoDocNo_PVLines; "Payment Lines"."Applies-to Doc. No.")
                {
                }
                column(VATCode_PVLines; "Payment Lines"."VAT Code")
                {
                }
                column(WTaxCode_PVLines; "Payment Lines"."W/Tax Code")
                {
                }
                column(RetentionCode_PVLines; "Payment Lines"."Retention Code")
                {
                }
                column(VATAmount_PVLines; "Payment Lines"."VAT Amount")
                {
                }
                column(WTaxAmount_PVLines; "Payment Lines"."W/Tax Amount")
                {
                }
                column(RetentionAmount_PVLines; "Payment Lines"."Retention Amount")
                {
                }
                column(NetAmount_PVLines; "Payment Lines"."Net Amount")
                {
                }
                column(WTVATCode_PVLines; "Payment Lines"."W/T VAT Code")
                {
                }
                column(WTVATAmount_PVLines; "Payment Lines"."W/T VAT Amount")
                {
                }
                column(InvoiceNo; InvoiceNo)
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

                trigger OnAfterGetRecord()
                begin
                    Counter := Counter + 1;

                    case "Payment Lines"."Account Type" of
                        "Payment Lines"."Account Type"::Customer:
                            begin
                                CustLedgerEntry.Reset();
                                CustLedgerEntry.SetRange("Applies-to ID", "Payment Lines"."Applies-to ID");
                                if CustLedgerEntry.Find('-') then
                                    InvoiceNo := CustLedgerEntry."Document No.";
                            end;
                        "Payment Lines"."Account Type"::Vendor:
                            begin
                                VendLedgerEntry.Reset();
                                VendLedgerEntry.SetRange("Document No.", "Payment Lines"."Applies-to ID");
                                if VendLedgerEntry.Find('-') then begin
                                    //MESSAGE(VendLedgerEntry."Document No.");
                                    VendLedgerEntry2.Reset();
                                    VendLedgerEntry2.SetRange("Closed by Entry No.", VendLedgerEntry."Entry No.");
                                    if VendLedgerEntry2.Find('-') then
                                        InvoiceNo := VendLedgerEntry2."External Document No.";
                                end;
                            end;
                    end;
                end;
            }
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                DataItemLink = "Appl. To ID Copy" = field("No.");

                column(DocumentType; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(DocumentNo; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(Amount; "Vendor Ledger Entry".Amount)
                {
                }
                column(RemainingAmount; "Vendor Ledger Entry"."Remaining Amount")
                {
                }
                column(Description; "Vendor Ledger Entry".Description)
                {
                }
                column(AmounttoApply; AmounttoApply)
                {
                }
                column(DocumentDate2; "Vendor Ledger Entry"."Document Date")
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(DocumentDate; InvoiceDate)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    // IF "Vendor Ledger Entry"."Document Type"="Vendor Ledger Entry"."Document Type"::Invoice THEN
                    //  InvoiceDate:=GetInvoiceDate("Vendor Ledger Entry"."Document No.")
                    // ELSE
                    InvoiceDate := "Vendor Ledger Entry"."Document Date";
                    if "Vendor Ledger Entry".Open then
                        AmounttoApply := "Vendor Ledger Entry"."Amount to Apply"
                    else
                        AmounttoApply := "Vendor Ledger Entry"."Closed by Amount";
                end;
            }

            trigger OnAfterGetRecord()
            begin

                if ((Payments."Payment Type" = Payments."Payment Type"::Imprest) and (Payments.Status <> Payments.Status::Released)) then
                    CurrReport.Skip();
                if Payments."Payment Type" = Payments."Payment Type"::Imprest then begin
                    PayeeTxt := Payments."On behalf of";
                    Payments.CalcFields("Imprest Amount");
                    AmountPaid := Payments."Imprest Amount";
                end else begin
                    PayeeTxt := Payments.Payee;
                    Payments.CalcFields("Total Net Amount");
                    AmountPaid := Payments."Total Net Amount";
                end;
                Payments.CalcFields("Imprest Amount");
                PaymentMgt.InitTextVariable();
                PaymentMgt.FormatNoText(NumberText, AmountPaid, Currency);

                if PaymentMethod.Get(Payments."Pay Mode") then
                    if PaymentMethod."Bal. Account Type" = PaymentMethod."Bal. Account Type"::Cheque then
                        ChequePayment := true
                    else
                        ChequePayment := false;

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
                    ApproverDate[4] := CreateDateTime("Posted Date", "Time Posted");
                    if UserSetup3.Get(Approver[4]) then
                        UserSetup3.CalcFields(Signature);
                end;

                /*//Approvals
                ApprovalEntries.Reset();
                ApprovalEntries.SetRange("Table ID",Database::"Payments");
                ApprovalEntries.SetRange("Document No.",Payments."No.");
                // ApprovalEntries.SETRANGE(Status,ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin

                  i:=0;
                 repeat
                 i:=i+1;
                if i=1 then begin
                //Approver[1]:=ApprovalEntries."Sender ID";
                //ApproverDate[1]:=ApprovalEntries."Date-Time Sent for Approval";
                 if UserSetup.Get(Approver[1]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup.CalcFields(Signature);
                 end;
                ApprovalEntries.SetRange(Status,ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-') then begin
                Approver[2]:=ApprovalEntries."Approver ID";
                ApproverDate[2]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup1.Get(Approver[2]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup1.CalcFields(Signature);
                 end;
                 end;
                end;

                if i=2 then
                begin
                Approver[3]:=ApprovalEntries."Approver ID";
                ApproverDate[3]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup2.Get(Approver[3]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup2.CalcFields(Signature);
                 end;
                end;

                if i=3 then
                begin
                Approver[4]:=ApprovalEntries."Approver ID";
                ApproverDate[4]:=ApprovalEntries."Last Date-Time Modified";
                 if UserSetup3.Get(Approver[4]) then begin
                   if CashMgt."Append Sign To Documents"=true then
                    UserSetup3.CalcFields(Signature);
                 end;
                end;
                until
                ApprovalEntries.Next()=0;
                end;*/

                /* PaymentLine.Reset();
                PaymentLine.SetRange("Payment Type", PaymentLine."Payment Type"::"Payment Voucher");
                PaymentLine.SetRange(No, Payments."No.");
                PaymentLine.SetRange("Account Type", PaymentLine."Account Type"::Vendor);
                if PaymentLine.Find('-') then begin
                    VendorBank.Reset();
                    VendorBank.SetRange("Vendor No.", PaymentLine."Account No");
                    if VendorBank.Find('-') then;
                end; */

                PaymentLine.Reset();
                PaymentLine.SetRange(No, "No.");
                PaymentLine.SetRange("Account Type", PaymentLine."Account Type"::Vendor);
                if PaymentLine.FindFirst() then
                    PaymentMgt.GetVendorBankDetails(VendorBank, PaymentLine."Account No");

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

                GetVendorDetails();
            end;
        }
    }
    labels
    {
    }

    var
        ApprovalEntries: Record "Approval Entry";
        CompanyInfo: Record "Company Information";
        CustLedgerEntry: Record "Cust. Ledger Entry";
        DimSetEntry: Record "Dimension Set Entry";
        GLSetup: Record "General Ledger Setup";
        PaymentLine: Record "Payment Lines";
        PLines: Record "Payment Lines";
        PaymentMethod: Record "Payment Method";
        UserSetup: Record "User Setup";
        UserSetup1: Record "User Setup";
        UserSetup2: Record "User Setup";
        UserSetup3: Record "User Setup";
        Vend: Record Vendor;
        VendorBank: Record "Vendor Bank Account";
        VendLedgerEntry: Record "Vendor Ledger Entry";
        VendLedgerEntry2: Record "Vendor Ledger Entry";
        PaymentMgt: Codeunit "Payments Management";
        ChequePayment: Boolean;
        BankCode: Code[20];
        HeaderDimValueCode: array[8] of Code[20];
        PinNo: Code[20];
        SwiftCode: Code[20];
        VendAcNo: Code[20];
        Approver: array[10] of Code[50];
        BranchCode: Code[50];
        InvoiceNo: Code[50];
        InvoiceDate: Date;
        ApproverDate: array[10] of DateTime;
        AmountPaid: Decimal;
        AmounttoApply: Decimal;
        Counter: Integer;
        BankName: Text;
        Branch: Text;
        DimValueName: array[8] of Text;
        HeaderDimValueName: array[8] of Text;
        ISOCert: Text;
        NumberText: array[2] of Text;
        PayeeTxt: Text;
        VendAddress: Text;

    trigger OnPreReport()
    begin

        CompanyInfo.Get();
        CompanyInfo.CalcFields(CompanyInfo.Picture);
        GLSetup.Get();
        Counter := 0;

        // IF COMPANYNAME='KUC' THEN
        //  ISOCert:=ISOCaption;
    end;

    local procedure GetInvoiceDate(DocNo: Code[70]): Date
    var
        PurchInvHeader: Record "Purch. Inv. Header";
    begin
        if PurchInvHeader.Get(DocNo) then
            exit(PurchInvHeader."Vendor Invoice Date");
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

    local procedure GetVendorDetails()
    begin
        PLines.Reset();
        PLines.SetRange(No, Payments."No.");
        if PLines.FindFirst() then
            if PLines."Account Type" = PLines."Account Type"::Vendor then begin
                if Vend.Get(PLines."Account No") then;
                PinNo := Vend."KRA PIN";
                PaymentMgt.GetVendorBankDetails(VendorBank, Vend."No.");
                VendAcNo := VendorBank."Bank Account No.";
                SwiftCode := VendorBank."SWIFT Code";
                BankCode := VendorBank.Code;
                //  BankName := VendorBank."Bank Name";
                Branch := VendorBank."Bank Branch Name";
                BranchCode := VendorBank."Bank Branch No.";
                VendAddress := Vend.Address + ' ' + Vend."Address 2" + '-' + Vend."Post Code" + ' ' + Vend.City + ' ' + Vend."Country/Region Code";
            end;
    end;
}
