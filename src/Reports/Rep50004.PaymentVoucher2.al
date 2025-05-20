report 50004 "Payment Voucher2"
{
    // version THL-Basic Fin 1.0
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSRS/Payment Voucher2.rdlc';

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
            }
            trigger OnAfterGetRecord()
            begin
                GLsetup.GET;
                IF Payments.Currency <> '' THEN CurrencyCodeText:=Payments.Currency
                ELSE
                    CurrencyCodeText:=GLsetup."LCY Code";
                Banks.RESET;
                Banks.SETRANGE(Banks."No.", Payments."Paying Bank Account");
                IF Banks.FIND('-')THEN BEGIN
                    BankName:=Banks.Name;
                END
                ELSE
                BEGIN
                    BankName:='';
                END;
                Payments.CALCFIELDS("Total Amount");
                InitTextVariable;
                FormatNoText(NumberText, "Total Amount", CurrencyCodeText);
                //Approvers
                ApprovalEntries.RESET;
                ApprovalEntries.SETRANGE(ApprovalEntries."Table ID", 50000);
                ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", Payments."No.");
                ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
                IF ApprovalEntries.FIND('-')THEN BEGIN
                    i:=0;
                    REPEAT i:=i + 1;
                        IF i = 1 THEN BEGIN
                            Users.RESET;
                            Users.SETRANGE("User Name", ApprovalEntries."Sender ID");
                            IF Users.FINDFIRST THEN BEGIN
                                "1stapprover":=Users."Full Name";
                            END;
                            Users.RESET;
                            Users.SETRANGE("User Name", ApprovalEntries."Approver ID");
                            IF Users.FINDFIRST THEN BEGIN
                                "2ndapprover":=Users."Full Name";
                                "3rdapprover":=Users."Full Name";
                                "4thapprover":=Users."Full Name";
                            END;
                            "1stapproverdate":=ApprovalEntries."Date-Time Sent for Approval";
                            "2ndapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            IF UserRecApp1.GET(ApprovalEntries."Sender ID")THEN UserRecApp1.CALCFIELDS(UserRecApp1.Signature);
                            IF UserRecApp2.GET(ApprovalEntries."Approver ID")THEN UserRecApp2.CALCFIELDS(UserRecApp2.Signature);
                            IF UserRecApp3.GET(ApprovalEntries."Approver ID")THEN UserRecApp3.CALCFIELDS(UserRecApp3.Signature);
                            IF UserRecApp4.GET(ApprovalEntries."Approver ID")THEN UserRecApp4.CALCFIELDS(UserRecApp4.Signature);
                        END;
                        IF i = 2 THEN BEGIN
                            Users.RESET;
                            Users.SETRANGE("User Name", ApprovalEntries."Approver ID");
                            IF Users.FINDFIRST THEN BEGIN
                                "3rdapprover":=Users."Full Name";
                                "4thapprover":=Users."Full Name";
                            END;
                            "3rdapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            IF UserRecApp3.GET(ApprovalEntries."Approver ID")THEN UserRecApp3.CALCFIELDS(UserRecApp3.Signature);
                            IF UserRecApp4.GET(ApprovalEntries."Approver ID")THEN UserRecApp4.CALCFIELDS(UserRecApp4.Signature);
                        END;
                        IF i = 3 THEN BEGIN
                            Users.RESET;
                            Users.SETRANGE("User Name", ApprovalEntries."Approver ID");
                            IF Users.FINDFIRST THEN BEGIN
                                "4thapprover":=Users."Full Name";
                            END;
                            "4thapproverdate":=ApprovalEntries."Last Date-Time Modified";
                            IF UserRecApp4.GET(ApprovalEntries."Approver ID")THEN UserRecApp4.CALCFIELDS(UserRecApp4.Signature);
                        END;
                    UNTIL ApprovalEntries.NEXT = 0;
                END;
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
        CompInfo.GET;
        CompInfo.CALCFIELDS(CompInfo.Picture);
        CompInfo.CALCFIELDS(CompInfo.Picture2);
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
    CurrencyCodeText: Code[10];
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
    procedure FormatNoText(var NoText: array[2]of Text[80]; No: Decimal; CurrencyCode: Code[10])
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex:=1;
        NoText[1]:='****';
        IF No < 1 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        ELSE
        BEGIN
            FOR Exponent:=4 DOWNTO 1 DO BEGIN
                PrintExponent:=FALSE;
                Ones:=No DIV POWER(1000, Exponent - 1);
                Hundreds:=Ones DIV 100;
                Tens:=(Ones MOD 100) DIV 10;
                Ones:=Ones MOD 10;
                IF Hundreds > 0 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                END;
                IF Tens >= 2 THEN BEGIN
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    IF Ones > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                END
                ELSE IF(Tens * 10 + Ones) > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                IF PrintExponent AND (Exponent > 1)THEN AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No:=No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            END;
        END;
        IF CurrencyCode = '' THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' KENYA SHILLINGS');
            IF No <> 0 THEN BEGIN
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                //Translate KOBO to words
                IF(No * 100) > 0 THEN BEGIN
                    No:=No * 100;
                    FOR Exponent:=4 DOWNTO 1 DO BEGIN
                        PrintExponent:=FALSE;
                        Ones:=No DIV POWER(1000, Exponent - 1);
                        Hundreds:=Ones DIV 100;
                        Tens:=(Ones MOD 100) DIV 10;
                        Ones:=Ones MOD 10;
                        IF Hundreds > 0 THEN BEGIN
                            AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                            AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                        END;
                        IF Tens >= 2 THEN BEGIN
                            AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                            IF Ones > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                        END
                        ELSE IF(Tens * 10 + Ones) > 0 THEN AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                        IF PrintExponent AND (Exponent > 1)THEN AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                        No:=No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
                    END;
                END;
                //
                //AddToNoText(NoText,NoTextIndex,PrintExponent,FORMAT(No * 100) + ' KOBO');
                AddToNoText(NoText, NoTextIndex, PrintExponent, ' CENTS');
            END;
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY****');
        END;
        IF CurrencyCode <> '' THEN BEGIN
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
            IF No <> 0 THEN BEGIN
                AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
                AddToNoText(NoText, NoTextIndex, PrintExponent, FORMAT(No * 100) + ' CENTS');
            END;
            AddToNoText(NoText, NoTextIndex, PrintExponent, ' ONLY');
        END;
    end;
    local procedure AddToNoText(var NoText: array[2]of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30])
    begin
        PrintExponent:=TRUE;
        WHILE STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1])DO BEGIN
            NoTextIndex:=NoTextIndex + 1;
            IF NoTextIndex > ARRAYLEN(NoText)THEN ERROR(Text029, AddText);
        END;
        NoText[NoTextIndex]:=DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
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
