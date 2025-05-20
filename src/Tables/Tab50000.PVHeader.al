table 50000 "PV Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            NotBlank = false;
            Editable = false;

            trigger OnValidate()
            begin
                CashMgt.Get;
                if "No." <> xRec."No." then NoSeriesMgt.TestManual(CashMgt."PV Nos");
                "No. Series":='';
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; Type; Code[20])
        {
        }
        field(4; "Pay Mode"; Code[20])
        {
            TableRelation = "Pay Mode";
        }
        field(5; "External Document No"; Code[20])
        {
            Caption = 'Cheque Number';

            trigger OnValidate()
            begin
                if "External Document No" <> '' then begin
                    PV.Reset;
                    PV.SetRange(PV."External Document No", "External Document No");
                    if PV.Find('-')then begin
                        if PV."No." <> "No." then Error('Cheque No. already exists');
                    end;
                end;
            end;
        }
        field(6; "External Document Date"; Date)
        {
            Caption = 'Cheque Date';
        }
        field(7; "Bank Code"; Code[20])
        {
        }
        field(8; Payee; Text[100])
        {
            trigger OnValidate()
            begin
                "Payee Account Name":=Payee;
            end;
        }
        field(9; "On behalf of"; Text[100])
        {
        }
        field(10; Cashier; Code[50])
        {
            Editable = false;
        }
        field(11; Posted; Boolean)
        {
            Editable = false;

            trigger OnValidate()
            begin
                if(Posted = true) and (xRec.Posted <> Posted)then begin
                    PVLines.Reset;
                    PVLines.SetRange(No, "No.");
                    if PVLines.FindSet then begin
                        repeat PVLines.Posted:=true;
                            PVLines."Posted Date":=Today;
                            PVLines.Modify;
                        until PVLines.Next = 0;
                    end;
                end;
            end;
        }
        field(12; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(13; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                UpdatePaymentLines;
            end;
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                UpdatePaymentLines;
            end;
        }
        field(16; "Time Posted"; Time)
        {
            Editable = false;
        }
        field(17; "Total Amount"; Decimal)
        {
            Caption = 'Net Amount';
            CalcFormula = Sum("PV Lines"."Net Amount" WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(18; "Paying Bank Account"; Code[20])
        {
            TableRelation = "Bank Account";
        }
        field(19; Status;Enum "Document Status")
        {
            Editable = false;
        }
        field(20; "Payment Type";Enum "Payment Types")
        {
        }
        field(21; Currency; Code[20])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            begin
                UpdatePaymentLines;
            end;
        }
        field(22; "No. Series"; Code[20])
        {
        }
        field(23; "Account Type"; Option)
        {
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset";
        }
        field(24; "Payee Account No."; Code[20])
        {
        }
        field(25; "Payee Account Name"; Text[100])
        {
        }
        field(26; "Imprest Amount"; Decimal)
        {
            Editable = false;
        }
        field(27; Surrendered; Boolean)
        {
        }
        field(28; "Applies- To Doc No."; Code[20])
        {
            trigger OnLookup()
            begin
                case "Account Type" of "Account Type"::Customer: begin
                    CustLedger.Reset;
                    CustLedger.SetCurrentKey(CustLedger."Customer No.", Open, "Document No.");
                    CustLedger.SetRange(CustLedger."Customer No.", "Payee Account No.");
                    CustLedger.SetRange(Open, true);
                    CustLedger.CalcFields(CustLedger.Amount);
                    if PAGE.RunModal(25, CustLedger) = ACTION::LookupOK then begin
                        "Applies- To Doc No.":=CustLedger."Document No.";
                    end;
                end;
                end;
            end;
        }
        field(29; "Petty Cash Amount"; Decimal)
        {
        }
        field(30; "Original Document"; Option)
        {
            OptionCaption = ',Imprest,Staff Claim';
            OptionMembers = , Imprest, "Staff Claim";
        }
        field(31; "PV Creation DateTime"; DateTime)
        {
        }
        field(32; "PV Creator ID"; Code[50])
        {
        }
        field(33; "Remaining Amount"; Decimal)
        {
        }
        field(34; "Receipt Created"; Boolean)
        {
        }
        field(37; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(38; "Payee Bank"; Text[30])
        {
        }
        field(42; "Pending Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(50000), "Document No."=FIELD("No."), Status=FILTER(Open|Created)));
            Caption = 'Pending Approvals';
            FieldClass = FlowField;
            Editable = false;
        }
        field(43; "Total Amount LCY"; Decimal)
        {
            CalcFormula = Sum("PV Lines"."Amount LCY" WHERE(No=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(44; "Approvals Trail"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(50000), "Document No."=FIELD("No."), Status=FILTER(Approved)));
            FieldClass = FlowField;
            Caption = 'Approvers';
            Editable = false;
        }
        field(45; "Payee Bank Code"; Code[10])
        {
            TableRelation = "Commercial Banks";

            trigger OnValidate()
            begin
                if Banks.Get("Payee Bank Code")then "Payee Bank":=Banks.Name;
            end;
        }
        field(46; "Branch Code"; Code[10])
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
        field(47; "Sort Code"; Code[10])
        {
        }
        field(48; "Branch Name"; Text[50])
        {
        }
        field(54; "Save Bank Details"; Boolean)
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
        field(56; "SharePoint Link"; Text[250])
        {
        }
        field(57; "Being Payment for"; Text[250])
        {
        }
        field(58; Uncommited; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Total Withholding Tax"; Decimal)
        {
            CalcFormula = Sum("PV Lines"."W/Tax Amount" WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; Description; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(61; EFT_No; Text[30])
        {
        }
        field(62; "Stamp Duty Amount"; Decimal)
        {
            CalcFormula = Sum("PV Lines"."Stamp Duty Amount" WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Purchase Invoice Amount"; Decimal)
        {
            CalcFormula = Sum("PV Lines"."Purchase Invoice Amount" WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Gross Amount"; Decimal)
        {
            CalcFormula = Sum("PV Lines".Amount WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(67; "Outstanding Amount"; Decimal)
        {
            CalcFormula = Sum("PV Lines"."Outstanding Amount" WHERE(No=FIELD("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        TestField(Status, Status::Open);
        TestField(Posted, false);
    end;
    trigger OnInsert()
    begin
        GLSetup.Get();
        GLSetup.TestField(GLSetup."PV Nos");
        if "No." = '' then NoSeriesMgt.InitSeries(GLSetup."PV Nos", xRec."No. Series", 0D, "No.", "No. Series");
    end;
    trigger OnRename()
    begin
        TestField(Posted, false);
    end;
    var GLSetup: Record "Cash Management Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    GLAccount: Record "G/L Account";
    Customer: Record Customer;
    Vendor: Record Vendor;
    Bank: Record "Bank Account";
    FixedAsset: Record "Fixed Asset";
    Amt: Integer;
    CustLedger: Record "Cust. Ledger Entry";
    CustLedger1: Record "Cust. Ledger Entry";
    UserSetup: Record "User Setup";
    PV: Record "PV Header";
    CashMgt: Record "Cash Management Setup";
    Text000: Label 'Cash management setup does''''nt exist';
    Emp: Record "Employee Master";
    NAVEmp: Record Employee;
    Banks: Record "Commercial Banks";
    EmployeeAccMapping: Record "Employee Customer Mapping";
    PVLines: Record "PV Lines";
    Text001: Label 'Please create staff customer account for %1';
    AdvancedFinanceSetup: Record "Advanced Finance Setup";
    Customer2: Record Customer;
    EmployeeAccMapping2: Record "Employee Customer Mapping";
    CreatingText: Label 'Nairobi,Kisumu,Kericho';
    Text002: Label 'You are about to create a Payment Voucher, Kindly select the site.';
    Selection: Integer;
    Branches: Record "Bank Branches";
    BankDetails: Record "Payee Bank Details";
    [Scope('Cloud')]
    procedure AssistEdit(): Boolean begin
        GLSetup.Get();
        GLSetup.TestField(GLSetup."PV Nos");
        if NoSeriesMgt.SelectSeries(GLSetup."PV Nos", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
    local procedure UpdatePaymentLines()
    var
        Lines: Record "PV Lines";
    begin
        Lines.Reset();
        Lines.SetRange(No, "No.");
        Lines.SetFilter(Amount, '<>%1', 0);
        if Lines.FindSet()then begin
            repeat Lines."Global Dimension 1 Code":="Global Dimension 1 Code";
                Lines."Global Dimension 2 Code":="Global Dimension 2 Code";
                Lines."Currency Code":=Currency;
            until Lines.Next() = 0;
        end;
    end;
}
