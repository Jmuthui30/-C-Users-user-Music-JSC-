table 51625 "Medical Schemes"
{
    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Description; Text[30])
        {
        }
        field(3; Type; Option)
        {
            OptionCaption = 'Outsourced,In-House';
            OptionMembers = Outsourced, "In-House";

            trigger OnValidate()
            begin
                if Type = Type::"In-House" then Validate("Settled By", "Settled By"::"Our Organization")
                else
                    "Settled By":="Settled By"::Insurance;
            end;
        }
        field(4; Provider; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Suppliers.Get(Provider)then "Provider Name":=Suppliers.Name;
            end;
        }
        field(5; "Provider Name"; Text[50])
        {
        }
        field(6; "Settled By"; Option)
        {
            Editable = false;
            OptionCaption = 'Insurance,Our Organization';
            OptionMembers = Insurance, "Our Organization";

            trigger OnValidate()
            begin
                if "Settled By" = "Settled By"::"Our Organization" then begin
                    Reset;
                    SetRange(Code, Code);
                    if PAGE.RunModal(PAGE::"Scheme Expense Code", Rec) = ACTION::LookupOK then begin
                        TestField("Expense Code");
                        Validate("Expense Code", "Expense Code");
                    end;
                end
                else
                begin
                    "Expense Code":='';
                    Expense:='';
                end;
            end;
        }
        field(7; "Expense Code"; Code[10])
        {
            TableRelation = "Expense Codes";

            trigger OnValidate()
            begin
                if ExpenseCodes.Get("Expense Code")then begin
                    Expense:=ExpenseCodes.Description;
                    "Account Type":=ExpenseCodes."Account Type";
                    "Account No":=ExpenseCodes."Account No";
                end;
            end;
        }
        field(8; Expense; Text[50])
        {
        }
        field(9; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Vendor,Customer,Item,Fixed Asset';
            OptionMembers = "G/L Account", Vendor, Customer, Item, "Fixed Asset";
        }
        field(10; "Account No"; Code[10])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Account Type"=CONST(Posting), Blocked=CONST(false))
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Item))Item
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset";
        }
        field(11; "Pay Claim To"; Option)
        {
            OptionCaption = 'Service Provider,Employee';
            OptionMembers = "Service Provider", Employee;

            trigger OnValidate()
            begin
                ActiveCovers.Reset;
                ActiveCovers.SetRange(Cover, Code);
                ActiveCovers.SetRange("Cover Status", ActiveCovers."Cover Status"::Active);
                if ActiveCovers.FindSet then ActiveCovers.ModifyAll("Pay Claim To", "Pay Claim To", true);
            end;
        }
    }
    keys
    {
        key(Key1; "Code")
        {
        }
    }
    fieldgroups
    {
    }
    var Suppliers: Record Vendor;
    ExpenseCodes: Record "Expense Codes";
    ActiveCovers: Record "Employee Medical Cover";
}
