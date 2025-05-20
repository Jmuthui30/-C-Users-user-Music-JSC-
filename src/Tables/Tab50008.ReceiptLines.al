table 50008 "Receipt Lines"
{
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Receipt No."; Code[30])
        {
            TableRelation = "Receipts Header";

            trigger OnValidate()
            begin
                if ReceiptsHeader.Get("Receipt No.")then "Receipt Type":=ReceiptsHeader."Receipt Type";
            end;
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset";
        }
        field(4; "Account No."; Code[30])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account";

            trigger OnValidate()
            begin
                case "Account Type" of "Account Type"::"G/L Account": begin
                    if GLAccount.Get("Account No.")then "Account Name":=GLAccount.Name;
                end;
                "Account Type"::Customer: begin
                    if Cust.Get("Account No.")then "Account Name":=Cust.Name;
                end;
                "Account Type"::Vendor: begin
                    if Vendor.Get("Account No.")then "Account Name":=Vendor.Name;
                end;
                end;
            end;
        }
        field(5; "Account Name"; Text[70])
        {
        }
        field(6; Description; Text[70])
        {
        }
        field(7; "VAT Code"; Code[30])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(8; "W/Tax Code"; Code[30])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(9; "VAT Amount"; Decimal)
        {
        }
        field(10; "W/Tax Amount"; Decimal)
        {
        }
        field(11; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                "Net Amount":=Amount;
            end;
        }
        field(12; "Net Amount"; Decimal)
        {
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(21; "Receipt Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Normal,Advance';
            OptionMembers = Normal, Advance;
        }
        field(22; "Advance Loan No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Loan Application"."Loan No" WHERE("Debtors Code"=FIELD("Account No."), "Stop Loan"=CONST(false), "Loan Status"=CONST(Issued), "Loan Category"=CONST(Advance));
        }
    }
    keys
    {
        key(Key1; "Receipt No.", "Line No")
        {
        }
    }
    fieldgroups
    {
    }
    var GLAccount: Record "G/L Account";
    Cust: Record Customer;
    Vendor: Record Vendor;
    FixedAsset: Record "Fixed Asset";
    BankAccount: Record "Bank Account";
    ReceiptsHeader: Record "Receipts Header";
}
