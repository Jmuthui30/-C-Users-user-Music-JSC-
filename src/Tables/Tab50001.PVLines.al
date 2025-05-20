table 50001 "PV Lines"
{
    // version THL-Basic Fin 1.0
    DrillDownPageID = "Payment Voucher Lines";
    LookupPageID = "Payment Voucher Lines";

    fields
    {
        field(1; No; Code[20])
        {
            TableRelation = "PV Header";
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(3; Date; Date)
        {
        }
        field(4; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset";
        }
        field(5; "Account No"; Code[20])
        {
            Editable = true;

            trigger OnLookup()
            begin
                if "Account Type" = "Account Type"::"G/L Account" then begin
                    if PAGE.RunModal(18, GLAccount) = ACTION::LookupOK then begin
                        GLAccount.TestField("Direct Posting", true);
                        "Account No":=GLAccount."No.";
                        Validate("Account Name", GLAccount.Name);
                    end;
                end
                else if "Account Type" = "Account Type"::Customer then begin
                        if PAGE.RunModal(22, Customer) = ACTION::LookupOK then begin
                            "Account No":=Customer."No.";
                            Validate("Account Name", Customer.Name);
                        end;
                    end
                    else if "Account Type" = "Account Type"::Vendor then begin
                            if PAGE.RunModal(27, Vendor) = ACTION::LookupOK then begin
                                "Account No":=Vendor."No.";
                                Validate("Account Name", Vendor.Name);
                            end;
                        end
                        else if "Account Type" = "Account Type"::"Bank Account" then begin
                                if PAGE.RunModal(371, Bank) = ACTION::LookupOK then begin
                                    "Account No":=Bank."No.";
                                    Validate("Account Name", Bank.Name);
                                end;
                            end
                            else if "Account Type" = "Account Type"::"Fixed Asset" then begin
                                    if PAGE.RunModal(5601, FixedAsset) = ACTION::LookupOK then begin
                                        "Account No":=FixedAsset."No.";
                                        Validate("Account Name", FixedAsset.Description);
                                    end;
                                end;
            end;
        }
        field(6; "Account Name"; Text[100])
        {
            trigger OnValidate()
            begin
                if Header.Get(No)then begin
                    if Header.Payee = '' then begin
                        Header.Payee:="Account Name";
                        Header.Validate(Payee);
                        Header.Modify;
                    end;
                end;
                Validate(Amount);
            end;
        }
        field(7; Description; Text[250])
        {
        }
        field(8; Amount; Decimal)
        {
            Editable = true;

            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
                GenLedSetup: Record "General Ledger Setup";
                BudgetAmount: Decimal;
                Expenses: Decimal;
                BudgetAvailable: Decimal;
                Committments: Record "Commitment Entries";
                CommittedAmount: Decimal;
                CommitmentEntries: Record "Commitment Entries";
                PVHeader: Record "PV Header";
                TotalCommittedAmount: Decimal;
            begin
                CSetup.Get;
                CSetup.TestField("Rounding Precision");
                if CSetup."Rounding Type" = CSetup."Rounding Type"::Up then Direction:='>'
                else if CSetup."Rounding Type" = CSetup."Rounding Type"::Nearest then Direction:='='
                    else if CSetup."Rounding Type" = CSetup."Rounding Type"::Down then Direction:='<';
                case "Account Type" of "Account Type"::"G/L Account": begin
                    if "VAT Code" <> '' then begin
                        if GLAccount.Get("Account No")then if VATSetup.Get(GLAccount."VAT Bus. Posting Group", "VAT Code")then begin
                                if VATSetup."VAT %" <> 0 then begin
                                    if "Purchase Invoice Amount" <> 0 then begin
                                        VATAmount:=Round(("Purchase Invoice Amount" / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        NetAmount:="Purchase Invoice Amount" - VATAmount;
                                    end
                                    else
                                    begin
                                        VATAmount:=Round((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        NetAmount:=Amount - VATAmount;
                                    end;
                                    "VAT Amount":=VATAmount;
                                    //Check IF VAT is to be posted
                                    if CSetup."Post VAT" then "Net Amount":=Amount - VATAmount
                                    else
                                        "Net Amount":=Amount;
                                    //Withholding Tax Calculations
                                    if "W/Tax Code" <> '' then begin
                                        if GLAccount.Get("Account No")then if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "W/Tax Code")then begin
                                                "W/TAmount":=Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "W/Tax Amount":="W/TAmount";
                                                //Check IF VAT is to be posted
                                                if CSetup."Post VAT" then "Net Amount":=NetAmount
                                                else
                                                    "Net Amount":=Amount - "W/Tax Amount" - "Stamp Duty Amount";
                                            end;
                                    end;
                                    //Stamp Duty Tax Calculations
                                    if(("Stamp Duty Code" <> '') AND ("Stamp Duty Flat Amount" = false))then begin
                                        if GLAccount.Get("Account No")then if VATSetup.Get(GLAccount."Gen. Bus. Posting Group", "Stamp Duty Code")then begin
                                                "Stamp/TAmount":=Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "Stamp Duty Amount":="Stamp/TAmount";
                                                //Check IF VAT is to be posted
                                                if CSetup."Post VAT" then "Net Amount":=NetAmount
                                                else
                                                    "Net Amount":=Amount - "W/TAmount" - "Stamp/TAmount";
                                            end;
                                    end
                                    else
                                        "Net Amount":=Amount - "W/Tax Amount" - "Stamp Duty Amount";
                                end;
                            end;
                    end;
                end;
                "Account Type"::Customer: begin
                    if "VAT Code" <> '' then begin
                        if Customer.Get("Account No")then if VATSetup.Get(Customer."VAT Bus. Posting Group", "VAT Code")then begin
                                if VATSetup."VAT %" <> 0 then begin
                                    if "Purchase Invoice Amount" <> 0 then begin
                                        VATAmount:=Round(("Purchase Invoice Amount" / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        NetAmount:="Purchase Invoice Amount" - VATAmount;
                                    end
                                    else
                                    begin
                                        VATAmount:=Round((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        NetAmount:=Amount - VATAmount;
                                    end;
                                    "VAT Amount":=VATAmount;
                                    //Check IF VAT is to be posted
                                    if CSetup."Post VAT" then "Net Amount":=Amount - VATAmount
                                    else
                                        "Net Amount":=Amount;
                                    //Withholding Tax Calculations
                                    if "W/Tax Code" <> '' then begin
                                        if Customer.Get("Account No")then if VATSetup.Get(Customer."VAT Bus. Posting Group", "W/Tax Code")then begin
                                                "W/TAmount":=Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "W/Tax Amount":="W/TAmount";
                                                //Check IF VAT is to be posted
                                                if CSetup."Post VAT" then "Net Amount":=NetAmount
                                                else
                                                    "Net Amount":=Amount - "W/Tax Amount" - "Stamp Duty Amount";
                                            end;
                                    end;
                                    //Stamp Duty Tax Calculations
                                    if(("Stamp Duty Code" <> '') AND ("Stamp Duty Flat Amount" = false))then begin
                                        if Customer.Get("Account No")then if VATSetup.Get(Customer."VAT Bus. Posting Group", "Stamp Duty Code")then begin
                                                "Stamp/TAmount":=Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "Stamp Duty Amount":="Stamp/TAmount";
                                                //Check IF VAT is to be posted
                                                if CSetup."Post VAT" then "Net Amount":=NetAmount
                                                else
                                                    "Net Amount":=Amount - "W/TAmount" - "Stamp/TAmount";
                                            end;
                                    end
                                    else
                                        "Net Amount":=Amount - "W/Tax Amount" - "Stamp Duty Amount";
                                end;
                            end;
                    end;
                end;
                "Account Type"::Vendor: begin
                    if "VAT Code" <> '' then begin
                        if Vendor.Get("Account No")then if VATSetup.Get(Vendor."VAT Bus. Posting Group", "VAT Code")then begin
                                if VATSetup."VAT %" <> 0 then begin
                                    if "Purchase Invoice Amount" <> 0 then begin
                                        VATAmount:=Round(("Purchase Invoice Amount" / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        NetAmount:="Purchase Invoice Amount" - VATAmount;
                                    end
                                    else
                                    begin
                                        VATAmount:=Round((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        NetAmount:=Amount - VATAmount;
                                    end;
                                    "VAT Amount":=VATAmount;
                                    //Check IF VAT is to be posted
                                    if CSetup."Post VAT" then "Net Amount":=Amount - VATAmount
                                    else
                                        "Net Amount":=Amount;
                                    //Withholding Tax Calculations
                                    if "W/Tax Code" <> '' then begin
                                        if Vendor.Get("Account No")then if VATSetup.Get(Vendor."VAT Bus. Posting Group", "W/Tax Code")then begin
                                                "W/TAmount":=Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "W/Tax Amount":="W/TAmount";
                                                //Check IF VAT is to be posted
                                                if CSetup."Post VAT" then "Net Amount":=NetAmount
                                                else
                                                    "Net Amount":=Amount - "W/Tax Amount" - "Stamp Duty Amount";
                                            end;
                                    end;
                                    //Stamp Duty Tax Calculations
                                    if(("Stamp Duty Code" <> '') AND ("Stamp Duty Flat Amount" = false))then begin
                                        if Vendor.Get("Account No")then if VATSetup.Get(Vendor."VAT Bus. Posting Group", "Stamp Duty Code")then begin
                                                "Stamp/TAmount":=Round(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                "Stamp Duty Amount":="W/TAmount";
                                                //Check IF VAT is to be posted
                                                if CSetup."Post VAT" then "Net Amount":=NetAmount
                                                else
                                                    "Net Amount":=Amount - "W/TAmount" - "Stamp/TAmount";
                                            end;
                                    end
                                    else
                                        "Net Amount":=Amount - "W/Tax Amount" - "Stamp Duty Amount";
                                end;
                            end;
                    end;
                end;
                "Account Type"::"Bank Account": "Net Amount":=Amount;
                end;
                ////////////////////////////////////////////////////////////////////
                /*CSetup.GET;
                CSetup.TESTFIELD("Rounding Precision");
                IF CSetup."Rounding Type"=CSetup."Rounding Type"::Up THEN
                   Direction:='>'
                 ELSE IF CSetup."Rounding Type"=CSetup."Rounding Type"::Nearest THEN
                   Direction:='='
                 ELSE IF CSetup."Rounding Type"=CSetup."Rounding Type"::Down THEN
                   Direction:='<';
                CASE "Account Type" OF
                "Account Type"::"G/L Account":
                 BEGIN
                  IF "VAT Code"<>'' THEN BEGIN
                    IF GLAccount.GET("Account No") THEN
                      IF VATSetup.GET(GLAccount."VAT Bus. Posting Group","VAT Code") THEN BEGIN
                        IF VATSetup."VAT %"<>0 THEN BEGIN
                           VATAmount:=ROUND((Amount/(1+VATSetup."VAT %"/100)*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                           NetAmount:=Amount-VATAmount;
                           NetAmount:=Amount;
                           "VAT Amount":=VATAmount;
                           IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                           "Net Amount":=Amount-VATAmount
                           ELSE
                           "Net Amount":=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF GLAccount.GET("Account No") THEN
                            IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                                IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                "Net Amount":=NetAmount
                                ELSE
                                "Net Amount":=Amount-"W/TAmount";
                             END;
                           END;
                         END ELSE BEGIN
                          "Net Amount":=Amount;
                           NetAmount:=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF GLAccount.GET("Account No") THEN
                            IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              "Net Amount":=Amount-"W/TAmount";
                             END;
                           END;
                         END;
                       END;
                    END
                  ELSE BEGIN
                  "Net Amount":=Amount;
                  NetAmount:=Amount;
                   IF "W/Tax Code"<>'' THEN BEGIN
                     IF GLAccount.GET("Account No") THEN
                      IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group","W/Tax Code") THEN BEGIN
                          "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                          "W/Tax Amount":="W/TAmount";
                           NetAmount:=NetAmount-"W/TAmount";
                          "Net Amount":=Amount-"W/TAmount";
                      END;
                    END;
                  END;
                END;
                 "Account Type"::Customer:
                 BEGIN
                  IF "VAT Code"<>'' THEN BEGIN
                    IF Customer.GET("Account No") THEN
                      IF VATSetup.GET(Customer."VAT Bus. Posting Group","VAT Code") THEN BEGIN
                         VATAmount:=ROUND((Amount/(1+VATSetup."VAT %"/100)*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                        IF VATSetup."VAT %"<>0 THEN BEGIN
                           NetAmount:=Amount-VATAmount;
                          NetAmount:=Amount;
                           "VAT Amount":=VATAmount;
                           IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                              "Net Amount":=Amount-VATAmount
                              ELSE
                              "Net Amount":=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Customer.GET("Account No") THEN
                            IF VATSetup.GET(Customer."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                             IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                "Net Amount":=NetAmount
                                ELSE
                                "Net Amount":=Amount-"W/TAmount";
                             END;
                           END;
                         END ELSE BEGIN
                           "Net Amount":=Amount;
                           NetAmount:=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Customer.GET("Account No") THEN
                            IF VATSetup.GET(Customer."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              "Net Amount":=Amount-"W/TAmount";
                             END;
                           END;
                         END;
                       END;
                    END
                  ELSE BEGIN
                  "Net Amount":=Amount;
                  NetAmount:=Amount;
                   IF "W/Tax Code"<>'' THEN BEGIN
                     IF Customer.GET("Account No") THEN
                      IF VATSetup.GET(Customer."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                          "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                          "W/Tax Amount":="W/TAmount";
                           NetAmount:=NetAmount-"W/TAmount";
                          "Net Amount":=Amount-"W/TAmount";
                      END;
                    END;
                  END;
                END;
                 "Account Type"::Vendor:
                 BEGIN
                  IF "VAT Code"<>'' THEN BEGIN
                    IF Vendor.GET("Account No") THEN
                      IF VATSetup.GET(Vendor."VAT Bus. Posting Group","VAT Code") THEN BEGIN
                        IF VATSetup."VAT %"<>0 THEN BEGIN
                           VATAmount:=ROUND((Amount/(1+VATSetup."VAT %"/100)*VATSetup."VAT %"/100),CSetup."Rounding Precision",Direction);
                           NetAmount:=Amount-VATAmount;
                           NetAmount:=Amount;
                           "VAT Amount":=VATAmount;
                           IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                           "Net Amount":=Amount-VATAmount
                           ELSE
                           "Net Amount":=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Vendor.GET("Account No") THEN
                            IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                "Net Amount":=NetAmount
                                ELSE
                                "Net Amount":=Amount-"W/TAmount";
                             END;
                           END;
                         END ELSE BEGIN
                         "Net Amount":=Amount;
                           NetAmount:=Amount;
                          IF "W/Tax Code"<>'' THEN BEGIN
                           IF Vendor.GET("Account No") THEN
                            IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                               "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                                "W/Tax Amount":="W/TAmount";
                                NetAmount:=NetAmount-"W/TAmount";
                              "Net Amount":=Amount-"W/TAmount";
                             END;
                           END;
                         END;
                       END;
                    END
                  ELSE BEGIN
                  "Net Amount":=Amount;
                  NetAmount:=Amount;
                   IF "W/Tax Code"<>'' THEN BEGIN
                     IF Vendor.GET("Account No") THEN
                      IF VATSetup.GET(Vendor."VAT Bus. Posting Group","W/Tax Code") THEN BEGIN
                          "W/TAmount":=ROUND(NetAmount*VATSetup."VAT %"/100,CSetup."Rounding Precision",Direction);
                          "W/Tax Amount":="W/TAmount";
                           NetAmount:=NetAmount-"W/TAmount";
                          "Net Amount":=Amount-"W/TAmount";
                      END;
                    END;
                  END;
                 END;
                "Account Type"::"Bank Account":
                 "Net Amount":=Amount;
                END;
                */
                if "Currency Code" = '' then "Amount LCY":=Amount;
            /*IF "Currency Code" <> '' THEN
                VALIDATE("Exchange Rate");*/
            end;
        }
        field(9; Posted; Boolean)
        {
        }
        field(10; "Posted Date"; Date)
        {
        }
        field(11; "Posted Time"; Time)
        {
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(14; "Applies to Doc. No"; Code[20])
        {
            trigger OnLookup()
            begin
                "Applies to Doc. No":='';
                Amt:=0;
                VATAmount:=0;
                "W/TAmount":=0;
                case "Account Type" of "Account Type"::Customer: begin
                    CustLedger.Reset;
                    CustLedger.SetCurrentKey(CustLedger."Customer No.", Open, "Document No.");
                    CustLedger.SetRange(CustLedger."Customer No.", "Account No");
                    CustLedger.SetRange(Open, true);
                    CustLedger.CalcFields(CustLedger.Amount);
                    if PAGE.RunModal(25, CustLedger) = ACTION::LookupOK then begin
                        if CustLedger."Applies-to ID" <> '' then begin
                            CustLedger1.Reset;
                            CustLedger1.SetCurrentKey(CustLedger1."Customer No.", Open, "Applies-to ID");
                            CustLedger1.SetRange(CustLedger1."Customer No.", "Account No");
                            CustLedger1.SetRange(Open, true);
                            CustLedger1.SetRange("Applies-to ID", CustLedger."Applies-to ID");
                            if CustLedger1.Find('-')then begin
                                repeat CustLedger1.CalcFields(CustLedger1.Amount);
                                    Amt:=Amt + Abs(CustLedger1.Amount);
                                until CustLedger1.Next = 0;
                            end;
                            if Amt <> Amt then //ERROR('Amount is not equal to the amount applied on the application form');
                                if Amount = 0 then Amount:=Amt;
                            Validate(Amount);
                            "Applies to Doc. No":=CustLedger."Document No.";
                            Description:=CustLedger.Description;
                            Validate("Currency Code", CustLedger."Currency Code");
                            "Global Dimension 1 Code":=CustLedger."Global Dimension 1 Code";
                            "Global Dimension 2 Code":=CustLedger."Global Dimension 2 Code";
                        end
                        else
                        begin
                            if Amount <> Abs(CustLedger.Amount)then CustLedger.CalcFields(CustLedger."Remaining Amount");
                            if Amount = 0 then Amount:=Abs(CustLedger."Remaining Amount");
                            Validate(Amount);
                            "Applies to Doc. No":=CustLedger."Document No.";
                            Description:=CustLedger.Description;
                            "Global Dimension 1 Code":=CustLedger."Global Dimension 1 Code";
                            "Global Dimension 2 Code":=CustLedger."Global Dimension 2 Code";
                        end;
                    end;
                    Validate(Amount);
                end;
                "Account Type"::Vendor: begin
                    VendLedger.Reset;
                    VendLedger.SetCurrentKey(VendLedger."Vendor No.", Open, "Document No.");
                    VendLedger.SetRange(VendLedger."Vendor No.", "Account No");
                    VendLedger.SetRange(Open, true);
                    VendLedger.CalcFields("Remaining Amount", "Remaining Amt. (LCY)");
                    if PAGE.RunModal(29, VendLedger) = ACTION::LookupOK then begin
                        if VendLedger."Applies-to ID" <> '' then begin
                            VendLedger1.Reset;
                            VendLedger1.SetCurrentKey(VendLedger1."Vendor No.", Open, "Applies-to ID");
                            VendLedger1.SetRange(VendLedger1."Vendor No.", "Account No");
                            VendLedger1.SetRange(Open, true);
                            VendLedger1.SetRange(VendLedger1."Applies-to ID", VendLedger."Applies-to ID");
                            if VendLedger1.Find('-')then begin
                                repeat VendLedger1.CalcFields(VendLedger1."Remaining Amount");
                                    NetAmount:=NetAmount + Abs(VendLedger1."Remaining Amount");
                                until VendLedger1.Next = 0;
                            end;
                            if Amount <> Amount then //ERROR('Amount is not equal to the amount applied on the application form');
                                if Amount = 0 then Amount:=Amount;
                            Validate(Amount);
                            "Applies to Doc. No":=VendLedger."Document No.";
                            Description:=VendLedger.Description;
                            Validate("Currency Code", VendLedger."Currency Code");
                            "Global Dimension 1 Code":=VendLedger."Global Dimension 1 Code";
                            "Global Dimension 2 Code":=VendLedger."Global Dimension 2 Code";
                        end
                        else
                        begin
                            if Amount <> Abs(VendLedger."Remaining Amount")then VendLedger.CalcFields(VendLedger."Remaining Amount", VendLedger."Remaining Amt. (LCY)");
                            if Amount = 0 then Amount:=Abs(VendLedger."Remaining Amount");
                            "Applied Amount LCY":=Abs(VendLedger."Remaining Amt. (LCY)");
                            Validate(Amount);
                            "Applies to Doc. No":=VendLedger."Document No.";
                            Description:=VendLedger.Description;
                            Validate("Currency Code", VendLedger."Currency Code");
                            "Global Dimension 1 Code":=VendLedger."Global Dimension 1 Code";
                            "Global Dimension 2 Code":=VendLedger."Global Dimension 2 Code";
                        end;
                    end;
                    Amount:=Abs(VendLedger."Remaining Amount");
                    "Applied Amount LCY":=Abs(VendLedger."Remaining Amt. (LCY)");
                    Validate(Amount);
                    Description:=VendLedger.Description;
                    Validate("Currency Code", VendLedger."Currency Code");
                    "Global Dimension 1 Code":=VendLedger."Global Dimension 1 Code";
                    "Global Dimension 2 Code":=VendLedger."Global Dimension 2 Code";
                end;
                end;
            end;
        }
        field(15; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(16; "W/Tax Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(17; "Retention Code"; Code[20])
        {
            TableRelation = Document;
        }
        field(18; "VAT Amount"; Decimal)
        {
            Editable = false;
        }
        field(19; "W/Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(20; "Retention Amount"; Decimal)
        {
        }
        field(21; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(22; "Exchange Rate"; Decimal)
        {
            trigger OnValidate()
            begin
                "Amount LCY":=Round(Amount * "Exchange Rate", 0.01);
                if "Applied Amount LCY" = 0 then "Applied Amount LCY":="Amount LCY";
                if "Applied Amount LCY" <> 0 then "Exchange Rate Gain/Loss":="Amount LCY" - "Applied Amount LCY"
                else
                    "Exchange Rate Gain/Loss":=0;
            end;
        }
        field(23; "Currency Code"; Code[10])
        {
            TableRelation = Currency;

            trigger OnValidate()
            begin
                if Header.Get(No)then begin
                    Header.Currency:="Currency Code";
                    Header.Modify;
                end;
            end;
        }
        field(24; "Applied Amount LCY"; Decimal)
        {
        }
        field(25; "Exchange Rate Gain/Loss"; Decimal)
        {
        }
        field(26; "Amount LCY"; Decimal)
        {
        }
        field(27; "M-Pesa Phone No."; Code[12])
        {
            trigger OnValidate()
            begin
                if CopyStr("M-Pesa Phone No.", 1, 3) <> '254' then Error('The M-Pesa Phone Number must start with 254...');
            end;
        }
        field(28; "Payee Bank Code"; Code[10])
        {
            TableRelation = "Commercial Banks";

            trigger OnValidate()
            begin
                if Banks.Get("Payee Bank Code")then "Payee Bank":=Banks.Name;
            end;
        }
        field(29; "Branch Code"; Code[10])
        {
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code"=FIELD("Payee Bank Code"));

            trigger OnLookup()
            begin
                TestField("Payee Bank Code");
                Branches.Reset;
                Branches.SetRange("Bank Code", "Payee Bank Code");
                if PAGE.RunModal(PAGE::"Bank Branches", Branches) = ACTION::LookupOK then Validate("Branch Code", Branches."Branch Code");
            end;
            trigger OnValidate()
            begin
                if Branches.Get("Payee Bank Code", "Branch Code")then begin
                    "Branch Name":=Branches."Branch Name";
                    "Sort Code":=Branches."Sort Code";
                end;
            end;
        }
        field(30; "Sort Code"; Code[10])
        {
        }
        field(31; "Branch Name"; Text[50])
        {
        }
        field(32; "Save Bank Details"; Boolean)
        {
            trigger OnValidate()
            begin
                TestField(Payee);
                TestField("Payee Account No.");
                TestField("Payee Bank Code");
                TestField("Payee Bank");
                TestField("Branch Code");
                TestField("Branch Name");
                if "Ben ID" <> '' then begin
                    if Confirm('There is an existing saved Bank Record for this beneficiary, are you trying to overwrite it?', false) = true then begin
                        if BankDetails.Get("Ben ID")then begin
                            BankDetails."BENEFICIARY NAME":=Payee;
                            BankDetails."BEN ACCT NO":="Payee Account No.";
                            BankDetails."FULL BEN NAME":=Payee;
                            BankDetails.BANKNAME:="Payee Bank";
                            BankDetails."BANK CODE":="Payee Bank Code";
                            BankDetails."BRANCH CODE":="Branch Code";
                            BankDetails."BC.SORT.CODE":="Payee Bank Code" + PadStr('', 3 - StrLen("Branch Code"), '0') + "Branch Code";
                            BankDetails."BRANCH NAME":="Branch Name";
                            BankDetails.Modify;
                        end;
                        Message('Bank Details Successfully Modified.');
                    end;
                end
                else
                begin
                    BankDetails.Init;
                    BankDetails."BEN ID":=Format(CurrentDateTime);
                    BankDetails."BENEFICIARY NAME":=Payee;
                    BankDetails."BEN ACCT NO":="Payee Account No.";
                    BankDetails."FULL BEN NAME":=Payee;
                    BankDetails.BANKNAME:="Payee Bank";
                    BankDetails."BANK CODE":="Payee Bank Code";
                    BankDetails."BRANCH CODE":="Branch Code";
                    BankDetails."BRANCH NAME":="Branch Name";
                    BankDetails."BC.SORT.CODE":="Payee Bank Code" + PadStr('', 3 - StrLen("Branch Code"), '0') + "Branch Code";
                    BankDetails.Insert;
                    "Ben ID":=BankDetails."BEN ID";
                    Modify;
                    Message('Bank Details saved successfully.');
                end;
            end;
        }
        field(55; "Ben ID"; Code[20])
        {
        }
        field(56; "Payee Bank"; Text[30])
        {
        }
        field(57; Payee; Text[100])
        {
            trigger OnValidate()
            begin
                "Payee Account Name":=Payee;
            end;
        }
        field(58; "Payee Account No."; Code[20])
        {
        }
        field(59; "Payee Account Name"; Text[100])
        {
        }
        field(60; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));
        }
        field(61; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));
        }
        field(62; "Global Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Global Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(5));
        }
        field(63; "Cost Centre"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(64; Uncommitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(65; Surrendered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Purchase Invoice Amount"; Decimal)
        {
            Editable = false;
        }
        field(67; "Stamp Duty Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";

            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(68; "Stamp Duty Amount"; Decimal)
        {
        }
        field(69; "Outstanding Amount"; Decimal)
        {
            Editable = false;
        }
        field(70; "Stamp Duty Flat Amount"; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; No, "Line No")
        {
            SumIndexFields = "Net Amount", "VAT Amount", "W/Tax Amount";
        }
        key(Key2; "Line No")
        {
            SumIndexFields = "Net Amount", "VAT Amount", "W/Tax Amount";
        }
    }
    fieldgroups
    {
    }
    var GLAccount: Record "G/L Account";
    Customer: Record Customer;
    Vendor: Record Vendor;
    Bank: Record "Bank Account";
    FixedAsset: Record "Fixed Asset";
    VATAmount: Decimal;
    "W/TAmount": Decimal;
    "Stamp/TAmount": Decimal;
    RetAmount: Decimal;
    NetAmount: Decimal;
    VATSetup: Record "VAT Posting Setup";
    CustLedger: Record "Cust. Ledger Entry";
    CustLedger1: Record "Cust. Ledger Entry";
    VendLedger: Record "Vendor Ledger Entry";
    VendLedger1: Record "Vendor Ledger Entry";
    Amt: Decimal;
    CSetup: Record "Cash Management Setup";
    Direction: Text[30];
    Header: Record "PV Header";
    Banks: Record "Commercial Banks";
    EmployeeAccMapping: Record "Employee Customer Mapping";
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    Customer2: Record Customer;
    EmployeeAccMapping2: Record "Employee Customer Mapping";
    Selection: Integer;
    Branches: Record "Bank Branches";
    BankDetails: Record "Payee Bank Details";
    PayDate: Date;
    PayrollPeriod: Record "Payroll Period";
    GLEntry: Record "G/L Entry";
}
