table 52103 "Expense Codes"
{
    // version THL- ADV.FIN 1.0
    DrillDownPageID = "Expense Codes";
    LookupPageID = "Expense Codes";

    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; Description; Text[250])
        {
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Vendor,Customer,Item,Fixed Asset';
            OptionMembers = "G/L Account", Vendor, Customer, Item, "Fixed Asset";
        }
        field(4; "Account No"; Code[10])
        {
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account" WHERE("Account Type"=CONST(Posting), Blocked=CONST(false))
            ELSE IF("Account Type"=CONST(Vendor))Vendor
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST(Item))Item
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset";

            trigger OnValidate()
            begin
                if "Account Type" = "Account Type"::"G/L Account" then if GLAcc.Get("Account No")then "Account Name":=GLAcc.Name;
                if "Account Type" = "Account Type"::Vendor then if Ven.Get("Account No")then "Account Name":=Ven.Name;
                if "Account Type" = "Account Type"::Customer then if Cust.Get("Account No")then "Account Name":=Cust.Name;
                if "Account Type" = "Account Type"::Item then if Item.Get("Account No")then "Account Name":=Item.Description;
                if "Account Type" = "Account Type"::"Fixed Asset" then if FA.Get("Account No")then "Account Name":=FA.Description;
            end;
        }
        field(5; "Account Name"; Text[50])
        {
        }
        field(6; "Treatment On Imprest"; Option)
        {
            OptionCaption = 'Order from Service Provider,Pay Cash to Traveller,Reject,Process to Payroll';
            OptionMembers = "Order from Service Provider", "Pay Cash to Traveller", Reject, "Process to Payroll";
        }
        field(7; "Payroll Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = if("Treatment On Imprest"=const("Process to Payroll"))"Client Earnings";
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
    var GLAcc: Record "G/L Account";
    Ven: Record Vendor;
    Cust: Record Customer;
    Item: Record Item;
    FA: Record "Fixed Asset";
}
