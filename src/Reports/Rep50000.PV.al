report 50000 "PV"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/PV.rdlc';

    dataset
    {
        dataitem(Payments; "PV Header")
        {
            column(Logo; CompInfo.Picture)
            {
            }
            column(Logo2; CompInfo.Picture2)
            {
            }
            column(CompName; CompInfo.Name)
            {
            }
            column(CompAddress; CompInfo.Address)
            {
            }
            column(CompAddress2; CompInfo."Address 2")
            {
            }
            column(CompCity; CompInfo.City)
            {
            }
            column(CompPhone; CompInfo."Phone No.")
            {
            }
            column(CompCountry; CompInfo."Country/Region Code")
            {
            }
            column(Date; Payments.Date)
            {
            }
            column(No; Payments."No.")
            {
            }
            column(Payee; Payments.Payee)
            {
            }
            column(AmountInWords; NumberText[1] + ' ' + NumberText[2])
            {
            }
            column(Bank; BankName)
            {
            }
            column(BeingPaymentFor; Payments."Being Payment for")
            {
            }
            column(ChequeNo; Payments."External Document No")
            {
            }
            column(FirstApprover; "1stapprover")
            {
            }
            column(SecondApprover; "2ndapprover")
            {
            }
            column(ThirdApprover; "3rdapprover")
            {
            }
            column(FourthApprover; "4thapprover")
            {
            }
            column(FirstApproverDate; "1stapproverdate")
            {
            }
            column(SecondApproverDate; "2ndapproverdate")
            {
            }
            column(ThirdApproverDate; "3rdapproverdate")
            {
            }
            column(FourthApproverDate; "4thapproverdate")
            {
            }
            column(FirstApproverSignature; UserRecApp1.Signature)
            {
            }
            column(SecondApproverSignature; UserRecApp2.Signature)
            {
            }
            column(ThirdApproverSignature; UserRecApp3.Signature)
            {
            }
            column(FourthApproverSignature; UserRecApp4.Signature)
            {
            }
            column(PayMode; Payments."Pay Mode")
            {
            }
            dataitem("PV Lines"; "PV Lines")
            {
                DataItemLink = No=FIELD("No.");

                column(Description; "PV Lines".Description)
                {
                }
                column(GrossAmount; "PV Lines".Amount)
                {
                }
                column(VAT; "PV Lines"."VAT Amount")
                {
                }
                column(WHT; "PV Lines"."W/Tax Amount")
                {
                }
                column(NetAmount; "PV Lines"."Net Amount")
                {
                }
                column(Account; AccountNo)
                {
                }
                column(Project; "PV Lines"."Global Dimension 1 Code")
                {
                }
                column(Donor; "PV Lines"."Global Dimension 2 Code")
                {
                }
                column(CostCenter; "PV Lines"."Cost Centre")
                {
                }
                column(Department; "PV Lines"."Global Dimension 3 Code")
                {
                }
                column(LNO; "PV Lines"."Line No")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    InvoiceLine.Reset;
                    InvoiceLine.SetRange("Document No.", "PV Lines"."Applies to Doc. No");
                    if InvoiceLine.FindFirst then begin
                        case InvoiceLine.Type of InvoiceLine.Type::Item: begin
                            Item.Reset;
                            if Item.Get(InvoiceLine."No.")then if Item."Inventory Posting Group" = '' then Error('Assign Posting Group to Item No %1', Item."No.");
                            InventoryPostingSetup.Get(InvoiceLine."Location Code", Item."Inventory Posting Group");
                            CostCenter:=InventoryPostingSetup."Inventory Account";
                        end;
                        InvoiceLine.Type::"Fixed Asset": begin
                            if FixedAssetPG.Get(InvoiceLine."Posting Group")then begin
                                FixedAssetPG.TestField("Acquisition Cost Account");
                                CostCenter:=FixedAssetPG."Acquisition Cost Account";
                            end;
                        end;
                        InvoiceLine.Type::"G/L Account": begin
                            CostCenter:=InvoiceLine."No.";
                        end;
                        end;
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                GLsetup.Get;
                if Payments.Currency <> '' then CurrencyCodeText:=Payments.Currency
                else
                    CurrencyCodeText:=GLsetup."LCY Code";
                Banks.Reset;
                Banks.SetRange(Banks."No.", Payments."Paying Bank Account");
                if Banks.Find('-')then begin
                    BankName:=Banks.Name;
                    AccountNo:=Banks."Bank Account No.";
                end
                else
                begin
                    BankName:='';
                end;
                Payments.CalcFields("Total Amount");
                InitTextVariable;
                FormatNoText(NumberText, "Total Amount", CurrencyCodeText);
                //Approvers
                ApprovalEntries.Reset;
                ApprovalEntries.SetRange(ApprovalEntries."Table ID", 50000);
                ApprovalEntries.SetRange(ApprovalEntries."Document No.", Payments."No.");
                ApprovalEntries.SetRange(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                if ApprovalEntries.Find('-')then begin
                    i:=0;
                    repeat i:=i + 1;
                        if i = 1 then begin
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Sender ID");
                            if Users.FindFirst then begin
                                "1stapprover":=Users."Full Name";
                            end;
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Approver ID");
                            if Users.FindFirst then begin
                                "2ndapprover":=Users."Full Name";
                                "3rdapprover":=Users."Full Name";
                                "4thapprover":=Users."Full Name";
                            end;
                            "1stapproverdate":=ApprovalEntries."Date-Time Sent for Approval";
                            "2ndapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp1.Get(ApprovalEntries."Sender ID")then UserRecApp1.CalcFields(UserRecApp1.Signature);
                            if UserRecApp2.Get(ApprovalEntries."Approver ID")then UserRecApp2.CalcFields(UserRecApp2.Signature);
                            if UserRecApp3.Get(ApprovalEntries."Approver ID")then UserRecApp3.CalcFields(UserRecApp3.Signature);
                            if UserRecApp4.Get(ApprovalEntries."Approver ID")then UserRecApp4.CalcFields(UserRecApp4.Signature);
                        end;
                        if i = 2 then begin
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Approver ID");
                            if Users.FindFirst then begin
                                "3rdapprover":=Users."Full Name";
                                "4thapprover":=Users."Full Name";
                            end;
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp3.Get(ApprovalEntries."Approver ID")then UserRecApp3.CalcFields(UserRecApp3.Signature);
                            if UserRecApp4.Get(ApprovalEntries."Approver ID")then UserRecApp4.CalcFields(UserRecApp4.Signature);
                        end;
                        if i = 3 then begin
                            Users.Reset;
                            Users.SetRange("User Name", ApprovalEntries."Approver ID");
                            if Users.FindFirst then begin
                                "4thapprover":=Users."Full Name";
                            end;
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            if UserRecApp4.Get(ApprovalEntries."Approver ID")then UserRecApp4.CalcFields(UserRecApp4.Signature);
                        end;
                    until ApprovalEntries.Next = 0;
                end;
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
    trigger OnPreReport()
    begin
        CompInfo.Get;
        CompInfo.CalcFields(CompInfo.Picture);
        CompInfo.CalcFields(CompInfo.Picture2);
    end;
    var CompInfo: Record "Company Information";
    DimValues: Record "Dimension Value";
    CompName: Text[100];
    TypeOfDoc: Text[100];
    RecPayTypes: Record "Receipts Header";
    BankName: Text[100];
    Banks: Record "Bank Account";
    Bank: Record "Bank Account";
    PayeeBankName: Text[100];
    VendorPG: Record "Vendor Posting Group";
    CustPG: Record "Customer Posting Group";
    FAPG: Record "FA Posting Group";
    BankPG: Record "Bank Account Posting Group";
    PGAccount: Text[50];
    Vend: Record Vendor;
    Cust: Record Customer;
    FA: Record "FA Depreciation Book";
    BankAccountUsed: Text[50];
    BankAccountUsedName: Text[100];
    PGAccountUsedName: Text[50];
    GLAccount: Record "G/L Account";
    SalesSetup: Record "Sales & Receivables Setup";
    OnesText: array[20]of Text[30];
    TensText: array[10]of Text[30];
    ExponentText: array[5]of Text[30];
    GLsetup: Record "General Ledger Setup";
    NumberText: array[2]of Text[80];
    CurrencyCodeText: Code[50];
    ApprovalEntries: Record "Approval Entry";
    "1stapprover": Text[100];
    "2ndapprover": Text[100];
    "3rdapprover": Text[100];
    "4thapprover": Text[100];
    i: Integer;
    "1stapproverdate": DateTime;
    "2ndapproverdate": DateTime;
    "3rdapproverdate": DateTime;
    "4thapproverdate": DateTime;
    UserRec: Record "User Setup";
    UserRecApp1: Record "User Setup";
    UserRecApp2: Record "User Setup";
    UserRecApp3: Record "User Setup";
    UserRecApp4: Record "User Setup";
    x: Integer;
    DimensionRec: Record Dimension;
    DimensionValueRec: Record "Dimension Value";
    AIEHolder: Code[20];
    UserSetup: Record "User Setup";
    Text000: Label 'Preview is not allowed.';
    TXT002: Label '%1, %2 %3';
    Text001: Label 'Last Check No. must be filled in.';
    Text002: Label 'Filters on %1 and %2 are not allowed.';
    Text003: Label 'XXXXXXXXXXXXXXXX';
    Text004: Label 'must be entered.';
    Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
    Text006: Label 'Salesperson';
    Text007: Label 'Purchaser';
    Text008: Label 'Both Bank Accounts must have the same currency.';
    Text009: Label 'Our Contact';
    Text010: Label 'XXXXXXXXXX';
    Text011: Label 'XXXX';
    Text012: Label 'XX.XXXXXXXXXX.XXXX';
    Text013: Label '%1 already exists.';
    Text014: Label 'Check for %1 %2';
    Text015: Label 'Payment';
    Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
    Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
    Text018: Label 'XXX';
    Text019: Label 'Total';
    Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
    Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
    Text022: Label 'NON-NEGOTIABLE';
    Text023: Label 'Test print';
    Text024: Label 'XXXX.XX';
    Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
    Text026: Label 'ZERO';
    Text027: Label 'HUNDRED';
    Text028: Label 'AND';
    Text029: Label '%1 results in a written number that is too long.';
    Text030: Label ' is already applied to %1 %2 for customer %3.';
    Text031: Label ' is already applied to %1 %2 for vendor %3.';
    Text032: Label 'ONE';
    Text033: Label 'TWO';
    Text034: Label 'THREE';
    Text035: Label 'FOUR';
    Text036: Label 'FIVE';
    Text037: Label 'SIX';
    Text038: Label 'SEVEN';
    Text039: Label 'EIGHT';
    Text040: Label 'NINE';
    Text041: Label 'TEN';
    Text042: Label 'ELEVEN';
    Text043: Label 'TWELVE';
    Text044: Label 'THIRTEEN';
    Text045: Label 'FOURTEEN';
    Text046: Label 'FIFTEEN';
    Text047: Label 'SIXTEEN';
    Text048: Label 'SEVENTEEN';
    Text049: Label 'EIGHTEEN';
    Text050: Label 'NINETEEN';
    Text051: Label 'TWENTY';
    Text052: Label 'THIRTY';
    Text053: Label 'FORTY';
    Text054: Label 'FIFTY';
    Text055: Label 'SIXTY';
    Text056: Label 'SEVENTY';
    Text057: Label 'EIGHTY';
    Text058: Label 'NINETY';
    Text059: Label 'THOUSAND';
    Text060: Label 'MILLION';
    Text061: Label 'BILLION';
    Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
    Text063: Label 'Net Amount %1';
    Text064: Label '%1 must not be %2 for %3 %4.';
    Text131: Label 'Please specify which Global Dimension caters for budget\Contact your system admin';
    Text132: Label 'Please specify a dimension that caters for budget';
    Text133: Label 'The AIE Holder %1 doesnt exist ';
    Users: Record User;
    CostCenter: Text;
    InvoiceLine: Record "Purch. Inv. Line";
    Item: Record Item;
    InventoryPostingSetup: Record "Inventory Posting Setup";
    FixedAssetPG: Record "FA Posting Group";
    AccountNo: Code[50];
    procedure FormatNoText(var NoText: array[2]of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        Clear(NoText);
        NoTextIndex:=1;
        NoText[1]:='****';
        if No < 1 then AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else
        begin
            for Exponent:=4 downto 1 do begin
                PrintExponent:=false;
                Ones:=No div Power(1000, Exponent - 1);
                Hundreds:=Ones div 100;
                Tens:=(Ones mod 100) div 10;
                Ones:=Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end
                else if(Tens * 10 + Ones) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1)then AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
            end;
        end;
        if CurrencyCode = '' then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' KENYA SHILLINGS');
            if No <> 0 then begin
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                //Translate KOBO to words
                if(No * 100) > 0 then begin
                    No:=No * 100;
                    for Exponent:=4 downto 1 do begin
                        PrintExponent:=false;
                        Ones:=No div Power(1000, Exponent - 1);
                        Hundreds:=Ones div 100;
                        Tens:=(Ones mod 100) div 10;
                        Ones:=Ones mod 10;
                        if Hundreds > 0 then begin
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                            AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                        end;
                        if Tens >= 2 then begin
                            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                            if Ones > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                        end
                        else if(Tens * 10 + Ones) > 0 then AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                        if PrintExponent and (Exponent > 1)then AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                        No:=No - (Hundreds * 100 + Tens * 10 + Ones) * Power(1000, Exponent - 1);
                    end;
                end;
                //
                //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + ' KOBO');
                AddToNoText(NoText, NoTextIndex, PrintExponent, ' CENTS');
            end;
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY****');
        end;
        if CurrencyCode <> '' then begin
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
            if No <> 0 then begin
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                AddToNoText(NoText, NoTextIndex, PrintExponent, Format(No * 100) + ' CENTS');
            end;
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY');
        end;
    end;
    local procedure AddToNoText(var NoText: array[2]of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent:=true;
        while StrLen(NoText[NoTextIndex] + ' ' + AddText) > MaxStrLen(NoText[1])do begin
            NoTextIndex:=NoTextIndex + 1;
            if NoTextIndex > ArrayLen(NoText)then Error(Text029, AddText);
        end;
        NoText[NoTextIndex]:=DelChr(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;
    procedure InitTextVariable()
    begin
        OnesText[1]:=Text032;
        OnesText[2]:=Text033;
        OnesText[3]:=Text034;
        OnesText[4]:=Text035;
        OnesText[5]:=Text036;
        OnesText[6]:=Text037;
        OnesText[7]:=Text038;
        OnesText[8]:=Text039;
        OnesText[9]:=Text040;
        OnesText[10]:=Text041;
        OnesText[11]:=Text042;
        OnesText[12]:=Text043;
        OnesText[13]:=Text044;
        OnesText[14]:=Text045;
        OnesText[15]:=Text046;
        OnesText[16]:=Text047;
        OnesText[17]:=Text048;
        OnesText[18]:=Text049;
        OnesText[19]:=Text050;
        TensText[1]:='';
        TensText[2]:=Text051;
        TensText[3]:=Text052;
        TensText[4]:=Text053;
        TensText[5]:=Text054;
        TensText[6]:=Text055;
        TensText[7]:=Text056;
        TensText[8]:=Text057;
        TensText[9]:=Text058;
        ExponentText[1]:='';
        ExponentText[2]:=Text059;
        ExponentText[3]:=Text060;
        ExponentText[4]:=Text061;
    end;
}
