table 50004 "Payee Bank Details"
{
    fields
    {
        field(1; "BEN ID"; Code[20])
        {
        }
        field(2; "BENEFICIARY NAME"; Code[100])
        {
        }
        field(3; "CUST NO"; Code[10])
        {
        }
        field(4; "CUSTOMER REF"; Text[30])
        {
        }
        field(5; "BEN ACCT NO"; Text[30])
        {
        }
        field(6; "TRANSACTION TYPE"; Code[10])
        {
        }
        field(7; "FULL BEN NAME"; Text[100])
        {
        }
        field(8; "BC.SORT.CODE"; Code[10])
        {
        }
        field(9; BANKNAME; Text[30])
        {
        }
        field(10; "BANK CODE"; Code[10])
        {
        }
        field(11; "BRANCH CODE"; Code[10])
        {
        }
        field(12; "BRANCH NAME"; Text[50])
        {
        }
    }
    keys
    {
        key(Key1; "BEN ID")
        {
        }
    }
    fieldgroups
    {
    }
}
